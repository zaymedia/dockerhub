# Dockerhub

## Запуск на локальной машине
- Запустить команду: make init
- Открыть сервер по пути: localhost:9000
- Логин/пароль для входа: dockerhub/dockerhub

## Установка через Ansible на production
1. Создать файл hosts.yml по примеру из provisioning/hosts.yml.dist
2. Добавить свои A записи в DNS для доменов dockerhub.zay.media и cache-dockerhub.zay.media
3. Заменить все вхождения dockerhub.zay.media и cache-dockerhub.zay.media на свои домены из пункта 2
4. Установить ansible на локальный компьютер:
    1. brew install ansible
    2. brew install ansible-lint
    3. brew link ansible
5. Перейти в папку provisioning (cd provisioning/)
6. Запустить команду: make server 
7. Если возникнет ошибка "Permission denied (publickey,password)", запустить команду: ssh-copy-id -i ~/.ssh/id_rsa.pub root@**_HOST_**
8. Если возникнет ошибка на этапе с "Add Certbot repository" - нужно перейти на Debian 10
9. Запустить команду для добавления ssh ключа для пользователя deploy: make authorize
10. Вернуться в папку выше (cd ../)
11. Сгенерировать пароль для доступа командой: docker run --rm registry:2.6 htpasswd -Bbn YOUR_LOGIN YOUR_PASSWORD > htpasswd
12. Запустить deploy командой: HOST=**_HOST_** PORT=22 make deploy
13. Если ошибка с 80 портом, то перезагрузить сервер