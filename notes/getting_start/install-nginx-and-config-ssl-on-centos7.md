---
title: 在CentOS8上启动服务
keywords: CentOS8 Startup
permalink: notes/getting_start/install-nginx-and-config-ssl-on-centos
---

summary: 这是一个新建服务器之后启动本人常用的流程，包括打开nignx，设置ssl，等内容。

## 0x00 启动BBR

```shell
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
```

[CentOS8系统启用BBR]: https://nodeedge.com/centos8-bbr.html

## 0x01 安装nginx

```shell
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx
# enable port on firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

> [how to install nginx on centos7](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-centos-7)

## 0x02 配置nginx

### 0x02.1 jekyll 博客框架

```shell
sudo apt install ruby ruby-dev
sudo gem install jekyll
```

### 0x02.2 nginx 配置 1

首先修改第一波内容

```shell
sudo vim /etc/nginx/nginx.conf
# 更改nginx启动用户, 改为当前用户
user zyh;
# 删除默认的文件路径 在server里面的root路径
dd root /usr/share/nginx/html;
# 在server种添加Jekyll博客静态路径
location / {
    root /home/zyh/hydrogen-master/_site;
    index index.html index.htm;
}
# 重启nginx服务
sudo nginx -s reload
```

### 0x02.3 申请证书

#### 1) 安装acme.sh

```shell
curl https://get.acme.sh | sh
source ~/.bashrc
```

[使用acme.sh获得证书]: https://ruby-china.org/topics/31983

```shell
acme.sh --issue -d www.your-app.com -w /home/ubuntu/www/your-app/current/public
acme.sh --issue -d ethereal.work -w /home/zyh/_site
```

如果出现`It seems the CA server is busy now, let's wait and retry. Sleeping 1 seconds.`提示信息, 那么需要更新acme脚本

```shell
acme.sh --upgrade
```

#### 2) 安装证书

```shell
mkdir /home/zyh/ssl
cp -r /home/zyh/.acme.sh/ethereal.work/* ~/ssl/
```

添加计划任务

```shell
acme.sh --installcert -d ethereal.work \
               --keypath       /home/zyh/ssl/ethereal.work.key  \
               --fullchainpath /home/zyh/ssl/ethereal.work.key.pem \
               --reloadcmd     "sudo service nginx force-reload"
```

让重启nginx不需要密码

```shell
$ sudo visudo
# 在zyh用户配置
zyh     ALL=(ALL)       ALL, NOPASSWD: /usr/sbin/service nginx force-reload
```

上面那句话的意思是, 除了重启nginx不需要输入密码, sudo其他命令均需要密码

#### 3) 生成 dhparam.pem 文件

```shell
openssl dhparam -out /home/zyh/ssl/dhparam.pem 2048
```

#### 4) 测试重新申请证书计划任务

Let's Encrypt 的证书有效期是 90 天的，你需要定期 `renew` 重新申请，这部分 `acme.sh` 以及帮你做了，在安装的时候往 crontab 增加了一行每天执行的命令 `acme.sh --cron`:

```shell
$ crontab -l
17 0 * * * "/home/zyh/.acme.sh"/acme.sh --cron --home "/home/zyh/.acme.sh" > /dev/null
```

PS: 下面这段你可以尝试执行一下，看看是否正确

```shell
"/home/zyh/.acme.sh"/acme.sh --cron --home "/home/zyh/.acme.sh"
```

得到如下返回值

```shell
[Wed Jan 13 12:12:43 UTC 2021] ===Starting cron===
[Wed Jan 13 12:12:43 UTC 2021] Renew: 'ethereal.work'
[Wed Jan 13 12:12:43 UTC 2021] Skip, Next renewal time is: Sun Mar 14 11:08:10 UTC 2021
[Wed Jan 13 12:12:43 UTC 2021] Add '--force' to force to renew.
[Wed Jan 13 12:12:43 UTC 2021] Skipped ethereal.work
[Wed Jan 13 12:12:43 UTC 2021] ===End cron===
```

最后测试计划任务流程(主要看重启nginx是否需要密码)

```shell
acme.sh --cron -f
```

这个过程应该会得到这样的结果，并在最后重启 Nginx (不需要输入密码)

```shell
[Tue Dec 27 14:28:09 CST 2016] Renew: 'www.your-app.com'
[Tue Dec 27 14:28:09 CST 2016] Single domain='www.your-app.com'
[Tue Dec 27 14:28:09 CST 2016] Getting domain auth token for each domain
[Tue Dec 27 14:28:09 CST 2016] Getting webroot for domain='www.your-app.com'
[Tue Dec 27 14:28:09 CST 2016] _w='/home/ubuntu/www/your-app/current/public/'
[Tue Dec 27 14:28:09 CST 2016] Getting new-authz for domain='www.your-app.com'
[Tue Dec 27 14:28:16 CST 2016] The new-authz request is ok.
[Tue Dec 27 14:28:16 CST 2016] www.your-app.com is already verified, skip.
[Tue Dec 27 14:28:16 CST 2016] www.your-app.com is already verified, skip http-01.
[Tue Dec 27 14:28:16 CST 2016] www.your-app.com is already verified, skip http-01.
[Tue Dec 27 14:28:16 CST 2016] Verify finished, start to sign.
[Tue Dec 27 14:28:19 CST 2016] Cert success.
... 省略
[Fri Dec 23 11:09:02 CST 2016] Your cert is in  /home/ubuntu/.acme.sh/www.your-app.com/www.your-app.com.cer 
[Fri Dec 23 11:09:02 CST 2016] Your cert key is in  /home/ubuntu/.acme.sh/www.your-app.com/www.your-app.com.key 
[Fri Dec 23 11:09:04 CST 2016] The intermediate CA cert is in  /home/ubuntu/.acme.sh/www.your-app.com/ca.cer 
[Fri Dec 23 11:09:04 CST 2016] And the full chain certs is there:  /home/ubuntu/.acme.sh/www.your-app.com/fullchain.cer 
[Tue Dec 27 14:28:22 CST 2016] Run Le_ReloadCmd: sudo service nginx force-reload
 * Reloading nginx nginx                                                                                                                                     [ OK ] 
[Tue Dec 27 14:28:22 CST 2016] Reload success
```



### 0x02.4 nginx 配置 2 -- 生效SSL

```shell
sudo vim /etc/nginx/nginx.conf
# in the first 'server' modify to down there
    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  ethereal.work;
        # redirct to https
        return 302 https://$host$request_uri;    
    } 
# after the first server add a new server for ssl
    server {
        listen 443 ssl http2 default_server;
        listen [::]:443 ssl http2 default_server;
        ssl_certificate         /home/zyh/ssl/ethereal.work.key.pem;
        ssl_certificate_key     /home/zyh/ssl/ethereal.work.key;
        # ssl_dhparam
        ssl_dhparam             /home/zyh/ssl/dhparam.pem;
 
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
        ssl_prefer_server_ciphers on;
         ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        server_name  ethereal.work;
 
        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;
 
        location / {
            root /home/zyh/_site;
            index index.html index.htm;
        }
 
        error_page 404 /404.html;
            location = /40x.html {
        }
 
        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# 重启nginx
sudo nginx -s reload
```

## 0x03 配置Django爬虫

### 0x03.1 安装Django

```shell
sudo python3 -m pip install django
```

### 0x03.2 安装支持库

````shell
sudo python3 -m pip install requests
sudo python3 -m pip install lxml
````

### 0x03.3 安装uwsgi

从官网上下载安装包

[Getting uWSGI]: https://uwsgi-docs.readthedocs.io/en/latest/Download.html

解压

```shell
tar -zxvf uwsgi.tar.gz
```

安装

```shell
sudo yum install python3-devel
sudo python3 setup.py install
```
