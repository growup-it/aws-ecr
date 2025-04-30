docker build -t your-docker-username/your-image-name:tag .

docker build -t myusername/myapp:latest .

docker login

docker push your-docker-username/your-image-name:tag

docker push myusername/myapp:latest


docker run -dp 127.0.0.1:9000:80 kiran11113/nginx-22-10-2024:v1.0