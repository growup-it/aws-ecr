## Steps
    first build docker image using : docker build -t my-flask-app:v1.0 .
    Run container : docker run -p 5000:5000 my-flask-app

# docker run -p 5000:5000 -e NAME=devopsrttnew my-flask-app
you can pass environment variables to your Docker container during runtime.


