# Use a minimal base image
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /newapp

# Copy the application files into the container
COPY . /newapp

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Define environment variable
ENV NAME DevOps-V2.0

# Command to run the application
CMD ["python", "app.py"]
