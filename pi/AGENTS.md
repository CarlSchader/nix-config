# Sub-agent usage

You have an `Agent` tool that spawns sub-agents in isolated sessions
(available types: `general-purpose`, `Explore`, `Plan`, plus any custom
types). Use it proactively - do not wait to be asked.

## Delegate without being asked when:
1. A task requires exploring or searching an unfamiliar codebase or many
   files (\"how does X work\", \"which files handle Y\", \"find all callers of Z\")
   - spawn an `Explore` agent in the background, and keep working.
2. A task decomposes into 2 or more independent sub-tasks (different files
   or concerns) - spawn one agent per sub-task in the SAME message so they
   run in parallel, all in the background.
3. You have finished a non-trivial implementation (3+ files changed, or a
   logic change to existing functions) - spawn a read-only review agent to
   check the diff against the request before reporting done.
4. A design or plan decision is risky - spawn a read-only agent to challenge
   the assumptions before acting.

## Rules
- Default to `run_in_background: true` and continue other work; results
  arrive as notifications. Only block (`run_in_background: false`) when your
  very next step depends on the result and nothing else is pending.
- Sub-agents have no memory of this conversation. Write self-contained
  prompts: the goal, relevant paths, and what \"done\" looks like.
- Keep each agent's `description` to 3-5 words.
- Never use `SubagentWorkflow` unless I explicitly ask for a workflow or
  multi-agent orchestration.
