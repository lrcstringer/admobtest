# WIP: Poll Question Types Expansion (Types 1-4)

## Status: IMPLEMENTED (not committed)

### What was built
4 question types for the Poll earning type (type 1 already existed):

1. **Multiple-Choice** — Already implemented (singleSelect/multiSelect) — no changes needed
2. **Ranking** — Drag-to-reorder all options with `ReorderableListView`, rank number badges, medal icons in results, average rank computed from all responses
3. **Text** — Free-text response with configurable min/max length, `TextField` with counter, "response recorded" results display (individual texts are private)
4. **Scale/Rating** — Rate each item on a numeric scale (configurable min/max 1-10), tappable circle buttons per scale position, label endpoints (e.g. "Extremely unlikely" / "Extremely likely"), animated bar chart results with average ratings

### Key design decisions
- `PollQuestionType` enum added: `multipleChoice`, `ranking`, `text`, `scale`
- PollResponse is polymorphic: `rankedOptions`, `textResponse`, `scaleRatings` fields alongside existing `selectedOption`/`selectedOptions`
- Aggregation: multipleChoice uses `optionCounts`, ranking computes `averageRanks` from responses on read, scale uses `ratingDistribution` with atomic increments, text just counts respondents
- Fully backward compatible: `questionType` defaults to `multipleChoice`, existing polls unaffected
- Options not required for text questions (validation relaxed from 2-6 to 2-20 for non-text)

### Files modified

**Flutter domain/data:**
- `lib/domain/entities/poll.dart` — `PollQuestionType` enum, new fields on Poll (scale/text config, aggregation), new fields on PollResponse
- `lib/data/models/poll_model.dart` — Mirror entity changes, `_parseRatingDistribution`, `_parsePollQuestionType`
- `lib/domain/repositories/poll_repository.dart` — `submitVote`/`changeVote` now accept `Map<String, dynamic> voteData`
- `lib/data/repositories/poll_repository_impl.dart` — Pass polymorphic data
- `lib/data/datasources/remote/poll_remote_datasource.dart` — Accept polymorphic vote data with spread operator

**Cloud Functions:**
- `functions/src/poll.ts` — `submitPollVote`/`changePollVote` dispatch on `questionType` for validation/aggregation/idempotency. `getPollResults` returns type-specific results. `invalidatePollResponse` handles type-specific counter reversal.
- `functions/src/pollAdmin.ts` — `createPoll` accepts `questionType`, scale config, text config. `updatePoll` handles new config fields. `getPollAdminDetails` returns type-specific analytics (text responses, average ranks/ratings, rating distribution).
- `functions/src/engagement.ts` — Poll evidence validation accepts new response types

**Flutter UI:**
- `lib/presentation/screens/earn/earn_interaction_screen.dart` — Type dispatch in `_buildPollVoteState`, new state vars (`_pollRankedOptionIds/Texts`, `_pollTextController`, `_pollScaleRatings`), new builders (`_buildRankingPollBody`, `_buildTextPollBody`, `_buildScalePollBody`), type-specific results (`_buildRankingResults`, `_buildTextResults`, `_buildScaleResults`), type-specific submission in `_submitPollVote`

**Admin portal:**
- `lib/presentation/admin/screens/earn_management_screen.dart` — Question type dropdown, conditional options/scale/text config sections, multi-select & "other" toggles hidden for non-MC types, `_handleCreatePoll()` sends `questionType` + type-specific config, validation per type, controller disposal

### Not yet done
- No commit (user hasn't asked)
- No git push
- No Firebase deploy
- Admin poll *edit* form not yet updated with question type selector (only create form done)
