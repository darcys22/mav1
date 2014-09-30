class SchedulePdf < Prawn::Document
  def initialize(schedule)
    @schedule = schedule
    @week = @schedule.get_dates
    @weekrange = @schedule.getrange
    @employees = @schedule.getemployees
    super(:page_layout => :landscape, :margin => [9], :page_size => 'A4')
    heading
    tablezz
  end

  def heading
    text "Schedule: #{@weekrange}", size: 30, style: :bold
  end

  def tablezz
    move_down 20
    line_item_rows
  end

  def line_item_rows
    headers = ["Employee"]
    (@week.first..@week.last).each do |day|
      headers << day.strftime("%A, %b %d")
    end
    table_data = []
    table_data << headers
    @employees.each do |employee|
      x = []
      x << employee.format_name
      @schedule.emp_shifts(employee).each do |shift|
        x << shift[1]
      end
      table_data << x
    end

    table(table_data, :header => true) do
      row(0).style(:background_color => 'dddddd', :size => 9, :align => :center, :font_style => :bold)
      column(0).style(:background_color => 'dddddd', :size => 9, :padding_top => 5, :font_style => :bold)
      row(1..-1).column(1..9).style(:size => 8, :padding => 5)
      cells[0,0].background_color = 'ffffff'
      row(0).height = 22
      row(1..-1).height = 22
      column(0).width = 70
      column(1..9).width = 100
    end
  end


end
