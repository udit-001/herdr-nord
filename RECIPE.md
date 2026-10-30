# Nord for Herdr

Your agents as a focused workbench in Nord colors. One space, one tab, one
terminal at a time, with Files and Changes panels a keypress away — and the
confidence that every color pair you look at was measured, not eyeballed.

This file is the brief: enough to build the layout from an empty folder.
`layouts/square-nord.json` and `mods/` next to it are one build of it. If
they don't work on your Herdr, or you want it different, build it again
from here.

## What you see

Three regions, left to right, filling the window (no title bar):

1. **The sidebar**, 140px, Nord chrome. Brand row on top; Spaces and Agents
   lists between; Settings and Add machine in the footer. Rows select as
   inset rounded pills; an agent's row shows its program icon, name, idle
   time, and a status cue (spinner while working, ringed dot otherwise).
2. **The tab rail**, 24px. Tabs with program icons, a + menu for new
   terminals, agents, spaces and worktrees; Files and Changes toggle the
   right panel; window buttons on the right. The active tab is Nord cyan
   with dark text.
3. **The work area**: terminal panes as 6px cards on the darker canvas,
   8px gaps, draggable borders. The focused pane's border stays quiet —
   same color as the rest. The right panel (389px, resizable 280-900)
   stacks the Files browser and the Changes diff view.

Colors: the Nord palette throughout, `#2e3440` surfaces, `#eceff4` text,
`#88c0d0` accent. Text in your own fonts (the layout ships none).

## How it behaves

- Status is always visible somewhere: the pane header, the tab, and the
  agents list each carry it. Working spins; blocked shows a "Needs you"
  badge; done and idle show dots.
- On the cyan active tab, status cues switch to dark ink or gain a dark
  ring, so they keep a 3:1 boundary against the bright fill.
- Files and Changes are rounded cards matching the panes. Changes takes
  arrow-key and Enter navigation, and shows per-file add/del counts in a
  text-grade red and green distinct from the terminal ANSI colors.
- Sidebar rows highlight as pills; drag a space row onto another to
  reorder (the accent drop indicator shows the landing line).
- Panes drag by their borders; saved sizes persist across restarts.

## Built from

- **The layout file** (`layouts/square-nord.json`): a root `row` — sidebar
  `column` (brand block 46px, spaces + agents blocks, footer block 76px)
  and a work `column` (tabs block 24px, then a `work-body` row holding the
  terminal pane block and the panel stack). The root carries `theme` and
  the full `colors` token set; treat that block as the single source of
  truth for color, not this file.
- **Twelve mods** under `mods/square-nord-*`, renamed clones of Herdr
  0.1.7's shipped mods: workspace-chrome (brand + footer), spaces, agents,
  tabs, pane (header), files, changes, picker, menu, new-menu,
  machine-add, worktree.
- **Tokens, not literals**: mods read `theme()` and the semantic names
  (`t.dim`, `t.muted`, `t.selected`, `t.hover`). The two text-grade colors
  live as constants in the two mods that need them (`redText`, `#cf9094`),
  because terminal ANSI (`#bf616a`) must stay terminal-grade.

## Watch out

- **Measure, don't eyeball.** Every text token was checked at 4.5:1 on
  each surface it renders on (`dim` 5.07, `muted` 5.91 on the background),
  and non-text cues at 3:1. If you move a color to a new surface, remeasure
  the pair — `#6d7a90`-class greys fail hard on raised fills.
- **`image()` cannot stretch.** For full-bleed art use the block's own
  `background` with `fit: "cover"` (the layout supports it), or draw with
  divs. A plain image letterboxes.
- **Mods can't measure their block.** No conditional art by height. Pick
  one adaptive strategy up front.
- **No press states, no color transitions, no reduced-motion signal** in
  gpui-kit today. Hover snaps; motion is `.transition` / `.loop` only.
  Don't promise fluidity the platform can't draw.
- **Type scale is 11 / 12 / 13.** Larger only in dialogs (15). A second
  size crept in is a finding, not a tweak.
- **Selection outranks hover.** `selected` (#434c5e) is brighter than
  `hover` (#3b4252) — keep that order or active rows read as hovered.
- **Edits apply live, but clicks persist.** Sizes and toggles you set in
  the window are saved to `layouts/.state/` and survive; a deliberate
  layout-file edit beats a saved click on the same field.
- **Never call a mod done without `herdr-app check <mod folder>` passing**
  (run it from the app home), and don't commit screenshots of a real
  project — preview images get anonymized first.

## Done when

- Every surface draws Nord: no leftover theme defaults peeking through in
  any of the twelve mods.
- Contrast pairs pass: 4.5:1 for text, 3:1 for boundaries and cues,
  measured on the surface each actually renders on.
- All twelve mods pass `herdr-app check`; switching to another layout and
  back works.
- A blocked agent is unmistakable in the sidebar, the tab bar, and the
  pane header at once — and the cue survives on the active tab.
