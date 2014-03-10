class SchedulePdf < Prawn::Document
  def initialize(weekrange, week)
    @weekrange, @week = weekrange, week
    super(:page_layout => :landscape)
    heading
  end

  def heading
    text "Schedule: #{@weekrange}", size: 30, style: :bold
  end

  def table
  end

  def employee
  end

end
