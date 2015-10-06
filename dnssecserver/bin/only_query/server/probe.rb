#!/usr/bin/env ruby

class Usage_Probe
  def initialize
    @@target = "named"
    @@period = 0.001
    @@totall = 500
    @CPU_usage = []
    @MEM_usage = [] 
  end

  def probe
    @@totall.times do 
      probe_core
      sleep(@@period)
    end
  end

  def write_cpu_res filename
    File.open("#{filename}_cpu", "w") do |f|
      @CPU_usage.each do |cpu|
        f.write("#{cpu}\n")
      end
    end
  end

  def write_mem_res filename
    File.open("#{filename}_mem", "w") do |f|
      @MEM_usage.each do |mem|
        f.write("#{mem}\n")
      end
    end
  end

  def draw filetodraw
    draw_core("CPU", "#{filetodraw}_CPU.gif")
    draw_core("MEM", "#{filetodraw}_MEM.gif")
  end

private
  def probe_core
    r = `top -n 1`
    tmp = /(\d+\.\d+)\s+(\d+\.\d+)\s+\d+:\d+\.\d+\s+#{@@target}/.match(r)
    if !tmp.nil?
      @CPU_usage << tmp[1]
      @MEM_usage << tmp[2]
    #else
      #@CPU_usage << 0
      #@MEM_usage << 0
    end
  end

  def draw_core type, filetodraw
    if type == "CPU"
      len = @CPU_usage.length
      y = @CPU_usage
    elsif type == "MEM"
      len = @MEM_usage.length
      y = @MEM_usage
    end
    x = (1..len).to_a
    title = "#{type} Usage"
    xlabel = "probe squence"
    ylabel = "Percentage"
    require 'gnuplot'
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.terminal "gif"
        plot.output filetodraw
        plot.title title
        plot.ylabel ylabel
        plot.xlabel xlabel
        plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
          ds.with = "linespoints"
          ds.title = "#{type} Usage"
        end
      end
    end
  end
end

prb = Usage_Probe.new
prb.probe
puts "done probing"
prb.write_cpu_res "../../../res/only_query/server"
prb.write_mem_res "../../../res/only_query/server"
prb.draw "../../../res/only_query/server"
