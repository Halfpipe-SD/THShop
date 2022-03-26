# syntax=docker/dockerfile:1

FROM node:16 
WORKDIR /app

COPY thshop-middleware/package*.json ./
COPY thshop-middleware/tsconfig.json ./

RUN npm install --production

COPY thshop-middleware .

ENV PORT=3333

EXPOSE 3333 

CMD ["npm", "run", "prod"]