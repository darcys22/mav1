class Profiler
  @consecutiveweekdays = {:Monday => :Tuesday, :Tuesday => :Wednesday, :Wednesday => :Thursday, :Thursday => :Friday, :Friday => :Saturday, :Saturday => :Sunday, :Sunday => :Monday}

  class << self
    def arraybuilder(start, finish)
      [posi(start), posi(finish)]
    end

    def posi(shift)
      temp = shift.hour * 2
      temp += 1 if shift.min >= 15
      temp += 1 if shift.min >= 45
      temp
    end

    def dayarray(positions)
      e = Array.new(48){|i| 0}
      (positions[1]-positions[0]).times do |i|
        e[positions[0]+i] = 1
      end
      e
    end

    def something_to_the_something(array, key, output)
      if array[0] > array[1]
        newarray = []
        newarray[0] = 0
        newarray[1] = array[1]
        something_to_the_something(newarray, @consecutiveweekdays[key], output)
        array[1] = 48
      end
      unless output[key].nil?
        output[key] = [output[key], dayarray(array)].transpose.map {|x| x.reduce(:+)}
      else
        output[key] = dayarray(array)
      end
    end


  end
end
