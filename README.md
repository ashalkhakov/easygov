# Что это такое?

Это браузер Firefox, специально настроенный на работу с сайтом
[egov](http://egov.kz). Предназначен для Linux.

* корневые сертификаты НУЦ добавлены как доверенные
* NCAlayer установлен и запущен
* Firefox распознает сертификаты НУЦ как доверенные

# Как использовать

* Установите *Docker CE* для Linux. Инструкции для [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
* Скачайте образ, набрав в терминале: `docker pull ashalkhakov/easygov:latest`
* Запустите приложение с помощью команды:

``` shell
docker run -ti --rm \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $HOME:/user \
        --net=host \
        --ipc=host \
        ashalkhakov/easygov:latest $@
```

* Заходите на сайт [egov](http://egov.kz) в открывшемся окне
  браузера. Вы можете получить файлы из своей домашней директории в
  директории `/user` контейнера.


--Артём Шалхаков, artyom DOT shalkhakov AT gmail DOT com
