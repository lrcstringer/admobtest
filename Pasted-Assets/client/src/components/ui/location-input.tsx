"use client"

import * as React from "react"
import { Check, MapPin, Search } from "lucide-react"
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from "@/components/ui/command"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"

const LOCATIONS = [
  { value: "johannesburg, gauteng", label: "Johannesburg, Gauteng, South Africa" },
  { value: "cape town, western cape", label: "Cape Town, Western Cape, South Africa" },
  { value: "durban, kwazulu-natal", label: "Durban, KwaZulu-Natal, South Africa" },
  { value: "pretoria, gauteng", label: "Pretoria, Gauteng, South Africa" },
  { value: "sandton, gauteng", label: "Sandton, Gauteng, South Africa" },
  { value: "soweto, gauteng", label: "Soweto, Gauteng, South Africa" },
  { value: "port elizabeth, eastern cape", label: "Gqeberha (Port Elizabeth), Eastern Cape" },
  { value: "bloemfontein, free state", label: "Bloemfontein, Free State, South Africa" },
  { value: "centurion, gauteng", label: "Centurion, Gauteng, South Africa" },
  { value: "stellenbosch, western cape", label: "Stellenbosch, Western Cape, South Africa" },
  { value: "east london, eastern cape", label: "East London, Eastern Cape, South Africa" },
  { value: "nelspruit, mpumalanga", label: "Mbombela (Nelspruit), Mpumalanga" },
  { value: "polokwane, limpopo", label: "Polokwane, Limpopo, South Africa" },
  { value: "kimberley, northern cape", label: "Kimberley, Northern Cape, South Africa" },
  { value: "rustenburg, north west", label: "Rustenburg, North West, South Africa" },
]

interface LocationInputProps {
  value?: string
  onSelect?: (value: string) => void
}

export function LocationInput({ value, onSelect }: LocationInputProps) {
  const [open, setOpen] = React.useState(false)
  const [searchQuery, setSearchQuery] = React.useState("")

  const filteredLocations = LOCATIONS.filter((item) => 
    item.label.toLowerCase().includes(searchQuery.toLowerCase())
  )

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-full justify-between h-12 bg-card border-white/10 text-white hover:bg-white/5 hover:text-white font-normal"
        >
          {value
            ? LOCATIONS.find((framework) => framework.value === value)?.label || value
            : "Search your city or town..."}
          <Search className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-[--radix-popover-trigger-width] p-0 bg-card border-white/10 text-white" align="start">
        <Command className="bg-transparent" shouldFilter={false}>
          <div className="flex items-center border-b border-white/10 px-3" cmdk-input-wrapper="">
            <Search className="mr-2 h-4 w-4 shrink-0 opacity-50" />
            <input
              className="flex h-11 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50 text-white"
              placeholder="Type to search..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
          <CommandList>
            {filteredLocations.length === 0 && searchQuery !== "" && (
               <div className="py-6 text-center text-sm text-muted-foreground">
                No location found.
               </div>
            )}
            <CommandGroup>
              {filteredLocations.map((framework) => (
                <CommandItem
                  key={framework.value}
                  value={framework.value}
                  onSelect={(currentValue) => {
                    onSelect?.(currentValue === value ? "" : currentValue)
                    setOpen(false)
                  }}
                  className="text-white hover:bg-white/10 aria-selected:bg-white/10 cursor-pointer py-3"
                >
                  <MapPin className="mr-2 h-4 w-4 text-muted-foreground" />
                  <span>{framework.label}</span>
                  <Check
                    className={cn(
                      "ml-auto h-4 w-4",
                      value === framework.value ? "opacity-100" : "opacity-0"
                    )}
                  />
                </CommandItem>
              ))}
            </CommandGroup>
            <div className="border-t border-white/5 py-2 px-3 flex justify-end">
               <span className="text-[10px] text-muted-foreground/50 flex items-center gap-1">
                 powered by <span className="font-bold text-muted-foreground/70">Google</span>
               </span>
            </div>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  )
}
