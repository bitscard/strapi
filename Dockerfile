FROM node:16
# Installing libvips-dev for sharp Compatability
RUN mkdir -p /opt/app
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

RUN apt-get update && apt-get install libvips-dev -y

WORKDIR /opt/app
COPY package.json yarn.lock ./
ENV PATH /opt/app/node_modules/.bin:$PATH
RUN yarn install

COPY config /opt/app/config
COPY database /opt/app/database
COPY public /opt/app/public
COPY src /opt/app/src

RUN yarn build

EXPOSE 1337
#ENTRYPOINT ["tail", "-f", "/dev/null"]

CMD ["yarn", "start"]
