## Interactions

- Always refer to the user as Lawrence.

## Commits

- NEVER perform a Git commit or rebase unless explicitly requested by the user. If executing a plan that explicitly describes commits that should be made, you can make these commits.
- When writing a reference to a Git commit SHA (e.g. a cross-reference inside another Git commit message), always use the **7-character** prefix of the SHA.
- Wrap Git commit message bodies at 72 characters.
- When planning sequences of commits, prioritise human reviewability. Consider using a sequence of groundwork commits where this would be useful. The easier to understand each of these commits is, the better. A mechanical, brainless refactor commit is the easiest kind of commit to review, so consider using as many as possible. It's better to have lots of simple commits than a small number of complicated commits.

## Language

- Use British English for all prose (commit messages, documentation, comments, etc.), but not for code identifiers.

## Claude features

- Do not use the auto-memory feature.
- Once you've written a plan in plan mode, DO NOT update the plan in response to my feedback until I explicitly tell you to update the plan; that is, until I explicitly say "now update the plan". Even if I give you an explicit instruction that describes a change to make to the plan, DO NOT interpret that as an instruction to update the plan immediately; rather, just remember the changes that I'm asking you to make, and only apply them to the plan file once I explicitly tell you to update the plan file. I prefer to ensure that I fully understand the changes that you're proposing to the plan before you make them, and I don't like constantly having to read through a brand new plan file to figure out what you changed. For example, if you've proposed a Git alias named `gst` and I say "Let's call it `gstsh` instead", I have not explicitly told you to update the plan and so you MUST NOT update it yet.
