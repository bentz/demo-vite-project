FROM node:16-alpine as builder
ARG CMD
WORKDIR /app
COPY package*.json ./
RUN npm config set registry https://registry.npm.taobao.org
RUN npm i
COPY . .
RUN node node_modules/esbuild/install.js
RUN ls -al
RUN ${CMD}

FROM steebchen/nginx-spa
COPY --from=builder /app/dist/ /app
EXPOSE 80
CMD ["nginx"]