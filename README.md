1. Вход на хосты локальной сети через бастион:
-   Команда
    ```
    ssh -i ~/.ssh/shh_private_key userName@bastion_ip -A -t ssh -t local_ip
    ```
    Чтобы не мучиться и не запоминать ip адреса  хостов, то можно настроить аллиасы:
    a) Редактируем  ~/.ssh/config и приводим к такому виду:
    ```
    Host someinternalhost
    HostName 10.132.0.3
    User userName
    ProxyCommand ssh userName@35.210.90.82 -W %h:%p
    IdentityFIle ~/.ssh/id_rsa_remotesystem
    ```
    После внесенных изменений достаточно выполнить
    ```
    ssh someinternalhost
    ```
    чтобы попать по аллиасу в локальную сеть.

    b) Откройте файл ~/.bashrc или ~/.bash_profile (в случае ZSH - ~/.zshrc )  и впишите туда:
    ```
    alias someinternalhost='ssh -i ~/.ssh/id_rsa_remotesystem -A remote_user_name@bastion_IP -A -t ssh -t internal_IP'
    ```
    После этого, в баш оболочке будет достаточно набрать
    ```
    someinternalhost
    ```
    и нажать  Enter

# Установка pritunl
Скачиваем:
```
wget https://github.com/Otus-DevOps-2020-05/mikelog_infra/blob/cloud-bastion/setupvpn.sh
````
Выставляем права
```
chmod +x setupvpn.sh
```
Выполняем:
```
./setupvpn.sh
```
После выполнения будет выдана информация, например:
```
Managament inerface:
https://84-201-152-107.sslip.io

Let's encrypt domain for FINE SSL !!!
84-201-152-107.sslip.io
```
Где **84-201-152-107.sslip.io**  это параметр необходимый для работы веб интерфейса по   https



    Данные для  Travis-CI
    ```
    bastion_IP = 84.201.152.107
    someinternalhost_IP = 10.129.0.21
    ```
# Работа с  yacloud cli и деплой тестового приложения
Создание  ВМ из  CLI с автоматическим выполнением набора команд:
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=metadata.yml \
  --metadata serial-port-enable=1
```
user-data=metadata.yml - указываем, что считывать параметры и инструкции к выполнению необходимо из файла  [metadata.yml](./metadata.yml)
[metadata_v2.yml](./metadata_v2.yml) предоставляет другой вариант исполнения скрипта при старте

Данные для  Travis-CI
```
testapp_IP=130.193.38.188
testapp_port=9292
```
