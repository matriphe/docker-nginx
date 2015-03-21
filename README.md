# Docker Nginx

 Build from [nginx official docker repo](https://registry.hub.docker.com/_/nginx/). This build just add PHP-FPM ready to `nginx.conf` file.

## To Build

```bash
cd /path/to/repo/docker/nginx
docker build -t nginx .
```
This command will build a docker image named "nginx" from location "."

## To Run

```bash
docker run -d -p 80:80 --name webserver nginx
```

This command will run using default configuration and default root directory. To change the configuration path (read only) or root directory (writeable), just add `-v` to command like this.

```bash
docker run -d -p 80:80 -v /path/to/nginx/config:/etc/nginx:ro -v /path/to/root/directory:/usr/share/nginx/html:rw --name webserver nginx
```

Then you can hit `http://localhost` or `http://host-ip` from your browser.

## Ingredients
* Debian 7.0 wheezy
* nginx 1.7.10-1~wheezy
