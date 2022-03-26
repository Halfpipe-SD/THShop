# syntax=docker/dockerfile:1

FROM node:16

WORKDIR /app

RUN cd thshop-middleware

COPY package*.json ./

RUN npm install

COPY . .

ENV PORT=3000

EXPOSE 3000 

CMD ["npm", "run", "production"]