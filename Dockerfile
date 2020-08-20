FROM dotriver/drupal

ENV CIVICRM_DB_NAME=civicrm \
    CIVICRM_DB_USERNAME=civicrm \
    CIVICRM_DB_PASSWORD=password \
    CIVICRM_VERSION=5.14.1

RUN apk add --no-cache wkhtmltopdf xvfb xauth fontconfig ttf-freefont coreutils curl imagemagick php7-bcmath php7-intl \
    && echo 'xvfb-run --server-args="-screen 0, 1024x768x24" -a /usr/bin/wkhtmltopdf $*' > /usr/local/bin/wkhtmltopdf \
    && chmod a+rx /usr/local/bin/wkhtmltopdf

RUN mkdir -p /opt/ressources/ \
    && curl -s -L https://download.civicrm.org/civicrm-${CIVICRM_VERSION}-drupal.tar.gz --output /opt/ressources/civicrm.tgz \
    && curl -s -L https://download.civicrm.org/civicrm-${CIVICRM_VERSION}-l10n.tar.gz --output /opt/ressources/civicrm-l10n.tgz \
    && curl -s -L https://ftp.drupal.org/files/projects/betterlogin-7.x-1.5.tar.gz --output /opt/ressources/betterlogin.tar.gz \
    && curl -s -L https://raw.githubusercontent.com/civicrm/civicrm-drupal/7.x-master/drush/civicrm.drush.inc --output /opt/ressources/civicrm.drush.inc

ADD conf/ /


RUN set -x \
    && chmod +x /usr/local/bin/* \
    && chmod +x /etc/cont-init.d/* \
    && chmod +x /etc/s6/services/*/* \
    && chmod +x /etc/periodic/*/*