#!/usr/bin/env ruby


class Nsupdate_New
  def initialize
    @low_num = 0x80e179ad8a515536ed683d8082906924735c6f625878af4700000000
    @rand_range = 100000000000000000000000000000000000
    @formate = "._getpgpkey.example.com."
    @fqdn = "example.com"
    @action = "add"
    @query_arr = []
  end 

  def randomnew_arr(n)
    n.times do
      @query_arr << "#{(rand(0..@rand_range)+@low_num).to_s(16)}#{@format}"
    end
  end

  def to_add_format
  cert = "mI0EVXZU9AEEAMU7aevqDqk9K6/EtMfg5PjLWWymiKex+keBp4S4RY7QSPgvZ+Onp4oJd5ZFuygM+1ergzwHF0uYHfJoCkFRJLv7mDiw1fP25sj6JMXNk9Tit+Y7eeBzRmT14VxhlrM5l/GDe71xApI7Rfw256YhIJ/ztMamugszUpKIKluDPZbfABEBAAG0JW1pY2hjaG8gPG1pY2hjaG9AZHNucy5jcy5uY3R1LmVkdS50dz6IuQQTAQIAIwUCVXZU9AIbLwYLCQgHAwIGFQgKCQsCBRYCAwEAAh4BAheAAAoJEDHgQpy3gfm3t9oEALelY+QLBZfdQ++3UxR+VbY3u5dj3yoXcGdsCkEQop05htYGgXBI/XGoVDhhC9osbnZsawZRG0NMXIcRWG+9sTcS8o5VKsBOQdjzl+1xCTGPjjLkmGRRtIjPXfWMRDYXHSiWXtfSbIjiW2tAEVd6a50K3C1OR9nhGTSqMnmGcRw5uI0EVXZU9AEEANZo0Cp5281UfDdem/OlqhAXvYTBX6QmnZmThjRdbWe6gQJ66gDV4v/dxelCrjXrB1c0GP1SlPC2ys3gyBlMC1hxme9kHbscbVYDo/KGk7NSGo/sD3oygnPUPiY22zwwvAavVv4CHoA/EpHCpbTJHDulPB1vad1asMonJRvqFpGVABEBAAGJAT0EGAECAAkFAlV2VPQCGy4AqAkQMeBCnLeB+bedIAQZAQIABgUCVXZU9AAKCRD8X5mYNHrA3wqzA/9uTyqg0Irr5OSTkOoVBLTnAw2AwmSea+XoRvyOVaIuht5TNZ1NMZuwBre3im1pwipGI507QRCZC7OhlR8RwrUn4AoL8wJIJG8j0brV41A8jJEFFGUs2RsFfHth8yEjezVPb6zWL613aCIZFcfWXrpX/r/7G5R/P3/a9I8t4lnQYNicA/9zVONSjMXJAK2BAg+teUlT6WHCJriyOahNTUStKc/3PdXIm1O1yH7Y6IbJMXNoSpqMxX/fCrm9TleLla9oDHIkSHcDVqg1OXLGdqj6bpX0/4c4IskAKSAQ/r6XXOwOBmIsbFfKgVr0eA35Cmsx9tOXYpJ83tgAMHPncMVwGEY6hw=="
    @query_arr.map! { |q| "#{@action} #{q} 86400 CERT PGP 0 0 #{cert}" }
  end

  def query_arr
    @query_arr
  end

  def query_arr_to_file(filepath)
    File.open(filepath, "w") do |f|
      f.puts @fqdn
      @query_arr.each do |line|
        f.puts line
      end
      f.puts "send"
    end
    puts "\nSuccess write to file #{filepath}"
  end
end

u = Nsupdate_New.new
u.randomnew_arr(4)
u.to_add_format
u.query_arr_to_file("./test_add_1027")
