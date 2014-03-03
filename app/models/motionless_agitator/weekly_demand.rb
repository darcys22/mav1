module MotionlessAgitator
    class WeeklyDemand
        require 'csv'
        require 'chronic'

        attr_accessor :shifts

        def initialize(csv_name = nil)
            csv_name ||= "shifts.csv"
            @shifts = []
            read(csv_name)
        end

        def read(csv_name)
            csv = CSV.foreach(csv_name, :headers => true) do |csv_obj|
                @shifts << Day.new.tap do |shift|
                    date = Chronic.parse(csv_obj['date'])
                    shift.start = Chronic.parse(csv_obj['begin'], now: date)
                    shift.finish = Chronic.parse(csv_obj['end'], now: date)
                end
            end
        end
        
        def week_begins
            @shifts.map(&:start).min
        end

        def shifts_by_day(date)
            date = Chronic.parse(date, now: week_begins) unless date.kind_of? Time 
            @shifts.select {|shift| shift.date == date.to_date}
        end

        alias_method :shifts_by_date, :shifts_by_day

        def day_hours(date)
            shifts_by_day(date).inject(0) {|sum,x| sum + x.hours}
        end

        alias_method :date_hours, :day_hours

        def week_hours
            @shifts.inject(0) {|sum,x| sum + x.hours}
        end

        def sort_by_busiest
            daily_hours = Hash[days_by_hours.sort_by {|day, hours| hours}]
            daily_hours.keys.reverse
        end

        private

            def days_by_hours
                days = Hash.new
                7.times do |x|
                    days[week_begins.to_date + x] = date_hours(week_begins.to_date + x)
                end
                days
            end
    end
end

