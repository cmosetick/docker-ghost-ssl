#!/bin/bash

ghostblog_image_name="cmosetick/docker-ghost"
ghostblog_container_name="ghostblog"
ghostblog_proxy_image_name="cmosetick/nginx-ghost-ssl"
ghostblog_proxy_container_name="ghostblog_proxy"

data_folder="data"
ghost_data_folder="${data_folder}/ghostblog_data"
ghost_config_file="${ghost_data_folder}/config.js"
cert_folder="${data_folder}/certificates"
ssl_crt="${cert_folder}/server.crt"
ssl_key="${cert_folder}/server.key"
nginx_sites_folder="${data_folder}/sites-enabled"
nginx_ghost_conf="${nginx_sites_folder}/ghost.conf"

#define restart policy for containers

#leave set to always for production use
#this will make sure that your containers get started back up following a host reboot
auto_restart_policy="--restart='always'"

#set this to no for testing or development
#auto_restart_policy="--restart='no'"

#Ref: https://docs.docker.com/reference/run/#restart-policies-restart
