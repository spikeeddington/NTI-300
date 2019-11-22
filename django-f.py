#!/usr/bin/python

import os
import subprocess

def setup_install():
  print('Installing pip and virtualenv so we can give django its own version of python')
  os.system('yum -y install python-pip && pip install --upgrade pip')
  os.system('pip install virtualenv')
  os.chdir('/opt')
  os.mkdir('/opt/django')
  os.chdir('/opt/django')
  os.system('virtualenv django-env')
  os.system('adduser -M django && usermod -L django')

def local_repo():
    repo="""[local-epel]
name=NTI300 EPEL
baseurl=http://104.198.248.166//epel/
gpgcheck=0
enabled=1"""
    print(repo)
    with open("/etc/yum.repos.d/local-repo.repo","w+") as f:
      f.write(repo)
    f.close()
    on="enabled=1"
    off="enabled=0"
    with open('/etc/yum.repos.d/epel.repo') as f:
      dissablerepo=f.read().replace(on, off)
    f.close()
    with open('/etc/yum.repos.d/epel.repo', "w") as f:
      f.write(dissablerepo)
    f.close()

def django_install():
  print('Activating virtualenv and installing django after pre-reqs have been met')
  os.system('source /opt/django/django-env/bin/activate && pip install django')
  os.chdir('/opt/django')
  os.system('source /opt/django/django-env/bin/activate ' + \
    '&& django-admin --version ' + \
    '&& django-admin startproject project1' + \
    '&& chown -R django /opt/django')

def django_start():
  print('Starting django service')
  os.chdir('/opt/django/project1')
  os.system('source /opt/django/django-env/bin/activate ' + \
    '&& python manage.py migrate')
  os.system('source /opt/django/django-env/bin/activate && echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\'admin\',\'admin@project1.com\',\'NTI300NTI300\') | python manage.py shell')
  outputwithnewline = subprocess.check_output('curl -s checkip.dyndns.org | sed -e \'s/.*Current IP Address: //\' -e \'s/<.*$//\'', shell=True)
  print outputwithnewline
  output = outputwithnewline.replace("\n","")
  old_string = 'ALLOWED_HOSTS = []'
  new_string = 'ALLOWED_HOSTS = [\'{}\']'.format(output)
  print old_string
  print new_string
  with open('project1/settings.py') as f: newText=f.read().replace(old_string, new_string)
  with open('project1/settings.py', "w") as f: f.write(newText)
  f.close()
  os.system('sudo -u django sh -c "source /opt/django/django-env/bin/activate && python manage.py runserver 0.0.0.0:8000&"')

local_repo()
setup_install()
django_install()
django_start()
