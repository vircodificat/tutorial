# Tutorial Guidelines

Guidelines for authoring Virdant tutorial lessons in this directory.
Every rule here exists to serve one goal: **teach the learner Virdant.**

Related reading: `../agents/skills/virdant/` (read ALL files before
writing lessons — it is the source of truth for the language and its
coding conventions).

## Audience

Software programmers with **no hardware background**. Assume comfort
with programming (variables, functions, conditionals) but assume
*nothing* about clocks, registers, wires, synthesis, or HDL generally.

Consequences:

* The tutorial teaches hardware *thinking*, not just Virdant syntax.
  A lesson about `reg` must also teach what a clock edge is.
* Never assume prior HDL vocabulary. Introduce every term the first
  time it appears in a lesson — because lessons may be reordered, the
  "first time" is whatever lesson the learner is in.
* Verilog comparisons are allowed, but only **sparingly and only when
  pertinent**. They are seasoning, not structure.

## Lesson anatomy

Each lesson is a directory `NNN_snake_title/` containing a complete,
self-contained Virdant project:

```
NNN_snake_title/
    README.md        # minimal puzzle intro (see below)
    virdant.toml     # project config (top module, etc.)
    src/             # the BROKEN code the learner repairs
        top.vir      # (plus more files as the lesson needs)
    test.poke        # the executable spec / stimulus script
    test.toml        # dev-only metadata; learners ignore it
    Makefile         # `make test` = `vir poke test.poke --script`
                     # (bare `vir poke test.poke` also runs the script;
                     #  add `--repl` to drop into the REPL on failure)
    solution/        # the fixed version (see "Solutions" below)
```

* Scaffold new lessons with `./make_lesson <title>`.
* Directory names are `NNN_snake_case`. Numbers are assigned by
  `make_lesson` in creation order; **ordering does not matter yet** —
  lessons will be reordered later, so numbering carries no meaning.
* Multiple files and multiple packages appear **as soon as they make
  sense**. Packages are a tool for reducing how much a learner must
  hold in their head at once: when a lesson uses supporting modules,
  put them in other files/packages, with enough comments that a
  learner can skim them without a guided tour — but the *lesson's*
  concept lives in the highlighted file.
* The broken code may live in **any** file. The README says which
  file(s) are suspect when it is not `src/top.vir`.

## The learner's loop

The learner works with two commands, stated in every README:

1. `vir check` — while reading and editing.
2. `make test` — to confirm the design actually behaves.

* Broken code must **fail**: either `vir check` errors, or `make test`
  asserts fail. A lesson whose bug "still passes" is a defect.
* Solutions must **pass both, with zero warnings**. Warnings are
  treated as bugs.
* Progression between lessons is handled by `vir tutor` (out of scope
  for these guidelines). Lessons themselves need no runner glue.

## READMEs

The README is the **introduction to a puzzle**, not a lecture.

* Structure: **title + one-line pitch**, then a short framing of the
  task (what is broken or what to build, and which files matter),
  then the verification loop, then an optional "Stuck?" hint at the
  very bottom.
* **Do not teach in the README.** Teaching happens in the code's
  comments. The README sets the scene; the code is the textbook.
* **Never quote or excerpt code in the README.** The source is right
  there in `src/`; duplicating it invites drift.
* Keep it minimal — a reader should finish the README in under a
  minute and immediately open the source.
* Hints ("Stuck?" section) are optional, included only when they make
  sense, and always at the very bottom.

## Comments are the textbook

The broken source carries the teaching load:

* A short header comment (2–4 lines) stating what the module does.
* 1–3 line notes *next to the thing they explain* — above the `reg`,
  above the slice, above the `match` arm that matters. Explain the
  concept at the place the learner will trip over it.
* Budget: roughly 15–25 comment lines per file. **No lectures.** Only
  as much as necessary.
* Lessons must stand alone: do not refer to other lessons ("as you
  saw in lesson 007..."). Briefly re-explain, or write the comment so
  it doesn't need the earlier lesson.
* No external links anywhere (README or comments). Everything is
  perfectly self-contained.
* Follow the language's doc-comment conventions (`//>` on
  declarations, `//!` at line 1 for package docs) where appropriate —
  and plain `//` for lesson-teaching notes.

## Breaks

Every lesson repairs something broken. Four kinds of breakage, mixed
freely so the learner never knows what's coming:

1. **Compile errors** — wrong slice, missing `dependson`, `:=` vs
   `<=`, `{` vs `=>`, non-exhaustive `match`, ...
2. **Behavior bugs** — compiles clean, `make test` fails. Missing
   reset, off-by-one slice, wrong hold logic, ...
3. **Fill-in-the-blank** — a marked `// TODO` where a driver or arm
   is missing.
4. **Write-from-spec** — README gives a spec, source has a stub.
   (For these, the README may be slightly longer, since the spec is
   the puzzle.)

**The master rule: everything orients toward learning Virdant.**
A break must teach the lesson's concept — never proofreading, never
guess-the-typo, never harness trivia.

Quality bar for a good break:

* **Single cause.** Exactly one conceptual thing is wrong. Fixing it
  must not reveal a second error.
* **The fix teaches the concept.** In a slicing lesson, the slice is
  wrong — not some incidental typo elsewhere.
* **Minimal diff.** Broken and solution differ only in the lines that
  matter. No reformatting, no unrelated renames.
* **Diagnosable.** The error or failing assert points the learner
  toward the concept. Some ambiguity is acceptable in later lessons,
  but difficulty must come from *depth* (sub-module bugs, bugs only
  visible in the waveform), never from obscurity.
* **Marked vs unmarked.** Early lessons mark the break
  (`// BUG: this line is wrong`); later lessons leave it unmarked and
  let the README say only "this doesn't pass yet — find out why."
  Trend from marked to unmarked as the tutorial advances.

## Solutions

Each lesson ships a known-good reference in `solution/`:

* `solution/` is a complete runnable project (same layout as the
  lesson: `src/`, `test.poke`, `Makefile`, `virdant.toml`) so that
  `cd solution && make test` and `vir check` both work in place.
* **Authoring rule: write the solution first.** Get it green
  (`vir check` clean, `make test` passing, zero warnings), *then*
  introduce the break, then verify the break actually fails.
* Solution and broken code must differ only in the lines that matter.
* `solution/README.md` explains simply what the issue was and how it was fixed in this directory.

## Tests

`test.poke` is both the grader and the debugging canvas.

* The test must exercise the design hard enough that a wrong
  implementation fails, and the resulting `trace.vcd` must tell a
  story a learner can debug in a waveform viewer. **Meaty stimulus,
  meaningful asserts** — enough to flush out most plausible errors,
  not just two happy-path pokes.
* Cover interesting values, edge cases, and boundaries; include
  several `poke`/`advance`/`tick` phases so the VCD has texture.
* Tests are read-only scaffolding for the learner. Never require the
  learner to edit them; never make harness features a hidden
  prerequisite.
* Cap simulation work with tight cycle limits (see `AGENTS.md`).
* If a lesson introduces new poke-script techniques, the code
  comments may note them — but the test itself is never the lesson's
  teaching topic (unless the lesson is deliberately about `vir poke`).

## Code style

Solutions and lesson code follow the Virdant coding conventions in
full (see `../agents/skills/virdant/coding-conventions.md` and
`idioms.md`); highlights:

* 4-space indent, spaces only, no trailing whitespace, <100 columns.
  Formatting is compiler-enforced.
* Descriptive, unabbreviated names. Modules/types/sockets camelCase
  (`SpiController`, not `SPIController`); everything else snake_case.
* Prefer driver blocks with `it`; prefer direct chaining (no
  unnecessary `=>` before nested `if`/`match`); cull redundant
  `else { it <= it }` arms.
* Slices are exclusive on top: `x[8..4]` is bits 7..4. Never slip on
  this — a lesson about slicing must be immaculate.
* Canonical module slot ordering: ports and sockets, submodules,
  `reg`s, `wire`s/`net`s, then stray drivers.
* `initial it <= ...` for power-on values when the value matters.

## Tone and voice

Warm and summery — this is *Virdant*, after all: think dappled
sunlight through green leaves, unhurried afternoons, a friend walking
you through their garden.

* Second person, present tense, encouraging.
* Light garden/summer metaphors welcome but never forced.
* A playful sign-off flourish every few lessons — rationed, not
  formulaic.
* Never condescending, never cutesy-for-its-own-sake. The warmth is
  in the welcome, not the exclamation marks.

## Workflow

Lessons are developed in **batches of 3–4**:

1. Propose a short list of candidate topics with one-line pitches.
2. The maintainer picks 3–4.
3. Write the batch; the maintainer reviews it as a whole.
4. Update the topic tracker below.

The curriculum is **organic** — no fixed syllabus. Let each batch
pick the natural next concepts. Keep the tracker below current so
uncovered topics stay visible.

### Definition of done (per lesson)

- [ ] Broken `src/` fails as intended (`vir check` error or
      `make test` failure) — verified.
- [ ] `solution/` passes `vir check` warning-free and `make test`.
- [ ] Broken and solution differ only in the lines that matter.
- [ ] Break teaches the lesson's concept (single cause, no gotchas).
- [ ] Comments teach in code, compactly, with no lesson cross-references.
- [ ] README is minimal, warm, quotes no code, ends with an optional
      "Stuck?" hint.
- [ ] `test.poke` is meaty: catches plausible bugs and produces a
      debuggable `trace.vcd`.
- [ ] Code follows the Virdant skill's conventions throughout.

## Topic tracker (living section)

Update this after each batch. No planned ordering — this is a
checklist of coverage, not a schedule.

### Covered

* Modules, ports (`incoming`/`outgoing`), drivers, `:=` (lesson 000)
* `reg`, clock inference, `initial` (lessons 001, 003)
* `dependson` (lesson 000 et al.)
* Mod-N/loadable counters, priority `when` arms (lesson 004)
* Two-flop synchronizers, metastability (lesson 005)
* Enum-state FSMs, Euclid's GCD, start/done handshakes (lesson 006)
* Shift-and-add multiplier, `zext`, shift-by-slices idiom (lesson 007)
* Barrel shifter, `word()` + exclusive-top slices (lesson 008)
* Sockets, `:=:` connect, simplified Wishbone handshake (lesson 009)
* UART transmitter framing, LSB-first shift-out (lesson 010)
* LFSRs, taps-as-polynomial, maximal sequences (lesson 011)
* Platforms, `for` port matching, `default` ports, `vir run` on `virt::Virt` (lesson 012)
* `let` bindings, binding lists (lesson 013)
* Muxes, `when`/`match` in expression position (lesson 014)
* `match` deep dive: guards, arm order, exhaustiveness (lesson 015)
* Stacked `when` arms, first-match-wins priority (lesson 016)
* Game of Life: whole-generation simultaneous update on `Word[N]` (lesson 017)
* Traffic-light FSM with a timer reg, safety invariants (lesson 018)
* Seven-segment decoder as a match lookup table (lesson 019)
* USB NRZI encoding + bit stuffing (lesson 020)

### Wanted

*(nothing listed yet — add candidates here as they come up)*

### Capstone

* Lessons ~90–99: a fully working 5-stage RISC-V core, built up in
  stages. Everything before it should feed this.
