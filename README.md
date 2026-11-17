# AI FRONTEND DESIGN KIT

Skills, repos and rules that make an AI coding agent (Claude Code, Codex, Cursor, Gemini CLI) produce designed frontend work instead of "AI slop".

Type: reference list plus agent instructions. Star counts and push dates were read from the GitHub API on 17 Nov 2026.

## TLDR

- "AI slop" = the generic look an agent produces by default: Inter font, purple gradient, three feature cards, emoji as icons, chatbot-sounding text.
- An agent gets good at frontend when it has four things: **a direction** (a design skill), **an identity** (a `DESIGN.md` file), **real parts** (a component library), and **eyes** (a browser loop where the agent takes screenshots of its own work and fixes what it sees).
- Install the 10 items in [Starter stack](#starter-stack), paste [Agent instructions](#agent-instructions) into your `CLAUDE.md` or `AGENTS.md`, then use the [Catalog](#catalog) when you need something specific.
- Pick ONE main design skill. Two taste skills at once give the agent conflicting rules.

## HOW TO USE THIS FILE

1. Give this whole file to your agent and say: "Read this, install the starter stack for this project, then follow the agent instructions for all UI work."
2. Or do it by hand: run the install commands in the starter stack, then copy the agent instructions block into your project instruction file.
3. Before you install any skill, read its `SKILL.md`. A skill is instructions that your agent will obey, so treat it like code from a stranger.

Install commands marked ✓ were read from the repo README on 17 Nov 2026. Commands marked † come from public docs and were not re-checked, so confirm them in the README first.

## STARTER STACK

Install in this order.

| # | What | Why | Install |
|---|---|---|---|
| 1 | [anthropics/skills](https://github.com/anthropics/skills) `frontend-design` | The base skill. Names the slop and forces one clear visual direction. | `npx skills add anthropics/skills --skill frontend-design` † |
| 2 | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Commands to steer (polish, bolder, critique, audit) plus a slop detector you can run as a gate. | `npx impeccable install` then `npx impeccable detect src/` ✓ |
| 3 | A `DESIGN.md` from [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | A fixed identity (colors, type, spacing) the agent must follow. | Copy one `DESIGN.md` into the repo root ✓. Check it with `npx @google/design.md lint DESIGN.md` ✓ |
| 4 | [shadcn-ui/ui](https://github.com/shadcn-ui/ui) plus a [tweakcn](https://github.com/jnsahaj/tweakcn) theme | Real accessible components, with a theme that is not the default grey. | `npx shadcn@latest init` †, MCP: `npx shadcn@latest mcp init --client claude` † |
| 5 | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) `web-design-guidelines` | Review pass for focus states, forms, loading and empty states, accessibility. | `npx skills add vercel-labs/agent-skills` ✓ |
| 6 | [emilkowalski/skills](https://github.com/emilkowalski/skills) | Motion and interaction feel, the small details templates lack. | `npx skills@latest add emilkowalski/skills` ✓ |
| 7 | [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) or [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | The agent's eyes: screenshots, console errors, several screen widths. | `claude mcp add playwright npx @playwright/mcp@latest` ✓ |
| 8 | [ngocanhnckh/renderlint](https://github.com/ngocanhnckh/renderlint) | Checks the rendered page: overflowing text, low contrast, overlaps, broken mobile layout, emoji icons. Exits 1 on error. | `npx -y @yitec/renderlint init` then `npx renderlint http://localhost:3000` ✓ |
| 9 | [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) | Keeps the agent on current web platform practice instead of 2021 habits. | `npx modern-web-guidance@latest install` ✓ |
| 10 | [lucide-icons/lucide](https://github.com/lucide-icons/lucide) plus [fontsource/fontsource](https://github.com/fontsource/fontsource) | Real icons and a chosen font instead of emoji and Inter. | `npm i lucide-react` †, `npm i @fontsource-variable/<font>` † |

Swap options for item 2: [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill), [Nutlope/hallmark](https://github.com/Nutlope/hallmark), [heydamir/unslop](https://github.com/heydamir/unslop) or [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill). Choose one.

## AGENT INSTRUCTIONS

Copy this block into `CLAUDE.md`, `AGENTS.md` or your Cursor rules.

```markdown
## Frontend and design rules

### Before writing UI code
1. Read DESIGN.md. If there is none, stop and write one first: product, audience, one visual
   direction in a sentence, color tokens, type scale, spacing scale, radius, motion rules.
2. Load the installed design skill and follow it. Use one design skill, not several.
3. Look at 2 or 3 real reference sites for this product type before choosing a layout.
4. Use the project's component library and tokens. Never invent a hex color or a spacing value
   that is not a token.
5. Work in this order: layout first (a text wireframe is enough), then theme (colors, font
   pairing, spacing scale), then motion timing, then code last.
6. For a new screen with no clear direction, build 3 real versions (closest to the design
   system, half the elements, bold), screenshot them, and let the human pick.
7. Read the "## taste" section of this file. Every design correction the human gives is added
   there as one rule, so the next screen follows it.

### Never ship these (AI slop tells)
- Inter, Roboto, Arial or system font as the only typeface with no reason.
- Purple-to-blue or pink-to-purple gradients, gradient text, glow blobs in the background.
- Emoji used as icons. Use an icon set (Lucide, Phosphor, Tabler).
- The default page: centered hero, three feature cards with an icon each, a call to action band.
- Cards inside cards, a border plus a shadow plus a large radius on everything.
- Every section centered, every block the same size, no clear first thing to look at.
- Default shadcn grey theme with no change.
- Glass blur panels and badges above every heading ("New", "Beta" pills) with no purpose.
- Filler text: "Elevate", "Seamless", "Unlock", "Supercharge", "in today's fast-paced world".
- Fake numbers, fake logos, fake testimonials, lorem ipsum.
- Hover-only actions, missing focus rings, text under 4.5:1 contrast.
- Extra labels and descriptions under every heading. Let the layout do the explaining.
- More than 4 font sizes on one screen, small all-caps headings everywhere.
- Motion tells: pulsing dots, blur on every entrance, bouncy springs on everything.

### Always do these
- One strong idea per page: one typeface pairing, one accent color, one signature detail.
- Build every state: loading, empty, error, disabled, long text, zero items, many items.
- Real hierarchy: size, weight and space show what matters first.
- Motion has a purpose (shows cause, guides the eye), stays under 300 ms for UI feedback, and
  respects prefers-reduced-motion.
- Keyboard works everywhere, focus is visible, targets are at least 44 px on touch.

### After writing UI code (the loop, do not skip)
1. Run the app. Take screenshots at 390, 768 and 1280 px wide, light and dark if both exist.
2. LOOK at each screenshot. List what is wrong: overflow, clipped text, uneven spacing,
   weak hierarchy, anything from the slop list.
3. Fix, then screenshot again. Repeat until a screenshot has no item on the list.
4. Run the gates: the slop detector, the rendered-UI linter, an accessibility check (axe),
   and confirm zero console errors.
5. Final walkthrough: keyboard only, text at 200 percent, dark mode.
6. Report with the screenshots. Never say a UI is done without having looked at it.
   A green build is not a good screen. The final yes belongs to the human.

## taste
(one rule per line, added after each design correction)
```

Why the loop matters: a skill is a text file of rules. It cannot see your code or the page it produced ([SuperDesign's review of design skills](https://superdesign.dev/blog/design-skills-reviewed)). Only a browser loop lets the agent see and correct its own result.

## TIPS FROM PRACTITIONERS

Techniques shared on X by people who build with agents every day. Each links to the post. These are their claims; they were not tested here.

1. **Give the agent a `DESIGN.md` before it builds.** The agent is not bad at design, the prompt is empty. ([@HeyDetya](https://x.com/HeyDetya/status/2115126738615411180))
2. **Run a six-pass designer loop:** brief, 3 directions in real code, pick from scored screenshots, redline on the running page (spacing, type scale, contrast, 44 px targets, all states), polish one fix at a time, walkthrough (keyboard, 200 percent text, dark mode). ([@fleyta88](https://x.com/fleyta88/status/2119013077588828193))
3. **Fix the order:** layout with text wireframes, then theme, then animation timing, then code. ([@SaminXD](https://x.com/SaminXD/status/2116197471726555242))
4. **Image first, code second:** have the model design the screen as an image, then build with that image as the reference. The image locks the taste. ([@SPAC89](https://x.com/SPAC89/status/2118127769968140722))
5. **One line that cuts slop:** "Avoid unnecessary secondary labels and descriptions. Let the layout do the explaining." ([@luinlee](https://x.com/luinlee/status/2113085361836744764))
6. **Polish rules designers repeat:** at most 4 font sizes, one color system, inner radius = outer radius minus padding, keep color for content and use black, white and grey for the frame. ([@bruc3van](https://x.com/bruc3van/status/2115963644811116732))
7. **Taste is a list of rules you keep writing down.** Every correction goes into a rules file that the next screen reads. ([@Threeaio](https://x.com/Threeaio/status/2115689720445387021))
8. **Turn each correction into a check** (lint rule, type, test) instead of a longer instruction file. ([@TheTuringPost](https://x.com/TheTuringPost/status/2120607968408531110))
9. **Guard the design system:** check output for off-token colors, block overrides of shared components, and test a rule with 10 generations with it and 10 without. ([@designertom](https://x.com/designertom/status/2118389882011926895))
10. **Install 2 or 3 anti-slop skills, not all ten.** ([@BenjaminUIX](https://x.com/BenjaminUIX/status/2122286309855338953))
11. **Counter-view: a distinctive component library helps more than a design skill.** Build on libraries with a strong look. ([@Justin1024go](https://x.com/Justin1024go/status/2119282740340101569))
12. **Start from references:** pick sites from Awwwards, Godly or One Page Love and have the agent remake them. ([@rubenhassid](https://x.com/rubenhassid/status/2122298654081912983))
13. **Rebuild a site you like from a screenshot:** ask for the same layout, spacing, typography, colors and responsive behavior as reusable components. ([@RoundtableSpace](https://x.com/RoundtableSpace/status/2121041604563583304))
14. **Modern Web Guidance raised Chrome's own test scores** (Claude Code 57 to 88 percent, Codex 54 to 82 percent on 215 tasks), at the cost of more tokens. ([@ChromiumDev](https://x.com/ChromiumDev/status/2120222458242273448))
15. **Know the limit:** after 100+ generated sites, skills only go so far; a human still picks and approves. ([@daradoescode](https://x.com/daradoescode/status/2121745903031910541))

## CATALOG

Stars are rounded. "k" = thousand.

### 1. Design skills (the direction)

A skill is a folder with a `SKILL.md` file that the agent loads when the task matches.

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [anthropics/skills](https://github.com/anthropics/skills) | 197k | Anthropic's official skills. `frontend-design` is the base anti-slop skill. | `npx skills add anthropics/skills --skill frontend-design` † |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 151k | Searchable database of styles, palettes, font pairs and UX rules per product type. | `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` then `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill` ✓ |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 119k | 25 engineering skills; `frontend-ui-engineering` covers building UI that does not look generated. | `npx skills add addyosmani/agent-skills` ✓ |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | 112k | Design vocabulary commands plus a detector for AI design tells. | `npx impeccable install` ✓ |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | 58k | Design engineering: animation and interaction craft. | `npx skills@latest add emilkowalski/skills` ✓ |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | 34k | Vercel's skills: `web-design-guidelines`, `react-best-practices`. | `npx skills add vercel-labs/agent-skills` ✓ |
| [alchaincyf/huashu-design](https://github.com/alchaincyf/huashu-design) | 30k | One sentence in, deliverable design out (web, app prototype, slides); proposes directions to choose from; 84 styles. Docs mostly Chinese. | See README |
| [openai/skills](https://github.com/openai/skills) | 29k | Codex skills catalog, includes frontend skills. | `$skill-installer` inside Codex † |
| [elayadesign/ai-design-skills](https://github.com/elayadesign/ai-design-skills) | 16k | Collection of design skills for agents. | See README |
| [ConardLi/garden-skills](https://github.com/ConardLi/garden-skills) | 15k | Skills collection that includes web design. | See README |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | 48k | Anthropic's official plugin directory; includes the `frontend-design` plugin. | Install from the plugin marketplace in Claude Code |
| [jakubkrehel/skills](https://github.com/jakubkrehel/skills) | 12k | Collection of skills for building great interfaces. | See README |
| [benjitaylor/skills](https://github.com/benjitaylor/skills) | 4k | UI polish skills by Benji Taylor. | See README |
| [dominikmartn/nothing-design-skill](https://github.com/dominikmartn/nothing-design-skill) | 3k | UI in the Nothing design language: monochrome, typographic, industrial. | See README |
| [madebymustafa/design-taste](https://github.com/madebymustafa/design-taste) | 0.2k | 24 skills that turn taste into instructions, with ten genre identities. | See README |
| [ibelick/ui-skills](https://github.com/ibelick/ui-skills) | 11k | Constraint skills for design engineers (baseline UI, motion, accessibility). | `npx ui-skills start` ✓ |
| [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills) | 10k | Skills for Google Stitch (design tool): design to code, `DESIGN.md` generation. | `npx skills add google-labs-code/stitch-skills` ✓ |
| [Dammyjay93/interface-design](https://github.com/Dammyjay93/interface-design) | 6k | Design engineering for Claude Code: craft, memory of past decisions, enforcement. | `npx skills add https://github.com/dammyjay93/interface-design --skill interface-design` ✓ |
| [nateherkai/scroll-craft](https://github.com/nateherkai/scroll-craft) | 5k | Premium scroll-driven websites. | See README |
| [jakubkrehel/make-interfaces-feel-better](https://github.com/jakubkrehel/make-interfaces-feel-better) | 4k | One skill for the details that make an interface feel good. | `npx skills add jakubkrehel/make-interfaces-feel-better` ✓ |
| [dickwu/apple-design-skill](https://github.com/dickwu/apple-design-skill) | 4k | UI reviewer based on Apple's Human Interface Guidelines; Flutter, Tauri, Electron, React Native. | See README |
| [oil-oil/oil-ui](https://github.com/oil-oil/oil-ui) | 3k | Explores distinct directions, compares side by side, refines against real screenshots. | `npx skills add oil-oil/oil-ui` ✓ |
| [Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills) | 3k | Designer workflow skills from research to design systems to delivery. | See README |
| [plugin87/ux-ui-agent-skills](https://github.com/plugin87/ux-ui-agent-skills) | 3k | Tokens, 52 components, WCAG 2.2 (accessibility standard) checks, 50 objective gates. | `/plugin marketplace add plugin87/ux-ui-agent-skills` then `/plugin install ux-ui-agent-skills@ux-ui-agent-skills` ✓ |
| [Motionsites-AI/claude-skill](https://github.com/Motionsites-AI/claude-skill) | 2k | Award-style cinematic landing pages. | See README |
| [superdesigndev/superdesign-skill](https://github.com/superdesigndev/superdesign-skill) | 1k | Design judgment skill that works across many agents. | `npx skills add superdesigndev/superdesign-skill` ✓ |
| [abdiraimov-otabek/dashboard-design-skill](https://github.com/abdiraimov-otabek/dashboard-design-skill) | 0.9k | Clean dashboards: KPI tiles, charts, states, plus a screenshot check pass. | See README |
| [Moh4696/open-3d-skills](https://github.com/Moh4696/open-3d-skills) | 0.4k | Eight skills for 3D and animated websites (three.js, scroll films). | See README |
| [smokeeaasd/flawless-ui-ux](https://github.com/smokeeaasd/flawless-ui-ux) | 0.2k | Distinctive, usable interfaces. | See README |
| [diego3g/craft](https://github.com/diego3g/craft) | 0.1k | `/craft-setup` writes a design brief, `/craft` designs screens with every state and reviews them. | `npx skills add diego3g/craft` ✓ |
| [PetriLahdelma/measured-type](https://github.com/PetriLahdelma/measured-type) | under 0.1k | Web typography rules (Bringhurst) applied to modern CSS, with measured claims. | See README |

### 2. Anti-slop for visuals (detect and fix the generated look)

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | 118k | Art direction, reference images, a browser check, dials for variance and density. | `npx skills add https://github.com/Leonxlnx/taste-skill --skill "design-taste-frontend"` ✓ |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | 112k | Rule-based detector for AI design tells in code or on a live URL; works in CI. | `npx impeccable detect .` or `npx impeccable detect https://site` ✓ |
| [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | 57k | Anti-slop design skill for Claude Code, Cursor and Codex. | `npx skills add nutlope/hallmark -g` ✓ |
| [heydamir/unslop](https://github.com/heydamir/unslop) | 18k | Turns vibe-coded, AI-looking UI into a designed interface. | `claude plugin marketplace add heydamir/unslop` then `claude plugin install unslop@heydamir` ✓ |
| [miqdadbadjuber/anti-slop](https://github.com/miqdadbadjuber/anti-slop) | 9k | Filter rules against generic AI design, text and code. | `npx skills add miqdadbadjuber/anti-slop` ✓ |
| [Manavarya09/design-extract](https://github.com/Manavarya09/design-extract) | 5k | Scores how generic a site looks out of 100 and lists every tell. | `npx designlang slop https://yoursite.com` ✓ |
| [github/awesome-copilot](https://github.com/github/awesome-copilot) `anti-ui-slop` | 41k (whole repo) | GitHub's community collection; includes an `anti-ui-slop` skill. | Copy `skills/anti-ui-slop` into your skills folder |
| [erkamyaman/unslopovich](https://github.com/erkamyaman/unslopovich) | 0.2k | Finds and fixes AI-looking UI in mobile apps, web apps and sites. | See README |
| [avivgerz-hue/unslop](https://github.com/avivgerz-hue/unslop) | under 0.1k | 72-rule UI design linter with a contrast engine, a CLI and an MCP server. | See README |
| [marcosnovo/unslop-design](https://github.com/marcosnovo/unslop-design) | under 0.1k | 72 numbered design fixes with screenshots. | See README |
| [arhamhi/oxfords](https://github.com/arhamhi/oxfords) | under 0.1k | Plain, polished interfaces; includes a zero-dependency slop checker. | See README |

### 3. Anti-slop for text (UI copy that does not sound like a chatbot)

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [blader/humanizer](https://github.com/blader/humanizer) | 70k | Removes signs of AI writing, based on Wikipedia's "Signs of AI writing". | `/plugin marketplace add blader/humanizer` then `/plugin install humanizer@humanizer` ✓ |
| [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop) | 19k | Lighter skill to strip AI tells from prose. | Copy `SKILL.md` into `.claude/skills/stop-slop/` † |
| [Dodaios/ste80-humanizer](https://github.com/Dodaios/ste80-humanizer) | 0.8k | Removes AI tells and rewrites toward Simplified Technical English. | See README |
| [FeedHive/ai-slop-detector](https://github.com/FeedHive/ai-slop-detector) | 0.1k | 120 patterns that make writing read as AI, with an agent skill. | See README |

### 4. DESIGN.md and design systems (the identity)

`DESIGN.md` is a file in the repo root that describes the visual identity so the agent reads it on every task.

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | 128k | `DESIGN.md` files modeled on well-known brand design systems. | Copy one into the repo root ✓ |
| [google-labs-code/design.md](https://github.com/google-labs-code/design.md) | 29k | The `DESIGN.md` format spec, with a linter and a diff tool. | `npx @google/design.md lint DESIGN.md` ✓ |
| [Manavarya09/design-extract](https://github.com/Manavarya09/design-extract) | 5k | Extracts a full design system from any website: tokens, Tailwind, shadcn, `DESIGN.md`. Can also verify your UI against your `DESIGN.md` at 3 widths. | `npx designlang https://example.com`, `npx designlang verify-ui localhost:3000 --brand DESIGN.md` ✓ |
| [style-dictionary/style-dictionary](https://github.com/style-dictionary/style-dictionary) | 5k | One source of design tokens, exported to CSS, JS, iOS, Android. | `npm i -D style-dictionary` † |
| [VoltAgent/awesome-claude-design](https://github.com/VoltAgent/awesome-claude-design) | 5k | 68 design system starting points in `DESIGN.md` format. | Copy one into the repo root |
| [dembrandt/dembrandt](https://github.com/dembrandt/dembrandt) | 4k | Extracts a website's design system into tokens: logo, colors, typography, borders. | See README |
| [zanwei/design-dna](https://github.com/zanwei/design-dna) | 2k | Turns reference screenshots or URLs into measured design tokens, then generates matching UI. | See README |
| [VoltAgent/official-design-md](https://github.com/VoltAgent/official-design-md) | 0.5k | `DESIGN.md` files published by the companies themselves. | Copy one into the repo root |
| [oliur/cards](https://github.com/oliur/cards) | under 0.1k | Tune color, type and radius, then export as shadcn theme, prompt or skill. | See README |

### 5. Components (the real parts)

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [shadcn-ui/ui](https://github.com/shadcn-ui/ui) | 128k | Accessible components copied into your repo, with a registry and an MCP server. | `npx shadcn@latest init` † |
| [DavidHDev/react-bits](https://github.com/DavidHDev/react-bits) | 52k | Large library of animated, interactive React components. | Via shadcn registry † |
| [saadeghi/daisyui](https://github.com/saadeghi/daisyui) | 43k | Tailwind component classes with themes; works without React. | `npm i -D daisyui` † |
| [meta/astryx](https://github.com/meta/astryx) | 30k | Meta's open design system, customizable and built to be agent ready. | `npm install @astryxdesign/core @astryxdesign/theme-neutral @stylexjs/stylex` ✓ |
| [magicuidesign/magicui](https://github.com/magicuidesign/magicui) | 23k | Animated landing page components on the shadcn registry. | Via shadcn registry † |
| [radix-ui/primitives](https://github.com/radix-ui/primitives) | 20k | Unstyled accessible primitives with correct keyboard and focus behavior. | `npm i radix-ui` † |
| [mui/base-ui](https://github.com/mui/base-ui) | 11k | Unstyled accessible components, actively developed. | `npm i @base-ui/react` † |
| [cosscom/ui](https://github.com/cosscom/ui) | 11k | Formerly Origin UI; large set of quality shadcn variants. | Via shadcn registry † |
| [unovue/shadcn-vue](https://github.com/unovue/shadcn-vue) | 11k | shadcn for Vue. | `npx shadcn-vue@latest init` † |
| [jnsahaj/tweakcn](https://github.com/jnsahaj/tweakcn) | 11k | Visual theme editor for shadcn; removes the default look in one step. | Build a theme on tweakcn.com, add it with `npx shadcn@latest add <theme url>` † |
| [nolly-studio/cult-ui](https://github.com/nolly-studio/cult-ui) | 8k | 150+ animated shadcn components with Tailwind and Motion. | Via shadcn registry |
| [ibelick/motion-primitives](https://github.com/ibelick/motion-primitives) | 7k | Subtle animated UI pieces built on Motion. | Copy from the site † |
| [shader-effects-inc/shaders](https://github.com/shader-effects-inc/shaders) | 6k | WebGPU visual effect components for React, Vue, Svelte, Solid. | See README |
| [vercel-labs/ui](https://github.com/vercel-labs/ui) | 5k | Library of UI behaviors made for agents to build with. | `npx skills@latest add vercel-labs/ui --skill ui-sdk` ✓ |
| [DavidHDev/canvas-ui](https://github.com/DavidHDev/canvas-ui) | 5k | Creative canvas components: real HTML with WebGL effects over it. | See README |
| [paper-design/shaders](https://github.com/paper-design/shaders) | 4k | Zero-dependency canvas shaders for gradients and effects. | See README |
| [kevintngo/looseleaf](https://github.com/kevintngo/looseleaf) | 0.7k | 123 accessible React components that look drawn by hand, with a shadcn registry. | See README |
| [deeplethe/solid-glass](https://github.com/deeplethe/solid-glass) | 2k | Design system for AI applications. | See README |
| [BoardUI/boardui](https://github.com/BoardUI/boardui) | 1k | React design system for agent interfaces, components as source. | See README |
| [flohoeller/affectui](https://github.com/flohoeller/affectui) | 0.9k | React components for what agents do: tool calls, traces, approvals. | See README |

Aceternity UI has no public GitHub repo; use it through its website. Tailwind Plus is paid.

### 6. Motion and animation

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [juliangarnier/anime](https://github.com/juliangarnier/anime) | 75k | Light JavaScript animation engine, no framework needed. | `npm i animejs` † |
| [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | 74k | Videos written in React. Company license, check terms. | `npx create-video@latest --skills` ✓ |
| [motiondivision/motion](https://github.com/motiondivision/motion) | 35k | Motion (formerly Framer Motion), the default React animation library. | `npm i motion` † |
| [greensock/GSAP](https://github.com/greensock/GSAP) | 31k | Professional timeline and scroll animation. | `npm i gsap` † |
| [greensock/gsap-skills](https://github.com/greensock/gsap-skills) | 19k | Official GSAP skills, so the agent writes correct GSAP instead of guessed APIs. | `npx skills add https://github.com/greensock/gsap-skills` ✓ |
| [remotion-dev/skills](https://github.com/remotion-dev/skills) | 7k | Official Remotion skills. | `npx skills add remotion-dev/skills` ✓ |
| [Jakubantalik/transitions.dev](https://github.com/Jakubantalik/transitions.dev) | 6k | 43+ crafted UI transitions, usable as a library or as a skill. | See README |
| [CloudAI-X/threejs-skills](https://github.com/CloudAI-X/threejs-skills) | 4k | Three.js skills for 3D scenes. | See README |
| [LottieFiles/motion-design-skill](https://github.com/LottieFiles/motion-design-skill) | 3k | Motion design principles for agents: timing, easing, choreography. | See README |
| [showheyohtaki/motion-prompt](https://github.com/showheyohtaki/motion-prompt) | 2k | 192 named effects, each with a prompt to copy. | See README |
| [kylezantos/design-motion-principles](https://github.com/kylezantos/design-motion-principles) | 2k | Removes AI motion tells: pulsing dots, blur on every entrance, bouncy springs. | See README |
| [oil-oil/oil-motion](https://github.com/oil-oil/oil-motion) | 3k | Web animation that follows scroll and mouse. | See README |
| [bangtutorial/bang-motion](https://github.com/bangtutorial/bang-motion) | 2k | Browser motion graphics: openers, promos, kinetic typography. | See README |
| [iart-ai/motion-skills](https://github.com/iart-ai/motion-skills) | 2k | 56 skills for motion graphics, animation and video. | See README |
| [NiazMorshed2007/reanimate](https://github.com/NiazMorshed2007/reanimate) | 2k | Reverse-engineers an animation frame by frame, then proves the copy moves the same. | See README |
| [JDhruv14/line-art-animation](https://github.com/JDhruv14/line-art-animation) | 1k | Animated line-art SVG components. | See README |
| [lovisdotio/motion2code](https://github.com/lovisdotio/motion2code) | 0.4k | Rebuilds a motion design video as SVG plus GSAP code, checked frame by frame. | See README |

### 7. Visual checks (the eyes)

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | 58k | Chrome DevTools for agents: screenshots, console, performance. | `claude mcp add chrome-devtools -- npx chrome-devtools-mcp@latest` † |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | 52k | Browser command line tool for agents; cheap screenshot loop. | `npm install -g agent-browser`, skill: `npx skills add vercel-labs/agent-browser` ✓ |
| [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) | 40k | Browser control: click through, screenshot at many widths. | `claude mcp add playwright npx @playwright/mcp@latest` ✓ |
| [storybookjs/storybook](https://github.com/storybookjs/storybook) | 92k | Every component state (empty, loading, error) in one place, so the agent can see and check them all. | `npm create storybook@latest` † |
| [GoogleChrome/lighthouse](https://github.com/GoogleChrome/lighthouse) | 31k | Performance, accessibility and best practice scores. | `npx lighthouse <url> --view` † |
| [dequelabs/axe-core](https://github.com/dequelabs/axe-core) | 8k | Accessibility engine; catches contrast and label errors. | `npm i -D @axe-core/playwright` † |
| [garris/BackstopJS](https://github.com/garris/BackstopJS) | 7k | Screenshot comparison, so a fixed page does not break again. | `npx backstop init` † |
| [pa11y/pa11y](https://github.com/pa11y/pa11y) | 5k | One-line accessibility test. | `npx pa11y <url>` † |
| [shadcn-ui/lint](https://github.com/shadcn-ui/lint) | 3k | Linter for Tailwind design systems; rules that agents can verify. | `npm install -D @shadcn/lint eslint @typescript-eslint/parser` ✓ |
| [ngocanhnckh/renderlint](https://github.com/ngocanhnckh/renderlint) | 0.6k | Lints the rendered UI: overflow, contrast, overlaps, responsive breaks, emoji icons. | `npx -y @yitec/renderlint init` ✓ |
| [ShuaiMXu/happyhands](https://github.com/ShuaiMXu/happyhands) | 0.5k | Local workbench for UI review: inspect screenshots, compare before and after. Alpha. | See README |
| [enmerasoftware/ai-design-check](https://github.com/enmerasoftware/ai-design-check) | 0.3k | Design rules plus a zero-dependency checker for web, SwiftUI and Jetpack Compose. | `npx @enmera/ai-design-check`, skill: `npx skills add enmerasoftware/ai-design-check` ✓ |
| [dgesteves/onsystem](https://github.com/dgesteves/onsystem) | under 0.1k | Keeps the agent on your design system at every edit and pull request. | See README |
| [ginader/born-accessible-ui](https://github.com/ginader/born-accessible-ui) | under 0.1k | Skill plus Playwright and axe loop for accessible frontends on the first pass. | See README |

### 8. Design connectors (MCP servers)

MCP (Model Context Protocol) servers give the agent live access to a tool such as Figma.

| Repo | Stars | What it does | Install |
|---|---|---|---|
| [GLips/Figma-Context-MCP](https://github.com/GLips/Figma-Context-MCP) | 16k | Figma layout data for agents (community). Needs a Figma API key. | `npx -y figma-developer-mcp --figma-api-key=$FIGMA_API_KEY --stdio` † |
| [21st-dev/magic-mcp](https://github.com/21st-dev/magic-mcp) | 7k | Searches 10,000+ community React and Tailwind components. Needs a 21st API key. | `npx @21st-dev/cli@latest init --client claude` ✓ |
| [southleft/figma-console-mcp](https://github.com/southleft/figma-console-mcp) | 3k | Your design system as an API: extract, create and debug in Figma. | See README |
| [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide) | 2k | Guide for Figma's official MCP server. | `claude mcp add --transport http figma https://mcp.figma.com/mcp` † |
| [INSANE0777/Awwwards-mcp](https://github.com/INSANE0777/Awwwards-mcp) | 0.8k | Design inspiration from award-winning websites. | `claude mcp add awwwards -- npx -y awwwards-mcp` ✓ |
| [marvkr/better-design](https://github.com/marvkr/better-design) | 0.6k | Design MCP plus a shadcn registry of design systems. | See README |
| [magicuidesign/mcp](https://github.com/magicuidesign/mcp) | 0.2k | Lets the agent search Magic UI directly. | See README |

### 9. Guides and rule sets

| Source | Stars | What it is |
|---|---|---|
| [thedaviddias/Front-End-Checklist](https://github.com/thedaviddias/Front-End-Checklist) | 75k | Checklist for modern web development, for people and agents. |
| [anthropics/claude-cookbooks](https://github.com/anthropics/claude-cookbooks) | 55k | Holds the "prompting for frontend aesthetics" recipe: typography, color, motion, backgrounds. |
| [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) | 22k | Current web best practices, searchable by the agent. `npx modern-web-guidance@latest install` ✓ |
| [a11yproject/a11yproject.com](https://github.com/a11yproject/a11yproject.com) | 4k | Accessibility checklist: https://www.a11yproject.com/checklist/ |
| [raunofreiberg/interfaces](https://github.com/raunofreiberg/interfaces) | 2k | Classic list of details that make a good interface. Last push 2023. |
| [vercel-labs/web-interface-guidelines](https://github.com/vercel-labs/web-interface-guidelines) | 1k | Vercel's interface rules as a concrete checklist. |
| [Laws of UX](https://lawsofux.com) | site | Shared UX vocabulary. |

### 10. Icons and fonts (instead of emoji and Inter)

| Repo | Stars | Install |
|---|---|---|
| [lucide-icons/lucide](https://github.com/lucide-icons/lucide) | 26k | `npm i lucide-react` † |
| [tailwindlabs/heroicons](https://github.com/tailwindlabs/heroicons) | 24k | `npm i @heroicons/react` † |
| [tabler/tabler-icons](https://github.com/tabler/tabler-icons) | 23k | `npm i @tabler/icons-react` † |
| [phosphor-icons/homepage](https://github.com/phosphor-icons/homepage) | 8k | `npm i @phosphor-icons/react` † |
| [iconify/iconify](https://github.com/iconify/iconify) | 6k | `npm i @iconify/react` † (all icon sets) |
| [fontsource/fontsource](https://github.com/fontsource/fontsource) | 6k | `npm i @fontsource-variable/<font>` † |

### 11. Lists that index more

| Repo | Stars | What |
|---|---|---|
| [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) | 80k | Large Claude skills list. |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 58k | Claude Code resources. |
| [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 37k | 1000+ skills across agents. |
| [BehiSecc/awesome-claude-skills](https://github.com/BehiSecc/awesome-claude-skills) | 10k | Curated Claude skills. |
| [bergside/awesome-design-skills](https://github.com/bergside/awesome-design-skills) | 4k | Design only: 67 `DESIGN.md` and `SKILL.md` files. |

### 12. Design tools and builders (not skills, full apps)

| Repo | Stars | What it does |
|---|---|---|
| [nexu-io/open-design](https://github.com/nexu-io/open-design) | 108k | Local, open design workspace that drives your installed agent to make prototypes, sites, slides. |
| [abi/screenshot-to-code](https://github.com/abi/screenshot-to-code) | 81k | Drop in a screenshot, get HTML, Tailwind, React or Vue code. |
| [onlook-dev/onlook](https://github.com/onlook-dev/onlook) | 27k | Open visual editor for AI-built apps: edit the UI by hand after the agent builds it. |
| [OpenCoworkAI/open-codesign](https://github.com/OpenCoworkAI/open-codesign) | 8k | Open alternative to Claude Design: prompt to prototype, slides, PDF. |
| [ZSeven-W/openpencil](https://github.com/ZSeven-W/openpencil) | 7k | Open vector design tool where designs are code. |

## LIMITS OF THIS LIST

- A high star count shows attention, not quality. Test a skill on one real screen of your product before you adopt it.
- Entries with "See README" were confirmed to exist on GitHub, but their install step was not read.
- The X post links were taken from saved post data and were not reopened.
- Small repos (under 0.1k stars) are listed because they do one narrow thing well on paper; they are untested here.

## SOURCES

- GitHub API, 17 Nov 2026, for every star count, push date and license.
- [SuperDesign: design skills reviewed](https://superdesign.dev/blog/design-skills-reviewed)
- [Bitdoze: best AI skills for web design compared](https://www.bitdoze.com/best-ai-skills-for-web-design/)
- [Snyk: top Claude skills for UI/UX engineers](https://snyk.io/articles/top-claude-skills-ui-ux-engineers/)
- [DEV Community: design skills for AI agents](https://dev.to/guayoyo_tech/design-skills-for-ai-agents-how-to-stop-getting-generic-interfaces-12bg)
- [Trilogy AI: fixing visual AI slop](https://trilogyai.substack.com/p/fixing-visual-ai-slop)
