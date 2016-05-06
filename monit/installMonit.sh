apt-get install monit -y

cp monitrc.orig monitrc

default_lisk_location=~/lisk-0.2.1-Linux-x86_64

read -r -p "Who is your mail hoster? (ex: smtp.gmail.com): " response
sed -i "s|SMTP.MAILHOSTER.COM|$response|g" monitrc

read -r -p "What port do they use? (ex: 587): " response
sed -i "s|587|$response|g" monitrc

read -r -p "What is your email login? (ex: admin@admin.net): " response
sed -i "s|LoginUsername|$response|g" monitrc

read -r -p "What is your email password? (ex: passw1): " response
sed -i "s|LoginPassword|$response|g" monitrc

read -r -p "What is your email servers encryption? (ex: sslv3 or tlsv1): " response
sed -i "s|tlsv12|$response|g" monitrc

read -r -p "Where should emails show as coming from? (ex: liskmonitor@admin.net): " response
sed -i "s|SEND@MAILHOSTER.COM|$response|g" monitrc

read -r -p "What email do you want to recieve alerts at? (ex: myemail@gmail.com): " response
sed -i "s|RECEIVE@example.net|$response|g" monitrc

read -r -p "Where do you have lisk installed to? (Default $default_lisk_location):  " lisk_location
lisk_location=${lisk_location:-$default_lisk_location}
if [[ ! -r "$lisk_location" ]]
then
echo "$lisk_location is not valid, please check and re-excute"
exit 2

rm -rf /etc/monit/monitrc
cp ./monitrc /etc/monit/monitrc
chmod 700 /etc/monit/monitrc

/etc/init.d/monit status
/etc/init.d/monit restart

rm -rf /etc/monit/conf.d/checknode*
find ./check* -type f -exec  sed -i "s#lisk_home#$lisk_location#g" {} \;
cp checknodeprocess /etc/monit/conf.d/checknodeprocess
cp checknodelogs /etc/monit/conf.d/checknodelogs
cp checknodesize /etc/monit/conf.d/checknodesize
