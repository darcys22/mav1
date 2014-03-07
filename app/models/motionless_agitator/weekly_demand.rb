module MotionlessAgitator
    class WeeklyDemand
        require 'csv'
        require 'chronic'

        attr_accessor :shifts

        def initialize
            @week = Week.create
        end

        def read(csvfile)
            csv = CSV.foreach(csvfile.path, :headers => true) do |csv_obj|
                date = Chronic.parse(csv_obj['date'])
                @week.start = date if @week.start.blank? || date < @week.start
                day = @week.businesses.where(date: date).first_or_create
                shift = day.shifts.new
                binding.pry
                shift.start = Chronic.parse(csv_obj['begin'], now: date)
                shift.finish = Chronic.parse(csv_obj['end'], now: date)
                shift.save
            end
            @week.save
        end
        
        def week_begins
            @week.start
        end

        def shifts_by_day(date)
            date = Chronic.parse(date, now: week_begins) unless date.kind_of? Time 
            day = @week.businesses.where(date: date).first.shifts.where(true)
        end

        alias_method :shifts_by_date, :shifts_by_day

        def day_hours(date)
            shifts_by_day(date).inject(0) {|sum,x| sum + x.hours}
        end

        alias_method :date_hours, :day_hours

        def week_hours
            @week.shifts.where(true).inject(0) {|sum,x| sum + x.hours}
        end

        def sort_by_busiest
            daily_hours = Hash[days_by_hours.sort_by {|day, hours| hours}]
            daily_hours.keys.reverse
        end

        private

            def days_by_hours
                days = Hash.new
                @week.businesses.where(true) do |x|
                    days[x.date] = date_hours(x.date)
                end
                days
            end
    end
end
