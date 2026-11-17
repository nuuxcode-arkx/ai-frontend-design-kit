# AI FRONTEND DESIGN KIT

**Install once. After that, your AI coding agent is instructed to follow a design workflow each time it builds or changes a screen, without you asking.** It is an instruction plus a reminder, not a guarantee: in our tests on 17 Nov 2026 the agent followed it on plain requests such as "make me a landing page", and each task ends with a receipt that says what was checked and what was not. Made for Claude Code and Codex. Other agents (Cursor, Gemini CLI) can use the same files, with less automation.

## INSTALL (FOR PEOPLE)

Open your agent and send it this one message:

```text
Read https://github.com/nuuxcode-arkx/ai-frontend-design-kit and follow its INSTALL.md.
```

That is all. The agent installs the workflow, the design skills and a browser it can look through, for all your projects, then tells you what worked. You do not need to understand any of the tools. You need Node.js 22.20 or newer on the computer; if it is missing, the agent tells you.

## WHAT CHANGES AFTER INSTALL

You ask for anything with a screen: a website, an app page, a dashboard, a quick HTML demo. You do not mention design. The agent now does this on its own:

| Step | What the agent does | Why it matters |
|---|---|---|
| 1. Brief and content | Writes down what the screen is for and the real words of each section | Design follows the message, not the other way round |
| 2. Identity | Reads or writes a `DESIGN.md` file: colors, fonts, spacing, tone | Every screen looks like the same product |
| 3. Direction | Uses one design skill and real reference sites to choose a style | No generic template look |
| 4. Build | Uses real components, real icons, chosen fonts, current web practice, and builds every state (loading, empty, error) | Solid, accessible parts |
| 5. Motion and effects | Adds smooth interaction motion everywhere. On pages that deserve it (landing pages, launches, "futuristic" briefs) it also adds signature effects by itself: 3D scenes (three.js), scroll storytelling, parallax, diagrams with light flowing along the lines, text reveals, animated backgrounds | Impressive where it helps, calm where people work or read, and still fast on a phone |
| 6. Copy | Cleans the text on screen | Does not sound like a chatbot |
| 7. See | Opens the page in a browser at phone, tablet and desktop size, looks at it, uses it like a visitor, fixes what is wrong, repeats | The agent sees its own mistakes before you do |
| 8. Gates | Runs automatic checks: generated-look detector, match with `DESIGN.md`, accessibility, performance | Problems are caught by tools, not by luck |
| 9. Report | Shows you screenshots, one plain line about what it checked, and what it could not check | You know what "done" means |

The look this is built to avoid has a name, "AI slop": Inter font, purple gradient, three feature cards, emoji as icons. One test so far: a fresh agent with these rules, asked only for "a page for my startup", wrote a style file, checked three screen sizes and fixed 5 issues on its own. The kit raises the floor; it does not guarantee a great design.

## WHAT IS IN THIS REPOSITORY

| File | For whom | What it is |
|---|---|---|
| [INSTALL.md](INSTALL.md) | the agent | Step-by-step install it runs by itself |
| [skills/frontend-kit/SKILL.md](skills/frontend-kit/SKILL.md) | the agent | The workflow: the 9-step chain, which tool to use when, and the receipt it must fill |
| [skills/frontend-kit/catalog.md](skills/frontend-kit/catalog.md) | the agent | Every tool by step, with "use when", "advantage" and the install command |
| [skills/frontend-kit/effects.md](skills/frontend-kit/effects.md) | the agent | The default tool for each effect, plus working code for effects that need no library (light flowing along SVG lines, line drawing, gradient borders, scroll reveals) |
| [claude-md-block.md](claude-md-block.md) | the agent | The rules block added to your agent's instruction file |
| [hooks/frontend-kit-reminder.sh](hooks/frontend-kit-reminder.sh) | Claude Code | Small automatic reminder that starts the workflow when a screen file is touched |

## THE CORE TOOLS (ALWAYS USED)

Each one solves a problem the others do not.

| Tool | Its job in the chain |
|---|---|
| [anthropics/skills](https://github.com/anthropics/skills) `frontend-design` | Makes the agent commit to one clear style before coding |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Main taste skill, plus a detector for the AI look that runs as a check |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) `web-design-guidelines` | Interface rules: focus, forms, states, accessibility |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | Motion and interaction feel |
| [blader/humanizer](https://github.com/blader/humanizer) | Removes AI-sounding text |
| [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) | The agent's eyes: screenshots at several sizes |
| [Manavarya09/design-extract](https://github.com/Manavarya09/design-extract) (`designlang`) | Extracts a style from a site you like, and checks the built page against `DESIGN.md` at three sizes |
| [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) | Current web platform practice instead of old habits |
| [GoogleChrome/lighthouse](https://github.com/GoogleChrome/lighthouse) | Accessibility, performance and search checks |
| [google-labs-code/design.md](https://github.com/google-labs-code/design.md) | The `DESIGN.md` format and its checker |

Around this core, the catalog holds the tools for special jobs (landing pages, dashboards, Figma files, mobile apps, 3D, charts, brand work). The workflow tells the agent when to reach for each one.

## TIPS FROM PRACTITIONERS

Techniques shared on X by people who build with agents every day. The workflow already applies them. These are their claims; they were not tested here.

1. **Give the agent a `DESIGN.md` before it builds.** ([@HeyDetya](https://x.com/HeyDetya/status/2115126738615411180))
2. **Run a designer loop:** brief, 3 directions in real code, pick from screenshots, redline on the running page, polish one fix at a time, walkthrough with keyboard, 200 percent text and dark mode. ([@fleyta88](https://x.com/fleyta88/status/2119013077588828193))
3. **Fix the order:** layout, then theme, then animation timing, then code. ([@SaminXD](https://x.com/SaminXD/status/2116197471726555242))
4. **Image first, code second:** design the screen as an image, then build from it. ([@SPAC89](https://x.com/SPAC89/status/2118127769968140722))
5. **One line that cuts slop:** "Avoid unnecessary secondary labels and descriptions. Let the layout do the explaining." ([@luinlee](https://x.com/luinlee/status/2113085361836744764))
6. **Polish rules designers repeat:** at most 4 font sizes, one color system, inner radius = outer radius minus padding. ([@bruc3van](https://x.com/bruc3van/status/2115963644811116732))
7. **Taste is a list of rules you keep writing down.** ([@Threeaio](https://x.com/Threeaio/status/2115689720445387021))
8. **Turn each correction into a check** instead of a longer instruction file. ([@TheTuringPost](https://x.com/TheTuringPost/status/2120607968408531110))
9. **Guard the design system** with checks for off-token colors. ([@designertom](https://x.com/designertom/status/2118389882011926895))
10. **Install 2 or 3 anti-slop skills, not all ten.** ([@BenjaminUIX](https://x.com/BenjaminUIX/status/2122286309855338953))
11. **Counter-view: a distinctive component library helps more than a design skill.** ([@Justin1024go](https://x.com/Justin1024go/status/2119282740340101569))
12. **Know the limit:** skills only go so far; a human still approves. ([@daradoescode](https://x.com/daradoescode/status/2121745903031910541))

## LIMITS

- The kit installs tools written by other people. The installer tells the agent to read each one before and after installing it, and never to create accounts, pay or send your files anywhere. You still run them at your own risk.
- To remove the kit, tell your agent: "follow the Uninstall section of INSTALL.md in the frontend design kit".
- The install was tested piece by piece (the skill installs, the reminder script, one page built by a fresh agent). A full install by a fresh agent on a clean computer has not been tested yet.
- The automatic reminder works in Claude Code. Other agents rely on the rules block and the skill description.
- A workflow raises the floor; it does not replace a designer. The final yes on a screen is yours.
- Star counts and install commands were checked on 17 Nov 2026 and can change.

## SOURCES

- GitHub API, 17 Nov 2026, for the existence and state of every listed repository.
- [SuperDesign: design skills reviewed](https://superdesign.dev/blog/design-skills-reviewed) (why a skill alone is not enough: it cannot see its own output)
- [Bitdoze: best AI skills for web design compared](https://www.bitdoze.com/best-ai-skills-for-web-design/)
- [Snyk: top Claude skills for UI/UX engineers](https://snyk.io/articles/top-claude-skills-ui-ux-engineers/)
- [DEV Community: design skills for AI agents](https://dev.to/guayoyo_tech/design-skills-for-ai-agents-how-to-stop-getting-generic-interfaces-12bg)
- [Trilogy AI: fixing visual AI slop](https://trilogyai.substack.com/p/fixing-visual-ai-slop)
