class Shift < ActiveRecord::Base
    belongs_to :commentable, :polymorphic => true
    before_save :calculate_minutes

    def hours
       self.minutes/60
    end

    def format_shift
      shift_string = ""
      shift_string << self.start.strftime("%A %B %e: %l:%m %p")
      shift_string << " - "
      shift_string << self.finish.strftime("%l:%m %p")
      shift_string
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
