# Etap 1: build Reacta
FROM node:18 AS build

WORKDIR /app

COPY client/package*.json ./client/
RUN cd client && npm install

COPY client ./client
RUN cd client && npm run build

# Etap 2: uruchomienie Node.js backendu z Reactem
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install express mssql

COPY server.js ./
COPY --from=build /app/client/build ./client/build

ENV PORT=3000
EXPOSE 3000

CMD ["node", "server.js"]