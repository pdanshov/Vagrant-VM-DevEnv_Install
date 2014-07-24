#!/bin/bash
#echo "$1 $2 $3 $4 $5 $6 $7" &&
#echo $1 $2 $3 $4 $5 $6 $7 &&
#echo $1 && # keys_email
#echo $2 && # vagrant_pswd
#echo $3 && # root_pswd
#echo $4 && # mysql_root_pswd
#echo $5 && # mysql_serv_pswd
#echo $6 && # github_un
#echo $7 && #
sudo apt-get update
echo
echo
echo 1. Update Worked
echo
echo
sudo apt-get install -y libgtk2.0-0
echo
echo
echo 2. Installed libgtk
echo
echo
sudo apt-get install -y dbus-x11
echo
echo
echo 3. Installed x11
echo
echo
sudo apt-get install -y python-software-properties
echo
echo
echo 4. Installed python
echo
echo
sudo add-apt-repository ppa:webupd8team/sublime-text-2
echo
echo
echo 5. Added sublime repo
echo
echo
apt-get update
echo
echo
echo 6. apt-get update
echo
echo
sudo apt-get install -y sublime-text
echo
echo
echo 7. Installed Sublime
echo
echo
sudo ln -s /opt/sublime_text_2/sublime_text /bin/sublime
echo
echo
echo 8. Linked Sublime
echo
echo
#echo $1 >> .ssh/authorized_keys
echo
echo
echo 9. Var into auth_keys, passwd vagrant block next
echo
echo
#sudo passwd vagrant &&
#echo Rubyvm1.&&
#echo Rubyvm1.
#echo -e "Rubyvm1.\nRubyvm1." | (passwd --stdin vagrant)
echo -e "$2\n$2" | (passwd vagrant)
echo
echo
echo 10. Changed vagrant passwd, root passwd block next
echo
echo
#sudo passwd &&
#echo Rubyvmroot1.
#sleep 5s
#echo Rubyvmroot1.
#echo -e "Rubyvmroot1.\nRubyvmroot1." | (passwd --stdin $USER)
#echo "$USER:$3" | chpasswd
echo -e "$3\n$3" | (passwd root)
echo
echo
echo 11. Changed root passwd, git core block next
echo
echo
sudo apt-get install -y build-essential git-core
echo
echo
echo 12. Install curl next
echo
echo
sudo apt-get install -y curl
echo
echo
echo 13. Use curl next
echo
echo
curl -sSL https://get.rvm.io |bash -s stable
echo
echo
echo 14. Run rvm as source next
echo
echo
#source /home/vagrant/.rvm/scripts/rvm
source /usr/local/rvm/scripts/rvm
#source /etc/profile.d/rvm.sh
sleep 15
echo
echo
echo 15. Use rvm to install ruby next
echo
echo
rvm install ruby-1.9.3-p374
sleep 15
echo
echo
echo 16. Install rubygems next
echo
echo
sudo apt-get install -y rubygems
echo
echo
echo 17. If bundler block next
echo
echo
if gem list |grep --quiet bundler
then
 echo
 echo
 echo "18 .Bundler Exists, Continuing..."
 echo
 echo
else
 echo
 echo
 echo "18 .Bundler Doesn't Exist, Installing..."
 echo
 echo
 gem install bundler
fi
echo
echo
echo 19. Install Mysql next
echo
echo
sudo apt-get -y install mysql-client libmysql-ruby libmysqlclient-dev
#-------------------------Method 1------------------------------
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/$3 password $4'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/$3 password $4'
sudo DEBIAN_FRONTEND=noninteractive aptitude install -q -y mysql-server-5.5 mysql-server
# > /dev/null 2>&1
#export DEBIAN_FRONTEND=noninteractive
#sudo apt-get -y -f install
mysqladmin -u root password "$4"
#-------------------------Method 2------------------------------
#sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/$3 password $5'
#sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/$3 password $5'
#sudo apt-get -y install mysql-server-5.5 mysql-server
echo
echo
echo 20. ssh-keygen for github next
echo
echo
#y | ssh-keygen -t rsa -C "$1"
#mkdir ~/.ssh/authorize_keys
# The following two lines cause a password request for vagrant ssh
#mkdir /home/vagrant
#mkdir /home/vagrant/.ssh
ssh-keygen -t rsa -C "$1" -N "" -f /home/vagrant/.ssh/github_id_rsa
echo -e ""
#"~/.ssh/authorize_keys/github_id_rsa.pub" | ssh-keygen -t rsa -C "$1"
#echo -e "/home/vagrant/.ssh/github_id_rsa\n\n" | ssh-keygen -t rsa -C "$1"
#ssh-keygen -t rsa -C "$1" -N "" -f ~/.ssh/authorize_keys/github_id_rsa
echo
echo
echo "21. echo to config & chmod next"
echo
echo
sudo chmod 700 /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/github*
#chmod 0600 ~/.ssh/authorize_keys/github_id_rsa.pub
echo -e "  Host github.com\n      HostName github.com\n      IdentityFile ~/.ssh/github_id_rsa\n      User $6" > /home/vagrant/.ssh/config
sudo chmod 664 /home/vagrant/.ssh/config
echo
echo
echo 22. echo create scripts next
echo
echo
#cp config /home/vagrant/.ssh/config
#cp github_id_rsa /home/vagrant/.ssh/github_id_rsa
#cp github_id_rsa.pub /home/vagrant/.ssh/github_id_rsa.pub
#chmod 0600 /home/vagrant/.ssh/github_id_rsa
#echo
#cd /home/vagrant/.ssh
#touch config
#echo Host github.com HostName github.com IdentityFile ~/.ssh/github_id_rsa User "$6" >> /home/vagrant/.ssh/config
#cat .ssh/authorized_keys
#cat /home/vagrant/.ssh/config
#mail -s "NYCCT Tut Sys Git Authorization Request from: $6" pdanshv@gmail.com < /home/vagrant/.ssh/github_id_rsa.pub
#echo
#echo
#echo
echo -e "#!/bin/bash\nread -p \"\n\n\nWait until you receive confirmation that your github username and public key have been authorized and then press any key to continue...\n\n\n\necho -e \"yes\n\" | (git clone $6@github.com:ajwnycct/nycct-tutorial-tech-prod.git)\nsleep 5\ncd nycct-tutorial-tech-prod\ngit checkout develop\ncd ..\necho -e \"yes\n\" | (cd nycct-tutorial-tech-prod)\nbundle install\nsudo apt-get install -y nodejs\nmysql -u root -p$4 << EOF\ncreate database nycct_tutorial_development;\ncreate database nycct_tutorial_test;\ncreate database nycct_tutorial_production;\nquit\nEOF\nRAILS_ENV=development bundle exec rake db:migrate\nRAILS_ENV=development script/rails server" > /home/vagrant/setup_ror.sh
echo -e "#!/bin/bash\ncd nycct-tutorial-tech-prod\nsleep 5\nRAILS_ENV=development script/rails server" > /home/vagrant/start_ror.sh
chmod +x setup_ror.sh
chmod +x start_ror.sh

#echo -e "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEA4932zTGkoeelt3BO4WeGWaWZl3VJX9CCV9gnf2PPxNZIndZu\noejaQbQnraUQUQrX/omh6vMRYjfvDGxzvqVRCpW7A1V1vS04cgn6LgDKw5PGiTwP\n2ZvOXHEr/hk7zThk/0t8jwE1gcmdyaDzj9dTiaphA6P/gk+HzPcM40/JI026TOhE\nSeCEGV2LHT/b5Qt4SGbit8mVpnQKzgGKgs7XrJZ7ITNwGmujmOwdOIWEH9EusAxO\nkHK74oFfe7KeUoBchrXcUMlcbeLrLhXgds7CVxWK1sXidOkEHbxJwz+LqKtJ0s7U\nECKkIbCO4scXbw533OyIUd+zIr+celcrzAHqEwIBIwKCAQEA0FXo9h7CaCQ/vaiC\nojLD+jEBdIh9mW4uBywG2t7p2Ilm9rVsdsZD5EzxE8odi+yoOS1g1s+a3XT30Ngv\nTzgPlKYnU4FVtEaaAd08gdTWpC9WbtfT+igNIVGHTrf8KVgh03g3Xiz9uH3SF26V\nitN/k875nO22aIM6VP8hueKMAwOCjkmTxcYBS4B1b8IgCSSJL0XUT0/zQd/4b9qA\nLJ50++OmNbOGW2G9wTL1YM68PMESIRXncVNnfstBznaeqo0tIfU83ei1E7OLO7Gm\nxLD7gud6W7lSzgPEYGwykV4K9aXAimdoLiEXLK6vdskYupfhLh1/iHdBXN1Z7ExV\njDW7iwKBgQD8QVeggjDbpEL4nknIA+21L/dLkDEKt7CQbDC0NdPSM+4VEPhbXftF\nUZHQ/r0bJEUUyJ6rN9KwznDcBDELPm6+uqKwNGKipeFShflldfAa4Py4wLGtULTL\njKamN6fFJ6X5mzXxfv3V/6GRI29Z8pD5N05CKEzJ1w9aytIH0LcPkQKBgQDnP/Aq\nJ18XCoYSDLnA1x3NDLs28NkY3raCp3naHC21hSdoRX65yH12vAqP1+ZLGRjuEz2u\nNKzR4WIzfa/ViYc0bu7xibAzunU4XtIsmb0UXuukQcGCkuAZx59MPJjqhFgFoDfI\nnrCcyS/t1WvKcGdgWy4CrFB5zh4nVRGmafAVYwKBgFZ8zZYeAh9rhK0DEftvD6vV\n7mMM3Z1GSyozuO1USJ/XSlBdlvrBIvMx6Nnw8GETv+neYklU98eXPKM0oxnMQzoU\nGoWOTbQbnbXkyokvwAk3MhN1RDtsILrRIzGsroy9IvZ+W6NBe5nT/OFN+kq5kMp5\nXKj339AseksDtbmJY1XLAoGAO3bXW0vz4Vp6PyfX/mMzjH+d2u15p082PtqbrR0w\nUz9/KXD0s24RojBafMJ9C/8jqu8BO2yhd8w90rnrYsuXy6d/RWyMZRKwbZS5s7KB\nE93k0ndPBFGnVxYTBPmjqgTGLVUVqJ3VpKjDLodWO167fy1jmkmRCWDjLq95kTEv\nG3ECgYEA3ZlpdwQ/8Z7o9aSsLh4dUYasulVD+loA0V2ljfeJ65E9o7DpG5p09yXJ\nBB4uvzzkMGLc3Cb1nNoZE7osYDKw1Bb/jWLVFYY+fPG7Se7LgqEn2zwfid8rYLjH\nE28gUSA2AvvD9MLU4bvctwQcbFVDyBpZ606WL22656x9inGdOYU=\n-----END RSA PRIVATE KEY-----" > /home/vagrant/.ssh/github_id_rsa
echo
echo
echo
#echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA4932zTGkoeelt3BO4WeGWaWZl3VJX9CCV9gnf2PPxNZIndZuoejaQbQnraUQUQrX/omh6vMRYjfvDGxzvqVRCpW7A1V1vS04cgn6LgDKw5PGiTwP2ZvOXHEr/hk7zThk/0t8jwE1gcmdyaDzj9dTiaphA6P/gk+HzPcM40/JI026TOhESeCEGV2LHT/b5Qt4SGbit8mVpnQKzgGKgs7XrJZ7ITNwGmujmOwdOIWEH9EusAxOkHK74oFfe7KeUoBchrXcUMlcbeLrLhXgds7CVxWK1sXidOkEHbxJwz+LqKtJ0s7UECKkIbCO4scXbw533OyIUd+zIr+celcrzAHqEw== pdanshv@gmail.com" > /home/vagrant/.ssh/github_id_rsa.pub

BodyVar=$(cat /home/vagrant/.ssh/github_id_rsa.pub)

#echo -e "EHLO\nMAIL FROM: <$1>\nRCPT TO: <wilson.adam.james@gmail.com>\nDATA\nDate: $(date)\nTo: wilson.adam.james@gmail.com\nFrom: $1\nSubject: NYCCT Tut Sys Git Authorization Request from: $1\n$BodyVar\n.\nQUIT\n" | telnet gmail-smtp-in.l.google.com 25
echo
echo
echo 23. Emailing Git Key to Prof Wilsons Gmail Account
echo
echo

count=1
while [ $count = 1 ]; do
( echo open gmail-smtp-in.l.google.com 25
sleep 8
echo EHLO
sleep 2
echo "MAIL FROM: <$1>"
sleep 2
#echo "RCPT TO: <pdanshv@gmail.com>"
echo "RCPT TO: <wilson.adam.james@gmail.com>"
sleep 2
echo DATA
sleep 2
echo "Date $(date)"
sleep 2
#echo "To: pdanshv@gmail.com"
echo "To: wilson.adam.james@gmail.com"
sleep 2
echo "From: $1"
sleep 2
echo "Subject: NYCCT Tut Sys Git Authorization Request from: $1"
sleep 2
echo
echo
echo "$(date)"
echo
echo Public Key:
echo
echo
echo "$BodyVar"
echo
echo
echo "Please reply to $1, when the key is added to the repository."
echo
echo
sleep 5
echo .
sleep 5
echo QUIT ) | telnet &>> MailTestLog
count=2
done
echo $(date) >> MailTestLog

echo -e "_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=."
echo
echo
echo "                                     Done"
echo
echo
echo -e "_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=.,_,.=-^\`^-=."
echo
echo



