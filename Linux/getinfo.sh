#!/bin/bash

# For the variable exporting to work, this script must be run as source;
# E.g:           . ./getinfo.sh
#      -or-
#           source ./getinfo.sh

echo "enter email for private and public keys"
read keys_email
echo "email for private and public keys: $keys_email"
echo ""

echo "enter password for vagrant"
read vagrant_pswd
echo "vagrant password: $vagrant_pswd"
echo ""

echo "enter password for root"
read root_pswd
echo "root password: $root_pswd"
echo ""

echo "enter password for mysql root"
read mysql_root_pswd
echo "mysql root password: $mysql_root_pswd"
echo ""

echo "enter password for mysql server"
read mysql_serv_pswd
echo "mysql server password: $mysql_serv_pswd"
echo ""

echo "enter your github username"
read github_un
echo "github username: $github_un"

#Six Variables
export keys_email vagrant_pswd root_pswd mysql_root_pswd mysql_serv_pswd github_un
