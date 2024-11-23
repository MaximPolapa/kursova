# Базовий образ Node.js для створення збірки
FROM node:16 as build

# Встановлюємо робочу директорію
WORKDIR /app

# Копіюємо package.json і package-lock.json
COPY package*.json ./

# Встановлюємо залежності
RUN npm install

# Копіюємо всі файли проєкту у контейнер
COPY . .

# Збираємо оптимізовану версію програми
RUN npm run build

# Базовий образ для веб-сервера NGINX
FROM nginx:alpine

# Копіюємо згенеровану збірку до папки NGINX
COPY --from=build /app/dist /usr/share/nginx/html

# Відкриваємо порт 80 для HTTP
EXPOSE 80

# Запускаємо NGINX
CMD ["nginx", "-g", "daemon off;"]

