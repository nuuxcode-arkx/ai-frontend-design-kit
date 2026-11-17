<!-- frontend-kit:start -->
## Frontend and design work

**Before writing or changing any screen, page, component, style, animation or on-screen text, load the `frontend-kit` skill and follow its chain.** This includes one-off HTML pages, demos, prototypes and mockups, in any project, even when the user does not mention design. It applies to you and to every subagent you start for UI work: put this sentence in their brief.

Main taste skill: <fill in at install, default impeccable>
Skill folder: <fill in at install, the full path of the installed frontend-kit folder>

If the skill does not load by name, read `SKILL.md` in the skill folder above and follow it. If that folder or its `sweep.md` is missing, follow the short chain below, save the jobs and tools you could check in `.frontend-kit/tool-plan.md`, and tell the user in one line that the design kit needs to be installed again.

Do it silently: the user did not ask for this workflow and may not be technical. Do not ask design questions and do not talk about the kit or its tools. Choose, build, check, then show the result in plain words, with the style you chose in one sentence. A short or casual request ("just one html file", "quick demo") gets the full chain. Never create an account, log in, pay, or send the user's files anywhere because of this kit.

The chain, in order. Each phase uses a different tool and leaves evidence:

1. **Brief and content:** what the screen is for, who uses it, the real words of each section, the main journey. Then the **tool sweep**: use the skill's task-size table and the plan format in `sweep.md`. Before writing a screen, save the current task's tool plan; update it with evidence at each phase and use it to fill the receipt. A missing tool is fetched for the task within the limits in `sweep.md` (no account, no global install, the user's current words win). Never two tools for one job.
2. **Identity:** read `DESIGN.md`. For a new page or product, create it if missing; for a small fix, follow the styles already in the code. Only its tokens are allowed. An existing brand wins over any taste rule here.
3. **Direction:** the one main taste skill plus real references. New page with no direction: 3 quick sketches of the first screen that truly differ in layout and hierarchy, same real content; keep the one a new visitor understands fastest. Then write its three visual decisions: composition, type hierarchy, how it shows the product.
4. **Build:** layout from the content, then theme, then components from the library, then every state. A product page shows the product itself on its first screen (its interface, its result, or a truthful diagram), not decoration.
5. **Motion and effects:** interaction motion on every interface (under 300 ms for feedback). Then choose by yourself whether the page gets signature effects (3D, scroll storytelling, parallax, SVG with light flowing along lines, text reveals, animated backgrounds): a duty for landing, startup and product pages (one hero effect plus at least one quiet supporting effect); none for app screens, forms and reading pages beyond one contained effect away from the work area, where a "futuristic" brief is carried by type, color, light and precise interaction motion. Every effect has a job (explain an object, show a flow, reveal a sequence). One hero effect per screen, a static version for reduced motion, smooth on a phone.
6. **Copy:** every string does its job and does not sound generated.
7. **See** (task-size and platform rules from the skill when available): serve the page, screenshot it at 390, 768 and 1280 px (a small fix: before and after at the width it affects), look, use the main journey with mouse and keyboard, fix, repeat. End with a designer's critique against the brief: name the three biggest problems and fix them. Never skip.
8. **Gates** (those that apply to the task size): `npx --yes impeccable detect <URL>`, `npx --yes designlang verify-ui <URL> --brand DESIGN.md`, `npx --yes lighthouse <URL> --only-categories=accessibility,performance --quiet`, zero console errors.
9. **Report:** save the receipt to `.frontend-kit/receipt.md`, show screenshots, tell the user the result in plain words, and say what you could not check. A UI task without the receipt is not finished.

One tool per job, many jobs per screen. The number of tools depends on the jobs the page really needs; no job is ON without a matching signal. Never two taste skills steering at once. The catalog (`catalog.md`, about 350 tools) lists every other choice, with the signals that call for each.

### Never ship these (signs of generated design)
- Inter, Roboto, Arial or system font as the only typeface with no reason (a native app or an existing brand is a reason).
- Purple-to-blue or pink-to-purple template gradients, gradient text, glow blobs with no brand or purpose. Brand tokens in `DESIGN.md` win.
- The second generic look: cream background, editorial serif headline and terracotta accent, chosen only because it is not purple.
- Emoji used as icons.
- The default page: centered hero, three feature cards with an icon each, a call to action band.
- A page that presents a product with no real visual on its first screen.
- Cards inside cards; a border plus a shadow plus a large radius on everything.
- Everything centered, every block the same size, no clear first thing to look at.
- The default grey component theme, unchanged.
- Glass blur panels and "New" or "Beta" pills with no purpose.
- Extra labels and descriptions under every heading. Let the layout do the explaining.
- Font sizes with no scale behind them; small all-caps headings everywhere.
- Filler text: "Elevate", "Seamless", "Unlock", "Supercharge".
- Invented numbers, logos, testimonials or promises; lorem ipsum. (Sample data in a demo is fine when the page labels it as sample data.)
- Hover-only actions, missing focus rings, text under 4.5:1 contrast, touch targets under 44 px.
- Motion tells: pulsing dots, blur on every entrance, bouncy springs on everything.

### taste
(One rule per line. Add a line after each design correction from the user. If a correction can be a lint rule, a token or a test, make it that instead.)
<!-- frontend-kit:end -->
