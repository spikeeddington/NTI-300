#!/bin/bash
                                                                             
yum -y install python-pip                                                                      
pip install virtualenv                                                                         # install the virtual environment service
pip install --upgrade pip                                                                      # upgrade to the lastest version of pip
mkdir ~/newproject                                                                             # create the project directory
cd ~/newproject                                                                                # change to the project directory
virtualenv newenv                                                                              # create the new environment
source newenv/bin/activate                                                                     # activate the new environement (source newenv/bin/deactivate to kill it)
pip install django                                                                             # install django framework
django-admin --version                                                                         # output the version so that it is logged
django-admin startproject newproject                                                           # start the project
cd newproject/                                                                                 # change to the project directory
python manage.py migrate                                                                       
                                                                                              
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@newproject.com', 'pw123456')" | python manage.py shell
myip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')         
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'$myip\'\]/g" newproject/settings.py      
python manage.py runserver 0.0.0.0:8000                                                       
