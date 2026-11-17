#!/bin/sh
# Claude Code PostToolUse hook for Write and Edit. When a screen file is written or
# edited, it reminds the agent to follow the frontend-kit chain. The general reminder
# speaks at most once every 30 minutes per session; the missing-plan warning at most
# 3 times per session. Silent for every other file. It never blocks a tool call.
# Output is fixed text only: no path from the event ever goes into the JSON.
in=$(cat)
# Value of a string field; keeps escaped quotes inside the value, then unescapes them.
field() {
  printf '%s' "$in" | tr '\n' ' ' |
    sed -E -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"(([^\"\\\\]|\\\\.)*)\".*/\1/p" |
    sed 's/\\"/"/g; s/\\\\/\\/g' | head -1
}

file=$(field file_path)
[ -n "$file" ] || exit 0
lc=$(printf '%s' "$file" | tr 'A-Z' 'a-z')
case "$lc" in
  *.html|*.htm|*.css|*.scss|*.sass|*.less|*.jsx|*.tsx|*.vue|*.svelte|*.astro|*.mdx) ;;
  *) exit 0 ;;
esac

cwd=$(field cwd)
case "$file" in
  /*) ;;
  *) [ -n "$cwd" ] && file="$cwd/$file" ;;
esac

# Session id is used in a file name: keep only safe characters.
sid=$(field session_id | tr -cd 'A-Za-z0-9_-' | cut -c1-128)
[ -n "$sid" ] || sid=nosession

# A plan counts only when it is a non-empty regular file, newer than 12 hours, in the
# edited file's folder or up to 6 folders above it. Another project's plan does not count.
has_plan=""
d=$(dirname "$file"); i=0
while [ -z "$has_plan" ] && [ "$i" -le 6 ]; do
  p="$d/.frontend-kit/tool-plan.md"
  if [ -f "$p" ] && [ ! -L "$p" ] && [ ! -L "$d/.frontend-kit" ] &&
     [ -n "$(find "$p" -type f -size +0 -mmin -720 2>/dev/null)" ]; then
    has_plan=1
  fi
  [ "$d" = "/" ] || [ "$d" = "." ] && break
  d=$(dirname "$d"); i=$((i+1))
done

# The state folder is private, and a link planted in it is never followed.
dir="$HOME/.claude/frontend-kit-state"
[ -L "$dir" ] && exit 0
mkdir -p "$dir" 2>/dev/null || exit 0
[ -d "$dir" ] || exit 0
chmod 700 "$dir" 2>/dev/null
flag="$dir/$sid"
[ -L "$flag" ] && exit 0

general=""
if [ ! -e "$flag" ] || [ -n "$(find "$flag" -type f -mmin +30 2>/dev/null)" ]; then
  rm -f "$flag" 2>/dev/null
  # Exclusive create: if another event won the race, it speaks instead.
  ( set -C; : > "$flag" ) 2>/dev/null && general=1
  # Housekeeping: drop state files older than a week.
  find "$dir" -type f -mtime +7 -exec rm -f {} + 2>/dev/null
fi

plan=""
if [ -z "$has_plan" ]; then
  for n in 1 2 3; do
    slot="$flag.plan$n"
    [ -L "$slot" ] && break
    [ -e "$slot" ] && continue
    ( set -C; : > "$slot" ) 2>/dev/null && plan=1
    break
  done
fi

G='You just changed a screen file. The frontend-kit workflow applies even though the user did not mention it: load the frontend-kit skill if it is not loaded, size the task with its table, follow the phases that size includes, look at the result in a browser before you say it is done, and save the receipt.'
P='This screen file has no fresh .frontend-kit/tool-plan.md beside it or in the folders above it. Open sweep.md in the frontend-kit skill folder, save the plan for this task (small fixes sweep only the rows they touch), and update it as you work.'

if [ -n "$general" ] && [ -n "$plan" ]; then msg="$G $P"
elif [ -n "$general" ]; then msg="$G"
elif [ -n "$plan" ]; then msg="$P"
else exit 0
fi
printf '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"%s"}}' "$msg"
