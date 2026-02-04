# iMaliChat Wallet Architecture

## Overview

Every user has a single **Ledger Account** containing multiple **Sub-Wallets**. Sub-wallets can be unrestricted (iMaliChat default) or brand-restricted (advertiser-controlled).

---

## Entity Relationship Diagram

```mermaid
erDiagram
    USER ||--|| LEDGER_ACCOUNT : has
    LEDGER_ACCOUNT ||--|{ SUB_WALLET : contains
    SUB_WALLET ||--|{ TRANSACTION : records
    SUB_WALLET }|--|| WALLET_TYPE : "governed by"
    
    ADVERTISER ||--|| ADVERTISER_LEDGER : has
    ADVERTISER ||--|{ WALLET_TYPE : defines
    ADVERTISER_LEDGER ||--|{ DISBURSEMENT : funds
    
    CAMPAIGN ||--|| ADVERTISER : "belongs to"
    CAMPAIGN }|--|| WALLET_TYPE : "rewards into"
    
    EARN_EVENT ||--|| CAMPAIGN : "triggered by"
    EARN_EVENT ||--|| TRANSACTION : creates
    
    GROUP ||--|| GROUP_LEDGER : has
    GROUP_LEDGER ||--|{ GROUP_SUB_WALLET : contains
    GROUP_SUB_WALLET }|--|| USER : "contributed by"

    USER {
        uuid user_id PK
        string msisdn
        string username
        datetime created_at
        boolean is_verified
    }

    LEDGER_ACCOUNT {
        uuid ledger_id PK
        uuid user_id FK
        datetime created_at
    }

    SUB_WALLET {
        uuid sub_wallet_id PK
        uuid ledger_id FK
        uuid wallet_type_id FK
        integer balance "in tokens"
        datetime created_at
        boolean is_active
    }

    WALLET_TYPE {
        uuid wallet_type_id PK
        uuid advertiser_id FK "null for iMaliChat default"
        string name "e.g. Shoprite Rewards"
        boolean is_restricted
        json offramp_rules "allowed purchase types"
        datetime created_at
    }

    TRANSACTION {
        uuid transaction_id PK
        uuid sub_wallet_id FK
        string tx_type "EARN|POT_WIN|REFERRAL|SEND|RECEIVE|PURCHASE|CASHOUT"
        integer amount
        integer balance_after
        uuid related_event_id "earn_event, pot_payout, etc"
        datetime created_at
    }

    ADVERTISER {
        uuid advertiser_id PK
        string company_name
        string vat_number
        datetime created_at
    }

    ADVERTISER_LEDGER {
        uuid adv_ledger_id PK
        uuid advertiser_id FK
        integer balance "prepaid budget"
        datetime created_at
    }

    DISBURSEMENT {
        uuid disbursement_id PK
        uuid adv_ledger_id FK
        uuid earn_event_id FK
        integer amount
        datetime created_at
    }

    CAMPAIGN {
        uuid campaign_id PK
        uuid advertiser_id FK
        uuid wallet_type_id FK
        string name
        string status "DRAFT|ACTIVE|PAUSED|COMPLETE"
        integer budget
        integer spent
        datetime start_date
        datetime end_date
    }

    EARN_EVENT {
        uuid earn_event_id PK
        uuid user_id FK
        uuid campaign_id FK
        integer tokens_earned
        integer score_earned
        decimal streak_multiplier
        datetime created_at
    }

    GROUP {
        uuid group_id PK
        string name
        uuid admin_user_id FK
        datetime created_at
    }

    GROUP_LEDGER {
        uuid group_ledger_id PK
        uuid group_id FK
        integer total_balance
        datetime created_at
    }

    GROUP_SUB_WALLET {
        uuid group_sub_wallet_id PK
        uuid group_ledger_id FK
        uuid user_id FK
        integer contribution
        datetime created_at
    }
```

---

## Token Flow Diagram

```mermaid
flowchart TD
    subgraph ADVERTISER_SIDE["Advertiser Side"]
        ADV_BANK[Advertiser Bank Account]
        ADV_LEDGER[(Advertiser Ledger)]
        CAMPAIGN[Active Campaign]
    end

    subgraph PLATFORM["iMaliChat Platform"]
        SKIM[Skim Account<br/>5% Daily + 5% Weekly]
        DAILY_POT[(Daily Pot)]
        WEEKLY_POT[(Weekly Pot)]
    end

    subgraph USER_SIDE["User Side"]
        USER_LEDGER[(User Ledger Account)]
        
        subgraph SUB_WALLETS["Sub-Wallets"]
            IMC_WALLET[iMaliChat Wallet<br/>Unrestricted]
            BRAND_WALLET_1[Shoprite Wallet<br/>Restricted: Shoprite only]
            BRAND_WALLET_2[PEP Wallet<br/>Restricted: PEP only]
            BRAND_WALLET_3[Vodacom Wallet<br/>Unrestricted]
        end
    end

    subgraph OFFRAMPS["Off-Ramps"]
        AIRTIME[Airtime/Data]
        ELECTRICITY[Electricity]
        SHOPRITE[Shoprite Vouchers]
        PEP[PEP Vouchers]
        CASHOUT[Bank Cash-out]
    end

    %% Funding flow
    ADV_BANK -->|EFT Top-up| ADV_LEDGER
    ADV_LEDGER -->|Fund Campaign| CAMPAIGN

    %% Earn flow - iMaliChat/AdMob
    CAMPAIGN -->|"User completes ad<br/>(90% to user)"| IMC_WALLET
    CAMPAIGN -->|"5% skim"| DAILY_POT
    CAMPAIGN -->|"5% skim"| WEEKLY_POT

    %% Earn flow - Brand specific
    CAMPAIGN -->|"Brand campaign<br/>with restrictions"| BRAND_WALLET_1
    CAMPAIGN -->|"Brand campaign<br/>with restrictions"| BRAND_WALLET_2
    CAMPAIGN -->|"Brand campaign<br/>no restrictions"| BRAND_WALLET_3

    %% Pot payouts
    DAILY_POT -->|"Top 5 winners"| IMC_WALLET
    WEEKLY_POT -->|"Top 10 winners"| IMC_WALLET

    %% Spending - Unrestricted wallets
    IMC_WALLET --> AIRTIME
    IMC_WALLET --> ELECTRICITY
    IMC_WALLET --> SHOPRITE
    IMC_WALLET --> PEP
    IMC_WALLET --> CASHOUT
    
    BRAND_WALLET_3 --> AIRTIME
    BRAND_WALLET_3 --> ELECTRICITY
    BRAND_WALLET_3 --> SHOPRITE
    BRAND_WALLET_3 --> PEP
    BRAND_WALLET_3 --> CASHOUT

    %% Spending - Restricted wallets
    BRAND_WALLET_1 -->|"Only allowed"| SHOPRITE
    BRAND_WALLET_2 -->|"Only allowed"| PEP

    %% Styling
    style IMC_WALLET fill:#22c55e,color:#000
    style BRAND_WALLET_1 fill:#f97316,color:#000
    style BRAND_WALLET_2 fill:#f97316,color:#000
    style BRAND_WALLET_3 fill:#22c55e,color:#000
    style DAILY_POT fill:#a855f7,color:#fff
    style WEEKLY_POT fill:#a855f7,color:#fff
```

---

## P2P Transfer Flow (Money Chat)

```mermaid
flowchart LR
    subgraph SENDER["Sender (Alice)"]
        ALICE_LEDGER[(Alice's Ledger)]
        ALICE_IMC[iMaliChat Wallet<br/>Balance: 500]
    end

    subgraph RECEIVER["Receiver (Bob)"]
        BOB_LEDGER[(Bob's Ledger)]
        BOB_IMC[iMaliChat Wallet<br/>Balance: 200]
    end

    ALICE_IMC -->|"Send 100 tokens"| BOB_IMC

    style ALICE_IMC fill:#22c55e,color:#000
    style BOB_IMC fill:#22c55e,color:#000
```

**Rules:**
- P2P transfers only from/to **iMaliChat Wallet** (unrestricted)
- Cannot send from brand-restricted wallets
- Cannot send directly into someone's brand wallet

---

## Future: Group Wallet Flow

```mermaid
flowchart TD
    subgraph MEMBERS["Group Members"]
        ALICE_WALLET[Alice's iMaliChat Wallet]
        BOB_WALLET[Bob's iMaliChat Wallet]
        CAROL_WALLET[Carol's iMaliChat Wallet]
    end

    subgraph GROUP["Group: Holiday Fund"]
        GROUP_LEDGER[(Group Ledger)]
        
        subgraph CONTRIBUTIONS["Member Contributions"]
            ALICE_CONTRIB[Alice's Sub-Wallet<br/>Contributed: 200]
            BOB_CONTRIB[Bob's Sub-Wallet<br/>Contributed: 150]
            CAROL_CONTRIB[Carol's Sub-Wallet<br/>Contributed: 100]
        end
        
        TOTAL[Total Balance: 450]
    end

    ALICE_WALLET -->|"Contribute 200"| ALICE_CONTRIB
    BOB_WALLET -->|"Contribute 150"| BOB_CONTRIB
    CAROL_WALLET -->|"Contribute 100"| CAROL_CONTRIB
    
    ALICE_CONTRIB --> TOTAL
    BOB_CONTRIB --> TOTAL
    CAROL_CONTRIB --> TOTAL

    style GROUP_LEDGER fill:#3b82f6,color:#fff
    style TOTAL fill:#3b82f6,color:#fff
```

**Open Questions:**
- Withdrawal rules (unanimous? admin-only? proportional?)
- Can group wallet earn from campaigns?
- Dissolution rules

---

## Wallet Type Configuration (Advertiser Portal)

```mermaid
flowchart TD
    subgraph PORTAL["Advertiser Portal"]
        CREATE[Create Wallet Type]
        CONFIG[Configure Rules]
        LINK[Link to Campaign]
    end

    CREATE --> CONFIG
    CONFIG --> LINK

    subgraph RULES["Offramp Rules Configuration"]
        R1[Allow Airtime?]
        R2[Allow Electricity?]
        R3[Allow Own Vouchers?]
        R4[Allow Other Vouchers?]
        R5[Allow Cash-out?]
    end

    CONFIG --> R1
    CONFIG --> R2
    CONFIG --> R3
    CONFIG --> R4
    CONFIG --> R5

    subgraph EXAMPLES["Example Configurations"]
        EX1["Shoprite Wallet<br/>✗ Airtime<br/>✗ Electricity<br/>✓ Shoprite Vouchers<br/>✗ Other Vouchers<br/>✗ Cash-out"]
        EX2["Vodacom Wallet<br/>✓ Airtime (Vodacom)<br/>✗ Electricity<br/>✗ Vouchers<br/>✗ Cash-out"]
        EX3["Open Brand Wallet<br/>✓ All options"]
    end
```

---

## Data Model: Sub-Wallet Table

| Field | Type | Description |
|-------|------|-------------|
| `sub_wallet_id` | UUID | Primary key |
| `ledger_id` | UUID | FK to user's ledger account |
| `wallet_type_id` | UUID | FK to wallet type (null = iMaliChat default) |
| `balance` | INTEGER | Current balance in tokens |
| `lifetime_earned` | INTEGER | Total ever credited |
| `lifetime_spent` | INTEGER | Total ever debited |
| `created_at` | DATETIME | When sub-wallet was created |
| `is_active` | BOOLEAN | Can receive/spend |

---

## Data Model: Wallet Type Table

| Field | Type | Description |
|-------|------|-------------|
| `wallet_type_id` | UUID | Primary key |
| `advertiser_id` | UUID | FK to advertiser (null = platform default) |
| `name` | STRING | Display name ("Shoprite Rewards") |
| `description` | STRING | User-facing description |
| `icon_url` | STRING | Brand logo for wallet UI |
| `is_restricted` | BOOLEAN | Has offramp limitations |
| `allowed_offramps` | JSON | `["shoprite_voucher"]` or `["*"]` |
| `allow_p2p_send` | BOOLEAN | Can send via Money Chat |
| `allow_p2p_receive` | BOOLEAN | Can receive via Money Chat |
| `expiry_days` | INTEGER | Days until unused balance expires (null = never) |
| `created_at` | DATETIME | |
| `is_active` | BOOLEAN | Accepting new earnings |

---

## Transaction Routing Logic

```
ON earn_event:
    campaign = get_campaign(earn_event.campaign_id)
    wallet_type = campaign.wallet_type_id
    
    IF wallet_type IS NULL:
        # AdMob/iMaliChat inventory
        target_wallet = user.get_or_create_sub_wallet("imalichat_default")
    ELSE:
        # Brand campaign
        target_wallet = user.get_or_create_sub_wallet(wallet_type)
    
    # Credit user (90%)
    target_wallet.credit(earn_event.tokens_earned)
    
    # Skim to pots (always from platform, not brand wallet)
    daily_pot.credit(earn_event.tokens_earned * 0.05)
    weekly_pot.credit(earn_event.tokens_earned * 0.05)
```

---

## Purchase Validation Logic

```
ON purchase_request(user, sub_wallet, purchase_type):
    wallet_type = sub_wallet.wallet_type
    
    IF wallet_type.is_restricted:
        IF purchase_type NOT IN wallet_type.allowed_offramps:
            REJECT "This wallet can only be used for {allowed_offramps}"
    
    IF sub_wallet.balance < purchase_amount:
        REJECT "Insufficient balance"
    
    APPROVE and debit sub_wallet
```

---

## Open Architectural Questions

| Question | Recommendation |
|----------|----------------|
| Transfer between own sub-wallets? | **No** — defeats brand restriction purpose |
| Pot winnings destination? | **iMaliChat wallet** — platform-level, unrestricted |
| Referral bonus destination? | **iMaliChat wallet** — not brand-specific |
| What if brand discontinues? | Option: convert to unrestricted after N days notice |
| Sub-wallet expiry? | Brand-configurable; notify user before expiry |
| Minimum balance display? | Show all sub-wallets, even zero balance, if active |
