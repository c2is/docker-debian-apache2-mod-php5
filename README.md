# C2is container for Debian Jessie Apache 2.4 And Php 5.6 (apache module)

### Usage 

##### Edit your /etc/hosts file and add the line:
```
127.0.0.1 website.docker
```
Host value could be changed according your choice below  
Warning for macosx and windows users : ip value should be changed according your Docker's VM ip

##### With docker-compose (use image already built from docker's hub)
```
# In your docker-compose.yml file
c2isapachephp:
    images: c2is/debian-apache2-mod-php5
    ports:
        - 80:80
    environment:
        # Default: website.docker
        WEBSITE_HOST: projectname.loc
        # Default: no, DocumentRoot have not the trailing /web/
        SYMFONY_VHOST_COMPLIANT: yes
```

##### With docker directly
```
git clone git@github.com:c2is/docker-debian-apache2-mod-php5.git
cd docker-debian-apache2-mod-php5
docker build -t . c2isDebAp
docker run -d -e WEBSITE_HOST=projectname.loc -e SYMFONY_VHOST_COMPLIANT=yes c2isDebAp
```

##### Then visit http://website.docker/