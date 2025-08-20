# FROM python:3.10-slim

# LABEL maintainer="Asif"

# WORKDIR /app

# COPY requirements.txt requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# EXPOSE 5000

# CMD ["python", "app.py"]
FROM ubuntu:20.04
LABEL maintainer="Asif"

# Avoid interactive tzdata prompt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install required packages
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    apache2 \
    zip \
    unzip \
    curl \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

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
CMD ["apache2ctl", "-D", "FOREGROUND"]
