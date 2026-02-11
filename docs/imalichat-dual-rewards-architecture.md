**iMaliChat**

Dual Rewards Architecture

Token Ledger & Rewards Inventory

Implementation Guide for Claude Code

Version 1.0 --- February 2026

CONFIDENTIAL

Table of Contents

1\. Executive Summary

iMaliChat currently operates a trust accounting system that tracks token
earnings and spending. Tokens are a fungible digital currency with a
fixed conversion rate of 1 token = R0.01 (ZAR). Users earn tokens by
watching videos, completing surveys, and other engagement activities,
then spend them on vouchers, airtime, electricity, and more.

However, the platform needs to support a second category of rewards:
discrete, non-fungible inventory items such as retailer-supplied QR
codes, promotional vouchers, discount codes, and special offers. These
items are fundamentally different from tokens --- they are finite,
campaign-specific, and cannot be partially spent or converted to ZAR.

This document defines a Dual Rewards Architecture that cleanly separates
these two concerns: a Token Ledger (the existing trust accounting
system) for fungible currency, and a new Rewards Inventory system for
discrete items. The two systems share a unified user-facing presentation
but remain architecturally independent, avoiding the complexity
explosion that would result from trying to force inventory items into
the token ledger.

**Key Design Principles:**

-   The existing token trust accounting system remains unchanged and
    untouched.

-   A single, generic Rewards Inventory system handles all non-token
    reward types (QR codes, vouchers, discount codes, free product
    offers, event tickets, etc.) without per-type schema changes.

-   A flexible JSON metadata field on campaigns and items absorbs
    retailer-specific and reward-type-specific differences.

-   Users see a unified \"My Rewards\" experience combining their token
    balance and inventory items.

-   The architecture scales to new reward types with zero schema
    migration.

2\. Architectural Overview

2.1 The Two-Track Model

The architecture separates rewards into two fundamentally different
tracks based on their nature:

**Track 1 --- Token Ledger (Existing):** A balance-based, double-entry
accounting system for fungible tokens. Tokens are interchangeable,
divisible, and have a fixed ZAR conversion rate. The ledger records
every credit and debit with full audit trail. This system already exists
and requires no changes.

**Track 2 --- Rewards Inventory (New):** An inventory management system
for discrete, non-fungible reward items. Each item is unique (has its
own code/identifier), belongs to a specific campaign, has a lifecycle
(available → allocated → redeemed → expired), and cannot be subdivided
or converted to tokens.

2.2 Why Two Systems, Not One

Attempting to force inventory items into the token ledger would create
significant problems:

-   Tokens are fungible (1 token = any other token); QR codes are unique
    and non-interchangeable.

-   Tokens have a universal conversion rate; inventory items have no
    standardised value and may not be convertible to ZAR at all.

-   Token balances are additive; inventory items have individual
    lifecycles with states.

-   Token accounting requires double-entry precision; inventory tracking
    requires status management and expiry handling.

-   Adding per-reward-type accounting would require a new ledger
    structure for every retailer campaign, which is unsustainable.

By keeping the systems separate, each can be optimised for its specific
purpose while presenting a unified experience to users.

2.3 System Interaction Diagram

The two tracks interact through the user interface and the earn
mechanism engine, but never through shared accounting:

> ┌────────────────────────────────────────────────┐
>
> │ USER INTERFACE │
>
> │ \"My Rewards\" Wallet Screen │
>
> │ ┌──────────────────┐ ┌──────────────────┐ │
>
> │ │ Token Balance │ │ Reward Items │ │
>
> │ │ 1,250 tokens │ │ 3 vouchers │ │
>
> │ │ = R12.50 │ │ 1 QR code │ │
>
> │ └──────────────────┘ └──────────────────┘ │
>
> └────────────────────────────────────────────────┘
>
> │ │
>
> ┌────┴───────┐ ┌────┴───────────┐
>
> │ TOKEN │ │ REWARDS │
>
> │ LEDGER │ │ INVENTORY │
>
> │ (existing) │ │ (new) │
>
> └────────────┘ └─────────────────┘
>
> │ │
>
> ┌────┴────────────────────────┴──────┐
>
> │ EARN MECHANISM ENGINE │
>
> │ (video watched + quiz passed) │
>
> │ → credit tokens OR allocate item │
>
> └─────────────────────────────────────┘

3\. Database Schema Design

The Rewards Inventory system requires four new tables. These are
designed to be generic enough to handle any reward type without schema
changes, while providing strong referential integrity and audit
capability.

3.1 reward_sponsors

Tracks the retailers, brands, and partners who supply non-token rewards.
This allows reporting by sponsor and managing the commercial
relationship.

  ------------------------------------------------------------------------
  **Column**        **Type**          **Constraints**   **Description**
  ----------------- ----------------- ----------------- ------------------
  sponsor_id        UUID              PK                Unique sponsor
                                                        identifier

  name              VARCHAR(255)      NOT NULL          Sponsor/retailer
                                                        display name

  slug              VARCHAR(100)      UNIQUE, NOT NULL  URL-safe
                                                        identifier

  logo_url          TEXT              NULLABLE          Sponsor logo for
                                                        UI display

  contact_name      VARCHAR(255)      NULLABLE          Primary contact
                                                        person

  contact_email     VARCHAR(255)      NULLABLE          Contact email
                                                        address

  contact_phone     VARCHAR(50)       NULLABLE          Contact phone
                                                        number

  is_active         BOOLEAN           DEFAULT true      Whether sponsor is
                                                        active

  metadata          JSONB             DEFAULT \'{}\'    Flexible sponsor
                                                        attributes

  created_at        TIMESTAMPTZ       NOT NULL          Record creation
                                                        timestamp

  updated_at        TIMESTAMPTZ       NOT NULL          Last update
                                                        timestamp
  ------------------------------------------------------------------------

3.2 reward_campaigns

Each campaign represents a batch of rewards from a sponsor, with defined
earn rules, validity period, and inventory limits. A sponsor can have
many campaigns running concurrently.

  --------------------------------------------------------------------------
  **Column**           **Type**          **Constraints**   **Description**
  -------------------- ----------------- ----------------- -----------------
  campaign_id          UUID              PK                Unique campaign
                                                           identifier

  sponsor_id           UUID              FK →              Sponsoring
                                         reward_sponsors   retailer/brand

  name                 VARCHAR(255)      NOT NULL          Campaign display
                                                           name

  description          TEXT              NULLABLE          User-facing
                                                           campaign
                                                           description

  reward_type          VARCHAR(50)       NOT NULL          Type enum (see
                                                           below)

  earn_mechanism       VARCHAR(50)       NOT NULL          How users earn
                                                           (see below)

  earn_criteria        JSONB             DEFAULT \'{}\'    Specific earn
                                                           rules (see 3.6)

  total_quantity       INTEGER           NOT NULL, CHECK   Total items
                                         \> 0              supplied by
                                                           sponsor

  remaining_quantity   INTEGER           NOT NULL, CHECK   Items still
                                         \>= 0             available

  max_per_user         INTEGER           DEFAULT 1         Max allocations
                                                           per user per
                                                           campaign

  starts_at            TIMESTAMPTZ       NOT NULL          Campaign start
                                                           datetime

  ends_at              TIMESTAMPTZ       NOT NULL          Campaign end
                                                           datetime

  item_expires_at      TIMESTAMPTZ       NULLABLE          When allocated
                                                           items expire

  display_image_url    TEXT              NULLABLE          Campaign
                                                           promotional image

  display_priority     INTEGER           DEFAULT 0         Sort order in UI
                                                           (higher = first)

  status               VARCHAR(20)       NOT NULL, DEFAULT Campaign
                                         \'draft\'         lifecycle status

  metadata             JSONB             DEFAULT \'{}\'    Flexible campaign
                                                           attributes

  created_at           TIMESTAMPTZ       NOT NULL          Record creation
                                                           timestamp

  updated_at           TIMESTAMPTZ       NOT NULL          Last update
                                                           timestamp
  --------------------------------------------------------------------------

**Campaign status values:** draft, active, paused, exhausted, expired,
cancelled

**reward_type enum values:**

-   qr_code --- QR codes scanned at point of sale for discounts or free
    items

-   voucher_code --- Alphanumeric codes entered online or in-store

-   discount_code --- Percentage or fixed-amount discount codes

-   freebie --- Free product redemptions (no code, tracked by status)

-   event_ticket --- Entry to events or experiences

-   digital_content --- Access to digital content (e.g., music, courses)

-   custom --- Catch-all for future types not yet categorised

**earn_mechanism enum values:**

-   video_quiz --- Watch a video then answer questions correctly

-   survey --- Complete a survey

-   video_only --- Watch a video to completion (no quiz)

-   challenge --- Complete a multi-step challenge

-   referral --- Refer new users

-   milestone --- Reach an engagement milestone (e.g., 30-day streak)

-   direct_grant --- Admin-allocated (promotional giveaway)

3.3 reward_items

Individual reward items supplied by the sponsor. Each row is a single QR
code, voucher code, discount code, etc. For code-based rewards, the
actual code value is stored encrypted.

  -----------------------------------------------------------------------------
  **Column**             **Type**          **Constraints**    **Description**
  ---------------------- ----------------- ------------------ -----------------
  item_id                UUID              PK                 Unique item
                                                              identifier

  campaign_id            UUID              FK →               Parent campaign
                                           reward_campaigns   

  code_value             TEXT              NULLABLE           The actual
                                                              QR/voucher code
                                                              (encrypted at
                                                              rest)

  code_hash              VARCHAR(64)       NULLABLE, UNIQUE   SHA-256 hash for
                                                              uniqueness check

  status                 VARCHAR(20)       NOT NULL, DEFAULT  Item lifecycle
                                           \'available\'      status

  allocated_to_user_id   UUID              FK → users,        User who earned
                                           NULLABLE           this item

  allocated_at           TIMESTAMPTZ       NULLABLE           When item was
                                                              allocated to user

  redeemed_at            TIMESTAMPTZ       NULLABLE           When user
                                                              redeemed the item

  expires_at             TIMESTAMPTZ       NULLABLE           Item-level expiry
                                                              (overrides
                                                              campaign)

  redemption_location    TEXT              NULLABLE           Where redeemed
                                                              (if tracked)

  metadata               JSONB             DEFAULT \'{}\'     Item-specific
                                                              attributes

  created_at             TIMESTAMPTZ       NOT NULL           Record creation
                                                              timestamp

  updated_at             TIMESTAMPTZ       NOT NULL           Last update
                                                              timestamp
  -----------------------------------------------------------------------------

**Item status values:** available, allocated, redeemed, expired, revoked

Status transition rules (enforced by application logic and database
constraints):

-   available → allocated (user completes earn mechanism)

-   allocated → redeemed (user presents/uses the code)

-   allocated → expired (expiry date passed without redemption)

-   available → expired (campaign ended, item never allocated)

-   allocated → revoked (admin action, e.g., fraud detected)

-   No reverse transitions allowed (expired/redeemed/revoked are
    terminal states)

3.4 reward_activity_log

An append-only audit trail for all inventory actions. This serves the
same purpose for the inventory system that the transaction log serves
for the token ledger --- complete traceability of every state change.

  ----------------------------------------------------------------------------
  **Column**        **Type**          **Constraints**    **Description**
  ----------------- ----------------- ------------------ ---------------------
  log_id            UUID              PK                 Unique log entry
                                                         identifier

  item_id           UUID              FK → reward_items  The affected item

  campaign_id       UUID              FK →               Denormalised for
                                      reward_campaigns   query perf

  user_id           UUID              FK → users,        Associated user (if
                                      NULLABLE           applicable)

  action            VARCHAR(30)       NOT NULL           Action performed (see
                                                         below)

  previous_status   VARCHAR(20)       NULLABLE           Status before the
                                                         action

  new_status        VARCHAR(20)       NOT NULL           Status after the
                                                         action

  performed_by      VARCHAR(100)      NOT NULL           Who performed it
                                                         (system/admin/user)

  ip_address        INET              NULLABLE           Client IP for fraud
                                                         detection

  notes             TEXT              NULLABLE           Additional context

  metadata          JSONB             DEFAULT \'{}\'     Flexible event
                                                         attributes

  created_at        TIMESTAMPTZ       NOT NULL           When the action
                                                         occurred
  ----------------------------------------------------------------------------

**Action values:** imported, allocated, redeemed, expired, revoked,
reissued

3.5 Database Indexes

The following indexes are essential for query performance at scale:

> \-- Fast lookup of available items for allocation
>
> CREATE INDEX idx_reward_items_available
>
> ON reward_items(campaign_id, status)
>
> WHERE status = \'available\';
>
> \-- User\'s allocated/redeemed items for wallet display
>
> CREATE INDEX idx_reward_items_user
>
> ON reward_items(allocated_to_user_id, status)
>
> WHERE allocated_to_user_id IS NOT NULL;
>
> \-- Active campaigns for discovery screen
>
> CREATE INDEX idx_reward_campaigns_active
>
> ON reward_campaigns(status, starts_at, ends_at)
>
> WHERE status = \'active\';
>
> \-- Code uniqueness enforcement
>
> CREATE UNIQUE INDEX idx_reward_items_code_hash
>
> ON reward_items(code_hash)
>
> WHERE code_hash IS NOT NULL;
>
> \-- Activity log queries by user
>
> CREATE INDEX idx_reward_activity_user
>
> ON reward_activity_log(user_id, created_at DESC);
>
> \-- Activity log queries by campaign
>
> CREATE INDEX idx_reward_activity_campaign
>
> ON reward_activity_log(campaign_id, created_at DESC);
>
> \-- Expiry batch processing
>
> CREATE INDEX idx_reward_items_expiry
>
> ON reward_items(expires_at)
>
> WHERE status = \'allocated\' AND expires_at IS NOT NULL;

3.6 The earn_criteria JSON Structure

The earn_criteria field on reward_campaigns defines the specific
conditions a user must meet to earn an item. This keeps the schema
generic while allowing arbitrarily complex earn rules. Examples:

**Video quiz campaign:**

> {
>
> \"video_id\": \"vid_abc123\",
>
> \"min_watch_percentage\": 90,
>
> \"quiz_questions\": \[
>
> {
>
> \"question\": \"What product was featured?\",
>
> \"options\": \[\"Coca-Cola\", \"Pepsi\", \"Sprite\", \"Fanta\"\],
>
> \"correct_index\": 0
>
> }
>
> \],
>
> \"min_correct_answers\": 1
>
> }

**Survey campaign:**

> {
>
> \"survey_id\": \"survey_xyz789\",
>
> \"min_completion_percentage\": 100,
>
> \"required_questions\": \[\"q1\", \"q2\", \"q5\"\]
>
> }

**Milestone campaign:**

> {
>
> \"milestone_type\": \"login_streak\",
>
> \"required_count\": 30,
>
> \"period\": \"consecutive_days\"
>
> }

4\. Core Business Logic

4.1 Item Allocation Flow

This is the critical path --- when a user completes an earn activity and
should receive a reward item. The allocation must be atomic to prevent
double-allocation under concurrent load.

**Pseudocode:**

> FUNCTION allocate_reward_item(user_id, campaign_id):
>
> // 1. Validate campaign is active and in date range
>
> campaign = SELECT \* FROM reward_campaigns
>
> WHERE campaign_id = :campaign_id
>
> AND status = \'active\'
>
> AND starts_at \<= NOW()
>
> AND ends_at \> NOW()
>
> IF campaign IS NULL: RETURN error(\'Campaign not available\')
>
> // 2. Check user hasn\'t exceeded per-user limit
>
> user_count = SELECT COUNT(\*) FROM reward_items
>
> WHERE campaign_id = :campaign_id
>
> AND allocated_to_user_id = :user_id
>
> IF user_count \>= campaign.max_per_user:
>
> RETURN error(\'Already earned maximum for this campaign\')
>
> // 3. Atomically claim one available item
>
> // (SELECT \... FOR UPDATE SKIP LOCKED prevents contention)
>
> BEGIN TRANSACTION
>
> item = SELECT \* FROM reward_items
>
> WHERE campaign_id = :campaign_id
>
> AND status = \'available\'
>
> ORDER BY created_at ASC
>
> LIMIT 1
>
> FOR UPDATE SKIP LOCKED
>
> IF item IS NULL:
>
> // Update campaign status if exhausted
>
> UPDATE reward_campaigns
>
> SET status = \'exhausted\',
>
> remaining_quantity = 0
>
> WHERE campaign_id = :campaign_id
>
> COMMIT
>
> RETURN error(\'No items remaining\')
>
> // 4. Allocate the item
>
> UPDATE reward_items SET
>
> status = \'allocated\',
>
> allocated_to_user_id = :user_id,
>
> allocated_at = NOW(),
>
> expires_at = campaign.item_expires_at
>
> WHERE item_id = item.item_id
>
> // 5. Decrement campaign remaining count
>
> UPDATE reward_campaigns SET
>
> remaining_quantity = remaining_quantity - 1
>
> WHERE campaign_id = :campaign_id
>
> // 6. Log the allocation
>
> INSERT INTO reward_activity_log
>
> (item_id, campaign_id, user_id, action,
>
> previous_status, new_status, performed_by)
>
> VALUES
>
> (item.item_id, :campaign_id, :user_id, \'allocated\',
>
> \'available\', \'allocated\', \'system\')
>
> COMMIT
>
> RETURN success(item)

**Critical implementation notes:**

-   The FOR UPDATE SKIP LOCKED clause is essential. Under concurrent
    load, multiple users might try to claim items simultaneously. SKIP
    LOCKED causes each transaction to skip rows already locked by
    another transaction, preventing deadlocks and ensuring each user
    gets a different item.

-   The remaining_quantity decrement is a convenience counter for fast
    UI queries. The authoritative count is always SELECT COUNT(\*) FROM
    reward_items WHERE status = \'available\'. A periodic reconciliation
    job should verify these match.

-   The entire allocation (steps 3--6) must be within a single database
    transaction.

4.2 Item Redemption Flow

Redemption happens when a user presents their earned item (e.g., shows a
QR code at a store, enters a voucher code online). Depending on the
reward type, redemption may be tracked externally (by the retailer) or
internally (by iMaliChat).

**Internal redemption (iMaliChat-tracked):**

> FUNCTION redeem_reward_item(user_id, item_id, location):
>
> BEGIN TRANSACTION
>
> item = SELECT \* FROM reward_items
>
> WHERE item_id = :item_id
>
> AND allocated_to_user_id = :user_id
>
> AND status = \'allocated\'
>
> FOR UPDATE
>
> IF item IS NULL: RETURN error(\'Item not found or not yours\')
>
> IF item.expires_at IS NOT NULL AND item.expires_at \< NOW():
>
> // Auto-expire and log
>
> UPDATE reward_items SET status = \'expired\' \...
>
> RETURN error(\'Item has expired\')
>
> UPDATE reward_items SET
>
> status = \'redeemed\',
>
> redeemed_at = NOW(),
>
> redemption_location = :location
>
> WHERE item_id = :item_id
>
> INSERT INTO reward_activity_log \...
>
> COMMIT

**External redemption (retailer-tracked):** For some campaigns, the
retailer handles redemption externally (e.g., the user shows a QR code
at a till). In this case, the retailer can notify iMaliChat via a
webhook callback, or the item can be marked redeemed when the user
confirms they used it in the app. The redemption_callback_url field in
campaign metadata supports this pattern.

4.3 Expiry Processing

A scheduled background job must run periodically (recommended: every 15
minutes) to expire items and campaigns that have passed their validity
dates.

> FUNCTION process_expiries():
>
> // 1. Expire allocated items past their expiry date
>
> expired_items = UPDATE reward_items SET
>
> status = \'expired\',
>
> updated_at = NOW()
>
> WHERE status = \'allocated\'
>
> AND expires_at IS NOT NULL
>
> AND expires_at \< NOW()
>
> RETURNING item_id, campaign_id, allocated_to_user_id
>
> // 2. Log each expiry
>
> FOR EACH item IN expired_items:
>
> INSERT INTO reward_activity_log (\...)
>
> // 3. Expire campaigns past their end date
>
> UPDATE reward_campaigns SET
>
> status = \'expired\'
>
> WHERE status IN (\'active\', \'paused\')
>
> AND ends_at \< NOW()
>
> // 4. Bulk-expire unclaimed items from expired campaigns
>
> UPDATE reward_items SET status = \'expired\'
>
> WHERE status = \'available\'
>
> AND campaign_id IN (
>
> SELECT campaign_id FROM reward_campaigns
>
> WHERE status = \'expired\'
>
> )
>
> // 5. Optionally notify users of expiring items
>
> // (items expiring within 24-48 hours)
>
> notify_upcoming_expiries()

4.4 The Earn Mechanism Engine

The earn mechanism engine is the decision point that determines whether
a user earns tokens, an inventory item, or both. This engine already
exists for token earnings and needs to be extended with a reward_type
parameter.

> FUNCTION process_earn_completion(user_id, activity):
>
> // activity contains: type, video_id, quiz_answers, etc.
>
> // 1. Check for token reward (existing logic)
>
> token_reward = lookup_token_reward(activity)
>
> IF token_reward:
>
> credit_tokens(user_id, token_reward.amount)
>
> // 2. Check for inventory reward (NEW logic)
>
> inventory_campaigns = SELECT \* FROM reward_campaigns
>
> WHERE status = \'active\'
>
> AND earn_mechanism = activity.type
>
> AND remaining_quantity \> 0
>
> AND starts_at \<= NOW() AND ends_at \> NOW()
>
> AND matches_criteria(earn_criteria, activity)
>
> FOR EACH campaign IN inventory_campaigns:
>
> result = allocate_reward_item(user_id, campaign.campaign_id)
>
> IF result.success:
>
> send_push_notification(user_id,
>
> \'You earned a reward from \' + campaign.sponsor.name)
>
> // NOTE: A single activity can earn BOTH tokens AND items
>
> // (e.g., watch video = 10 tokens + Shoprite QR code)

5\. Bulk Import Process

Retailers will supply reward codes in bulk (e.g., 1,000 QR codes in a
CSV file). The system needs a robust import process with validation,
deduplication, and error handling.

5.1 Import File Format

Accepted formats: CSV or JSON. The minimum required field is the code
value; additional columns map to the item metadata field.

> // CSV example (supplied by retailer)
>
> code,description,face_value
>
> QR-SHOP-001,\"10% off groceries\",\"R50 minimum spend\"
>
> QR-SHOP-002,\"10% off groceries\",\"R50 minimum spend\"
>
> QR-SHOP-003,\"10% off groceries\",\"R50 minimum spend\"
>
> \...

5.2 Import Workflow

1.  **Upload:** Admin uploads CSV via admin dashboard, selecting the
    target campaign.

2.  **Validate:** System checks each row --- non-empty code, no
    duplicates within file, no duplicates against existing code_hash
    values in database.

3.  **Preview:** Show admin a summary: X valid codes, Y duplicates, Z
    errors. Admin confirms or aborts.

4.  **Import:** Bulk insert valid items with status = \'available\'.
    Encrypt code values. Compute and store SHA-256 hashes. Update
    campaign total_quantity and remaining_quantity.

5.  **Log:** Create reward_activity_log entries for each imported item
    with action = \'imported\'.

**Important:** Code values must be encrypted at rest (AES-256) since
they represent financial value. The code_hash (SHA-256 of the plaintext
code) enables uniqueness checks without decrypting stored values.

6\. API Endpoint Design

The following REST API endpoints should be implemented. All endpoints
require authentication. Admin endpoints require admin role.

6.1 User-Facing Endpoints

  ----------------------------------------------------------------------------------
  **Method**              **Path**                           **Description**
  ----------------------- ---------------------------------- -----------------------
  GET                     /api/v1/rewards/wallet             Get user\'s token
                                                             balance + all
                                                             allocated/redeemed
                                                             items

  GET                     /api/v1/rewards/campaigns          List active campaigns
                                                             available to earn

  GET                     /api/v1/rewards/campaigns/:id      Campaign details + earn
                                                             criteria

  GET                     /api/v1/rewards/items              User\'s earned items
                                                             (filterable by status)

  GET                     /api/v1/rewards/items/:id          Single item detail
                                                             (includes decrypted
                                                             code)

  POST                    /api/v1/rewards/items/:id/redeem   Mark item as redeemed

  GET                     /api/v1/rewards/history            Combined activity feed
                                                             (tokens + items)
  ----------------------------------------------------------------------------------

6.2 Admin Endpoints

  ------------------------------------------------------------------------------------
  **Method**              **Path**                             **Description**
  ----------------------- ------------------------------------ -----------------------
  POST                    /api/v1/admin/sponsors               Create sponsor

  PUT                     /api/v1/admin/sponsors/:id           Update sponsor

  POST                    /api/v1/admin/campaigns              Create campaign

  PUT                     /api/v1/admin/campaigns/:id          Update campaign
                                                               (status, dates, etc.)

  POST                    /api/v1/admin/campaigns/:id/import   Bulk import items (CSV
                                                               upload)

  GET                     /api/v1/admin/campaigns/:id/stats    Campaign analytics
                                                               dashboard

  POST                    /api/v1/admin/items/:id/revoke       Revoke an allocated
                                                               item

  GET                     /api/v1/admin/reports/redemption     Redemption report by
                                                               sponsor/period
  ------------------------------------------------------------------------------------

6.3 Webhook Endpoints (for Retailer Integration)

Some retailers will want to notify iMaliChat when a code has been
redeemed at their point of sale:

  -----------------------------------------------------------------------------
  **Method**              **Path**                      **Description**
  ----------------------- ----------------------------- -----------------------
  POST                    /api/v1/webhooks/redemption   Retailer notifies code
                                                        was redeemed at POS

  -----------------------------------------------------------------------------

The webhook payload should include the code value (or hash), timestamp,
and location. The endpoint must validate the request using a per-sponsor
API key or HMAC signature stored in the sponsor metadata.

7\. User Interface Integration

7.1 Unified Wallet Screen

The \"My Rewards\" screen should present both tracks in a unified but
visually distinct way:

-   Top section: Token balance card showing current balance, ZAR
    equivalent, and quick-spend buttons (airtime, electricity,
    vouchers).

-   Below: Reward items section, grouped by status (Active items first,
    then Redeemed, then Expired). Each item shows the sponsor logo,
    campaign name, expiry countdown (if applicable), and a \"View Code\"
    / \"Use Now\" action button.

-   Tab or toggle to switch between \"All Rewards\" and \"Token
    History\" views.

7.2 Earn Flow UI Changes

When a user is about to watch a video or take a survey, the earn
mechanism may offer tokens, an inventory reward, or both. The
pre-activity screen should clearly show what the user stands to earn:

> ┌────────────────────────────────────┐
>
> │ Watch & Earn │
>
> │ │
>
> │ \[Video Thumbnail\] │
>
> │ \"Shoprite Summer Specials\" │
>
> │ │
>
> │ You\'ll earn: │
>
> │ ✨ 15 tokens (R0.15) │
>
> │ 🎁 Shoprite 10% Discount QR Code │
>
> │ (Answer 1 question correctly) │
>
> │ │
>
> │ \[Watch Now\] │
>
> └────────────────────────────────────┘

7.3 Reward Item Detail Screen

When a user taps on an earned item, they see:

-   Sponsor branding (logo, colours from campaign metadata)

-   Large QR code image or voucher code (generated dynamically from the
    decrypted code_value)

-   Clear instructions on how/where to redeem (from campaign
    description + metadata)

-   Expiry date and countdown timer if applicable

-   \"Mark as Used\" button for self-reported redemption

-   Terms and conditions (from campaign metadata)

7.4 Push Notification Triggers

-   Item earned: \"You just earned a \[reward name\] from \[sponsor\]!
    Check your rewards.\"

-   Expiry warning (48h): \"Your \[reward name\] expires in 2 days.
    Don\'t forget to use it!\"

-   Expiry warning (4h): \"Last chance! Your \[reward name\] expires in
    4 hours.\"

-   New campaign available: \"New reward available! Watch a video to
    earn \[reward name\].\"

8\. Security Considerations

8.1 Code Value Protection

Reward codes have real financial value and must be protected
accordingly:

-   Encrypt code_value at rest using AES-256-GCM with per-row
    initialisation vectors.

-   Store the encryption key in a secrets manager (e.g., AWS Secrets
    Manager, GCP Secret Manager), never in application config or source
    code.

-   Only decrypt codes at the moment of display to the authenticated
    user who owns the item.

-   Never log decrypted code values. Log only the code_hash for
    debugging.

-   Rate-limit the item detail endpoint to prevent brute-force
    enumeration of codes.

8.2 Allocation Fraud Prevention

-   Enforce max_per_user at both application and database levels (unique
    constraint on campaign_id + allocated_to_user_id where appropriate,
    or count-based check in the allocation transaction).

-   Validate earn_criteria completion server-side. Never trust
    client-reported quiz answers or video completion without server
    verification.

-   Track IP addresses in the activity log to detect bulk farming from
    the same source.

-   Implement velocity checks: flag accounts earning items at
    statistically unusual rates.

-   Consider device fingerprinting for high-value campaigns.

8.3 Webhook Security

For retailer webhook integrations:

-   Require HMAC-SHA256 signature verification on all incoming webhook
    requests.

-   Store per-sponsor webhook secrets in the sponsor metadata
    (encrypted).

-   Implement idempotency keys to prevent duplicate redemption
    processing.

-   Log all webhook calls for audit and dispute resolution.

8.4 POPIA Compliance

South African POPIA requirements for the rewards system:

-   Obtain explicit consent when users participate in sponsor campaigns
    (the sponsor may receive anonymised engagement data).

-   Provide a mechanism for users to view all their reward items and
    request deletion.

-   Ensure sponsor data access is limited to aggregate campaign
    analytics, never individual user data, unless the user consents.

-   Apply the same data retention policies as the existing token system.

9\. Admin Dashboard & Analytics

9.1 Campaign Management

The admin dashboard needs a campaign management section with the
following capabilities:

-   Create, edit, pause, and cancel campaigns.

-   Upload and import reward codes with validation preview.

-   View real-time campaign status: total items, allocated, redeemed,
    expired, remaining.

-   Set and modify campaign date ranges and per-user limits.

-   Preview the user-facing campaign appearance.

9.2 Key Metrics

The following metrics should be available per campaign, per sponsor, and
system-wide:

-   Allocation rate: items allocated / total items (as percentage and
    over time).

-   Redemption rate: items redeemed / items allocated (the key metric
    for sponsor satisfaction).

-   Time to redemption: average time between allocation and redemption.

-   Expiry rate: items expired / items allocated (indicates poor user
    engagement or too-short validity).

-   Campaign completion rate: how quickly items are claimed after
    campaign launch.

-   User engagement: unique users who viewed a campaign vs. those who
    attempted vs. those who earned.

9.3 Sponsor Reporting

Sponsors need access to their own campaign performance. This can be
delivered via:

-   A sponsor portal (future phase) with self-service analytics.

-   Automated email reports (daily/weekly) with campaign summaries.

-   CSV/Excel export of campaign data from the admin dashboard.

Sponsor reports should include aggregate data only (total allocations,
redemptions, geographic distribution) and never individual user data
unless POPIA consent has been obtained.

10\. Implementation Plan

10.1 Phase 1: Foundation (Core Schema + Allocation)

-   Create the four database tables (reward_sponsors, reward_campaigns,
    reward_items, reward_activity_log) with all indexes.

-   Implement the item allocation function with the atomic FOR UPDATE
    SKIP LOCKED pattern.

-   Build the bulk import endpoint for CSV upload.

-   Add the /api/v1/rewards/wallet endpoint that returns both token
    balance and reward items.

-   Unit tests for allocation concurrency, status transitions, and
    per-user limits.

10.2 Phase 2: Earn Integration

-   Extend the earn mechanism engine to check for inventory campaigns
    alongside token rewards.

-   Implement the earn_criteria matching logic for video_quiz and survey
    types.

-   Build the pre-activity UI showing combined token + item rewards.

-   Add push notifications for item allocation.

10.3 Phase 3: User Experience

-   Build the unified \"My Rewards\" wallet screen in the Flutter app.

-   Build the item detail screen with QR code display and redemption
    instructions.

-   Implement the self-reported redemption flow (\"Mark as Used\"
    button).

-   Add expiry countdown timers and notification triggers.

10.4 Phase 4: Admin & Analytics

-   Build the admin campaign management interface.

-   Implement campaign analytics dashboards.

-   Add sponsor management and reporting capabilities.

-   Build the expiry processing background job.

10.5 Phase 5: Advanced Features

-   Retailer webhook integration for external redemption tracking.

-   Sponsor self-service portal.

-   Advanced fraud detection and velocity checks.

-   A/B testing framework for campaign earn criteria.

11\. Metadata Patterns Reference

The JSON metadata fields are the key to the system\'s extensibility.
Below are reference patterns for different reward types showing what
metadata to store at each level.

11.1 Campaign Metadata Examples

**QR Code Campaign (Shoprite):**

> {
>
> \"brand_colour\": \"#E31837\",
>
> \"terms_and_conditions\": \"Valid at participating\...\",
>
> \"redemption_instructions\": \"Show this QR code at\...\",
>
> \"min_basket_value\": 50.00,
>
> \"discount_type\": \"percentage\",
>
> \"discount_value\": 10,
>
> \"applicable_departments\": \[\"groceries\", \"fresh\"\],
>
> \"redemption_callback_url\": \"https://api.shoprite\...\",
>
> \"pos_integration_type\": \"qr_scan\"
>
> }

**Voucher Code Campaign (Nando\'s):**

> {
>
> \"brand_colour\": \"#C8102E\",
>
> \"terms_and_conditions\": \"Valid for dine-in only\...\",
>
> \"redemption_instructions\": \"Show the code to your\...\",
>
> \"offer_description\": \"Free quarter chicken with\...\",
>
> \"valid_days\": \[\"monday\", \"tuesday\", \"wednesday\"\],
>
> \"valid_stores\": \[\"all\"\],
>
> \"pos_integration_type\": \"manual_code_entry\"
>
> }

**Data Bundle Campaign (MTN):**

> {
>
> \"brand_colour\": \"#FFCC00\",
>
> \"terms_and_conditions\": \"Prepaid customers only\...\",
>
> \"redemption_instructions\": \"Dial \*136\*\[code\]# to\...\",
>
> \"bundle_size_mb\": 500,
>
> \"bundle_validity_days\": 30,
>
> \"network\": \"MTN\",
>
> \"ussd_template\": \"\*136\*{code}#\"
>
> }

11.2 Item Metadata Examples

Item-level metadata captures anything unique to that specific code/item:

> // Typically minimal - most info lives at campaign level
>
> {
>
> \"batch_number\": \"BATCH-2026-02-001\",
>
> \"original_row_number\": 42,
>
> \"import_filename\": \"shoprite_codes_feb2026.csv\",
>
> \"face_value_description\": \"R50 minimum spend\"
>
> }

12\. Migration & Deployment Strategy

12.1 Database Migration

The Rewards Inventory system is entirely additive --- no existing tables
are modified. The migration consists only of CREATE TABLE statements and
CREATE INDEX statements for the four new tables. This means:

-   Zero risk to the existing token trust accounting system.

-   Migration can be run alongside the existing system with no downtime.

-   Rollback is a simple DROP TABLE of the four new tables (in reverse
    dependency order).

12.2 Feature Flags

Implement the following feature flags for controlled rollout:

-   rewards_inventory_enabled: Master flag to enable/disable the entire
    inventory system.

-   rewards_wallet_ui_enabled: Controls visibility of the unified wallet
    UI.

-   rewards_earn_integration_enabled: Controls whether the earn engine
    checks for inventory campaigns.

-   rewards_admin_enabled: Controls visibility of admin campaign
    management tools.

12.3 Testing Strategy

-   Unit tests: Allocation atomicity under concurrent requests, status
    transition enforcement, per-user limit enforcement, expiry
    processing, code encryption/decryption.

-   Integration tests: Full earn-to-redeem flow, bulk import with
    validation, webhook redemption flow, wallet API returning combined
    token + item data.

-   Load tests: Simulate 1,000 concurrent users attempting to claim from
    a campaign with 500 items. Verify no double-allocation, correct
    remaining counts, and acceptable latency.

13\. Summary

The Dual Rewards Architecture provides iMaliChat with a clean, scalable
solution for supporting both fungible token rewards and discrete
inventory-based rewards from sponsors and retailers. The key
architectural decisions are:

-   Complete separation of the token ledger and inventory system at the
    data layer, avoiding contamination of the trust accounting system.

-   A single, generic inventory system that handles all non-token reward
    types through flexible metadata, avoiding per-type schema
    proliferation.

-   Atomic allocation with database-level concurrency control (FOR
    UPDATE SKIP LOCKED) to prevent double-allocation under load.

-   A unified user experience that presents both reward tracks
    seamlessly in one wallet interface.

-   An extensible campaign and earn mechanism framework that
    accommodates new reward types and earn methods without code changes.

-   Comprehensive security including code encryption, POPIA compliance,
    webhook authentication, and fraud prevention measures.

This architecture is designed to be implemented incrementally, with the
foundation (schema + allocation) in Phase 1, followed by earn
integration, user experience, admin tools, and advanced features in
subsequent phases. Each phase delivers standalone value while building
toward the complete system.

--- End of Document ---
