json.array!(@employees) do |employee|
  json.extract! employee, :id, :firstname, :lastname, :email, :monstart, :monfinish, :tuestart, :tuefinish, :wedstart, :wedfinish, :thurstart, :thurfinish, :fristart, :frifinish, :satstart, :satfinish, :sunstart, :sunfinish
  json.url employee_url(employee, format: :json)
end
