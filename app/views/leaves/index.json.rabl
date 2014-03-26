collection @leaves
attributes :start

node do |leave| 
  {:title => Employee.first.format_name }
end
node(:end) {|leave| leave.finish || leave.start}
