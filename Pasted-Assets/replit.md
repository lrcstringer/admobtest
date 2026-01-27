# iMaliChat

## Overview

iMaliChat is a gamified mobile wallet application that rewards users for their attention. Users earn tokens by watching short ads and completing ultra-short surveys, then can use those tokens to build wallet balances, climb leaderboards, send/receive money with friends, and purchase items like airtime and electricity.

The app features a distinctive fintech brand identity with a navy background, pink primary actions, yellow value accents, and white text. It's built as a React web application with a mobile-first design, using a phone-frame layout component to simulate a native mobile experience.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture

**Framework & Routing**
- React 18 with TypeScript for type safety
- Wouter for lightweight client-side routing (simpler alternative to React Router)
- Vite as the build tool and development server
- TanStack Query (React Query) for server state management and API caching

**UI Component System**
- Shadcn/ui component library with the "new-york" style variant
- Radix UI primitives for accessible, unstyled components
- Tailwind CSS v4 for styling with custom CSS variables for theming
- Framer Motion for animations and transitions
- Lucide React for iconography

**Mobile-First Design Pattern**
- `MobileFrame` component wraps all screens to simulate phone viewport (max-width 448px)
- Bottom navigation component for primary app navigation
- Safe area handling for notches and home indicators

### Backend Architecture

**Server Framework**
- Express.js with TypeScript
- Session-based authentication using express-session with connect-pg-simple for PostgreSQL session storage
- Passport.js with local strategy for username/password authentication
- bcrypt for password hashing

**API Structure**
- RESTful API endpoints under `/api/*` prefix
- Endpoints organized by domain: auth, user, wallet, earn, leaderboard, contacts, chat, purchases
- Zod schemas for request validation (shared with frontend via drizzle-zod)

**Database Layer**
- PostgreSQL database with Drizzle ORM
- Schema defined in `shared/schema.ts` for type sharing between client and server
- Drizzle-kit for migrations (`npm run db:push`)

### Advertiser Portal Architecture

**Separate Web Portal**
- Desktop-first web portal at `/admin/*` routes
- Complete separation from mobile app experience
- Role-based access control: super_admin, org_admin, campaign_manager, analyst

**Advertiser Features**
- Self-serve signup with company/brand registration
- Prepaid wallet funding via EFT proof upload
- 5-step campaign wizard: basics, targeting, creative/survey, budget/caps, review
- Real-time analytics dashboard with demographic breakdowns
- CSV export for campaign metrics (aggregated, POPIA-compliant)

**Super Admin Features**
- Campaign approval queue (review creatives, targeting, budget)
- EFT payment verification (approve/reject top-ups)
- Platform-wide management

**Campaign Delivery Integration**
- Waterfall serving: campaigns matched to users by age, gender, province targeting
- Frequency capping: per-user daily limits enforced
- Budget management: auto-pause when 99%+ budget spent
- CPE charging: advertiser wallet debited on engagement completion
- User rewards: 90% of CPE value converted to tokens for user

### Data Models

Core entities include:
- **Users**: Authentication, profile, demographics (dateOfBirth, gender, province), streaks, earnings
- **Wallets**: Main wallet and brand-specific wallets with token/ZAR balances
- **Transactions**: Earning, sending, receiving, purchases, referral bonuses, pot wins
- **Earn System**: Threads (brand channels), opportunities (ads/surveys), completions
- **Social Features**: Contacts, money chat threads/entries, referrals
- **Gamification**: Leaderboard scores, prize pots
- **Purchases**: Airtime, data, electricity purchases
- **Advertiser System**: Organizations, org members (with roles), advertiser wallets, top-ups
- **Campaigns**: Campaign config, creatives, survey questions, metrics, user frequency tracking

### Build & Deployment

- Development: Vite dev server with HMR, proxied through Express
- Production: Vite builds static assets to `dist/public`, esbuild bundles server to `dist/index.cjs`
- Custom build script handles both client and server bundling

## External Dependencies

### Database
- PostgreSQL (required, connection via `DATABASE_URL` environment variable)
- Drizzle ORM for query building and schema management
- connect-pg-simple for session storage

### Frontend Libraries
- @tanstack/react-query for async state management
- framer-motion for animations
- embla-carousel-react for carousel components
- react-day-picker for calendar/date selection
- cmdk for command palette functionality

### Replit-Specific Plugins
- @replit/vite-plugin-runtime-error-modal for error display
- @replit/vite-plugin-cartographer for development tooling
- @replit/vite-plugin-dev-banner for development environment indication

### Authentication & Security
- passport and passport-local for authentication
- bcrypt for password hashing
- express-session for session management

### Utility Libraries
- date-fns for date formatting and manipulation
- zod for runtime validation
- class-variance-authority and clsx for conditional CSS classes