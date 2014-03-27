collection @leaves
attributes :start, :id

node do |leave| 
  {:title => Employee.find_by_id(leave.employee_id).format_name}
end
node(:end) {|leave| leave.finish || leave.start}
