#This is a sample Image
# sudo docker build -t kiran1111/myimage:0.1.
# FROM ubuntu

# RUN apt-get update -y
# RUN apt-get install -y nginx
# CMD [“echo”,”Image created”]

# Use the Nginx image from Docker Hub
FROM nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Add a new Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the HTML file to the Nginx document root
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]


