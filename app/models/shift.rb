class Shift < ActiveRecord::Base
    belongs_to :shiftable, :polymorphic => true
    belongs_to :user
    belongs_to :schedule
    before_save :calculate_minutes, :default_values

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

    def shift_check
    end

    def find_business
      User.current_user.businesses.where(Date: self.start).first
    end

    def default_values
      self.ignore ||= false
      self.resolved ||= false
      nil
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
