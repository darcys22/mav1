class Shift < ActiveRecord::Base
    belongs_to :business
    after_save :calculate_minutes

    def hours
        self.hours = self.minutes/60
    end

    private

        def calculate_minutes
            unless self.start.nil? || self.finish.nil?
                self.minutes = (self.finish - self.start)/60
            else
                self.minutes = 0
            end
        end

end
