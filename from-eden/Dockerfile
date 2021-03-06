#################################################
# Dockerfile to python Application Containers
# Based on centos66
#################################################
FROM centos:6.6

# File Author / Maintainer
MAINTAINER edenhuang@truetel.com

#**********************************
#* Override Enabled ENV Variables *
#**********************************
ENV MYSQL_PASS P@ssw0rd
ENV MYSQL_DB tctas
ENV MYSQL_CLIENTADDR %
ENV APP_USER tasadm
ENV APP_PASS tasadm

# default port
ENV MIB_PORT  6500
ENV WEB_PORT  6600

RUN yum clean all && \
yum -y update && \
# yum -y groupinstall "Development tools" && \
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel  && \
yum -y install sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel && \
yum -y install make automake gcc gcc-c++ kernel-devel git-core && \
yum -y install wget tar sudo hg unzip && \
yum -y install openssh* && \
# Install MySQL
yum -y localinstall http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm && \
yum -y install mysql-community-server && \
yum -y install mysql-community-devel && \
rm -fr /var/cache/*

#**************************
#*   Add Required Files   *
#**************************
ADD requirements.txt /usr/local/src/requirements.txt

# Install python
RUN wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz && \
tar -zxf Python-2.7.10.tgz && \
cd Python-2.7.10 && \
./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
make && make altinstall && \
rm -f Python-2.7.10.tgz && \
rm -rf Python-2.7.10
# Install ezsetup and pip
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | /usr/local/bin/python2.7 && \
/usr/local/bin/easy_install-2.7 pip && \
# Install python plugin
/usr/local/bin/pip install --upgrade pip && \
/usr/local/bin/pip install -r /usr/local/src/requirements.txt && \
/usr/local/bin/pip install https://pypi.python.org/packages/source/p/python-smpp/python-smpp-0.1.5.tar.gz && \
/usr/local/bin/easy_install-2.7 path.py && \
/usr/local/bin/easy_install-2.7 prettytable && \
wget https://pypi.python.org/packages/source/M/MySQL-python/MySQL-python-1.2.5.zip#md5=654f75b302db6ed8dc5a898c625e030c && \
ln -s /usr/lib64/libmysqlclient_r.so.16.0.0 /usr/lib64/libmysqlclient_r.so && \
unzip MySQL-python-1.2.5.zip && \
cd MySQL-python-1.2.5 && \
python2.7 setup.py install && \
cd / && \
rm -f MySQL-python-1.2.5.zip && \
rm -rf MySQL-python-1.2.5
# Create docker account
# RUN adduser --disabled-password --gecos "" --gid 1000 tasadm
RUN useradd docker && echo "docker:docker" | chpasswd && \
# echo 'docker    ALL=(ALL)   NOPASSWD:ALL' >> /etc/sudoers
echo 'docker    ALL=(ALL)   NOPASSWD:ALL' >> /etc/sudoers && \
# install vi
echo "/usr/local/lib" >> /etc/ld.so.conf && \
hg clone https://vim.googlecode.com/hg/ vim && \
cd /vim/src && \
ldconfig && \
export vi_cv_path_python=/usr/local/bin/python2.7 && \
export vi_cv_path_python_pfx=/usr/local && \
./configure --enable-pythoninterp --with-features=huge --with-python-config-dir=/usr/local/lib/python2.7/config && \
make && make install

RUN echo "/usr/local/lib" >> /etc/ld.so.conf && \
echo "alias vi='/usr/local/bin/vim'" >> ~/.bashrc && \
echo "alias vi='/usr/local/bin/vim'" >> /home/docker/.bashrc && \
echo "ldconfig" >> ~/.bashrc && \
echo "sudo ldconfig" >> /home/docker/.bashrc

#************************
#* Post Deploy Clean Up *
#************************
ADD my.cnf /etc/
ADD mysql_setup.sql /tmp/
ADD vim-plugin.tar.gz /home/docker/

#**************************
#*  Config Startup Items  *
#**************************

# Make TASHOME and add TAS tar file
RUN mkdir -p /home/docker/tashome
ADD  tasprod-TAS-OFF-R6V4P4-jboss-20160120-0938.tar.gz /home/docker/tashome/
ADD tasrtenv.sh /home/docker/tashome/
ADD tctools.tar.gz /
RUN chown -R docker:docker /home/docker

RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
RUN service mysqld start  && mysql -u root < /tmp/mysql_setup.sql && service mysqld stop

# for Dynamicly change web port
RUN echo 'sed -i "s/6600/${WEB_PORT}/g" /home/docker/tashome/tasrtenv.sh' >> /home/docker/.bashrc && \
echo 'source ~/tashome/tasrtenv.sh' >> /home/docker/.bashrc

# for TAS first time run
ADD tasdbinit.sh /tmp/
RUN chmod 755 /tmp/tasdbinit.sh
RUN service mysqld start  && su - docker -c ". ~/tashome/tasrtenv.sh;export TAS_IS_PRODUCTION=false;/tmp/tasdbinit.sh" && service mysqld stop
RUN su - docker -c ". ~/tashome/tasrtenv.sh;taspatch.sh"

# for Auto Start Mysql and TAS
RUN echo 'sudo service mysqld start' >> /home/docker/.bashrc && \
echo 'tasstart.sh -nl' >> /home/docker/.bashrc  && \
chmod 755 /home/docker/.bash*

# ADD .bashrc /home/docker/
# RUN chown -R docker:docker /home/docker
# ADD rc.local /etc/rc.local
# RUN chmod 755 /etc/rc.local

# VOLUME ["/var/lib/mysql"]
# VOLUME ["/run/mysqld"]
# VOLUME ["/home/docker/tashome"]

#CMD service mysqld start && su - tasadm -c ". ~/tashome/tasrtenv.sh;tasstart.sh -nl"
# ENTRYPOINT /etc/rc.local
USER docker
WORKDIR /home/docker/tashome
# CMD []
# ENTRYPOINT ["/env/bin/python", "/app/main.py"]

CMD /bin/bash

#****************************
#* Expose Applicatoin Ports *
#****************************
# Expose ports to other containers only

EXPOSE 6600
EXPOSE 3306
EXPOSE 22
