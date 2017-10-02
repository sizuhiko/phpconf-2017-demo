FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:ondrej/php && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
# install php requirements
RUN apt-get update && \
apt-get install -y php7.1-cli \
  php7.1-intl \
  php7.1-mcrypt \
  php7.1-mysql \
  php7.1-curl \
  php7.1-sqlite3 \
  php7.1-xsl \
  php7.1-common \
  php7.1-bz2 \
  php7.1-mbstring \
  php7.1-zip \
  php7.1-json \
&& apt-get clean -y

# Create a Jenkins "HOME" for composer files.
RUN mkdir -p /home/jenkins/composer
RUN chown -R jenkins:jenkins /home/jenkins

# Install composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/  --filename=composer

# Go back to jenkins user.
USER jenkins

# Setting composer.
RUN composer config -g repositories.packagist composer https://packagist.jp
RUN composer global require hirak/prestissimo

# install Jenkins plugins
RUN /usr/local/bin/install-plugins.sh checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit slack junit
RUN /usr/local/bin/install-plugins.sh git-client scm-api git bitbucket publish-over-ssh htmlpublisher workflow-aggregator ansicolor lockable-resources pipeline-milestone-step
