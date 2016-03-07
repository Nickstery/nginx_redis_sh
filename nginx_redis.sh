cd /opt
apt-get update
apt-get install libpcre3 libpcre3-dev  zlib1g-dev git build-essential tcl8.5
wget 'http://nginx.org/download/nginx-1.9.12.tar.gz'
tar -xzvf nginx-1.9.12.tar.gz
rm -rf nginx-1.9.12.tar.gz
git clone https://github.com/openresty/redis2-nginx-module.git
cd nginx-1.9.12/
./configure --prefix=/opt/nginx --add-module=/opt/redis2-nginx-module
make -j2
make install
cp -i /opt/nginx_redis_sh/nginx.conf /opt/nginx/conf/nginx.conf
cd ..
wget -O init-deb.sh https://www.linode.com/docs/assets/660-init-deb.sh
mv init-deb.sh /etc/init.d/nginx
chmod +x /etc/init.d/nginx
/usr/sbin/update-rc.d -f nginx defaults
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
rm -rf redis-stable.tar.gz
cd redis-stable
make
make install
cd utils
./install_server.sh
rm -rf redis-stable
rm -rf nginx-1.9.12
service redis_6379 start
service nginx start
