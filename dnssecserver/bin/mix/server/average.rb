#!/usr/bin/env ruby


path = "../../../res/mix/server_1000_20_20_cpu"
sum = 0.0
i = 0
File.open(path, "r").each_line do |line|
    i += 1
    sum += line.to_f
end

puts "average = #{sum/i}"
