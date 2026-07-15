# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Custom output formatters for [Timetrap](https://github.com/samg/timetrap), a command-line time tracker invoked as `t`. Each `.rb` file is a plugin that renders time entries in a different way (single-line grep-friendly rows, sums grouped by event/week/year, with ASCII progress bars). This folder is a leaf inside a larger Jekyll site repo but is self-contained — treat only these files as the project.

## Running / using a formatter

Formatters are not built or tested with a toolchain — they are loaded at runtime by Timetrap. For Timetrap to find them, this folder must be listed under `formatter_search_paths` in `~/.timetrap.yml`. `formatters.lnk` is a Windows shortcut used to wire this folder into that path.

Invoke via the display command with `-f <formatter>` (the name is the filename without `.rb`):

```
t display -f oneline            # or the short form: t d -f oneline
t d -f sum_events
t d other -f sum_weeks          # "other" is a Timetrap timesheet name
t d -f sum_years
```

Formatters compose with normal shell tools, e.g.:

```
t d -f oneline | grep -i RR_pimper | cut -f 1 | xargs -I "{}" t e -i{} "Code # RR_pimper"
```

## Formatter contract

Every file defines one class following Timetrap's plugin convention. To add a formatter, mirror an existing file:

- Filename `sum_weeks.rb` → class `Timetrap::Formatters::SumWeeks` (snake_case file → CamelCase class). Timetrap resolves the `-f` name to this class, so the mapping must hold exactly.
- The class lives under `module Timetrap; module Formatters`, exposes `attr_accessor :output`, and `include Timetrap::Helpers`.
- All work happens in `initialize(entries)`: build a string and assign it to `self.output`. Timetrap prints `self.output` verbatim — return nothing.
- `format_duration(seconds)` comes from `Timetrap::Helpers` and turns a duration into `H:MM:SS`.

### Entry objects

Each element of `entries` provides: `id`, `start` / `end` (Ruby `Time`; `end` may be nil for a running entry — guard with `next unless e.end` or `rescue`), `duration` (seconds, integer), `note` (string, may contain newlines), and `sheet` (timesheet name).

### Note parsing conventions (shared across formatters)

- `#` starts an inline comment stripped with `note.sub(/#.*$/, "")`.
- `@word` is a tag. Filter with `note.include?("@event")`; strip all tags with `gsub(/@\S+/, "")`.

### Progress-bar convention (`sum_weeks.rb`, `sum_years.rb`)

Both use per-file constants — `TARGET_*` (goal), `BAR_WIDTH`, and `CHAR_NORMAL="█"` / `CHAR_OVER="▉"` / `CHAR_EMPTY="-"`. The bar fills with `CHAR_NORMAL` up to 100% of target, pads remaining width with `CHAR_EMPTY`, and appends `CHAR_OVER` units when over target (so bars can exceed 100%, shown by the character switch `████▉▉▉▉`). These targets are Dorian's personal goals (e.g. `TARGET_HOURS = 28.8` h/week) — adjust the constants to retune, no other logic changes needed.

## Files

- `oneline.rb` — one tab-separated line per entry (id, start, end, duration, note); designed for `grep`/`cut` pipelines.
- `sum_events.rb` — durations summed per note within each timesheet.
- `sum_weeks.rb` — hours per ISO-ish week (`%Y-%W`) vs a weekly target, with progress bar.
- `sum_years.rb` — hours per year plus day-counts for the `@event` and `@ka` tags, each vs its own target. Day counts span `start`→`end` dates (inclusive), not entry lines.
