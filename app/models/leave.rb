class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :user
  scope :between, lambda {|start_time, end_time|
    where(start: Leave.format_date(start_time)..Leave.format_date(end_time))
  }

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

     [:start, :finish].each do |attr|
     define_method("#{attr}_human") do
       (send(attr) || Time.zone.now.to_date).strftime("%e %b %Y %l:%M %p")
     end

     define_method("#{attr}_human=") do |date_string|
       self.send "#{attr}=", Chronic.parse(date_string).in_time_zone(Time.zone)
     end
   end
end
