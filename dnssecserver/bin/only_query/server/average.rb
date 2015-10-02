#!/usr/bin/env ruby


path = "../../../res/only_query/server_cpu_300"
sum = 0.0
i = 0
File.open(path, "r").each_line do |line|
  i += 1
  sum += line.to_i
end

puts "average = #{sum/i}"
