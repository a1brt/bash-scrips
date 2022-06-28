#!/bin/bash:set number

function main(){
# check
  handle_args $@
  select_action
  exit 0
}

function select_action(){
  select mode in RESTORE BACKUP
  do 
    case $mode in
      RESTORE)
        restore 
        break
        ;;
      BACKUP)
        backup
        break
        ;;
      *)
        echo "Ivalid option $REPLY"
    esac
  done
}

# Check that mysql is installed 
function check(){
  which mysql
  if [ $? ne 0 ]; then
    echo "Please install MySQL before running this command"
    exit 1
  fi
}

function handle_args(){
  PARSED_ARGUMENTS=$(getopt -a -n percona_store -o hs:u: -l help,mysql-server:,mysql-user: -- "$@")
  eval set -- "$PARSED_ARGUMENTS"
  while :; do
    case $1 in 
     -h|--help)
        help
        exit
        ;;
     -s|--mysql-server)        
        SERVER=$2        
        log "server"
        shift 2
        ;;
     -u|--mysql-user)
        USER=$2
        log "user"
        shift 2
        ;;
     -p|--mysql-password)
        PASSWD=$2
        shift 2
        ;;
     -b|--s3bucket)
        BUCKET=$2
        shift 2
        ;;
     -d|--s3bucket-connection_details)
        DETAILS=$2
        shift 2
        ;;

     --)
        break;;
    esac
  done
}

function restore(){
  restore_check
}

function backup(){
  backup_check
}

function restore_check(){
  echo "restore checks"
}

function backup_check(){
  echo "backup checks"
}

function log(){
  echo "LOG: SQL $1 specifed"
}


###################################################################################################
# Help
function help(){
  echo "Usage: percona_store [OPTION]... [PARAMETER]"
  echo "percona_store is a script for making backups and restoring percona databases"
  echo "OPTIONS"
  echo "   -h|--help"
  echo "       display a manual for thi script"
}
###################################################################################################
main $@
