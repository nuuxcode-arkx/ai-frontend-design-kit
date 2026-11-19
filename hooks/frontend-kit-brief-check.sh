#!/bin/sh
# frontend-kit brief check (Claude Code, PreToolUse on Agent|Task).
# A main session often hands screen work to a helper agent. If the brief does not
# name the frontend-kit skill, the helper builds the screen without the workflow.
# This check refuses such a brief and says what to add. It reads the event on
# stdin as plain text and never runs or stores any of it.
in=$(cat)

# Read-only helper types never write a screen.
if printf '%s' "$in" | grep -Eq '"subagent_type"[[:space:]]*:[[:space:]]*"(Explore|Plan|advisor|claude-code-guide|statusline-setup)"'; then
  exit 0
fi

# The brief already names the workflow, or says in words that it writes no screen.
if printf '%s' "$in" | grep -Eq 'frontend-kit|UI: none'; then
  exit 0
fi

# Signs that the helper will write or change a screen.
if printf '%s' "$in" | grep -Eiq 'front[- ]?end|landing page|web ?page|html page|one html|single html|\.html|\.css|\.scss|\.tsx|\.jsx|\.vue|\.svelte|\.astro|stylesheet|tailwind|redesign|restyle|mock-?up|ui/ux|ui ux|ux/ui|user interface|dashboard|design pass|design the|visual design|react component|page layout|typography|animation'; then
  cat >&2 <<'EOF'
BRIEF REFUSED by the frontend-kit brief check: this brief looks like screen work but does not name the frontend-kit skill, so the helper would build without the design workflow.

Fix the brief and send it again:
- If the helper writes or changes any screen, page, component, style, animation or on-screen text, add this line to the brief: "Before writing or changing any screen, page, component, style, animation or on-screen text, load the `frontend-kit` skill and follow its chain. The `frontend-design` skill alone is not the workflow."
- If the helper writes no screen file at all (research, back-end, data, text files), add the line "UI: none" to the brief.
EOF
  exit 2
fi
exit 0
