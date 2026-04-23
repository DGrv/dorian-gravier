# text formatter for sum of spent time grouped by events.

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
