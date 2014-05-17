
[1mFrom:[0m /home/sean/mav1/app/models/week.rb @ line 38 Week#insufficient_days:

    [1;34m36[0m: [32mdef[0m [1;34minsufficient_days[0m
    [1;34m37[0m:   week = [1;36mself[0m.profile
 => [1;34m38[0m:   binding.pry
    [1;34m39[0m:   emp = current_user.employees.all.length
    [1;34m40[0m:   week.inject([]) [32mdo[0m |failed, day|
    [1;34m41[0m:     [32mif[0m day.last.max > emp
    [1;34m42[0m:       failed << day.first
    [1;34m43[0m:     [32mend[0m
    [1;34m44[0m:     failed
    [1;34m45[0m:   [32mend[0m
    [1;34m46[0m: [32mend[0m

