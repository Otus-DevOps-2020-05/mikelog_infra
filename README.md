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

    Данные для  Travis-CI
    ```
    bastion_IP = 84.201.152.107
    someinternalhost_IP = 10.129.0.21
    ```
