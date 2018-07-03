# README
### Authenticate base on [warden](https://github.com/wardencommunity/warden)
- Model: User. Admin, Corporation
```
User: email, password
Admin: user_id
Corporation: user_id
```

- Login admin, corporation for each domain with email, password of user

- git clone https://github.com/nguyenngoc2505/warden-demo.git
- bundle install
- rake db:create db:migrate db:seed
- rails s

### Run in wweb with domain config
## Development domain setup
### Local domain:
- Admin: admin.demo.local
- Corporation: corporation.demo.local

### Using nginx with unicorn
```
upstream unicorn {
  server  unix:/path/to/demo/tmp/sockets/unicorn.sock fail_timeout=0;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;
  server_name demo.local *.demo.local;

  root /path/to/demo/public;

  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://unicorn;
  }
}
```

* run rails server by unicorn with command below:
```
  unicorn -c config/unicorn/development.rb
```

### Using nginx + macosx
*  Install Nginx
```
  brew install nginx
```

*  config nginx.conf: /usr/local/etc/nginx/nginx.conf

```
worker_processes 4;

events {
  worker_connections 1024;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;

  include /usr/local/etc/nginx/mime.types;
  default_type application/octet-stream;

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  gzip on;
  gzip_disable "msie6";

  client_max_body_size 500M;

  include /usr/local/etc/nginx/servers/*;
}
```

*  config default.conf: /usr/local/etc/nginx/server/default.conf

```
upstream railsapp {
  server 127.0.0.1:3000;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;

  server_name demo.local *.demo.local;

  root /path/demo/public;

  try_files $uri/index.html $uri;

  location / {
    root /path/demo;
    index index.html index.htm;

    proxy_pass http://railsapp/;
    proxy_redirect off;
    proxy_set_header X-Real-IP  $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;

    proxy_set_header X-NginX-Proxy true;
  }
}
```
### Using nginx + Ubuntu

*  Install Nginx
```
  sudo apt-get install nginx
```

*  config nginx.conf: /etc/nginx/nginx.conf

```
user www-data;
worker_processes 4;
pid /run/nginx.pid;

events {
  worker_connections 768;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;

  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  gzip on;
  gzip_disable "msie6";

  client_max_body_size 500M;

  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;
}

```

*  config default.conf: /etc/nginx/sites-enabled/default.conf

```
upstream railsapp {
  server 127.0.0.1:3000;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;

  server_name demo.local *.demo.local;

  root /path/demo/public;

  try_files $uri/index.html $uri;

  location / {
    root /path/demo;
    index index.html index.htm;

    proxy_pass http://railsapp/;
    proxy_redirect off;
    proxy_set_header X-Real-IP  $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
  }
}
```

*  add domain to /etc/hosts
```
127.0.0.1 admin.demo.local
127.0.0.1 corporation.demo.local
127.0.0.1 demo.local
```

### Cal API
```ruby
curl -X POST -H "Content-Type: application/json" http://localhost:3000/v1/welcome -d '{"authentication_token":"447e50302f0cbf5b1a7951c603123c2ce354fd12"}'
```
