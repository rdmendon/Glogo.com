#!/bin/bash
#preparando a maquina
sudo yum update -y
sudo yum install -y docker
sudo yum install git -y
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo chkconfig docker on
sudo pip install --upgrade pip
sudo pip install -U Flask
sudo pip install gunicorn
sudo pip install -U itsdangerous
sudo pip install -U Jinja2
sudo pip install -U MarkupSafe
sudo pip install -U Werkzeug

#baixando app
sudo yum install git -y
git clone https://github.com/rdmendon/SelecaoGlobo.com
mkdir richard-mendonca/app
mv api.py requirements.txt run_api.sh Dockerfile /home/ec2-user/SelecaoGlobo.com/richard-mendonca/app
chmod 775 /home/ec2-user/SelecaoGlobo.com/richard-mendonca/app
cd /home/ec2-user/SelecaoGlobo.com/richard-mendonca/app
chmod 775 *
docker build --tag richard:1.0 .
sudo docker run -d -p 8000:8000 richard:1.0


#Criando container
cd SelecaoGlobo.com/richard-mendonca/app
nohup gunicorn --log-level debug api:app &