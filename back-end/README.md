# Expense Tracker

A Spring Boot application that manages personal expenses. It provides an API for the expenses flutter app.

## Running from docker (quickest)

Download docker-compose.yml (located at the root of the project)

Inside the folder with that file, run
```
docker-compose up
```

## Running from Intellij

* Install mysql
* Create the expenses database (see below)
* Import the project into Intellij. Since this is a maven project, it should configure everything automatically
* Go to the ExpensesDemoApplication.kt and run main

### Setup database
```
create database appatitec;

create user 'appatitec'@'localhost' identified by 'passwordappatitec';

grant all privileges on appatitec.* to 'appatitec'@'localhost';
```

## Technical notes

### Spring Security

There are two controllers with different security needs (web and api). See: https://www.youtube.com/watch?v=iJ2muJniikY for a good explanation
of spring security.

### Email

see https://www.youtube.com/watch?v=ugIUObNHZdo

### Building Docker Images

* mvn clean package
* docker buildx create --use (only first time)
* docker buildx build --platform linux/amd64,linux/arm64 --push -t pedroalv3s/spring-boot-expenses-demo:v0.0.1 . (tagged 0.0.1)
* docker buildx build --platform linux/amd64,linux/arm64 --push -t pedroalv3s/spring-boot-expenses-demo . (tagged latest)
* (test) docker run -p 8080:8080 pedroalv3s/spring-boot-expenses-demo (it will fail because it can't connect to mysql)
* (test) docker-compose pull  (to make sure you're not using a cache version)
* (test) docker-compose up 
* check [https://hub.docker.com/repository/docker/pedroalv3s/spring-boot-expenses-demo](https://hub.docker.com/repository/docker/pedroalv3s/spring-boot-expenses-demo) 