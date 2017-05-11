#!/bin/bash

cat > '/usr/src/proxy/config/settings.yml' << EOF
---
:foreman_url: ${FOREMAN_URL}
# host to bind ports to (possible values: *, localhost, 0.0.0.0)
:bind_host: '0.0.0.0'
# http is disabled by default. To enable, uncomment 'http_port' setting
:http_port: 8000
# Uncomment and modify if you want to change the location of the log file or use STDOUT or SYSLOG values
:log_file: logs/proxy.log
EOF

cat > '/usr/src/proxy/config/settings.d/chef.yml' << EOF
---
:enabled: true
:chef_authenticate_nodes: true
:chef_server_url: ${CHEF_URL}/organizations/${CHEF_ORG}
# smart-proxy client node needs to have some admin right on chef-server
# in order to retrive all nodes public keys
# e.g. 'host.example.net'
:chef_smartproxy_clientname: pivotal
# e.g. /etc/chef/client.pem
:chef_smartproxy_privatekey: /usr/src/proxy/chef/pivotal.pem

# turning of chef_ssl_verify is not recommended as it turn off authentication
# you can try set path to chef server certificate by chef_ssl_pem_file
# before setting chef_ssl_verify to false
# note that chef_ssl_pem_file must contain both private key and certificate
# because chef-api 0.5 requires it
:chef_ssl_verify: true
# :chef_ssl_pem_file: /path
EOF

/usr/src/proxy/bin/smart-proxy
