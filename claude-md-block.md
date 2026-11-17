<!-- frontend-kit:start -->
## Frontend and design work

**Before writing or changing any screen, page, component, style, animation or on-screen text, load the `frontend-kit` skill and follow its chain.** This includes one-off HTML pages, demos, prototypes and mockups, in any project, even when the user does not mention design. It applies to you and to every subagent you start for UI work: put this sentence in their brief.

Main taste skill: <fill in at install, default impeccable>
Skill folder: <fill in at install, the full path of the installed frontend-kit folder>

If the skill does not load by name, read `SKILL.md` in the skill folder above and follow it. If that folder is missing, follow the chain below as written and tell the user in one line that the design kit needs to be installed again.

Do it silently: the user did not ask for this workflow and may not be technical. Do not ask design questions and do not talk about the kit or its tools. Choose, build, check, then show the result in plain words, with the style you chose in one sentence. A short or casual request ("just one html file", "quick demo") gets the full chain. Never create an account, log in, pay, or send the user's files anywhere because of this kit.

The chain, in order. Each phase uses a different tool and leaves evidence:

1. **Brief and content:** what the screen is for, who uses it, the real words of each section, the main journey.
2. **Identity:** read `DESIGN.md` (create it if missing). Only its tokens are allowed. An existing brand wins over any taste rule here.
3. **Direction:** the one main taste skill plus real references. New page with no direction: 3 quick sketches of the first screen, score them, continue with the best.
4. **Build:** layout from the content, then theme, then components from the library, then every state. A product page shows a real visual on its first screen.
5. **Motion and effects:** interaction motion on every interface (under 300 ms for feedback). Then choose by yourself whether the page gets signature effects (3D, scroll storytelling, parallax, SVG with light flowing along lines, text reveals, animated backgrounds): yes for landing, startup, product and "futuristic" pages; no for app screens, forms and reading pages. One hero effect per screen, a static version for reduced motion, smooth on a phone.
6. **Copy:** every string does its job and does not sound generated.
7. **See:** serve the page, screenshot it at 390, 768 and 1280 px, look, use the main journey with mouse and keyboard, fix, repeat. Never skip.
8. **Gates:** `npx --yes impeccable detect <URL>`, `npx --yes designlang verify-ui <URL> --brand DESIGN.md`, `npx --yes lighthouse <URL> --only-categories=accessibility,performance --quiet`, zero console errors.
9. **Report:** save the receipt to `.frontend-kit/receipt.md`, show screenshots, tell the user the result in plain words, and say what you could not check. A UI task without the receipt is not finished.

One tool per job, several jobs per screen. Never two taste skills steering at once. For a special task (landing page, dashboard, Figma file, mobile, 3D, charts, brand) check the router table in the skill, then `catalog.md` for the phase you are in.

### Never ship these (signs of generated design)
- Inter, Roboto, Arial or system font as the only typeface with no reason (a native app or an existing brand is a reason).
- Purple-to-blue or pink-to-purple gradients, gradient text, glow blobs.
- The second generic look: cream background, editorial serif headline and terracotta accent, chosen only because it is not purple.
- Emoji used as icons.
- The default page: centered hero, three feature cards with an icon each, a call to action band.
- A page that presents a product with no real visual on its first screen.
- Cards inside cards; a border plus a shadow plus a large radius on everything.
- Everything centered, every block the same size, no clear first thing to look at.
- The default grey component theme, unchanged.
- Glass blur panels and "New" or "Beta" pills with no purpose.
- Extra labels and descriptions under every heading. Let the layout do the explaining.
- More than 4 font sizes on one screen; small all-caps headings everywhere.
- Filler text: "Elevate", "Seamless", "Unlock", "Supercharge".
- Invented numbers, logos, testimonials or promises; lorem ipsum. (Sample data in a demo is fine when the page labels it as sample data.)
- Hover-only actions, missing focus rings, text under 4.5:1 contrast, touch targets under 44 px.
- Motion tells: pulsing dots, blur on every entrance, bouncy springs on everything.

### taste
(One rule per line. Add a line after each design correction from the user. If a correction can be a lint rule, a token or a test, make it that instead.)
<!-- frontend-kit:end -->
