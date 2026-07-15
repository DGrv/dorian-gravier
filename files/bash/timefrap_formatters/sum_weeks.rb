# text formatter for sum of spent time grouped by week with progress bar.
#
# What it calculates:
#   - Every entry is bucketed into a week using its START date, keyed "YEAR-WEEK"
#     where WEEK is strftime("%W"): week-of-year with weeks starting on Monday (00-53).
#   - For each week it SUMS all entry durations and converts to hours (seconds / 3600).
#   - % = week hours / TARGET_HOURS * 100, i.e. progress toward the weekly hours goal.
#   - The progress bar fills one block per BAR_WIDTH-th of the target up to 100% (CHAR_NORMAL),
#     pads the rest with CHAR_EMPTY, and if the week goes OVER target adds CHAR_OVER blocks.
#     So the bar can exceed 100% and you spot it by the character change: ████▉▉▉▉
#   - Weeks are listed in chronological order. Running entries (no end) are skipped.
#
# Adjust the constants below to retune (target and bar look).
#
# $ t d other -f sum_weeks
#
# TARGET_HOURS = 28.8   # weekly hours goal (the 100% mark)
# BAR_WIDTH = 25        # width of the progress bar at 100%
# CHAR_NORMAL = "█"     # filled, up to 100%
# CHAR_OVER   = "▉"     # extra blocks when over 100%
# CHAR_EMPTY  = "-"     # unfilled remainder
#
# Week       Hours     %        Progress
# 2024-53     62.01     215%   █████████████████████████▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉
# 2025-01      5.65      20%   ████---------------------
# 2025-02     35.57     124%   █████████████████████████▉▉▉▉▉▉
# 2025-03     34.83     121%   █████████████████████████▉▉▉▉▉
# 2025-04     22.83      79%   ███████████████████------
# 2025-05     21.62      75%   ██████████████████-------
#
#
# Dorian Gravier
# https://dgrv.github.io/dorian-gravier/




module Timetrap
  module Formatters
    class SumWeeks
      attr_accessor :output
      include Timetrap::Helpers

      TARGET_HOURS = 28.8
      BAR_WIDTH = 25
      CHAR_NORMAL = "█"
      CHAR_OVER   = "▉"
      CHAR_EMPTY  = "-"

      def initialize(entries)
        self.output = ""

        weeks = Hash.new(0)

        # Sum weekly durations (bucket by the entry's start week)
        entries.each do |e|
          next unless e.end
          week = e.start.strftime("%Y-%W")
          weeks[week] += e.duration
        end

        self.output << "   Week       Hours     %        Progress\n"

        weeks.keys.sort.each do |w|
          hours = (weeks[w] / 3600.0).round(2)

          pct = (hours / TARGET_HOURS * 100).round

          # For up to 100%
          filled_normal = [(hours / TARGET_HOURS * BAR_WIDTH).floor, BAR_WIDTH].min
          empty = [BAR_WIDTH - filled_normal, 0].max

          # If over 100%, extend with CHAR_OVER
          if hours > TARGET_HOURS
            over_units = ((hours - TARGET_HOURS) / TARGET_HOURS * BAR_WIDTH).round
          else
            over_units = 0
          end

          bar =
            CHAR_NORMAL * filled_normal +
            CHAR_EMPTY  * empty +
            CHAR_OVER   * over_units

          self.output << "%10s     %5.2f     %3d%%   %s\n" %
            [w, hours, pct, bar]
        end
      end
    end
  end
end
