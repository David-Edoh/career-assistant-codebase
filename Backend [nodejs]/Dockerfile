FROM node:19
ENV PORT 8800
EXPOSE 8800

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json .
RUN npm install --production
COPY . .

CMD ["npm", "start"]
