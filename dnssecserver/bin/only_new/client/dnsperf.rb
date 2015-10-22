#!/usr/bin/ruby


IP = "192.168.1.253"

res = ""
3.times do |i|
  `ruby ./gen_payload.rb`
  cmd = "dnsperf -s #{IP} -d test_add_1020 -uvD"
  t = `#{cmd}`
  res = "#{res}#{t}"
end

puts res
