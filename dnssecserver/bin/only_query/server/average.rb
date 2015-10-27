#!/usr/bin/env ruby


path = "../../../res/only_new/server_cpu_0.01"
sum = 0.0
i = 0
File.open(path, "r").each_line do |line|
    i += 1
    sum += line.to_f
end

puts "average = #{sum/i}"
