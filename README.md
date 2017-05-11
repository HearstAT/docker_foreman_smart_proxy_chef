# Chef Multi-Org Foreman Smart Proxy
Dockerized Foreman Smart Proxy for Multiple Chef Organizations

## Table of Contents

*   [Info](#info)
*   [Usage](#usage)
*   [Development](#development)
*   [Contributing](#contributing)
*   [Credits](#credits)
*   [License](#license)

## Info
**Currently best suited for testing/dev purposes until automated alternative for pivotal pem is found**

*   Installs from Smart Proxy Git repo
*   Installs Smart Proxy Chef Plugin from Gem
*   Takes Environment Variables from Docker and creates configs based on those
*   Utilizes pivotal.pem for now, this will change in the future

## Usage

### Minimum
This container requires a few items to run appropriately

```bash
docker run \
  -e FOREMAN_URL='https://foreman.domain.com' \
  -e CHEF_URL='https://chef.domain.com' \
  -e CHEF_ORG='myorg' \
  -v /path/to/pivotal.pem:/usr/src/proxy/chef/pivotal.pem
  -d hearstat/chef-smart-proxy
```

### Compose Config

```yaml
proxy:
  image: hearstat/chef-smart-proxy
  command: proxy_start
  environment:
    - FOREMAN_URL='https://foreman.domain.com'
    - CHEF_URL='https://foreman.domain.com'
    - CHEF_ORG='https://foreman.domain.com'
  ports:
    - 8000:8000
```

### Automated Projects
Projects by Hearst Automation Team that use this Image

*   [The Foreman Cloudformation]() **In Progress**
*   [The Foreman Docker Compose]() **In Progress**

## Development

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
