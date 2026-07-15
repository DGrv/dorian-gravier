# text formatter for sum of spent time grouped by events.
#
# What it calculates:
#   - Entries are first split by timesheet (sheet), one block per timesheet.
#   - Within a timesheet, entries are grouped by "event name": the note with any
#     "#..." comment removed and all "@tags" stripped out (e.g. "Example1 @event @ka #foo"
#     -> "Example1"). Entries that share the same cleaned name are one group.
#   - For each group it SUMS the durations (total time spent), shown as H:MM:SS.
#   - Groups are listed alphabetically by name; there are no targets or percentages here,
#     this is just "how much time went into each event".
#
# $ t d -f sum_events
#
# Timesheet: work
#    Duration   Notes
#     8:30:00    Example1
#    12:15:00    Example2
#
# Dorian Gravier
# https://dgrv.github.io/dorian-gravier/

module Timetrap
  module Formatters
    class SumEvents
      attr_accessor :output
      include Timetrap::Helpers

      def initialize(entries)
        self.output = ''
        sheets = entries.inject({}) do |h, e|
          h[e.sheet] ||= []
          h[e.sheet] << e
          h
        end

        sheets.keys.sort.each do |sheet|
          self.output <<  "\nTimesheet: #{sheet}\n"
          self.output << "   Duration   Notes\n"

          durations = {}
          sheets[sheet].each do |e|
            note = (e.note || "").sub(/#.*$/, "").gsub(/@\S+/, "").strip
            durations[note] ||= 0
            durations[note]  += e.duration
          end

          durations.keys.sort.each do |d|
            self.output <<  "%10s    %s\n" % [
              format_duration(durations[d]),
              d
            ]
          end
        end
      end
    end
  end
end
