# EFFECTS REFERENCE

Open this file when a task adds a 3D scene, scroll effect, SVG animation, page transition or any other visual effect.
Read the Layer B rules in SKILL.md first. Use one hero effect per screen, and give every effect its own visible static state for reduced motion.
Any effect that moves on its own for more than 5 seconds (loops, marquees, flowing light) gets a visible pause button that works by keyboard and touch; the marquee recipe (i) shows the pattern. Hover-only pause is an extra, not the control.
Restyle every effect with the DESIGN.md tokens (colors, radii, easing); never keep a demo's own palette.
Tools are listed in catalog.md phase 5; this file holds the recipes that need no library. The single authority for default tools is the table in SKILL.md phase 4; the table below agrees with it.

## Default tool per job

| Job | Default | Switch to ... when ... |
|---|---|---|
| Product people rotate and inspect | model-viewer | React Three Fiber or three.js when it must be a custom scene |
| 3D in React | React Three Fiber plus drei (check React 18 or 19 first, catalog 5.2) | three.js directly when there is no React |
| 3D in Vue or Svelte | TresJS (Vue), Threlte (Svelte) | three.js when the framework wrapper blocks you |
| Dotted globe | cobe | globe.gl when the globe must show arcs or data |
| Smooth scroll | Lenis | native scroll when the page is a normal document |
| Scroll story, pinned sections | GSAP ScrollTrigger with gsap-skills | none needed |
| Simple reveal or progress tied to scroll | CSS `animation-timeline: view()` or `scroll()` (recipe e) | GSAP ScrollTrigger when it is part of a larger timeline |
| Parallax | CSS scroll-driven transforms | GSAP ScrollTrigger when it must sync with a timeline; Rellax for plain HTML that must support browsers without scroll-driven animation |
| Light flowing along SVG lines | CSS dash recipe (a) | GSAP when the timing is complex |
| SVG line drawing | CSS `pathLength` recipe (c) | Vivus or GSAP DrawSVG for long sequences |
| Vector animation files | dotLottie web player | Rive when the animation must react to user input |
| Page transitions | View Transitions API (recipe f) | next-view-transitions for basic Next.js App Router cases; Swup for multi-page static or server-rendered sites |
| Text reveal | GSAP SplitText, or CSS with one span per line | Fancy when a React headline needs a specific effect |
| Animated background | paper-design/shaders, or tsParticles with its slim bundle | Vanta for a one-call 3D background |
| Cards that feel alive (spotlight, glow, border) | CSS with `@property` and pointer variables (recipes d, h) | Atropos for 3D tilt with depth layers |
| Animated icons | pqoqubbw/icons (animated Lucide) in React | PulsoIcon for Vue or Svelte |
| Carousel | Embla | Swiper when the carousel needs 3D effects |

## Recipes without a library

Each recipe keeps its own reduced-motion handling and its own final static state. Recipe (j) is a backstop for Layer B wrappers, not a replacement for those states.

### (a) Light or energy flowing along an SVG path
Draw the path twice: a dim base line and a bright copy. On the bright copy set `pathLength="100"` so the unitless dash distances are normalised to a 0 to 100 path (write `12 88`, no percent signs), use `stroke-dasharray` for one short dash, and animate `stroke-dashoffset` from 100 to 0. The glow is a `drop-shadow` filter.
```html
<svg class="wire" viewBox="0 0 300 80" role="img" aria-label="Data flowing along a line">
  <path class="wire-base" d="M10 60 C80 0 160 120 290 20" />
  <path class="wire-flow" d="M10 60 C80 0 160 120 290 20" pathLength="100" />
</svg>
```
```css
.wire { width: 100%; max-width: 420px; }
.wire path { fill: none; stroke-width: 3; stroke-linecap: round; }
.wire-base { stroke: #2a3350; }
.wire-flow {
  stroke: #22d3ee;
  stroke-dasharray: 12 88;
  filter: drop-shadow(0 0 6px #22d3ee);
  animation: wire-flow 2s linear infinite;
}
@keyframes wire-flow { from { stroke-dashoffset: 100; } to { stroke-dashoffset: 0; } }
@media (prefers-reduced-motion: reduce) {
  .wire-flow { animation: none; stroke-dasharray: none; opacity: .6; }
}
```

### (b) A glowing dot travelling along a path
Give a small element `offset-path` with the same path data, then animate `offset-distance` from 0% to 100%. The path coordinates are measured from the top left of the positioned parent, so the parent must have the same size as the SVG viewBox.
```html
<div class="dot-box"><span class="dot"></span></div>
```
```css
.dot-box { position: relative; width: 300px; height: 80px; }
.dot {
  position: absolute; top: 0; left: 0;
  width: 10px; height: 10px; border-radius: 50%;
  background: #22d3ee; box-shadow: 0 0 12px 3px #22d3ee;
  offset-path: path('M10 60 C80 0 160 120 290 20');
  offset-distance: 0%;
  animation: dot-travel 3s linear infinite;
}
@keyframes dot-travel { to { offset-distance: 100%; } }
@media (prefers-reduced-motion: reduce) {
  .dot { animation: none; offset-distance: 100%; }
}
```

### (c) SVG line drawing
Set `pathLength="1"` so the dash is one unit, then animate `stroke-dashoffset` from 1 to 0. No JavaScript is needed. (Without `pathLength`, read `path.getTotalLength()` and use that number instead.)
```html
<svg class="draw" viewBox="0 0 200 80" aria-hidden="true">
  <path d="M10 60 L60 20 L110 60 L160 20 L190 50" pathLength="1" />
</svg>
```
```css
.draw { width: 100%; max-width: 320px; }
.draw path {
  fill: none; stroke: #f472b6; stroke-width: 3;
  stroke-dasharray: 1 1;
  animation: draw 2s ease-out forwards;
}
@keyframes draw { from { stroke-dashoffset: 1; } to { stroke-dashoffset: 0; } }
@media (prefers-reduced-motion: reduce) {
  .draw path { animation: none; stroke-dashoffset: 0; }
}
```

### (d) Animated gradient border with @property
Register `--angle` as a real angle so the browser can animate it, then paint a conic gradient on the border box under a solid padding box. The `var(--angle, 0deg)` fallback keeps the border valid in browsers without `@property`; they show a static border.
```html
<div class="glow-card">Gradient border</div>
```
```css
@property --angle { syntax: '<angle>'; inherits: false; initial-value: 0deg; }
.glow-card {
  padding: 24px; max-width: 280px; color: #e5e7eb;
  border: 2px solid transparent; border-radius: 16px;
  background:
    linear-gradient(#0b0f1a, #0b0f1a) padding-box,
    conic-gradient(from var(--angle, 0deg), #22d3ee, #a855f7, #22d3ee) border-box;
  animation: glow-spin 4s linear infinite;
}
@keyframes glow-spin { to { --angle: 360deg; } }
@media (prefers-reduced-motion: reduce) { .glow-card { animation: none; } }
```

### (e) Scroll-driven reveal with animation-timeline: view()
The element animates while it crosses the viewport. The default style is the visible one, so browsers without support (or with reduced motion) just show the content.
```html
<p class="reveal">I fade in as I scroll into view.</p>
```
```css
@keyframes reveal { from { opacity: 0; transform: translateY(40px); } to { opacity: 1; transform: none; } }
@supports (animation-timeline: view()) and (animation-range: entry 0% cover 40%) {
  @media (prefers-reduced-motion: no-preference) {
    .reveal {
      animation: reveal 1ms linear both; /* nonzero duration: Firefox needs it */
      animation-timeline: view();
      animation-range: entry 0% cover 40%;
    }
  }
}
```
The `animation` shorthand comes first because it resets `animation-timeline`. For a reading progress bar use `animation-timeline: scroll()` on a fixed bar that animates `transform: scaleX(0)` to `scaleX(1)`, with the same nonzero duration, the same `@supports` and reduced-motion guards, and a static full or hidden bar as the fallback.

### (f) View transitions
Same document: wrap the DOM change in `document.startViewTransition()`; the element that carries `view-transition-name` morphs. Cross document: progressive enhancement for eligible same-origin navigations without cross-origin redirects; both documents opt in with `@view-transition { navigation: auto; }`, and browsers without support navigate normally. Same-document support does not mean cross-document support. Always keep the fallback branch.
```html
<div class="vt-box" id="vtBox">Box</div>
<button id="vtBtn" type="button">Toggle size</button>
```
```css
.vt-box { view-transition-name: vt-box; width: 80px; height: 80px; background: #22d3ee; }
.vt-box.big { width: 200px; height: 120px; }
@view-transition { navigation: auto; } /* cross-document: put this in every page */
@media (prefers-reduced-motion: reduce) {
  ::view-transition-group(*), ::view-transition-old(*), ::view-transition-new(*) { animation: none; }
}
```
```js
document.getElementById('vtBtn').addEventListener('click', () => {
  const change = () => document.getElementById('vtBox').classList.toggle('big');
  if (document.startViewTransition) document.startViewTransition(change);
  else change();
});
```

### (g) Clip-path reveal
Animate `clip-path: inset()` from fully hidden to fully shown. It works on any element; compositing and cost depend on the browser, the shape and the content, so profile the real wipe or mask. For a soft edge use `mask-image: linear-gradient(...)` and animate `mask-position`.
```html
<div class="wipe">Revealed from the left</div>
```
```css
.wipe {
  padding: 24px; max-width: 280px; background: #7e22ce; color: #fff;
  clip-path: inset(0 100% 0 0);
  animation: wipe 1s cubic-bezier(.7, 0, .2, 1) .2s forwards;
}
@keyframes wipe { to { clip-path: inset(0 0 0 0); } }
@media (prefers-reduced-motion: reduce) {
  .wipe { animation: none; clip-path: none; }
}
```

### (h) Cursor spotlight with pointer variables
On `pointermove` write the pointer position into two CSS variables; the radial gradient reads them. The listener runs only with a fine pointer that can hover and no reduced-motion preference, and it is added or removed when that preference changes, so touch and reduced-motion users see a centered spotlight. In a component, return `disposeSpotlight` from the cleanup hook.
```html
<div class="spot">Move your pointer here</div>
```
```css
.spot {
  --x: 50%; --y: 50%;
  padding: 48px 24px; max-width: 360px; color: #e5e7eb;
  background:
    radial-gradient(260px circle at var(--x) var(--y), rgba(34, 211, 238, .28), transparent 70%),
    #0b0f1a;
}
```
```js
const spot = document.querySelector('.spot');
const allowed = matchMedia('(prefers-reduced-motion: no-preference) and (pointer: fine) and (hover: hover)');
function moveSpot(e) {
  const r = spot.getBoundingClientRect();
  spot.style.setProperty('--x', `${e.clientX - r.left}px`);
  spot.style.setProperty('--y', `${e.clientY - r.top}px`);
}
function syncSpot() {
  spot.removeEventListener('pointermove', moveSpot);
  spot.style.removeProperty('--x');
  spot.style.removeProperty('--y');
  if (allowed.matches) spot.addEventListener('pointermove', moveSpot);
}
function disposeSpotlight() {
  allowed.removeEventListener('change', syncSpot);
  spot.removeEventListener('pointermove', moveSpot);
}
allowed.addEventListener('change', syncSpot);
syncSpot();
```

### (i) CSS marquee
Two identical copies of the row sit side by side; moving the track by -50% lands exactly on the second copy, so the loop has no jump. Each copy must fill the container (`min-width: 200%` on the track, `flex: 1 0 auto` on each copy); repeat the content when it is short, and check with the real font at every supported width. Hide the copy from screen readers. A pause button outside the track stops it by keyboard, mouse and touch.
```html
<button type="button" id="marqueePause" aria-pressed="false">Pause animation</button>
<div class="marquee">
  <div class="marquee-track">
    <span>Design * Motion * 3D * Scroll * </span>
    <span aria-hidden="true">Design * Motion * 3D * Scroll * </span>
  </div>
</div>
```
```css
.marquee { overflow: hidden; max-width: 420px; color: #e5e7eb; }
.marquee-track { display: flex; width: max-content; min-width: 200%; animation: marquee-move 20s linear infinite; }
.marquee-track span { flex: 1 0 auto; white-space: pre; }
.marquee:hover .marquee-track,
.marquee[data-paused="true"] .marquee-track { animation-play-state: paused; }
@keyframes marquee-move { to { transform: translateX(-50%); } }
@media (prefers-reduced-motion: reduce) {
  .marquee { overflow-x: auto; }
  .marquee-track { animation: none; }
}
```
```js
const marquee = document.querySelector('.marquee');
const pause = document.getElementById('marqueePause');
pause.addEventListener('click', () => {
  const paused = marquee.dataset.paused !== 'true';
  marquee.dataset.paused = String(paused);
  pause.setAttribute('aria-pressed', String(paused));
});
```

### (j) prefers-reduced-motion: swap Layer B for a static frame
Layer B is the animated layer (canvas, video, looping animation). Ship a still image of the same scene next to it and switch them in CSS. Every Layer B effect must define its own visible static state. Mark each Layer B wrapper with `data-layer-b`; the backstop below turns off animation and transitions inside those wrappers (scroll-driven animations included) and restores the final style of the recipes above. It never speeds animations up.
```html
<canvas class="hero-live"></canvas>
<img class="hero-still" src="hero-still.webp" alt="" width="1200" height="630" hidden>
```
```css
@media (prefers-reduced-motion: reduce) {
  .hero-live { display: none; }
  .hero-still { display: block; }
  [data-layer-b], [data-layer-b] *,
  [data-layer-b]::before, [data-layer-b]::after,
  [data-layer-b] *::before, [data-layer-b] *::after {
    animation: none !important;
    transition: none !important;
  }
  html { scroll-behavior: auto !important; }
  .reveal { opacity: 1; transform: none; }
  .wipe { clip-path: none; }
  .draw path { stroke-dashoffset: 0; }
}
```
CSS cannot stop JavaScript. Canvas, video, GSAP and Lenis effects share one start and stop lifecycle that reacts to the reduced-motion preference (listen for its `change` event, as in recipe h), to the element leaving the viewport, and to the tab being hidden. When motion is not allowed, cancel the running loop; when it is allowed again, restart it once, never twice.

## Performance checklist for heavy visuals

1. Lazy load: import three.js, Lottie, Rive and big images only when the section is near the viewport (dynamic `import()`, `loading="lazy"`).
2. Cap the pixel ratio at 2: `renderer.setPixelRatio(Math.min(devicePixelRatio, 2))`.
3. Pause when off screen: observe the canvas with `IntersectionObserver` and stop the render loop when it leaves the view.
4. Pause when the tab is hidden: listen to `visibilitychange` and stop `requestAnimationFrame` and videos.
5. Compress models and textures: glTF-Transform (Draco or Meshopt, KTX2 textures); keep a hero model under about 2 MB.
6. Prefer `transform` and `opacity`. SVG `stroke-dashoffset`, `offset-distance`, `clip-path` and registered custom properties are fine on small areas. Never animate layout properties (`width`, `height`, `top`, `left`, `margin`, `padding`). Use `will-change` only after profiling shows a benefit, and remove it after.
7. Optional: detect-gpu gives a first guess of the GPU tier (fetch failed or unsupported results are not real tiers); the proof is a frame trace of the real scene, with the static frame as the fallback.
8. Test at 390 px wide on a real or emulated phone: no horizontal scroll, steady frame rate, tap targets still reachable.
