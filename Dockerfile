# Используем официальный образ OpenJDK для создания Docker-образа
FROM openjdk:17

# Создаем директорию для приложения
WORKDIR /usr/src/app/

# Копируем Gradle-конфигурацию
COPY build.gradle .
COPY settings.gradle .

# Копируем gradle wrapper
COPY gradlew .
COPY gradle gradle

# Загружаем зависимости Gradle
RUN ./gradlew build

# Копируем исходный код
COPY src src

# Копируем JAR-файл после сборки
COPY build/libs/*.jar app.jar

# Экспонируем порт, на котором работает приложение
EXPOSE 8080

# Команда для запуска приложения при старте контейнера
CMD ["java", "-jar", "app.jar"]
