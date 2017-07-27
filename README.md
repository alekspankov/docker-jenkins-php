Jenkins + PHP 7.0
=================

Current version: 0.3.1
Base image: [jenkins/jenkins lts](https://hub.docker.com/r/jenkins/jenkins/)

## Install

1. Pull image ```docker pull aleksxp/jenkins-php```



---

## Rebuild image 

If you want to rebuild image, run:

```
git clone https://github.com/alekspankov/docker-jenkins-php.git
cd docker-jenkins-php
docker build -t your/image:tag .
```

### Set executors number

Executors number is set to **1** by default. To change it:

1. Open file _tools/executors.groovy_
2. Edit executors in line 2: ```Jenkins.instance.setNumExecutors(1)``` (replace 1 by needed number)

## Authors

* **Alexander Pankov** <ap@wdevs.ru>

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details