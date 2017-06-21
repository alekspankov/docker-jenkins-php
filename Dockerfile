FROM jenkins:2.46.3
MAINTAINER Alexander Pankov <ap@wdevs.ru>

USER root

COPY ./tools/composer.sh /tools/composer.sh

RUN printf "\ndeb http://packages.dotdeb.org jessie all\ndeb-src http://packages.dotdeb.org jessie all\n" >> /etc/apt/sources.list && \
    wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm dotdeb.gpg && \
    apt-get update -qq && apt-get upgrade -y && \
    apt-get install -y software-properties-common curl mc nano \
    php7.0-cli php7.0-intl php7.0-xsl php7.0-dom php7.0-zip php7.0-mbstring php7.0-mysql php7.0-gd php-pear && \
    chmod a+x /tools/composer.sh

RUN /tools/composer.sh && rm -rf tools

RUN mkdir -p /var/www && chown -R jenkins:jenkins /var/www

USER jenkins

COPY ./tools/jenkins_plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN composer global config minimum-stability dev && composer global config prefer-stable true && \
    composer global require phpunit/phpunit squizlabs/php_codesniffer \
    phploc/phploc pdepend/pdepend phpmd/phpmd sebastian/phpcpd \
    mayflower/php-codebrowser theseer/phpdox:dev-master
    
RUN cd /var/www && git clone https://github.com/alekspankov/php-jenkins.git && \
    mv /var/www/php-jenkins /var/www/default
