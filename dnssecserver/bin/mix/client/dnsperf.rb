#!/usr/bin/ruby


IP = "192.168.1.253"
#RT = 0.1 #ramp up time
FREQ = 100

res = ""
(10000/200).times do

  `ruby ./gen_payload_query.rb`
  cmd = "dnsperf -s #{IP} -d inputfile_query -Q #{FREQ} -vD"
  t = `#{cmd}`
  res = "#{res}#{t}"

  `ruby ./gen_payload_update.rb`
  cmd = "dnsperf -s #{IP} -d inputfile_update -vuD"
  t = `#{cmd}`
  res = "#{res}#{t}"

  `ruby ./gen_payload_query.rb`
  cmd = "dnsperf -s #{IP} -d inputfile_query -Q #{FREQ} -vD"
  t = `#{cmd}`
  res = "#{res}#{t}"

  `ruby ./gen_payload_update.rb`
  cmd = "dnsperf -s #{IP} -d inputfile_update -vuD"
  t = `#{cmd}`
  res = "#{res}#{t}"


  `ruby ./gen_payload_new.rb`
  cmd = "dnsperf -s #{IP} -d inputfile_update -vuD"
  t = `#{cmd}`
  res = "#{res}#{t}"

end

File.open("../../../res/mix/client_#{FREQ}", "w") { |f| f.write(res) }
