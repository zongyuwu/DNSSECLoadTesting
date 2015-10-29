#!/usr/bin/ruby

require 'optparse'

IP = "192.168.1.253"

class Dnsperf_Query
  def initialize
    @low_num = 0x80e179ad8a515536ed683d8082906924735c6f625878af4695100000
    @rand_range = 0xfffff
    @format = "._getpgpkey.example.com"
    @query_arr = []
  end

  def randomquery_arr(n)
    n.times do 
      @query_arr << "#{(rand(0..@rand_range)+@low_num).to_s(16)}#{@format}"
    end
  end
  
  def query_type(type)
      @query_arr.map! { |q| "#{q} #{type}"}
  end

  def query_arr
    @query_arr
  end

  def query_arr_to_file(filepath)
    File.open("#{filepath}", "w") do |f|
      @query_arr.each do |line|
        f.puts line
      end
    end
    puts "\nSuccess write to file #{filepath}"
  end
end



q = Dnsperf_Query.new
q.randomquery_arr(100)
q.query_type("CERT")
#p q.query_arr
q.query_arr_to_file("./inputfile_query")
