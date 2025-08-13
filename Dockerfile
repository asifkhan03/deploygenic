FROM rockylinux/rockylinux:8.10
LABEL maintainer="Asif"

RUN yum install -y httpd zip unzip curl


ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

WORKDIR /var/www/html/

RUN curl -L -o /var/www/html/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

RUN cd /var/www/html/ && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

CMD ["httpd", "-D", "FOREGROUND"]

EXPOSE 80 443