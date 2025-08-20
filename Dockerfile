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

# Fix CentOS 8 repo issues
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Update system and SSL libs (fixes curl TLS issue)
RUN yum -y update nss curl libcurl ca-certificates && \
    yum -y install java httpd zip unzip curl && \
    yum clean all

# Set working directory
WORKDIR /var/www/html/

# Download & extract template
RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip \
    && unzip photogenic.zip \
    && cp -rvf photogenic/* . \
    && rm -rf photogenic photogenic.zip

# Expose port
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

