FROM php:7.0.32-apache-jessie
#RUN apt-get update \
#RUN apt-get install php-pclzip  -y \
#&& systemctl restart apache2
RUN echo "" > /etc/apt/sources.list \
&& echo "deb http://ftp.debianclub.org/debian jessie main" >> /etc/apt/sources.list \
&& echo "deb http://ftp.debianclub.org/debian-security jessie/updates main" >> /etc/apt/sources.list \
&& echo "deb http://ftp.debianclub.org/debian jessie-updates main" >> /etc/apt/sources.list
RUN apt-get update \
# && apt-get install libpng-dev -y \
&& apt-get install libz-dev -y  \
&& apt-get install libzip-dev -y  \
&& apt-get install libmagickwand-dev -y \
&& pecl install zip \
&& pecl install imagick \
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
# RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
# RUN docker-php-ext-install gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-enable zip imagick
# RUN docker-php-ext-enable mysqli #
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN usermod -u 1000 www-data

#php70:0 #work