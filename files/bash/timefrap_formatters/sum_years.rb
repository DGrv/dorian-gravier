# text formatter for sum of time per year, with @event / @ka day totals,
# progress bars vs yearly targets, and a per-@ka-event breakdown (days per event name).
# Days are counted per entry from its DURATION (not calendar span, not line count):
#   more than 4h -> 1 day,  4h or less -> 0.5 day  (capped at 1 day even above 8h).
# For this example I have 2 tags @event and @ka
#
# Targets = the goals that the % columns and progress bars are measured against.
# Adjust these constants to retune; they are also printed in the output header.
# TARGET_HOURS = 28.8 * 52   # yearly hours goal: 28.8 h/week * 52 weeks
# TARGET_EVENT_DAYS = 55     # yearly goal of @event days
# TARGET_KA_DAYS    = 25     # yearly goal of @ka days
# BAR_WIDTH = 15
# CHAR_NORMAL = "█"
# CHAR_OVER   = "▉"
# CHAR_EMPTY  = "-"
# has_event = note.include?("@event")
# has_ka    = note.include?("@ka")
#
# $ t d -f sum_years
# Explanation:
#   - Days per entry come from its duration: more than 4h = 1 day, else 0.5 day (max 1, even above 8h).
#   - Targets (goals the % and progress bars are measured against):
#       TARGET_HOURS      = 1497.6 h   (28.8 h/week * 52 weeks)
#       TARGET_EVENT_DAYS = 55 days   (@event)
#       TARGET_KA_DAYS    = 25 days   (@ka)
#
#   Year      Hours   %H     Progress Hours                       DaysEv   %D    Progress Days                   DaysKA   %K     Progress KA
#    2024      62.01    4%    4% ---------------                       0%    0% ---------------                       0%    0% ---------------
#    2025    1647.82  110%  110% ███████████████▉▉               64  116%  116% ███████████████▉▉             39.5  156%  156% ███████████████▉▉▉▉▉▉▉▉
#
#   Details (days per event):
#     2025
#         DaysKA  DaysEvOnly    Event
#             12        30.5    event1
#           27.5                event2
#                         15    event3
#
#
# Dorian Gravier
# https://dgrv.github.io/dorian-gravier/



module Timetrap
  module Formatters
    class SumYears
      attr_accessor :output
      include Timetrap::Helpers

      TARGET_HOURS = 28.8 * 52
      TARGET_EVENT_DAYS = 55
      TARGET_KA_DAYS    = 25

      BAR_WIDTH = 15

      CHAR_NORMAL = "█"
      CHAR_OVER   = "▉"
      CHAR_EMPTY  = "-"

      # Fractional day from an entry's duration (seconds):
      #   more than 4h -> 1.0 day, otherwise -> 0.5 day (never more than 1).
      def fractional_day(seconds)
        (seconds / 3600.0) > 4 ? 1.0 : 0.5
      end

      # Display a day count: blank for zero, integer when whole (no ".0"),
      # otherwise the fractional value (e.g. 12, 12.5, "").
      def fmt_days(x)
        return "" if x.zero?
        x == x.to_i ? x.to_i.to_s : x.to_s
      end

      def initialize(entries)
        self.output = ""

        years_hours = Hash.new(0)
        years_event_days = Hash.new(0)
        years_ka_days    = Hash.new(0)

        # year => { event_name => days }
        years_ka_detail        = Hash.new { |h, k| h[k] = Hash.new(0) }  # entries with @ka
        years_event_only_detail = Hash.new { |h, k| h[k] = Hash.new(0) } # entries with @event but NOT @ka

        entries.each do |e|
          next unless e.end
          note = (e.note || "").sub(/#.*$/, "").strip

          has_event = note.include?("@event")
          has_ka    = note.include?("@ka")

          # Sum hours per start year
          start_year = e.start.year
          years_hours[start_year] += e.duration

          # Fractional day from this entry's duration (see fractional_day)
          days_count = fractional_day(e.duration)
          years_event_days[start_year] += days_count if has_event
          years_ka_days[start_year]    += days_count if has_ka

          # Per-event day breakdown: strip all tags to get the event name
          if has_ka || has_event
            name = note.gsub(/@\S+/, "").strip
            name = "(no name)" if name.empty?
            if has_ka
              years_ka_detail[start_year][name] += days_count
            elsif has_event
              years_event_only_detail[start_year][name] += days_count
            end
          end
        end

       self.output << "Explanation:\n"
       self.output << "  - Days per entry come from its duration: more than 4h = 1 day, else 0.5 day (max 1, even above 8h).\n"
       self.output << "  - Targets (goals the %% and progress bars are measured against):\n"
       self.output << "      TARGET_HOURS      = %.1f h   (28.8 h/week * 52 weeks)\n" % TARGET_HOURS
       self.output << "      TARGET_EVENT_DAYS = %d days   (@event)\n" % TARGET_EVENT_DAYS
       self.output << "      TARGET_KA_DAYS    = %d days   (@ka)\n\n" % TARGET_KA_DAYS


        # Header
        self.output << "  Year      Hours   %H     Progress Hours                       DaysEv   %D    Progress Days                   DaysKA   %K     Progress KA\n"

        years = (years_hours.keys + years_event_days.keys + years_ka_days.keys).uniq.sort
        years.each do |year|
          hours = (years_hours[year] / 3600.0).round(2)
          pct_hours = (hours / TARGET_HOURS * 100).round

          # Hours bar
          filled_h = [(hours / TARGET_HOURS * BAR_WIDTH).floor, BAR_WIDTH].min
          empty_h  = [BAR_WIDTH - filled_h, 0].max
          over_h   = hours > TARGET_HOURS ? ((hours - TARGET_HOURS) / TARGET_HOURS * BAR_WIDTH).round : 0
          bar_hours = CHAR_NORMAL * filled_h + CHAR_EMPTY * empty_h + CHAR_OVER * over_h

          # Event bar
          event_days = years_event_days[year]
          pct_event = (event_days / TARGET_EVENT_DAYS.to_f * 100).round
          filled_e = [(event_days / TARGET_EVENT_DAYS.to_f * BAR_WIDTH).floor, BAR_WIDTH].min
          empty_e  = [BAR_WIDTH - filled_e, 0].max
          over_e   = event_days > TARGET_EVENT_DAYS ? ((event_days - TARGET_EVENT_DAYS) / TARGET_EVENT_DAYS.to_f * BAR_WIDTH).round : 0
          bar_event = CHAR_NORMAL * filled_e + CHAR_EMPTY * empty_e + CHAR_OVER * over_e

          # KA bar
          ka_days = years_ka_days[year]
          pct_ka = (ka_days / TARGET_KA_DAYS.to_f * 100).round
          filled_k = [(ka_days / TARGET_KA_DAYS.to_f * BAR_WIDTH).floor, BAR_WIDTH].min
          empty_k  = [BAR_WIDTH - filled_k, 0].max
          over_k   = ka_days > TARGET_KA_DAYS ? ((ka_days - TARGET_KA_DAYS) / TARGET_KA_DAYS.to_f * BAR_WIDTH).round : 0
          bar_ka = CHAR_NORMAL * filled_k + CHAR_EMPTY * empty_k + CHAR_OVER * over_k

          self.output << "%7s   %8.2f  %3d%%  %3d%% %-27s  %6s  %3d%%  %3d%% %-27s  %6s  %3d%%  %3d%% %s\n" %
            [year, hours, pct_hours, pct_hours, bar_hours,
             fmt_days(event_days), pct_event, pct_event, bar_event,
             fmt_days(ka_days), pct_ka, pct_ka, bar_ka]
        end

        # Details: days per event name, grouped by year.
        # Column 1 = days on @ka entries, column 2 = days on @event entries without @ka.
        self.output << "\n  Details (days per event):\n"
        detail_years = (years_ka_detail.keys + years_event_only_detail.keys).uniq.sort
        detail_years.each do |year|
          self.output << "    %s\n" % year
          self.output << "      %8s  %10s    %s\n" % ["DaysKA", "DaysEvOnly", "Event"]
          ka      = years_ka_detail[year]
          ev_only = years_event_only_detail[year]
          names = (ka.keys + ev_only.keys).uniq.sort
          names.each do |name|
            self.output << "      %8s  %10s    %s\n" % [fmt_days(ka[name]), fmt_days(ev_only[name]), name]
          end
        end
      end
    end
  end
end
