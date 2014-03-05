module MotionlessAgitator

    class Observer
        class << self

            attr_reader :no_avail, :short_days

            @@no_avail = []
            @@short_days = {}

            def no_availability_for_shift(shift)
                @@no_avail << shift
            end

            def limited_availability_for_day(day, shifts)
                @@short_days[day] = shifts
            end

            def list_no_avail_shifts
                @@no_avail.each { |shift| puts shift.start }
            end

            def list_limited_days
                @@short_days.each do |day|
                    puts day[0].start.to_date
                    puts day.length
                    puts day.employees_avail.count
                end
            end
        end
    end
end
