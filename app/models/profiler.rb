class Profiler
  class << self
    def arraybuilder(start, finish)
      [posi(start), posi(finish)]
    end

    def posi(shift)
      temp = shift.hour * 2
      temp += 1 if shift.minutes >= 15
      temp += 1 if shift.minutes >= 45
      temp
    end

    def dayarray(positions)
      (positions[1]-position[0]).times.inject.with_index([]) do |e,i|
        e[position[0]+i] = 1
        e
      end
    end
  end
end
