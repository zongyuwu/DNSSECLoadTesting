#!/usr/bin/env ruby

class Usage_Probe
  def initialize
    @@target = "named"
    @@period = 0.001
    @@totall = 100
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

private
  def probe_core
    r = `top -n 1`
    tmp = /(\d+\.\d+)\s+(\d+\.\d+)\s+\d+:\d+\.\d+\s+#{@@target}/.match(r)
    if !tmp.nil?
      @CPU_usage << tmp[1]
      @MEM_usage << tmp[2]
    else
      @CPU_usage << 0
      @MEM_usage << 0
    end
  end
end

prb = Usage_Probe.new
prb.probe
puts "done probing"
prb.write_cpu_res "/tmp/test"
prb.write_mem_res "/tmp/test"
