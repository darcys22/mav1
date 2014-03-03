class Week < ActiveRecord::Base
    has_many :businesses

    def self.day_names
        days = self.businesses.all
        days.map |d| do
            d.date.strftime("%A")
        end
    end

    def self.dates
        days = self.businesses.all
        days.map |d| do
            d.date.strftime("%f")
        end
    end

    def self.demand
        #Make and array of each day
        ## Go through every shift for that day and make a string that is kinda like HH:MM - HH:MM
    end
end
