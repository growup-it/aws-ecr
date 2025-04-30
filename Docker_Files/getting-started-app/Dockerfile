# Ref: https://docs.docker.com/get-started/02_our_app/

# syntax=docker/dockerfile:1
# docker build -t getting-started .  --- to build the image
# docker run -dp 127.0.0.1:3000:3000 getting-started

FROM node
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000

