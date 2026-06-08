---
name: obsidian-achievements
description: Use when the user asks to add, update, or review career achievement notes in Hugh Palmer's Obsidian vault. Applies to work-achievement notes, career wins, performance review evidence, and concise achievement logging.
---

# Obsidian Achievements

Use the Obsidian CLI through:

`/Applications/Obsidian.app/Contents/MacOS/obsidian`

Default vault:

`Coding Vault`

Achievement base:

`Career-Achievements/01_Achievements Base.base`

Achievement notes folder:

`Career-Achievements/`

## Workflow

1. Inspect existing notes before writing unless the user explicitly provides the exact format.
2. Use `obsidian files folder="Career-Achievements" ext=md vault="Coding Vault"` to list examples.
3. Use `obsidian read path="Career-Achievements/<note>.md" vault="Coding Vault"` to confirm style.
4. Create a new note with `obsidian create path="Career-Achievements/<Title>.md" content="..." vault="Coding Vault"`.
5. Keep achievement notes concise and evidence-focused.

## Note Format

Use this structure unless nearby notes show a more specific pattern:

```markdown
---
id: Achievement Title
aliases: []
tags:
  - bugs
  - work-ach
---
What: One sentence describing the achievement.
Why:
- Brief context on the problem or difficulty.
- Brief note on the confusing or important behaviour uncovered.
Impact:
- Concrete operational or product impact.
- Concrete engineering or reliability impact.
```

## Writing Guidance

- Match the user's voice: direct, informal enough for personal notes, but useful for career evidence.
- Prefer short notes over long write-ups.
- Make the achievement about the outcome and judgement, not just the implementation detail.
- Include ticket IDs only when they help later recall.
- Keep tags consistent with existing notes, usually `bugs` and `work-ach` for bug-fix achievements.
- Avoid overstating impact if the evidence is not known.

## Useful Commands

- List bases: `obsidian bases vault="Coding Vault"`
- List achievement notes: `obsidian files folder="Career-Achievements" ext=md vault="Coding Vault"`
- Read the base: `obsidian read path="Career-Achievements/01_Achievements Base.base" vault="Coding Vault"`
- Read an example note: `obsidian read path="Career-Achievements/<note>.md" vault="Coding Vault"`
- Create a note: `obsidian create path="Career-Achievements/<Title>.md" content="..." vault="Coding Vault"`

## Cautions

- Quote paths because the base filename contains spaces.
- Prefer exact `path=` over `file=` to avoid ambiguous note-name resolution.
- Do not delete or reorganize existing vault notes unless the user explicitly asks.
