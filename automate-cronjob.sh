# automate the cron job

# add cronjob script
wget https://raw.githubusercontent.com/thomaskise/hello-nti-300/master/pagecontrols/updating_webpage.sh         # get updating_webpage.sh file from github
mv -f updating_webpage.sh /root/updating_webpage.sh                                                        # move updating_webpage.sh file to the proper directory
chmod +x /root/updating_webpage.sh                                                                               # make script executable

# add crontab
wget https://raw.githubusercontent.com/thomaskise/hello-nti-300/master/cronjob/crontab                     # get crontab file from github
mv -f crontab /var/spool/cron/root                                                                         # move crontab to the proper directory
crontab /var/spool/cron/root                                                                               # install crontab file
