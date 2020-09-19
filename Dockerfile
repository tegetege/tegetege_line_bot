# copy from https://github.com/kakuemon/capture-tuna-bot-with-parrot/blob/master/Dockerfile.sample

# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7-slim

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget build-essential gcc zlib1g-dev

# Copy local code to the container image.
ENV APP_HOME /app
ENV YOUR_CHANNEL_ACCESS_TOKEN ${YOUR_CHANNEL_ACCESS_TOKEN}
ENV YOUR_CHANNEL_SECRET ${YOUR_CHANNEL_SECRET}

WORKDIR $APP_HOME
COPY . ./

# mecab
RUN apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8

# Install production dependencies.
RUN pip install -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :8080 --workers 1 --threads 8 --timeout 0 main:app
# CMD python main.py
