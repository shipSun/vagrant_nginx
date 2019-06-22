#!/bin/bash

mkdir -p /vagrant/logs/

sed -i 's/#error_log  logs\/error\.log  notice;/error_log  \/vagrant\/logs\/error\.log  error;/g' /usr/local/nginx/conf/nginx.conf;

echo 'server {
      	listen       81;
      	server_name  127.0.0.1;
      	root	"/vagrant";
      	index  index.php index.html index.htm;

       location / {
           try_files $uri /index.php?$args;
       }
       location ~ \.php(.*)$  {
            fastcgi_pass   192.168.56.12:9000;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
	    }
        access_log  /vagrant/logs/ship.tpddns.cn.log;

      }' > /usr/local/nginx/conf/conf.d/www.conf;

echo "/usr/local/nginx/sbin/nginx.service start" >> /etc/rc.local;

service nginx start;