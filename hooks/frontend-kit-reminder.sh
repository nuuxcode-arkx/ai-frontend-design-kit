#!/bin/sh
# Claude Code PostToolUse hook for Write and Edit. When a screen file is written or
# edited, it reminds the agent to follow the frontend-kit chain. It speaks at most
# once every 30 minutes per session, so the reminder comes back after a long task
# or a context compaction. Silent for every other file. It never blocks a tool call.
in=$(cat)
field() { printf '%s' "$in" | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -1; }

file=$(field file_path)
case "$file" in
  *.html|*.htm|*.css|*.scss|*.sass|*.less|*.jsx|*.tsx|*.vue|*.svelte|*.astro|*.mdx) ;;
  *) exit 0 ;;
esac

# Session id is used in a file name: keep only safe characters.
sid=$(field session_id | tr -cd 'A-Za-z0-9_-')

# No tool plan in the project: the sweep was skipped. Say so, at most 3 times per session.
cwd=$(field cwd)
plan_msg=""
# The plan may sit beside the file or in a folder above it, not only in the session folder.
has_plan=""
[ -n "$cwd" ] && [ -f "$cwd/.frontend-kit/tool-plan.md" ] && has_plan=1
d=$(dirname "$file"); i=0
while [ -z "$has_plan" ] && [ "$i" -lt 6 ] && [ "$d" != "/" ] && [ "$d" != "." ]; do
  [ -f "$d/.frontend-kit/tool-plan.md" ] && has_plan=1
  d=$(dirname "$d"); i=$((i+1))
done
if [ -z "$has_plan" ]; then
  plan_msg=" There is no .frontend-kit/tool-plan.md in this project, so the tool sweep was skipped. Stop building, open sweep.md in the frontend-kit skill folder, walk every job, and save the plan before you write more screen code (a small visual fix sweeps only the rows it touches)."
fi
dir="$HOME/.claude/frontend-kit-state"
# The state folder is private, and a link planted in it is never followed.
[ -L "$dir" ] && exit 0
mkdir -p "$dir" 2>/dev/null || exit 0
chmod 700 "$dir" 2>/dev/null
flag="$dir/${sid:-nosession}"
[ -L "$flag" ] && exit 0

# Recent reminder for this session: stay silent.
if [ -f "$flag" ] && [ -z "$(find "$flag" -mmin +30 2>/dev/null)" ]; then
  [ -n "$plan_msg" ] || exit 0
  pflag="$flag.plan"
  [ -L "$pflag" ] && exit 0
  n=0; [ -f "$pflag" ] && n=$(wc -c < "$pflag" | tr -d ' ')
  [ "$n" -ge 2 ] && exit 0
  printf x >> "$pflag"
  printf '%s' "{\"hookSpecificOutput\":{\"hookEventName\":\"PostToolUse\",\"additionalContext\":\"${plan_msg# }\"}}"
  exit 0
fi
rm -f "$flag"
( set -C; : > "$flag" ) 2>/dev/null || exit 0
# Housekeeping: drop state files older than a week.
find "$dir" -type f -mtime +7 -exec rm -f {} + 2>/dev/null

printf '%s' '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"You just changed a screen file. The frontend-kit workflow applies to this task even though the user did not mention it: load the frontend-kit skill now if it is not loaded, follow its chain (brief and content, identity, direction, build, motion and effects, copy, see, gates), look at the result in a browser at 390, 768 and 1280 px before you say it is done, and save the receipt.'"$plan_msg"'"}}'
