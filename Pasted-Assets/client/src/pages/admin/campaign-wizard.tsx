import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import { useState } from "react";
import { useLocation } from "wouter";
import {
  ArrowLeft,
  ArrowRight,
  Check,
  Loader2,
  FileVideo,
  FileImage,
  Plus,
  X,
  Calendar,
} from "lucide-react";
import { Checkbox } from "@/components/ui/checkbox";
import { Slider } from "@/components/ui/slider";
import { useToast } from "@/hooks/use-toast";

const STEPS = [
  { id: "basics", title: "Basics", description: "Campaign name and dates" },
  { id: "targeting", title: "Targeting", description: "Audience selection" },
  { id: "creative", title: "Creative & Survey", description: "Upload assets and questions" },
  { id: "budget", title: "Budget & Caps", description: "Set spending limits" },
  { id: "review", title: "Review & Launch", description: "Confirm and submit" },
];

const PROVINCES = [
  "Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", "Limpopo",
  "Mpumalanga", "North West", "Northern Cape", "Western Cape"
];

const GENDERS = ["male", "female", "non-binary"];

const AGE_RANGES = [
  { label: "18-24", min: 18, max: 24 },
  { label: "25-34", min: 25, max: 34 },
  { label: "35-44", min: 35, max: 44 },
  { label: "45-54", min: 45, max: 54 },
  { label: "55+", min: 55, max: 100 },
];

export default function CampaignWizard() {
  const [, setLocation] = useLocation();
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [currentStep, setCurrentStep] = useState(0);
  const [formData, setFormData] = useState({
    name: "",
    startDate: "",
    endDate: "",
    targetAgeMin: null as number | null,
    targetAgeMax: null as number | null,
    targetGenders: [] as string[],
    targetProvinces: [] as string[],
    creatives: [] as { type: "video" | "image"; fileUrl: string; fileName: string }[],
    questions: [] as { questionText: string; options: string[] }[],
    cpeZar: "0.10",
    totalBudget: "",
    dailyCap: "",
    frequencyCapPerUser: 2,
    pacing: "even",
  });
  const [newQuestion, setNewQuestion] = useState({ text: "", options: ["", "", "", ""] });

  const { data: adminProfile } = useQuery({
    queryKey: ["/api/admin/auth/me"],
    queryFn: adminApi.getMe,
  });

  const currentOrg = adminProfile?.organizations?.[0];

  const createCampaignMutation = useMutation({
    mutationFn: async (data: any) => {
      const campaign = await adminApi.createCampaign(currentOrg!.id, {
        name: data.name,
        startDate: data.startDate ? new Date(data.startDate) : null,
        endDate: data.endDate ? new Date(data.endDate) : null,
        targetAgeMin: data.targetAgeMin,
        targetAgeMax: data.targetAgeMax,
        targetGenders: data.targetGenders.length > 0 ? data.targetGenders : null,
        targetProvinces: data.targetProvinces.length > 0 ? data.targetProvinces : null,
        cpeZar: data.cpeZar,
        totalBudget: data.totalBudget,
        dailyCap: data.dailyCap || null,
        frequencyCapPerUser: data.frequencyCapPerUser,
        pacing: data.pacing,
      });

      // Add creatives
      for (const creative of data.creatives) {
        await adminApi.addCreative(currentOrg!.id, campaign.id, creative);
      }

      // Add questions
      if (data.questions.length > 0) {
        await adminApi.updateQuestions(currentOrg!.id, campaign.id, data.questions);
      }

      return campaign;
    },
    onSuccess: (campaign) => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaigns"] });
      toast({ title: "Campaign created", description: "Your campaign has been saved as a draft" });
      setLocation(`/admin/campaigns/${campaign.id}`);
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const submitCampaignMutation = useMutation({
    mutationFn: async (data: any) => {
      const campaign = await createCampaignMutation.mutateAsync(data);
      await adminApi.submitCampaign(currentOrg!.id, campaign.id);
      return campaign;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaigns"] });
      toast({ title: "Campaign submitted", description: "Your campaign has been submitted for review" });
      setLocation("/admin/campaigns");
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const nextStep = () => {
    if (currentStep < STEPS.length - 1) {
      setCurrentStep(currentStep + 1);
    }
  };

  const prevStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const addQuestion = () => {
    if (newQuestion.text && newQuestion.options.some(o => o.trim())) {
      setFormData({
        ...formData,
        questions: [
          ...formData.questions,
          {
            questionText: newQuestion.text,
            options: newQuestion.options.filter(o => o.trim()),
          },
        ],
      });
      setNewQuestion({ text: "", options: ["", "", "", ""] });
    }
  };

  const removeQuestion = (index: number) => {
    setFormData({
      ...formData,
      questions: formData.questions.filter((_, i) => i !== index),
    });
  };

  const handleSaveDraft = () => {
    createCampaignMutation.mutate(formData);
  };

  const handleSubmit = () => {
    submitCampaignMutation.mutate(formData);
  };

  const isStepValid = () => {
    switch (currentStep) {
      case 0:
        return formData.name.trim().length > 0;
      case 1:
        return true; // Targeting is optional
      case 2:
        return true; // Creatives can be added later (but required for submission)
      case 3:
        return formData.cpeZar && formData.totalBudget;
      case 4:
        return true;
      default:
        return true;
    }
  };

  return (
    <AdminLayout>
      <div className="max-w-4xl mx-auto">
        <div className="mb-8">
          <Button variant="ghost" onClick={() => setLocation("/admin/campaigns")} className="mb-4 text-slate-700 hover:text-slate-900 hover:bg-slate-100">
            <ArrowLeft size={16} className="mr-2" />
            Back to Campaigns
          </Button>
          <h1 className="text-2xl font-bold text-slate-900">Create Campaign</h1>
          <p className="text-slate-500">Set up your advertising campaign in 5 easy steps</p>
        </div>

        <div className="flex items-center justify-between mb-8 overflow-x-auto pb-4">
          {STEPS.map((step, index) => (
            <div key={step.id} className="flex items-center">
              <div
                className={`flex items-center justify-center w-10 h-10 rounded-full font-bold transition-colors ${
                  index < currentStep
                    ? "bg-green-500 text-white"
                    : index === currentStep
                    ? "bg-pink-600 text-white"
                    : "bg-slate-200 text-slate-500"
                }`}
              >
                {index < currentStep ? <Check size={18} /> : index + 1}
              </div>
              <div className="ml-3 hidden sm:block">
                <p className={`font-medium ${index === currentStep ? "text-slate-900" : "text-slate-500"}`}>
                  {step.title}
                </p>
                <p className="text-xs text-slate-400">{step.description}</p>
              </div>
              {index < STEPS.length - 1 && (
                <div className={`w-8 sm:w-16 h-0.5 mx-4 ${index < currentStep ? "bg-green-500" : "bg-slate-200"}`} />
              )}
            </div>
          ))}
        </div>

        <Card>
          <CardContent className="p-6">
            {currentStep === 0 && (
              <div className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="name">Campaign Name *</Label>
                  <Input
                    id="name"
                    placeholder="e.g., Summer Sale 2026"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    data-testid="input-campaign-name"
                  />
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="startDate">Start Date</Label>
                    <Input
                      id="startDate"
                      type="date"
                      value={formData.startDate}
                      onChange={(e) => setFormData({ ...formData, startDate: e.target.value })}
                      data-testid="input-start-date"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="endDate">End Date</Label>
                    <Input
                      id="endDate"
                      type="date"
                      value={formData.endDate}
                      onChange={(e) => setFormData({ ...formData, endDate: e.target.value })}
                      data-testid="input-end-date"
                    />
                  </div>
                </div>
              </div>
            )}

            {currentStep === 1 && (
              <div className="space-y-6">
                <div className="space-y-3">
                  <Label>Age Range</Label>
                  <div className="flex flex-wrap gap-2">
                    {AGE_RANGES.map((range) => {
                      const isSelected = formData.targetAgeMin === range.min && formData.targetAgeMax === range.max;
                      return (
                        <Button
                          key={range.label}
                          variant={isSelected ? "default" : "outline"}
                          size="sm"
                          onClick={() => {
                            if (isSelected) {
                              setFormData({ ...formData, targetAgeMin: null, targetAgeMax: null });
                            } else {
                              setFormData({ ...formData, targetAgeMin: range.min, targetAgeMax: range.max });
                            }
                          }}
                          data-testid={`button-age-${range.label}`}
                        >
                          {range.label}
                        </Button>
                      );
                    })}
                    <Button
                      variant={!formData.targetAgeMin ? "default" : "outline"}
                      size="sm"
                      onClick={() => setFormData({ ...formData, targetAgeMin: null, targetAgeMax: null })}
                    >
                      All Ages
                    </Button>
                  </div>
                </div>

                <div className="space-y-3">
                  <Label>Gender</Label>
                  <div className="flex flex-wrap gap-2">
                    {GENDERS.map((gender) => {
                      const isSelected = formData.targetGenders.includes(gender);
                      return (
                        <Button
                          key={gender}
                          variant={isSelected ? "default" : "outline"}
                          size="sm"
                          onClick={() => {
                            if (isSelected) {
                              setFormData({
                                ...formData,
                                targetGenders: formData.targetGenders.filter(g => g !== gender),
                              });
                            } else {
                              setFormData({
                                ...formData,
                                targetGenders: [...formData.targetGenders, gender],
                              });
                            }
                          }}
                          className="capitalize"
                          data-testid={`button-gender-${gender}`}
                        >
                          {gender}
                        </Button>
                      );
                    })}
                    <Button
                      variant={formData.targetGenders.length === 0 ? "default" : "outline"}
                      size="sm"
                      onClick={() => setFormData({ ...formData, targetGenders: [] })}
                    >
                      All Genders
                    </Button>
                  </div>
                </div>

                <div className="space-y-3">
                  <Label>Provinces</Label>
                  <div className="flex flex-wrap gap-2">
                    {PROVINCES.map((province) => {
                      const isSelected = formData.targetProvinces.includes(province);
                      return (
                        <Button
                          key={province}
                          variant={isSelected ? "default" : "outline"}
                          size="sm"
                          onClick={() => {
                            if (isSelected) {
                              setFormData({
                                ...formData,
                                targetProvinces: formData.targetProvinces.filter(p => p !== province),
                              });
                            } else {
                              setFormData({
                                ...formData,
                                targetProvinces: [...formData.targetProvinces, province],
                              });
                            }
                          }}
                          data-testid={`button-province-${province.toLowerCase().replace(" ", "-")}`}
                        >
                          {province}
                        </Button>
                      );
                    })}
                  </div>
                  <Button
                    variant={formData.targetProvinces.length === 0 ? "default" : "outline"}
                    size="sm"
                    onClick={() => setFormData({ ...formData, targetProvinces: [] })}
                  >
                    All Provinces
                  </Button>
                </div>
              </div>
            )}

            {currentStep === 2 && (
              <div className="space-y-6">
                <div className="space-y-3">
                  <Label>Creative Assets</Label>
                  <p className="text-sm text-slate-500">Upload a video (max 15s, MP4) or image (1080x1920 or 1200x628)</p>
                  <div className="border-2 border-dashed border-slate-200 rounded-lg p-8 text-center">
                    <div className="flex justify-center gap-4 mb-4">
                      <FileVideo size={32} className="text-slate-400" />
                      <FileImage size={32} className="text-slate-400" />
                    </div>
                    <p className="text-slate-500 mb-2">Drag and drop files here, or</p>
                    <Button variant="outline" size="sm">Browse Files</Button>
                    <p className="text-xs text-slate-400 mt-2">File upload will be enabled in production</p>
                  </div>
                </div>

                <div className="space-y-3">
                  <Label>Survey Questions (max 20)</Label>
                  <p className="text-sm text-slate-500">Add multiple choice questions for user engagement</p>
                  
                  {formData.questions.length > 0 && (
                    <div className="space-y-2 mb-4">
                      {formData.questions.map((q, index) => (
                        <div key={index} className="flex items-start gap-2 p-3 bg-slate-100 rounded-lg border border-slate-200">
                          <div className="flex-1">
                            <p className="font-medium text-sm text-slate-900">{q.questionText}</p>
                            <p className="text-xs text-slate-600">{q.options.join(" | ")}</p>
                          </div>
                          <Button variant="ghost" size="icon" onClick={() => removeQuestion(index)} className="text-slate-500 hover:text-slate-700">
                            <X size={16} />
                          </Button>
                        </div>
                      ))}
                    </div>
                  )}

                  {formData.questions.length < 20 && (
                    <div className="space-y-3 p-4 border border-slate-200 rounded-lg">
                      <Input
                        placeholder="Question text"
                        value={newQuestion.text}
                        onChange={(e) => setNewQuestion({ ...newQuestion, text: e.target.value })}
                        data-testid="input-question-text"
                      />
                      <div className="grid grid-cols-2 gap-2">
                        {newQuestion.options.map((option, index) => (
                          <Input
                            key={index}
                            placeholder={`Option ${index + 1}`}
                            value={option}
                            onChange={(e) => {
                              const newOptions = [...newQuestion.options];
                              newOptions[index] = e.target.value;
                              setNewQuestion({ ...newQuestion, options: newOptions });
                            }}
                            data-testid={`input-option-${index}`}
                          />
                        ))}
                      </div>
                      <Button variant="outline" size="sm" onClick={addQuestion} data-testid="button-add-question">
                        <Plus size={14} className="mr-2" />
                        Add Question
                      </Button>
                    </div>
                  )}
                </div>
              </div>
            )}

            {currentStep === 3 && (
              <div className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="cpe">Cost Per Engagement (CPE) *</Label>
                  <p className="text-sm text-slate-500">Minimum R0.10 per engagement</p>
                  <div className="flex items-center gap-2">
                    <span className="text-slate-500">R</span>
                    <Input
                      id="cpe"
                      type="number"
                      min="0.10"
                      step="0.01"
                      value={formData.cpeZar}
                      onChange={(e) => setFormData({ ...formData, cpeZar: e.target.value })}
                      className="w-32"
                      data-testid="input-cpe"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="totalBudget">Total Budget *</Label>
                  <div className="flex items-center gap-2">
                    <span className="text-slate-500">R</span>
                    <Input
                      id="totalBudget"
                      type="number"
                      min="100"
                      step="100"
                      placeholder="e.g., 10000"
                      value={formData.totalBudget}
                      onChange={(e) => setFormData({ ...formData, totalBudget: e.target.value })}
                      className="w-40"
                      data-testid="input-total-budget"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="dailyCap">Daily Cap (optional)</Label>
                  <p className="text-sm text-slate-500">Maximum spend per day</p>
                  <div className="flex items-center gap-2">
                    <span className="text-slate-500">R</span>
                    <Input
                      id="dailyCap"
                      type="number"
                      min="10"
                      step="10"
                      placeholder="No limit"
                      value={formData.dailyCap}
                      onChange={(e) => setFormData({ ...formData, dailyCap: e.target.value })}
                      className="w-40"
                      data-testid="input-daily-cap"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label>Frequency Cap Per User</Label>
                  <p className="text-sm text-slate-500">Max impressions per user per day: {formData.frequencyCapPerUser}</p>
                  <Slider
                    value={[formData.frequencyCapPerUser]}
                    onValueChange={(value) => setFormData({ ...formData, frequencyCapPerUser: value[0] })}
                    min={1}
                    max={5}
                    step={1}
                    className="w-64"
                    data-testid="slider-frequency-cap"
                  />
                </div>
              </div>
            )}

            {currentStep === 4 && (
              <div className="space-y-6">
                <h3 className="text-lg font-semibold">Review Your Campaign</h3>
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm text-slate-500">Campaign Name</p>
                      <p className="font-medium">{formData.name || "-"}</p>
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Dates</p>
                      <p className="font-medium">
                        {formData.startDate || "Not set"} - {formData.endDate || "Not set"}
                      </p>
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Target Audience</p>
                      <p className="font-medium">
                        {formData.targetAgeMin ? `${formData.targetAgeMin}-${formData.targetAgeMax}` : "All ages"}
                        {formData.targetGenders.length > 0 ? `, ${formData.targetGenders.join(", ")}` : ", All genders"}
                      </p>
                      <p className="text-sm">
                        {formData.targetProvinces.length > 0 ? formData.targetProvinces.join(", ") : "All provinces"}
                      </p>
                    </div>
                  </div>
                  
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm text-slate-500">Budget</p>
                      <p className="font-medium">R {formData.totalBudget || "0"}</p>
                      {formData.dailyCap && <p className="text-sm">Daily cap: R {formData.dailyCap}</p>}
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Cost Per Engagement</p>
                      <p className="font-medium">R {formData.cpeZar}</p>
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Survey Questions</p>
                      <p className="font-medium">{formData.questions.length} questions</p>
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Frequency Cap</p>
                      <p className="font-medium">{formData.frequencyCapPerUser} per user per day</p>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </CardContent>
        </Card>

        <div className="flex items-center justify-between mt-6">
          <Button variant="outline" onClick={prevStep} disabled={currentStep === 0}>
            <ArrowLeft size={16} className="mr-2" />
            Previous
          </Button>
          
          <div className="flex gap-2">
            {currentStep === STEPS.length - 1 ? (
              <>
                <Button
                  variant="outline"
                  onClick={handleSaveDraft}
                  disabled={createCampaignMutation.isPending}
                  data-testid="button-save-draft"
                >
                  {createCampaignMutation.isPending && <Loader2 className="animate-spin mr-2" size={16} />}
                  Save as Draft
                </Button>
                <Button
                  onClick={handleSubmit}
                  disabled={submitCampaignMutation.isPending || !isStepValid()}
                  className="bg-pink-600 hover:bg-pink-700"
                  data-testid="button-submit-campaign"
                >
                  {submitCampaignMutation.isPending && <Loader2 className="animate-spin mr-2" size={16} />}
                  Submit for Review
                </Button>
              </>
            ) : (
              <Button
                onClick={nextStep}
                disabled={!isStepValid()}
                className="bg-pink-600 hover:bg-pink-700"
                data-testid="button-next-step"
              >
                Next
                <ArrowRight size={16} className="ml-2" />
              </Button>
            )}
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
