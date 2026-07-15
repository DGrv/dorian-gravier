# text formatter for sum of spent time grouped by DAY with a stacked progress bar.
#
# What it calculates:
#   - Each entry is split across every calendar day it covers (key "YYYY-MM-DD"): an entry
#     from 2026-06-04 09:00 to 2026-06-06 17:00 adds hours to 2026-06-04 (09:00->midnight),
#     the full day 2026-06-05, and 2026-06-06 (midnight->17:00).
#   - For each day it SUMS those per-day hours (seconds / 3600), and separately sums the
#     hours from entries tagged "@event".
#   - % = day hours / TARGET_HOURS * 100, i.e. progress toward the daily hours goal.
#   - The bar is STACKED: within the 0-100% part it first draws the @event hours with
#     CHAR_EVENT, then the remaining (non-@event) hours with CHAR_NORMAL, then pads the
#     rest with CHAR_EMPTY. If the day goes OVER target it appends CHAR_OVER blocks, so
#     the bar can exceed 100% and you spot it by the character change.
#   - Days are listed chronologically. Running entries (no end) are skipped.
#
# Adjust the constants below to retune (target and bar look).
#
# $ t d other -f sum_days
#
# TARGET_HOURS = 8    # daily hours goal (the 100% mark)
# BAR_WIDTH = 25      # width of the progress bar at 100%
# CHAR_EVENT  = "▓"   # @event hours (drawn first)
# CHAR_NORMAL = "█"   # other (non-@event) hours
# CHAR_OVER   = "▉"   # extra blocks when over 100%
# CHAR_EMPTY  = "-"   # unfilled remainder
#
#   Day           Hours     %     Progress (▓=@event █=other ▉=over)
#   2025-07-01     8.50    106%   ▓▓▓▓▓▓▓▓▓▓▓▓█████████████▉▉
#   2025-07-02     3.00     38%   █████████----------------
#   2025-07-03     6.00     75%   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓------
#
#
# Dorian Gravier
# https://dgrv.github.io/dorian-gravier/




module Timetrap
  module Formatters
    class SumDays
      attr_accessor :output
      include Timetrap::Helpers

      TARGET_HOURS = 8
      BAR_WIDTH = 25
      CHAR_EVENT  = "▓"
      CHAR_NORMAL = "█"
      CHAR_OVER   = "▉"
      CHAR_EMPTY  = "-"

      # Split an entry into per-day seconds. An entry spanning several days
      # contributes to each calendar day it covers: from its start to the next
      # midnight on the first day, whole days in between, and midnight to its end
      # on the last day. Returns { "YYYY-MM-DD" => seconds }.
      def split_by_day(start_t, end_t)
        segments = {}
        cursor = start_t
        while cursor < end_t
          nd = cursor.to_date + 1
          next_midnight = Time.new(nd.year, nd.month, nd.day)
          seg_end = [next_midnight, end_t].min
          segments[cursor.strftime("%Y-%m-%d")] = seg_end - cursor
          cursor = seg_end
        end
        segments
      end

      def initialize(entries)
        self.output = ""

        days       = Hash.new(0)   # day => total seconds
        days_event = Hash.new(0)   # day => seconds on @event entries

        # Sum daily durations, splitting multi-day entries across each day they cover
        entries.each do |e|
          next unless e.end
          note     = (e.note || "").sub(/#.*$/, "").strip
          is_event = note.include?("@event")
          split_by_day(e.start, e.end).each do |day, secs|
            days[day] += secs
            days_event[day] += secs if is_event
          end
        end

        self.output << "   Day           Hours     %     Progress (#{CHAR_EVENT}=@event #{CHAR_NORMAL}=other #{CHAR_OVER}=over)\n"

        days.keys.sort.each do |d|
          # Derive from raw seconds so other >= 0 always (event is a subset of total).
          hours       = (days[d] / 3600.0).round(2)
          event_hours = days_event[d] / 3600.0
          other_hours = (days[d] - days_event[d]) / 3600.0

          pct = (hours / TARGET_HOURS * 100).round

          # Stacked bar within the 0-100% part: @event blocks first, then other blocks.
          event_blocks = [(event_hours / TARGET_HOURS * BAR_WIDTH).floor, BAR_WIDTH].min
          other_blocks = [[(other_hours / TARGET_HOURS * BAR_WIDTH).floor, BAR_WIDTH - event_blocks].min, 0].max
          empty        = [BAR_WIDTH - event_blocks - other_blocks, 0].max

          # If over 100%, extend with CHAR_OVER
          over_units = hours > TARGET_HOURS ? ((hours - TARGET_HOURS) / TARGET_HOURS * BAR_WIDTH).round : 0

          bar =
            CHAR_EVENT  * event_blocks +
            CHAR_NORMAL * other_blocks +
            CHAR_EMPTY  * empty +
            CHAR_OVER   * over_units

          self.output << "%10s     %5.2f     %3d%%   %s\n" %
            [d, hours, pct, bar]
        end
      end
    end
  end
end
