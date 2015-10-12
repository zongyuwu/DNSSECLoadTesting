#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

Title = "DNSSEC_CERT_Query_ErrorRate"
Xlable = "Frequency (times/seconds)"
Ylable = "Error rate"
require "gnuplot"
Gnuplot.open do |gp|
  x, y = [], []
  data = File.read("./inputfile_err")
  data.each_line do |line|
    x << line.chomp.split(",")[0]
    y << line.chomp.split(",")[1]
  end

  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "gif"
    plot.output File.expand_path("~/dnssec/DNSSECLoadTesting/dnssecserver/res/only_query/#{Title}.gif", __FILE__)
    plot.title Title
    plot.ylabel Ylable
    plot.xlabel Xlable
    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "linespoints"
      ds.title = "Error rate"
    end
  end
end
