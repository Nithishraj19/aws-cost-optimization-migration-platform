FROM node:22
WORKDIR /app
COPY app/package.json ./package.json
COPY app/src ./src
EXPOSE 3000
CMD ["node","src/server.js"]
