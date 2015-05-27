docker-ghost-ssl
================
This project builds and deploys two production ready [Docker](https://www.docker.com)
containers that work together to serve [Ghost blog](https://github.com/tryghost/Ghost) content:  
* one with Ghost/Node.js  
* the other with Nginx + SSL configured to proxy the content from the other container.

### Requirements
* Linux host with Git and Docker installed
* SSL certificate and key

### Running the blog

#### Clone repository

    git clone https://github.com/cmosetick/docker-ghost-ssl.git && cd docker-ghost-ssl

#### Import existing Ghost blog data (Optional)
AFTER above clone step is complete  
Put your Ghost data (contents directory) into data/ghostblog_data directory before
starting containers with start script.

#### SSL Configuration
* Copy SSL cert to data/certificates/server.crt
* Copy SSL private key to data/certificates/server.key  
Best way to do this is to create symlinks to the actual file names that mean something to you.  
__!Be sure to NOT accidentally commit your certificate and key to a public source code repository!__


#### Starting blog
Run the start script with your blog url like the example below. This will pull the
latest images and start containers with appropriate port and volume mappings.
If all goes well, your blog should be up and running.

    ./ghostblog_start.sh http://mybloghere.com

* Running this will start two containers:
    * ***ghostblog*** container with data/ghostblog_data mapped as a Docker volume.

    * ***ghostblog_proxy*** container with ports 80 and 443 mapped to actual host host.
    * linked to 'ghostblog' container so nginx can proxy connections to the Ghost container.
    * Docker volumes data/certificates and data/sites-enabled both mapped to /etc/nginx in the proxy container.

run `docker ps` on your host to see the running containers

In your browser vist: http://mybloghere.com to see HTTPS content  

vist: https://mybloghere.com/ghost to access the HTTPS admin area.


### Further optimizations

One can easily take this a step further by creating a free [Cloud Flare](https://www.cloudflare.com/plans)
account and using that as CDN to offload some of the work that your Linux host has to do.  
With this setup you would almost certainly be ready for the front page of Slashdot / Hacker News / Reddit.


### Goals and notes about this fork

The main idea with this fork is to only serve the Ghost blog admin area over TLS/SSL.  
i.e. https://myblog.com/ghost/  

All other content should be served via standard HTTP.  
i.e. http://myblog.com/post-title

Other small adjustments have been made along the way including:

* Using PPA's for Nginx and Node.js installation
* Increasing maximum file upload size for Nginx.
* Making sure that the containers are restarted upon host reboot
  ^^ Important ^^

The two major changes to make the admin area ONLY be served
via TLS/SSL are to `nginx.conf` and `config.js`

NOTE Currently this project will not work correctly for those wanting to try this
on systems running [boot2docker](http://boot2docker.io/) on Mac or Windows. The main
reason is because the port mapping will go to the Linux boot2docker host instead of
your Mac/Windows system. Future updates to Docker / boot2docker may change this.

e.g. This is more for a __production run__ of Ghost running under Docker on bare metal
or cloud based VM, than a local development environment.

### Docker Hub repositories
Automated builds of the images have been configured in Docker Hub:
* For the Ghost/Node.js container
https://registry.hub.docker.com/u/cmosetick/docker-ghost/
* For the Nginx + SSL container
https://registry.hub.docker.com/u/cmosetick/nginx-ghost-ssl/


### (Optional) Building images

    ./build.sh

  Running this will create two Docker images:
  * ***cmosetick/docker-ghost*** image for Ghost blog.
  * ***cmosetick/nginx-ghost-ssl*** image for Nginx proxy.
