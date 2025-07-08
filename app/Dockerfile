# Etap 1: budowanie frontendu
FROM node:18 AS build

WORKDIR /app

COPY client ./client
RUN cd client && npm install && npm run build

# Etap 2: backend + zbudowany frontend
FROM node:18

WORKDIR /app

COPY --from=build /app/client/build ./client/build
COPY server.js ./
COPY package.json ./
RUN npm install

ENV PORT=8080
EXPOSE 8080

CMD ["node", "server.js"]
