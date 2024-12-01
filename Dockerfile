FROM node:22 as builder
WORKDIR /app
COPY . .
ARG VITE_API_URL
ENV VITE_API_URL $VITE_API_URL
RUN npm install
RUN npm run build

FROM nginx:1.25.4-alpine-slim as prod
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf  /etc/nginx/conf.d
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]