class Leave < ActiveRecord::Base
  belongs_to :employee
  scope :between, lambda {|start_time, end_time|
    where(start: Leave.format_date(start_time)..Leave.format_date(end_time))
  }

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
