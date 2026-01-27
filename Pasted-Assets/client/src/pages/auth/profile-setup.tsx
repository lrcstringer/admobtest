import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useState } from "react";
import { motion } from "framer-motion";
import { Camera, ArrowRight, User, Loader2 } from "lucide-react";
import { useLocation } from "wouter";

import { LocationInput } from "@/components/ui/location-input";

export default function ProfileSetup() {
  const [, setLocation] = useLocation();
  const [isLoading, setIsLoading] = useState(false);
  const [photoPreview, setPhotoPreview] = useState<string | null>(null);
  const [locationValue, setLocationValue] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      setLocation("/auth/permissions");
    }, 1000);
  };

  const handlePhotoUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setPhotoPreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  return (
    <MobileFrame className="bg-background relative">
      <div className="flex-1 flex flex-col px-6 py-8 overflow-y-auto">
        <div className="mb-8">
          <h1 className="text-3xl font-heading font-bold text-white mb-2">Create Profile</h1>
          <p className="text-muted-foreground">
            Tell us a bit about yourself to start earning.
          </p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6 pb-8">
          {/* Photo Upload */}
          <div className="flex justify-center mb-8">
            <div className="relative group cursor-pointer">
              <div className={`w-28 h-28 rounded-full flex items-center justify-center border-2 border-dashed border-white/20 bg-white/5 overflow-hidden ${photoPreview ? 'border-solid border-primary' : ''}`}>
                {photoPreview ? (
                  <img src={photoPreview} alt="Profile" className="w-full h-full object-cover" />
                ) : (
                  <User size={40} className="text-white/20" />
                )}
              </div>
              <div className="absolute bottom-0 right-0 bg-secondary text-background p-2 rounded-full shadow-lg">
                <Camera size={16} />
              </div>
              <input 
                type="file" 
                accept="image/*" 
                className="absolute inset-0 opacity-0 cursor-pointer"
                onChange={handlePhotoUpload}
              />
            </div>
          </div>

          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="firstName" className="text-white">First Name</Label>
                <Input id="firstName" placeholder="Fundeka" className="bg-card border-white/10 text-white h-12" required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="surname" className="text-white">Surname</Label>
                <Input id="surname" placeholder="Zulu" className="bg-card border-white/10 text-white h-12" required />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="username" className="text-white">Username</Label>
              <Input id="username" placeholder="@fundeka_z" className="bg-card border-white/10 text-white h-12" maxLength={20} required />
              <p className="text-xs text-muted-foreground">Don't use your real name, this is publicly visible. No spaces.</p>
            </div>

            <div className="space-y-2">
              <Label className="text-white">Location</Label>
              <LocationInput value={locationValue} onSelect={setLocationValue} />
              <p className="text-xs text-muted-foreground">We use this to match you with relevant earn opportunities.</p>
            </div>

            <div className="grid grid-cols-1 gap-4">
              <div className="space-y-2">
                <Label className="text-white">Date of Birth</Label>
                <div className="grid grid-cols-3 gap-2">
                  <Select required>
                    <SelectTrigger className="bg-card border-white/10 text-white h-12">
                      <SelectValue placeholder="Day" />
                    </SelectTrigger>
                    <SelectContent className="bg-card border-white/10 text-white max-h-[300px]">
                      {Array.from({ length: 31 }, (_, i) => i + 1).map((day) => (
                        <SelectItem key={day} value={day.toString()}>{day}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>

                  <Select required>
                    <SelectTrigger className="bg-card border-white/10 text-white h-12">
                      <SelectValue placeholder="Month" />
                    </SelectTrigger>
                    <SelectContent className="bg-card border-white/10 text-white max-h-[300px]">
                      {["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"].map((month, i) => (
                        <SelectItem key={month} value={(i + 1).toString()}>{month}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>

                  <Select required>
                    <SelectTrigger className="bg-card border-white/10 text-white h-12">
                      <SelectValue placeholder="Year" />
                    </SelectTrigger>
                    <SelectContent className="bg-card border-white/10 text-white max-h-[300px]">
                      {Array.from({ length: 100 }, (_, i) => new Date().getFullYear() - 16 - i).map((year) => (
                        <SelectItem key={year} value={year.toString()}>{year}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="gender" className="text-white">Gender</Label>
                <Select required>
                  <SelectTrigger className="bg-card border-white/10 text-white h-12">
                    <SelectValue placeholder="Select" />
                  </SelectTrigger>
                  <SelectContent className="bg-card border-white/10 text-white">
                    <SelectItem value="female">Female</SelectItem>
                    <SelectItem value="male">Male</SelectItem>
                    <SelectItem value="non-binary">Non-binary</SelectItem>
                    <SelectItem value="prefer-not">Prefer not to say</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>

          <div className="pt-4">
            <Button 
              type="submit" 
              size="lg" 
              className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-[0_4px_20px_rgba(255,51,138,0.3)] transition-all rounded-xl"
              disabled={isLoading}
            >
              {isLoading ? <Loader2 className="animate-spin" /> : (
                <span className="flex items-center gap-2">
                  Complete Profile <ArrowRight size={20} />
                </span>
              )}
            </Button>
          </div>
        </form>
      </div>
    </MobileFrame>
  );
}
