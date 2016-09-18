# gjchen/php7@Dockerhub
Alpine Linux with nginx and php7-fpm configured.
* Base docker image: <a href="https://hub.docker.com/r/gjchen/alpine/" target="_blank">gjchen/alpine</a>.
* Branch base: automated build gjchen/php7:base, without any php extension installed yet.
* Branch master: automated build gjchen/php7:latest, mostly-using extensions installed.

Use enviornment variables to control php-fpm/php-cli (defaults) :
*  PHP_ERROR_LOG=syslog
*  PHP_LOG_ERRORS=1
*  PHP_DISPLAY_ERRORS=1
*  PHP_ERROR_REPORTING=-1
*  PHP_TIMEZONE="Asia/Taipei"
*  PHP_OPEN_SHORT_TAG=0
*  PHP_MAX_EXECUTION_TIME=30
*  PHP_MAX_INPUT_TIME=60
*  PHP_MEMORY_LIMIT=128M
*  PHP_CLI_MEMORY_LIMIT=512M
*  PHP_POST_MAX_SIZE=8M
*  PHP_UPLOAD_MAX_FILESIZE=2M
*  PHP_SESSION_NAME=PHPSESSID
*  PHP_SESSION_SAVE_HANDLER=files
*  PHP_SESSION_SAVE_PATH=/tmp
*  PHPFPM_LSITEN=127.0.0.1:9000
*  PHPFPM_USER=nobody
*  PHPFPM_GROUP=nobody
*  PHPFPM_PM=ondemand
*  PHPFPM_PM_MAX_CHILDREN=32
*  PHPFPM_PM_START_SERVERS=4
*  PHPFPM_PM_MIN_SPARE_SERVERS=2
*  PHPFPM_PM_MAX_SPARE_SERVERS=6
*  PHPFPM_PM_MAX_REQUESTS=16
  