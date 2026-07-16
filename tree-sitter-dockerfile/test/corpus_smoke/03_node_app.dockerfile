FROM node:20-slim
ENV NODE_ENV=production \
    PORT=3000
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
