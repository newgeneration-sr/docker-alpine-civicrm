![docker build automated](https://img.shields.io/docker/cloud/automated/dotriver/civicrm)
![docker build status](https://img.shields.io/docker/cloud/build/dotriver/civicrm)
![docker build status](https://img.shields.io/docker/pulls/dotriver/civicrm)

# CiviCRM 5.14.1 + Drupal 7

Civicrm documentation [here](https://docs.civicrm.org/) ([fr](https://doc.symbiotic.coop/))

# Auto configuration parameters :

Same as drupal 7 image :

- DATABASE_HOST=localhost       ( Name of the mariadb service )
- DATABASE_PORT=3306            ( Port of the mariadb service )
- DRUPAL_DB_NAME=drupal         ( Name of the drupal database )
- DRUPAL_DB_USERNAME=drupal     ( Username to connect to the drupal database )
- DRUPAL_DB_PASSWORD=password   ( Password to connect to the drupal database )
- ADMIN_USERNAME=admin          ( Drupal admin username )
- ADMIN_PASSWORD=password       ( Drupal admin password )
- ADMIN_EMAIL=admin@exemple.org ( Drupal admin email )
- SITE_NAME="drupal"            ( Drupal site name )
- TRUSTED_HOST=localhost        ( Drupal trusted domain )

New parameters :

- CIVICRM_DB_NAME=civicrm       ( Name of the civicrm database )
- CIVICRM_DB_USERNAME=civicrm   ( Username to connect to the civicrm database )
- CIVICRM_DB_PASSWORD=password  ( Password to connect to the civicrm database )
- CIVICRM_NO_CRON=YES           ( Disable Cron for test instances )

# Compose file exemple

```
version: '3'

services:

  civicrm:
    image: dotriver/civicrm
    environment:
      - DATABASE_HOST=mariadb
      - DATABASE_PORT=3306
      - DRUPAL_DB_NAME=drupal
      - DRUPAL_DB_USERNAME=drupal
      - DRUPAL_DB_PASSWORD=password
      - CIVICRM_DB_NAME=civicrm
      - CIVICRM_DB_USERNAME=civicrm
      - CIVICRM_DB_PASSWORD=password
      - SITE_EMAIL=email@example.com
      - TRUSTED_HOST=172.17.0.1:8080
      - ADMIN_USERNAME=admin
      - ADMIN_PASSWORD=password
      - ADMIN_EMAIL=admin@example.com
    ports:
      - 8080:80
    volumes:
      - civicrm-data:/var/www/drupal/
    networks:
      default:
    
  mariadb:
    image: dotriver/mariadb
    environment:
      - ROOT_PASSWORD=password
      - DB_0_NAME=drupal
      - DB_0_PASS=password
      - DB_1_NAME=civicrm
      - DB_1_PASS=password
    ports:
      - 3306:3306
      - 8081:80
    volumes:
      - mariadb-data:/var/lib/mysql/
      - mariadb-config:/etc/mysql/
    networks:
      default:
    
volumes:
    civicrm-data:
    mariadb-data:
    mariadb-config:
    
```