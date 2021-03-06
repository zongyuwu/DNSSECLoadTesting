#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

Title = "DNSSEC_CERT_NEW_MEM_Usage"
Xlable = "Rampup time (times/seconds)"
Ylable = "MEM Usage (%)"
require "gnuplot"
Gnuplot.open do |gp|
  x, y = [], []
  data = File.read("./inputfile_mem")
  data.each_line do |line|
    x << line.chomp.split(",")[0]
    y << line.chomp.split(",")[1]
  end

  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "gif"
    plot.output File.expand_path("~/dnssec/DNSSECLoadTesting/dnssecserver/res/only_new/#{Title}.gif", __FILE__)
    plot.title Title
    plot.ylabel Ylable
    plot.xlabel Xlable
    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "linespoints"
      ds.title = "MEM Usage (%)"
    end
  end
end
