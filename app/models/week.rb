class Week < ActiveRecord::Base
    has_many :businesses

    def day_names
        days = self.businesses.all
        days.map { |d| d.date.strftime("%A")}
    end

    def dates
        days = self.businesses.all
        days.map { |d| d.date.strftime("%f")}
    end

    def demand
        days = self.businesses.all
        days.inject([]) do |ary, element| 
            ary << element.shifts.all.map do |s|
                "#{s.start.strftime("%H%M")} - #{s.finish.strftime("%H%M")}"
            end
        end
    end

    def self.import(file)
        shifts = ::MotionlessAgitator::Something.new
        shifts.read(file)
        shifts.save
    end
    
end
