# Brand Storefront Builder — Comprehensive Guide

> **Admin Portal → Buy Management → Brand Storefronts → Create Storefront**

This guide covers every feature, field, and option available in the Brand Storefront Builder. Use it to create polished, branded storefront pages that appear in the consumer app's Buy tab.

---

## Table of Contents

1. [Overview & Layout](#1-overview--layout)
2. [Templates](#2-templates)
3. [Tab 1: Basics](#3-tab-1-basics)
4. [Tab 2: Hero & Visual](#4-tab-2-hero--visual)
5. [Tab 3: Content & Links](#5-tab-3-content--links)
6. [Tab 4: Dynamic Content](#6-tab-4-dynamic-content)
7. [Tab 5: Products](#7-tab-5-products)
8. [Tab 6: Analytics](#8-tab-6-analytics)
9. [Save, Publish & Auto-Save](#9-save-publish--auto-save)
10. [Undo / Redo](#10-undo--redo)
11. [Workflow: Creating a Storefront from Scratch](#11-workflow-creating-a-storefront-from-scratch)

---

## 1. Overview & Layout

The builder uses a **split-pane layout**:

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Back to Storefronts    Create Brand Storefront    [Save] [Pub]  │
├───────────────────────────────────────┬─────────────────────────────┤
│                                       │                             │
│   EDITING PANEL (flex: 5)             │   LIVE PREVIEW (flex: 3)    │
│                                       │                             │
│   ┌─────────────────────────────┐     │   ┌───────────────────┐     │
│   │ Tab Bar                     │     │   │   ╭───────────╮   │     │
│   │ Basics │ Hero │ Content │ …│     │   │   │ Phone     │   │     │
│   ├─────────────────────────────┤     │   │   │ Frame     │   │     │
│   │                             │     │   │   │           │   │     │
│   │   Form fields for the      │     │   │   │  Preview  │   │     │
│   │   selected tab              │     │   │   │  of your  │   │     │
│   │                             │     │   │   │ storefront│   │     │
│   │                             │     │   │   │           │   │     │
│   │                             │     │   │   │           │   │     │
│   │                             │     │   │   ╰───────────╯   │     │
│   └─────────────────────────────┘     │   └───────────────────┘     │
│                                       │                             │
│   [Undo] [Redo]  ● Unsaved changes   │      Live Preview           │
│                                       │                             │
└───────────────────────────────────────┴─────────────────────────────┘
```

**Left panel** — The editing area with 6 tabs. Each tab contains form fields for a different aspect of the storefront.

**Right panel** — A live phone-frame preview that updates in real time as you edit. The preview renders a scaled-down version of the actual storefront screen the consumer will see.

**Top bar** — Contains:
- **← Back** button (warns if unsaved changes)
- **Page title** ("Create Brand Storefront" or "Edit Brand Storefront")
- **Save** button (draft save, does not publish)
- **Publish** button (validates and makes the storefront live)

**Bottom bar** — Contains:
- **Undo / Redo** buttons
- **Unsaved changes** indicator (orange dot + text, appears when edits haven't been saved)

---

## 2. Templates

When creating a new storefront, you can start from a **template** to pre-populate sections and settings. Templates are available at the top of the **Basics** tab.

### Available Templates

| Template | Description | Pre-populated Sections |
|----------|-------------|----------------------|
| **Telecom** | For mobile network operators & ISPs | Quick Actions, Featured Products, Products, Promotions |
| **Retail** | For retail stores & e-commerce brands | Featured Products, Products, Gallery, Reviews, About |
| **Restaurant** | For food & beverage businesses | Quick Actions, Banner, Products, Gallery, Reviews, Location Card |
| **Services** | For professional service providers | About, Quick Actions, Products, Testimonials, FAQ |
| **Entertainment** | For entertainment & media brands | Video Showcase, Featured Products, Products, Gallery, Social Links |

### How Templates Work

```
┌───────────────────────────────────────────┐
│  Start from Template (optional)           │
│                                           │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐│
│  │ 📡  │ │ 🛍  │ │ 🍽  │ │ 🔧  │ │ 🎬  ││
│  │Telcm│ │Retl │ │Rest │ │Serv │ │Entr ││
│  └──┬──┘ └─────┘ └─────┘ └─────┘ └─────┘│
│     │                                     │
│  Click to apply                           │
└─────┼─────────────────────────────────────┘
      │
      ▼
  Confirmation dialog:
  "Apply Telecom Template?"
  "This will replace your current sections
   with the Telecom template sections."
  [Cancel]  [Apply]
```

- Selecting a template **replaces all current Dynamic Content sections** with the template's preset sections.
- It does NOT overwrite your Basics, Hero, or Content & Links settings.
- You get a confirmation dialog before the template is applied.
- After applying, you can freely add, remove, or reorder sections.

---

## 3. Tab 1: Basics

The Basics tab captures the brand's identity and core information.

```
┌─────────────────────────────────────────┐
│  BASICS                                 │
│                                         │
│  Start from Template (optional)         │
│  [Telecom] [Retail] [Restaurant] ...    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Brand Name *                           │
│  ┌─────────────────────────────────┐    │
│  │ e.g. Vodacom                    │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Brand ID                               │
│  ┌─────────────────────────────────┐    │
│  │ auto-generated-or-custom        │    │
│  └─────────────────────────────────┘    │
│  ℹ Unique identifier (auto-generated)   │
│                                         │
│  Tagline                                │
│  ┌─────────────────────────────────┐    │
│  │ e.g. "Power to you"            │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Description                            │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │ Multi-line brand description    │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Established Year                       │
│  ┌─────────────────────────────────┐    │
│  │ e.g. 1994                       │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ☑ Show Chat Button                     │
│  ℹ Display a chat button on storefront  │
│                                         │
│  Trust Badges                           │
│  ☑ Verified    ☑ Top Seller             │
│  ☐ Local Business    ☐ New Brand        │
│                                         │
└─────────────────────────────────────────┘
```

### Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| **Brand Name** | Yes* | The display name of the brand. Appears as the storefront title. |
| **Brand ID** | No | A unique identifier string. Auto-generated if left blank. Used internally for routing and data association. |
| **Tagline** | No | A short slogan or catchphrase displayed below the brand name. |
| **Description** | No | A longer brand description (multi-line). Can appear in the "About" section of the storefront. |
| **Established Year** | No | The year the brand was founded. Displayed in the storefront header area. |
| **Show Chat Button** | No | Toggle (default: on). When enabled, a chat/message button appears on the consumer storefront, allowing users to message the brand. |

### Trust Badges

Trust badges are visual indicators that appear on the storefront to build consumer confidence. You can select multiple badges:

```
┌────────────────────────────────────────────┐
│  Trust Badges                              │
│                                            │
│  ┌──────────┐  ┌───────────┐               │
│  │ ✓ Verified│  │ ★ Top     │               │
│  │          │  │   Seller  │               │
│  └──────────┘  └───────────┘               │
│                                            │
│  ┌──────────┐  ┌───────────┐               │
│  │ 📍 Local │  │ 🆕 New    │               │
│  │ Business │  │   Brand   │               │
│  └──────────┘  └───────────┘               │
└────────────────────────────────────────────┘
```

| Badge | Meaning |
|-------|---------|
| **Verified** | Brand identity has been verified by iMali |
| **Top Seller** | Brand is a high-performing seller on the platform |
| **Local Business** | Brand is a locally-owned South African business |
| **New Brand** | Brand is new to the iMali marketplace |

---

## 4. Tab 2: Hero & Visual

This tab controls the visual identity of the storefront — the hero banner, logos, and colour scheme.

```
┌─────────────────────────────────────────┐
│  HERO & VISUAL                          │
│                                         │
│  Hero Style                             │
│  ┌─────────────────────────────────┐    │
│  │ Full Bleed Image            ▼   │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Hero Image URL                         │
│  ┌─────────────────────────────────┐    │
│  │ https://...                     │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Cover Image URL                        │
│  ┌─────────────────────────────────┐    │
│  │ https://...                     │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Brand Logo URL *                       │
│  ┌─────────────────────────────────┐    │
│  │ https://...                     │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─ Focal Point ──────────────────┐    │
│  │                                 │    │
│  │      ┌──────────────────┐       │    │
│  │      │    Hero Image    │       │    │
│  │      │       📌         │       │    │
│  │      │    (drag pin)    │       │    │
│  │      └──────────────────┘       │    │
│  │                                 │    │
│  │  X: 0.50   Y: 0.35             │    │
│  │  [Reset to Centre]             │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ── Colour Palette ──────────────────   │
│                                         │
│  Brand Colour                           │
│  ┌─────────┐ ┌─────────────────────┐    │
│  │ ██████  │ │ #E60000             │    │
│  └─────────┘ └─────────────────────┘    │
│                                         │
│  Accent Colour                          │
│  ┌─────────┐ ┌─────────────────────┐    │
│  │ ██████  │ │ #FF6600             │    │
│  └─────────┘ └─────────────────────┘    │
│                                         │
│  Secondary Colour                       │
│  ┌─────────┐ ┌─────────────────────┐    │
│  │ ██████  │ │ #333333             │    │
│  └─────────┘ └─────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

### Hero Style Options

The hero style determines how the top banner area of the storefront renders:

```
FULL BLEED IMAGE                GRADIENT OVERLAY              MINIMAL
┌─────────────────┐            ┌─────────────────┐           ┌─────────────────┐
│▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│            │░░░▓▓▓▓▓▓▓▓▓▓▓▓▓│           │                 │
│▓▓▓  HERO IMAGE ▓│            │░░░ HERO IMAGE ▓▓│           │   Brand Name    │
│▓▓▓  edge-to-  ▓▓│            │░░░ with gradient│           │   ───────────   │
│▓▓▓  edge      ▓▓│            │░░░ fade on left │           │   Tagline here  │
│▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│            │░░░▓▓▓▓▓▓▓▓▓▓▓▓▓│           │                 │
│   Brand Name     │            │   Brand Name     │           │   [Logo]        │
│   Tagline        │            │   Tagline        │           │                 │
└──────────────────┘            └──────────────────┘           └─────────────────┘
```

| Style | Description |
|-------|-------------|
| **Full Bleed Image** | The hero image fills the entire banner area edge-to-edge. Brand name and tagline overlay the bottom. Best for brands with strong photographic assets. |
| **Gradient Overlay** | The hero image is displayed with a gradient fade on the left side, creating a softer look. Text is more readable over the gradient. |
| **Minimal** | No hero image. A clean, text-focused header with the brand name, tagline, and logo. Best for brands preferring a simple, modern look. |

### Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| **Hero Style** | No | Dropdown: `fullBleedImage`, `gradientOverlay`, `minimal`. Default: `fullBleedImage`. |
| **Hero Image URL** | No | URL to the main banner image. Recommended: wide landscape format (e.g. 1200x400px). |
| **Cover Image URL** | No | URL to an additional cover/background image. Used as a secondary visual element. |
| **Brand Logo URL** | Yes* | URL to the brand's logo image. Displayed in the header and throughout the storefront. Square or circular format recommended (e.g. 200x200px). |

### Focal Point Editor

When a Hero Image URL is provided, a **focal point editor** appears. This lets you control which part of the image stays centred when the hero is cropped on different screen sizes.

```
┌─────────────────────────────────┐
│                                 │
│    ┌───────────────────────┐    │
│    │                       │    │
│    │         📌            │    │    ← Drag the pin to set
│    │      (focal point)    │    │      the focal point
│    │                       │    │
│    └───────────────────────┘    │
│                                 │
│    X: 0.50    Y: 0.35           │    ← Coordinates (0.0 to 1.0)
│                                 │
│    [Reset to Centre]            │    ← Resets to (0.5, 0.5)
│                                 │
└─────────────────────────────────┘
```

- **X coordinate**: 0.0 = left edge, 1.0 = right edge
- **Y coordinate**: 0.0 = top edge, 1.0 = bottom edge
- The focal point ensures the most important part of the hero image is always visible, even when cropped.

### Colour Palette

Each colour field has two parts:
- A **colour swatch** (visual preview, updates live)
- A **hex input** field (enter a 6-digit hex code like `#E60000`)

| Colour | Purpose |
|--------|---------|
| **Brand Colour** | Primary brand colour. Used for headers, buttons, and primary UI elements on the storefront. |
| **Accent Colour** | Secondary highlight colour. Used for badges, highlights, call-to-action elements. |
| **Secondary Colour** | Tertiary colour. Used for subtle backgrounds, borders, secondary text. |

---

## 5. Tab 3: Content & Links

This tab manages supplementary content — banners, announcements, and social media links.

```
┌─────────────────────────────────────────┐
│  CONTENT & LINKS                        │
│                                         │
│  ── Banner ──────────────────────────   │
│                                         │
│  Banner Image URL                       │
│  ┌─────────────────────────────────┐    │
│  │ https://...                     │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Banner Deep Link                       │
│  ┌─────────────────────────────────┐    │
│  │ imali://buy/product/123        │    │
│  └─────────────────────────────────┘    │
│  ℹ Deep link when banner is tapped      │
│                                         │
│  ── Announcement Bar ────────────────   │
│                                         │
│  Announcement Text                      │
│  ┌─────────────────────────────────┐    │
│  │ Free delivery on orders over    │    │
│  │ R100 this weekend!              │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Announcement Deep Link                 │
│  ┌─────────────────────────────────┐    │
│  │ imali://promotions/free-del    │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ☑ Dismissible                          │
│  ℹ Allow users to dismiss the bar       │
│                                         │
│  ── Social Links ────────────────────   │
│                                         │
│  WhatsApp   ┌──────────────────────┐    │
│             │ +27...               │    │
│             └──────────────────────┘    │
│  Instagram  ┌──────────────────────┐    │
│             │ @brandname           │    │
│             └──────────────────────┘    │
│  Facebook   ┌──────────────────────┐    │
│             │ facebook.com/...     │    │
│             └──────────────────────┘    │
│  Website    ┌──────────────────────┐    │
│             │ https://...          │    │
│             └──────────────────────┘    │
│  TikTok     ┌──────────────────────┐    │
│             │ @brandname           │    │
│             └──────────────────────┘    │
│  X (Twitter)┌──────────────────────┐    │
│             │ @brandname           │    │
│             └──────────────────────┘    │
│  YouTube    ┌──────────────────────┐    │
│             │ youtube.com/...      │    │
│             └──────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

### Banner

The banner is a tappable promotional image that appears on the storefront.

| Field | Description |
|-------|-------------|
| **Banner Image URL** | URL to the banner image. Recommended: wide format (e.g. 1000x200px). |
| **Banner Deep Link** | A deep link URL that opens when the user taps the banner. Use `imali://` scheme for in-app navigation or `https://` for external links. |

### Announcement Bar

A prominent text bar displayed at the top of the storefront — ideal for promotions, delivery info, or important notices.

```
Consumer sees:
┌─────────────────────────────────────────┐
│ 🎉 Free delivery on orders over R100!  ✕│  ← Dismissible
└─────────────────────────────────────────┘
```

| Field | Description |
|-------|-------------|
| **Announcement Text** | The message displayed in the bar. Keep it short — 1-2 lines. |
| **Announcement Deep Link** | Tapping the bar navigates to this deep link. Optional. |
| **Dismissible** | Toggle (default: on). When enabled, users can dismiss/close the announcement bar with an ✕ button. |

### Social Links

All social link fields are optional. Only filled-in links appear on the storefront. They render as tappable icons.

| Platform | Input Format | What It Does |
|----------|-------------|--------------|
| **WhatsApp** | Phone number (e.g. `+27821234567`) | Opens WhatsApp chat with the brand |
| **Instagram** | Handle or URL (e.g. `@brand` or full URL) | Opens Instagram profile |
| **Facebook** | Page URL | Opens Facebook page |
| **Website** | Full URL (e.g. `https://brand.co.za`) | Opens the brand's website |
| **TikTok** | Handle or URL | Opens TikTok profile |
| **X (Twitter)** | Handle or URL | Opens X/Twitter profile |
| **YouTube** | Channel URL | Opens YouTube channel |

---

## 6. Tab 4: Dynamic Content

This is the most powerful tab. It lets you build the storefront's content by adding, removing, and reordering **sections**. Each section is a distinct content block.

```
┌─────────────────────────────────────────┐
│  DYNAMIC CONTENT                        │
│                                         │
│  [+ Add Section]                        │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ ≡  Quick Actions         👁 🗑  │    │
│  │    Visible                      │    │
│  └─────────────────────────────────┘    │
│  ┌─────────────────────────────────┐    │
│  │ ≡  Featured Products    👁 🗑  │    │
│  │    Visible                      │    │
│  └─────────────────────────────────┘    │
│  ┌─────────────────────────────────┐    │
│  │ ≡  Products              👁 🗑  │    │
│  │    Visible                      │    │
│  └─────────────────────────────────┘    │
│  ┌─────────────────────────────────┐    │
│  │ ≡  Promotions            👁 🗑  │    │
│  │    Hidden                       │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ℹ Drag ≡ to reorder sections          │
│                                         │
└─────────────────────────────────────────┘
```

### Section Management

- **Add Section**: Click the "+ Add Section" button to open a dropdown of all 17 section types. Select one to add it to the bottom of the list.
- **Reorder**: Drag the ≡ handle to change section order. The live preview updates immediately.
- **Visibility Toggle**: Click the 👁 eye icon to show/hide a section. Hidden sections are saved but not displayed to consumers. Useful for preparing content before revealing it.
- **Delete**: Click the 🗑 trash icon to remove a section. This action is undoable via Ctrl+Z.

### All 17 Section Types

#### 1. Quick Actions
```
┌─────────────────────────────┐
│  Quick Actions              │
│  ┌─────┐ ┌─────┐ ┌─────┐   │
│  │ Buy │ │ Pay │ │Chat │   │
│  │Data │ │Bill │ │ Us  │   │
│  └─────┘ └─────┘ └─────┘   │
└─────────────────────────────┘
```
Shortcut buttons for common brand actions (buy airtime, pay bill, contact, etc.). Renders as a horizontal row of action chips.

#### 2. Featured Products
```
┌─────────────────────────────┐
│  Featured Products          │
│  ┌────────┐ ┌────────┐      │
│  │ ★ Top  │ │ ★ Best │      │
│  │ Product│ │ Seller │      │
│  │ R49.99 │ │ R29.99 │      │
│  └────────┘ └────────┘      │
└─────────────────────────────┘
```
A curated selection of highlighted products. Displays as a horizontal scrollable carousel of product cards.

#### 3. Products
```
┌─────────────────────────────┐
│  Products                   │
│  ┌────────┐ ┌────────┐      │
│  │Product │ │Product │      │
│  │  One   │ │  Two   │      │
│  │ R19.99 │ │ R39.99 │      │
│  └────────┘ └────────┘      │
│  ┌────────┐ ┌────────┐      │
│  │Product │ │Product │      │
│  │ Three  │ │  Four  │      │
│  │ R59.99 │ │ R14.99 │      │
│  └────────┘ └────────┘      │
└─────────────────────────────┘
```
Full product grid. Shows all brand products in a grid layout. Products are managed separately via the admin VAS Products system.

#### 4. Banner
```
┌─────────────────────────────┐
│ ┌─────────────────────────┐ │
│ │                         │ │
│ │   PROMOTIONAL BANNER    │ │
│ │      (tappable)         │ │
│ │                         │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```
A large promotional banner image. Tapping navigates to a deep link. Different from the Content & Links banner — this one appears inline within the content sections.

#### 5. Promotions
```
┌─────────────────────────────┐
│  Promotions          🔥     │
│  ┌─────────────────────┐    │
│  │ 30% OFF all data    │    │
│  │ bundles this weekend │    │
│  │ Use code: DATA30    │    │
│  └─────────────────────┘    │
│  ┌─────────────────────┐    │
│  │ Buy 1 Get 1 Free    │    │
│  │ on selected airtime │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```
Active promotions and special offers. Displays as a list of promotion cards.

#### 6. Gallery
```
┌─────────────────────────────┐
│  Gallery                    │
│  ┌──────┐ ┌──────┐ ┌──────┐│
│  │ 📷 1 │ │ 📷 2 │ │ 📷 3 ││
│  └──────┘ └──────┘ └──────┘│
│  ┌──────┐ ┌──────┐ ┌──────┐│
│  │ 📷 4 │ │ 📷 5 │ │ 📷 6 ││
│  └──────┘ └──────┘ └──────┘│
└─────────────────────────────┘
```
A photo gallery grid. Ideal for showcasing products, store interiors, brand lifestyle imagery.

#### 7. Reviews
```
┌─────────────────────────────┐
│  Reviews               ★4.5│
│  ┌─────────────────────┐    │
│  │ ★★★★★  "Great       │    │
│  │ service and fast     │    │
│  │ delivery!" - Thabo   │    │
│  └─────────────────────┘    │
│  ┌─────────────────────┐    │
│  │ ★★★★☆  "Good        │    │
│  │ products" - Naledi   │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```
Customer reviews and ratings. Displays star ratings with review text.

#### 8. About
```
┌─────────────────────────────┐
│  About Us                   │
│                             │
│  Founded in 1994, we are    │
│  South Africa's leading     │
│  telecommunications         │
│  provider, connecting       │
│  millions of people...      │
│                             │
│  Est. 1994  │  📍 Jo'burg  │
└─────────────────────────────┘
```
A brand description section. Pulls from the Description and Established Year fields on the Basics tab.

#### 9. Social Links
```
┌─────────────────────────────┐
│  Follow Us                  │
│                             │
│  📱 WhatsApp  📸 Instagram  │
│  📘 Facebook  🌐 Website    │
│  🎵 TikTok   🐦 X          │
│  ▶ YouTube                  │
└─────────────────────────────┘
```
Renders the social links from the Content & Links tab as tappable icons in a grid.

#### 10. Announcement Bar
```
┌─────────────────────────────┐
│ 📢 Weekend sale starts now! │
└─────────────────────────────┘
```
Inline version of the announcement bar from Content & Links. Appears within the content flow rather than at the top.

#### 11. Video Showcase
```
┌─────────────────────────────┐
│  Videos                     │
│  ┌─────────────────────┐    │
│  │                     │    │
│  │     ▶ (play)        │    │
│  │                     │    │
│  │   Brand Video 1     │    │
│  └─────────────────────┘    │
│  ┌─────────────────────┐    │
│  │     ▶ (play)        │    │
│  │   Brand Video 2     │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```
Embedded video content. Ideal for brand stories, product demos, or promotional videos.

#### 12. Coupon Centre
```
┌─────────────────────────────┐
│  Coupons                    │
│  ┌─────────────────────┐    │
│  │ ✂ SAVE20            │    │
│  │ 20% off your next   │    │
│  │ purchase   [Copy]   │    │
│  └─────────────────────┘    │
│  ┌─────────────────────┐    │
│  │ ✂ FREEDEL           │    │
│  │ Free delivery on    │    │
│  │ orders R50+  [Copy] │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```
Discount coupon codes that users can copy. Displays coupon code, description, and a copy button.

#### 13. FAQ
```
┌─────────────────────────────┐
│  FAQ                        │
│                             │
│  ▸ How do I place an order? │
│  ▸ What are delivery times? │
│  ▸ How do I return items?   │
│  ▸ Do you offer refunds?    │
│                             │
└─────────────────────────────┘
```
Expandable FAQ accordion. Each question expands to reveal the answer when tapped.

#### 14. Testimonials
```
┌─────────────────────────────┐
│  What Our Customers Say     │
│                             │
│  "Outstanding service and   │
│   quality products. Will    │
│   definitely buy again!"   │
│                             │
│   — Sipho M., Durban        │
│                             │
│  ─────────────────────────  │
│                             │
│  "Fast delivery, exactly    │
│   what I ordered."          │
│                             │
│   — Ayanda K., Cape Town    │
└─────────────────────────────┘
```
Customer testimonials in a quote-style format. Different from Reviews in that these are curated quotes without star ratings.

#### 15. Location Card
```
┌─────────────────────────────┐
│  Find Us                    │
│  ┌─────────────────────┐    │
│  │                     │    │
│  │   🗺 Map Preview    │    │
│  │                     │    │
│  └─────────────────────┘    │
│  📍 123 Main Road           │
│     Sandton, Johannesburg   │
│     2196                    │
│  📞 +27 11 123 4567        │
│  [Get Directions]           │
└─────────────────────────────┘
```
A location card with address, map preview, phone number, and directions link. Ideal for brick-and-mortar businesses.

#### 16. Divider
```
┌─────────────────────────────┐
│  ─────────────────────────  │
└─────────────────────────────┘
```
A simple visual separator between sections. Use to create visual breathing room between content blocks.

#### 17. Rich Text
```
┌─────────────────────────────┐
│                             │
│  Custom formatted text      │
│  content with **bold**,     │
│  *italic*, and other        │
│  markdown-style formatting. │
│                             │
└─────────────────────────────┘
```
A free-form rich text block. Supports formatted text for any custom content that doesn't fit the other section types.

### Section Types Quick Reference

| Section | Best For | Appears in Templates |
|---------|----------|---------------------|
| Quick Actions | Action shortcuts | Telecom, Restaurant, Services |
| Featured Products | Hero products | Telecom, Retail, Entertainment |
| Products | Full catalogue | All templates |
| Banner | Promo image | Restaurant |
| Promotions | Sales & offers | Telecom |
| Gallery | Photo grid | Retail, Restaurant, Entertainment |
| Reviews | Customer ratings | Retail, Restaurant |
| About | Brand story | Retail, Services |
| Social Links | Social media | Entertainment |
| Announcement Bar | Urgent notices | — |
| Video Showcase | Video content | Entertainment |
| Coupon Centre | Discount codes | — |
| FAQ | Common questions | Services |
| Testimonials | Curated quotes | Services |
| Location Card | Physical address | Restaurant |
| Divider | Visual separator | — |
| Rich Text | Custom content | — |

---

## 7. Tab 5: Products

```
┌─────────────────────────────────────────┐
│  PRODUCTS                               │
│                                         │
│  Products are managed through the       │
│  admin product management system.       │
│                                         │
│  Use the VAS Products section in the    │
│  admin portal to add, edit, and manage  │
│  products for this brand.               │
│                                         │
│  Go to: Buy Management → VAS Products  │
│                                         │
└─────────────────────────────────────────┘
```

The Products tab is a **placeholder/informational tab**. Products are not managed directly within the Storefront Builder. Instead, they are managed via the separate **VAS Products** admin screen (Admin Portal → Buy Management → VAS Products).

Products associated with the brand's provider will automatically appear in the storefront's Products and Featured Products sections.

---

## 8. Tab 6: Analytics

```
┌─────────────────────────────────────────┐
│  ANALYTICS                              │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │         Total Views             │    │
│  │                                 │    │
│  │          1,247                   │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ℹ Analytics data is read-only         │
│                                         │
└─────────────────────────────────────────┘
```

The Analytics tab displays a **read-only** view of storefront performance metrics:

| Metric | Description |
|--------|-------------|
| **Total Views** | The total number of times the storefront has been viewed by consumers. |

This tab is informational only — no editable fields. Analytics data updates automatically as consumers visit the storefront in the app.

---

## 9. Save, Publish & Auto-Save

### Three Ways to Save

```
                    ┌─────────┐
                    │  DRAFT  │ ← Save button (top-right)
                    │  SAVE   │   Saves without publishing
                    └─────────┘

                    ┌─────────┐
                    │ PUBLISH │ ← Publish button (top-right)
                    │         │   Validates, saves, and makes live
                    └─────────┘

              ┌──────────────────┐
              │  AUTO-SAVE       │ ← Automatic, every 30 seconds
              │  (every 30s)     │   Only when changes exist
              └──────────────────┘
```

### Save (Draft)

- Persists all changes to Firestore
- Does **not** make the storefront visible to consumers
- The storefront remains in "draft" status
- Useful for work-in-progress storefronts

### Publish

Before publishing, the system validates:

```
Publish Validation Checklist:
✓ Brand Name is filled in          (required)
✓ Brand Logo URL is provided       (required)
✓ At least one section exists      (required)

If any check fails:
┌──────────────────────────────────┐
│  ⚠ Cannot Publish                │
│                                  │
│  Please fix the following:       │
│  • Brand name is required        │
│  • Brand logo is required        │
│  • Add at least one section      │
│                                  │
│                    [OK]          │
└──────────────────────────────────┘
```

Once published:
- The storefront becomes visible to all consumers in the Buy tab
- The `isPublished` flag is set to `true`
- Future edits still require re-publishing to go live

### Auto-Save

- Triggers automatically **every 30 seconds** when there are unsaved changes
- Saves as a draft (does not publish)
- The unsaved changes indicator (orange dot) disappears after auto-save
- Does not interrupt your editing flow

### Unsaved Changes Warning

If you try to navigate away (← Back button) with unsaved changes:

```
┌──────────────────────────────────┐
│  Unsaved Changes                 │
│                                  │
│  You have unsaved changes.       │
│  Do you want to save before      │
│  leaving?                        │
│                                  │
│  [Discard]  [Cancel]  [Save]    │
└──────────────────────────────────┘
```

---

## 10. Undo / Redo

The builder maintains an **undo/redo history** of up to 30 states.

### Controls

| Action | Button | Keyboard Shortcut |
|--------|--------|-------------------|
| **Undo** | Undo button (bottom-left) | `Ctrl + Z` |
| **Redo** | Redo button (bottom-left) | `Ctrl + Shift + Z` |

### What Can Be Undone

- Adding a section
- Removing a section
- Reordering sections
- Changing section visibility
- Editing any form field
- Applying a template

### How It Works

```
State History (max 30):

  State 1 ← State 2 ← State 3 ← State 4 (current)
                                     ↑
                                  You are here

  Press Undo:
  State 1 ← State 2 ← State 3 (current) → State 4
                          ↑
                       You are here now

  Press Redo:
  State 1 ← State 2 ← State 3 ← State 4 (current)
                                     ↑
                                  Back to here

  Make a new edit after undo:
  State 1 ← State 2 ← State 3 ← State 5 (new current)
                                     ↑
                                  State 4 is discarded
```

- Every change pushes a new state onto the stack
- Undoing moves back through previous states
- Making a new edit after undoing **discards** the redo history (standard behaviour)
- The undo/redo buttons are greyed out when there's nothing to undo/redo

---

## 11. Workflow: Creating a Storefront from Scratch

Here's a step-by-step walkthrough of creating a complete brand storefront:

### Step 1: Start

Navigate to **Admin Portal → Buy Management → Brand Storefronts → Create Storefront**.

### Step 2: Choose a Template (Optional)

On the **Basics** tab, optionally select a template that matches the brand type. This pre-populates Dynamic Content sections you can customise.

### Step 3: Fill in Basics

```
Brand Name:      "DataDirect"              ← Required
Brand ID:        (leave blank for auto)
Tagline:         "Data at your fingertips"
Description:     "South Africa's fastest growing..."
Established:     "2019"
Show Chat:       ☑ On
Trust Badges:    ☑ Verified  ☑ New Brand
```

### Step 4: Set Up Hero & Visual

```
Hero Style:      "Full Bleed Image"
Hero Image:      https://storage.../hero.jpg
Brand Logo:      https://storage.../logo.png  ← Required
Focal Point:     Drag pin to centre of hero image
Brand Colour:    #1A73E8  (brand blue)
Accent Colour:   #FF6D00  (orange highlight)
Secondary:       #424242  (dark grey)
```

### Step 5: Add Content & Links

```
Banner Image:    https://storage.../promo-banner.jpg
Banner Link:     imali://buy/provider/datadirect
Announcement:    "🎉 Launch special: 50% off all bundles!"
Dismissible:     ☑ On

Social Links:
  WhatsApp:      +27821234567
  Instagram:     @datadirect_za
  Website:       https://datadirect.co.za
```

### Step 6: Build Dynamic Content

Add and arrange sections:

```
1. Quick Actions        👁 Visible
2. Featured Products    👁 Visible
3. Products             👁 Visible
4. Promotions           👁 Visible
5. About                👁 Visible
6. FAQ                  👁 Visible
7. Social Links         👁 Visible
```

### Step 7: Preview

Check the live phone-frame preview on the right side. Scroll through to verify:
- Hero image and logo look correct
- Colours match brand guidelines
- Sections appear in the right order
- Banner and announcement display properly
- Social links are present

### Step 8: Save & Publish

1. Click **Save** to save as draft
2. Review everything one final time
3. Click **Publish** to make it live
4. Verify the three publish requirements are met (name, logo, sections)

### Step 9: Verify in Consumer App

Open the consumer app → Buy tab → find the brand storefront and verify it displays correctly.

---

## Appendix: Complete Field Reference

| Tab | Field | Required | Type | Default |
|-----|-------|----------|------|---------|
| Basics | Brand Name | Yes | Text | — |
| Basics | Brand ID | No | Text | Auto-generated |
| Basics | Tagline | No | Text | — |
| Basics | Description | No | Multi-line text | — |
| Basics | Established Year | No | Text | — |
| Basics | Show Chat Button | No | Toggle | On |
| Basics | Trust Badges | No | Multi-select | None |
| Hero | Hero Style | No | Dropdown | fullBleedImage |
| Hero | Hero Image URL | No | URL | — |
| Hero | Cover Image URL | No | URL | — |
| Hero | Brand Logo URL | Yes | URL | — |
| Hero | Focal Point X | No | 0.0–1.0 | 0.5 |
| Hero | Focal Point Y | No | 0.0–1.0 | 0.5 |
| Hero | Brand Colour | No | Hex colour | — |
| Hero | Accent Colour | No | Hex colour | — |
| Hero | Secondary Colour | No | Hex colour | — |
| Content | Banner Image URL | No | URL | — |
| Content | Banner Deep Link | No | URL/Deep link | — |
| Content | Announcement Text | No | Text | — |
| Content | Announcement Deep Link | No | URL/Deep link | — |
| Content | Dismissible | No | Toggle | On |
| Content | WhatsApp | No | Phone number | — |
| Content | Instagram | No | Handle/URL | — |
| Content | Facebook | No | URL | — |
| Content | Website | No | URL | — |
| Content | TikTok | No | Handle/URL | — |
| Content | X (Twitter) | No | Handle/URL | — |
| Content | YouTube | No | URL | — |
| Dynamic | Sections | No | Ordered list | Template or empty |
| Analytics | Total Views | — | Read-only | 0 |

---

*This guide was generated from the Brand Storefront Builder source code (v1.0). For the latest features and options, refer to the admin portal directly.*
