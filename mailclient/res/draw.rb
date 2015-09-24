#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

Title = "Deviation"
Xlable = "Number of User"
Ylabel = "Average Login Time"
require "gnuplot"
Gnuplot.open do |gp|
  x, y, y2, y3 = [], [], [], []
  data = File.read("./inputfile")
  data.each_line do |line|
    x << line.chomp.split(",")[0]
    y << line.chomp.split(",")[1]
    y2 << line.chomp.split(",")[2]
    y3 << line.chomp.split(",")[3]
  end

  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "gif"
    plot.output File.expand_path("../#{Title}.gif", __FILE__)
    plot.title Title
    plot.ylabel Ylable
    plot.xlabel Xlable
    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "linespoints"
      ds.notitle
    end
    plot.data << Gnuplot::DataSet.new( [x, y2] ) do |ds|
      ds.with = "linespoints"
      ds.notitle
    end
    plot.data << Gnuplot::DataSet.new( [x, y3] ) do |ds|
      ds.with = "linespoints"
      ds.notitle
    end
  end
end
