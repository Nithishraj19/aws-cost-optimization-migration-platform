FROM node:22-alpine
ENV NODE_ENV=production PORT=3000
WORKDIR /app
COPY --chown=node:node app/src ./src
USER node
EXPOSE 3000
CMD ["node","src/server.js"]
