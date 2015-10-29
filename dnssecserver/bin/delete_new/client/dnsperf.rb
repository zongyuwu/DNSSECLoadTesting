#!/usr/bin/ruby


IP = "192.168.1.253"
RT = 0.1 #ramp up time

res = ""
1000.times do |i|
  `ruby ./gen_payload.rb`
  cmd = "dnsperf -s #{IP} -d test_add_1027 -uvD"
  t = `#{cmd}`
  res = "#{res}#{t}"
  sleep(RT)
end

File.open("../../../res/delete_new/client_#{RT}", "w") { |f| f.write(res) }
