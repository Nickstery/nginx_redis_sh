apt-get install checkinstall libpcre3 libpcre3-dev zlib1g zlib1g-dbg zlib1g-dev zip unzip git && \

mkdir -p ~/sources/ && \

# Compile against OpenSSL to enable NPN
cd ~/sources && \
git clone https://github.com/openresty/redis2-nginx-module.git && \
git clone https://github.com/openresty/set-misc-nginx-module.git && \
git clone https://github.com/simpl/ngx_devel_kit.git && \
wget http://www.openssl.org/source/openssl-1.0.1j.tar.gz && \
tar -xzvf openssl-1.0.1j.tar.gz && \

# Download the Cache Purge module
cd ~/sources/ && \
git clone https://github.com/FRiCKLE/ngx_cache_purge.git && \
cd ~/sources && \

# Download PageSpeed
cd ~/sources && \
wget https://github.com/pagespeed/ngx_pagespeed/archive/v1.7.30.4-beta.zip && \
unzip v1.7.30.4-beta.zip && \
cd ngx_pagespeed-1.7.30.4-beta && \
wget https://dl.google.com/dl/page-speed/psol/1.7.30.4.tar.gz && \
tar -xzvf 1.7.30.4.tar.gz && \

# Get the Nginx source.
#
# Best to get the latest mainline release. Of course, your mileage may
# vary depending on future changes
cd ~/sources/ && \
wget http://nginx.org/download/nginx-1.5.12.tar.gz && \
tar zxf nginx-1.5.12.tar.gz && \
cd nginx-1.5.12 && \

# Configure nginx.
#
# This is based on the default package in Debian. Additional flags have
# been added:
#
# * --with-debug: adds helpful logs for debugging
# * --with-openssl=$HOME/sources/openssl-1.0.1e: compile against newer version
#   of openssl
# * --with-http_spdy_module: include the SPDY module
./configure --prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=www-data \
--group=www-data \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-http_spdy_module \
--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' \
--with-ld-opt='-Wl,-z,relro -Wl,--as-needed' \
--with-ipv6 \
--with-debug \
--with-openssl=$HOME/sources/openssl-1.0.1j \
--add-module=$HOME/sources/ngx_pagespeed-1.7.30.4-beta \
--add-module=$HOME/sources/ngx_cache_purge \
--add-module=$HOME/sources/redis2-nginx-module \
--add-module=$HOME/sources/ngx_devel_kit \
--add-module=$HOME/sources/set-misc-nginx-module \

# Make the package.
make && \

# Create a .deb package.
#
# Instead of running `make install`, create a .deb and install from there. This
# allows you to easily uninstall the package if there are issues.
checkinstall --install=no -y && \

# Install the package.
dpkg -i nginx_1.5.12-1_amd64.deb
