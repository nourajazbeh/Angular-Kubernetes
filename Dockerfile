FROM node:lts-alpine as build
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build
FROM nginx:alpine as production
COPY --from=build /app/dist/k8s-app/browser/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
