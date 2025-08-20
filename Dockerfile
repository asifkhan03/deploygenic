# FROM python:3.10-slim

# LABEL maintainer="Asif"

# WORKDIR /app

# COPY requirements.txt requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# EXPOSE 5000

# CMD ["python", "app.py"]

FROM centos:8
LABEL maintainer="Asif"

# Fix CentOS repo issue
RUN cd /etc/yum.repos.d/ \
 && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install packages
RUN yum -y install java httpd zip unzip curl

# Set working directory
WORKDIR /var/www/html/

# Download template safely with curl
RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip \
 && unzip photogenic.zip \
 && cp -rvf photogenic/* . \
 && rm -rf photogenic photogenic.zip

# Start Apache
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
