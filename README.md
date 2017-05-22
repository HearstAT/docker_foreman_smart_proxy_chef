# Chef Multi-Org Foreman Smart Proxy
Dockerized Foreman Smart Proxy for Multiple Chef Organizations

## Table of Contents

*   [Info](#info)
*   [Usage](#usage)
*   [Contributing](#contributing)
*   [Credits](#credits)
*   [License](#license)

## Info

*   Installs from Smart Proxy Git repo
*   Installs Smart Proxy Chef Plugin from Gem
*   Takes Environment Variables from Docker and creates configs based on those
*   Only Utilize pivotal.pem for test/non-prod setups!
    *   Create clients w/ admin permissions for orgs and utilize those keys instead

## Usage

### Command Line
This container requires a few items to run appropriately

#### Pivotal (For testing only)
**Note**: Example shows pivotal, if no ORG_CLIENT passed the client name defaults to pivotal
**Note**: Don't change the org.pem, this is the key name set in the settings.yml.
```bash
docker run \
  -e FOREMAN_URL='https://foreman.change_domain.com' \
  -e CHEF_URL='https://chef.change_domain.com' \
  -e CHEF_ORG='change_myorg' \
  -p 8000:8000 \
  -v /path/to/pivotal.pem:/usr/src/proxy/chef/org.pem \
  -d hearstat/chef-smart-proxy
```

#### Org Client (Recommended)
To set to a specific client and a non-pivotal setups
**Note**: Don't change the org.pem, this is the key name set in the settings.yml.
```bash
docker run \
  -e FOREMAN_URL='https://foreman.change_domain.com' \
  -e CHEF_URL='https://chef.change_domain.com' \
  -e CHEF_ORG='change_myorg' \
  -e ORG_CLIENT='change_myclient' \
  -p 8000:8000 \
  -v /path/to/change_myclient.pem:/usr/src/proxy/chef/org.pem \
  -d hearstat/chef-smart-proxy
```

### Docker Compose

#### Dockerhub Image
```yaml
proxy:
  image: hearstat/chef-smart-proxy
  command: proxy_start
  environment:
    - FOREMAN_URL='https://foreman.domain.com'
    - CHEF_URL='https://foreman.domain.com'
    - CHEF_ORG='https://foreman.domain.com'
    - ORG_CLIENT='myclient'
  volumes:
    - /path/to/myclient.pem:/usr/src/proxy/chef/org.pem
  ports:
    - 8000:8000
```

#### Build Image
```yaml
proxy:
  build: .
  command: proxy_start
  environment:
    - FOREMAN_URL='https://foreman.domain.com'
    - CHEF_URL='https://foreman.domain.com'
    - CHEF_ORG='https://foreman.domain.com'
    - ORG_CLIENT='myclient'
  volumes:
    - /path/to/myclient.pem:/usr/src/proxy/chef/org.pem
  ports:
    - 8000:8000
```

### Automated Projects
Projects by Hearst Automation Team that use this Image

*   [The Foreman Cloudformation](https://github.com/HearstAT/cfn_foreman) **In Progress**
*   [The Foreman Docker Dev](https://github.com/HearstAT/docker_foreman_dev) **In Progress**
*   Docker Swarm **Coming Soon**

## Contributing
### External Contributors
-   Fork the repo on GitHub
-   Clone the project to your own machine
-   Commit changes to your own branch
-   Push your work back up to your fork
-   Submit a Pull Request so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!

### Internal Contributors
-   Clone the project to your own machine
-   Create a new branch from master
-   Commit changes to your own branch
-   Push your work back up to your branch
-   Submit a Pull Request so the changes can be reviewed

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!

## Credits
A lot of this project functionality is due to [https://github.com/shlomizadok/foreman-docker-compose](https://github.com/shlomizadok/foreman-docker-compose)

## License
MIT License

Copyright (c) 2017 Hearst Automation Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
