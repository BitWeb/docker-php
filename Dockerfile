FROM ubuntu:16.04
MAINTAINER Rain Ramm <rain@bitweb.ee>

# Install PHP 7
RUN apt-get update
RUN apt-get install -y php php-json php-curl php-gd php-xml php-zip php-intl

# Installs Git as a fallback for composer
RUN apt-get install -y git

# Download and verify Composer for dependency management
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --version=1.3.2 \
    && php -r "unlink('composer-setup.php');"
    
RUN apt-get clean
