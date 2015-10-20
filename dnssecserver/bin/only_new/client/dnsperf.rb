#!/usr/bin/ruby

require 'optparse'

IP = "192.168.1.253"


class ARGVParser
  def initialize
    @@options = {}
    @banner = "Usage ruby ./dnsperf.rb [options]"
    OptionParser.new do |opts|
      opts.banner = @banner
      opts.on("-d D", String, :required, "Testing input file") do |v|
        @@options[:d] = v #testing file
      end

      opts.on("-n N", String, "Run how many times") do |v|
        @@options[:N] = v
      end

      opts.on("-Q Q", String, "Limits the number of requests per second. There is no default limit.") do |v|
        @@options[:Q] = v
      end
    end.parse!

    if !sanitycheck
      puts "File doesn't exist"
      exit
    end
  end

  def options
    @@options
  end

private
  def sanitycheck
    begin 
      return File.file? @@options[:d]
    rescue
      return false
    end
  end
end


class Query < ARGVParser
  def initialize
    @format = "dnsperf -s #{IP} -d #{@@options[:d]} -n #{@@options[:N]} -Q #{@@options[:Q]} -c 100 -vuD"
    #@format = "dnsperf -s #{IP} -d #{@@options[:d]} -n #{@@options[:N]} -Q #{@@options[:Q]} -vD"
    @output = "../../../res/only_new/report_#{@@options[:Q]}.txt"
  end

  def writeformat
    File.open(@output, "w") { |f| f.write(@format) }
  end

  def query
    File.delete @output if File.exist? @output
    `#{@format} >> #{@output}`
  end
end


#`ruby ./gen_payload.rb`
opts = ARGVParser.new
q = Query.new
q.query
