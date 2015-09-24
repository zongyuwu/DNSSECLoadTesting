#!/usr/bin/env ruby


beg = "aaaa"
out = ""
20000.times do 
  out = "#{out}#{beg},#{beg}\n"
  beg.next!
end

open("./CSVUSER_PASSWD.csv", "a") { |f| f.puts out.chomp }
