FROM node:20-alpine

RUN npm install -g serve

WORKDIR /app

EXPOSE 8080

CMD ["serve", "-l", "8080", "."]
