# nginx_redis_sh
sh script for nginx + redis module

#Requirements
1. Run sh from with sudo rights
2. Need to be created etc/init.d/nginx. External example:
 - wget -O init-deb.sh https://www.linode.com/docs/assets/660-init-deb.sh
 - mv init-deb.sh /etc/init.d/nginx
 - chmod +x /etc/init.d/nginx
 
3. Add locations to nginx.conf, which you wish from [redis2-nginx-module Synopsis](https://github.com/openresty/redis2-nginx-module#synopsis)