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

# Создание кастомного образа для YA Cloud

1. Подготовлено два файла конфигурации для  packer:
ubuntu16.json - параметризированный конфиг, для создания кастомного образа в я.облаке. Параметры задаются в файле variables.json. Для "запекания" образа с параметрами  синтаксис команды *packer build -var-file=./variables.json ubuntu16.json*

immutable.json - параметризированный конфиг, для создания кастомного образа в я.облаке, с деплоем приложения. В консоли я.облако, достачно создать ВМ и подключить загрузочный диск с именем reddit-full-*(последний по штампу времени). Параметры задаются в файле variables.json. Для "запекания" образа с параметрами  синтаксис команды *packer build -var-file=./variables.json  immutable.json*

2. Создан скприп, по развертыванию ВМ из командной строки, на основе образа, "запеченого"  packer`ом *reddit-full*

# Терраформ, этап 1.

1. Создал декларативное описание инициализации ресурсов и инфрасктуры, с провижингом приложения.
2. Параметризовал декларативное описание инициализации ресурсов и инфрасктуры.
3. Описал создание балансировщика, который прокидывает трафик на столько инстансов, сколько было создано.
4. Параметризовал количество создаваемых инстансов, переменная  **inst_cnt**
6. При дублировании описания инстанса для запуска нескольких инстансов, есть проблема в расползании конфгурации, увеличение точек отказа изза ошибок человеческого фактора, неудобочитаемость кода.

# Терраформ, этап 2.

1. Разбиение декларативного описания ресурсов и ифраструктуры  на модули.
2. Переиспользование модулей на разных средах(stage, prod).
3. Вынос  tfstate  в бакет, для совместного использования терраформ.
4. Передача параметров между модулями, сервис приложения подключается к БД, передаваемой параметром **DATABASE_URL**
