#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

Title = "Ramp_Up_Successful_Login"
Xlable = "Number of User"
Ylable = "Times (ms)"
require "gnuplot"
Gnuplot.open do |gp|
  x_60, y_60 = [], []
  x_120, y_120 = [], []
  x_180, y_180 = [], []

  data = File.read("./inputfile_ru")
  data.each_line do |line|
    target = line.chomp.split(",")
    case target[1]
    when "60"
      x_60 << target[0] #user
      y_60 << target[2].to_i #login time
    when "120"
      x_120 << target[0]
      y_120 << target[2].to_i #login time
    when "180"
      x_180 << target[0]
      y_180 << target[2].to_i
    end
  end


  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "gif"
    plot.output File.expand_path("../#{Title}.gif", __FILE__)
    plot.title Title
    plot.ylabel Ylable
    plot.xlabel Xlable
    plot.data << Gnuplot::DataSet.new( [x_60, y_60] ) do |ds|
      ds.with = "linespoints"
      ds.title = "Average Login Time"
    end
    plot.data << Gnuplot::DataSet.new( [x_120, y_120] ) do |ds|
      ds.with = "linespoints"
      ds.title = "Average Login Time"
    end
    plot.data << Gnuplot::DataSet.new( [x_180, y_180] ) do |ds|
      ds.with = "linespoints"
      ds.title = "Average Login Time"
  end
end
