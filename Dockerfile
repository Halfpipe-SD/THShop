# syntax=docker/dockerfile:1

FROM node:16

WORKDIR /app

COPY thshop-middleware/package*.json ./

RUN npm install

COPY thshop-middleware .

ENV PORT=3000

EXPOSE 3000 

CMD ["npm", "run", "production"]