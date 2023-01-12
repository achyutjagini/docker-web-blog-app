# syntax=docker/dockerfile:1

# Pulling the latest python image
FROM python:latest

# Making a copy of the local app directory in the container for virtualisation
COPY /app /app

# Setting the working directory where all the commands will be run
WORKDIR /app

# Installing all the dependencies specified in requirements.txt
RUN pip3 install -r requirements.txt

# Exposing port 5001 on which the flask app will run on
EXPOSE 5001

# Command to run the flask app
CMD [ "python3", "app.py"]