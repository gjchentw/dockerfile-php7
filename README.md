# gjchen/php7@Dockerhub
**Alpine Linux** with *nginx* and *php7-fpm* configured.
* Base docker image: https://hub.docker.com/r/gjchen/alpine/

**gjchen/php7:base** for a minimal installation.

**gjchen/php7:laravel-base** for running laravel app.


Use enviornment variables to control php-fpm/php-cli (defaults) :
*  PHP_ERROR_LOG=syslog
*  PHP_LOG_ERRORS=1
*  PHP_DISPLAY_ERRORS=1
*  PHP_ERROR_REPORTING=-1
*  PHP_TIMEZONE="Asia/Taipei"
*  PHP_SHORT_OPEN_TAG=0
*  PHP_MAX_EXECUTION_TIME=30
*  PHP_MAX_INPUT_TIME=60
*  PHP_MEMORY_LIMIT=128M
*  PHP_CLI_MEMORY_LIMIT=512M
*  PHP_POST_MAX_SIZE=8M
*  PHP_UPLOAD_MAX_FILESIZE=2M
*  PHP_SESSION_NAME=PHPSESSID
*  PHP_SESSION_SAVE_HANDLER=files
*  PHP_SESSION_SAVE_PATH=/tmp
*  PHP_XDEBUG_HOST="172.17.0.1"
*  PHPFPM_LISTEN=127.0.0.1:9000
*  PHPFPM_USER=nobody
*  PHPFPM_GROUP=nobody
*  PHPFPM_PM=ondemand
*  PHPFPM_PM_MAX_CHILDREN=32
*  PHPFPM_PM_START_SERVERS=4
*  PHPFPM_PM_MIN_SPARE_SERVERS=2
*  PHPFPM_PM_MAX_SPARE_SERVERS=6
*  PHPFPM_PM_MAX_REQUESTS=16

**Xdebug**: 
* xdebug.ini is tuned for debuger running on docker host - 172.17.0.1
* Change PHP_XDEBUG_HOST for remote debugging
```ini
zend_extension="xdebug.so"
xdebug.profiler_enable = On
xdebug.remote_enable = On
xdebug.remote_port = 9000
xdebug.remote_handler = dbgp
xdebug.remote_host = ${PHP_XDEBUG_HOST}
```  
