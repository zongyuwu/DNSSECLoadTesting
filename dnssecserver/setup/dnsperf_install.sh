sudo apt-get install -y bind9utils libbind-dev libkrb5-dev libssl-dev libcap-dev libxml2-dev
curl ftp://ftp.nominum.com/pub/nominum/dnsperf/2.0.0.0/dnsperf-src-2.0.0.0-1.tar.gz -O
tar xfvz dnsperf-src-2.0.0.0-1.tar.gz
cd dnsperf-src-2.0.0.0-1
./configure
make
sudo make install
