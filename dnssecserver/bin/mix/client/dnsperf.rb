#!/usr/bin/ruby

require 'timeout'


IP = "192.168.1.253"
UN_s = 0.1
FREQ = 100

$FLAG = true


def setup_query
  `ruby ./gen_payload_query.rb` #gen payload of query, payload at "inputfile_query"
end

def setup_update_new
  `ruby ./gen_payload_update.rb` #gen payload of update, payload at "inputfile_update"
  `ruby ./gen_payload_new.rb` #gen payload of new, payload at "inputfile_new"
end

def query
  begin
    setup_query
    cmd = "dnsperf -s #{IP} -d inputfile_query -Q #{FREQ} -D"
    `#{cmd}`
  end until $FLAG == false
end

def update_new
  Timeout::timeout(120) do
    begin
      setup_update_new
      cmd1 = "dnsperf -s #{IP} -d inputfile_update -uD"
      `#{cmd1}`
      cmd2 = "dnsperf -s #{IP} -d inputfile_new -uD"
      `#{cmd2}`
    rescue
      $FLAG = false
    end
  end
end

t1 = Thread.new { query }
t2 = Thread.new { update_new }
t1.join
t2.join
