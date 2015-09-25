#!/usr/bin/ruby

require 'optparse'

IP = "192.168.1.253"


class ARGVParser
  def initialize
    @@options = {}
    @banner = "Usage ruby ./dnsperf.rb [options]"
    OptionParser.new do |opts|
      opts.banner = @banner
      opts.on("-f F", String, :required, "Testing input file") do |v|
        @@options[:F] = v #testing file
      end

      opts.on("-n N", String, :required, "Run how many times") do |v|
        @@options[:N] = v
      end

      opts.on("-q Q", String, "Limits the number of requests per second. There is no default limit.") do |v|
        @@options[:Q] = v
      end
    end.parse!

    puts "File doesn't exist" if sanitycheck
  end

  def options
    @@options
  end

private
  def sanitycheck
    begin 
      return File.file? @@options[:F]
    rescue
      return false
    end
  end

end





opts = ARGVParser.new.options
p opts
q = Dnsperf_Query.new
#q.randomquery_arr(10)
#q.query_type("CERT")
#p q.query_arr
