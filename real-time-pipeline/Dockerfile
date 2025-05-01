FROM python:3.13.3-slim-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jre-headless \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Seting up JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Setting up working directory
WORKDIR /app

# Copying requirements file
COPY requirements.txt .

# Installing pip requirements
RUN pip install --no-cache-dir -r requirements.txt

# Defining environment variables
ENV PYTHONPATH=/app:$PYTHONPATH