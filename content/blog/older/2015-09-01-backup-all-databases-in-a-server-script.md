---
author: Mansoor A
date: "2015-09-01T19:51:39Z"
description: ""
draft: false
title: How To Backup All Databases in MySQL [ Script ]
url: blog/backup-all-databases-in-a-server-script
---


Hello Guys,

This is a simple bash script I wrote to dump all the databases ( excluding `information_schema` and `mysql`. I thought I'd share it with you. Someone might find it useful, others might find it silly 😀 But, anyway, here it is

```
#!/bin/bash

# Checking if the /root/.my.cnf file exists or not

if [[ ! -f /root/.my.cnf ]]
then
        echo "/root/.my.cnf does not exist"
        echo "Did not dump any db. Exiting"
        exit
fi

dbs=$(mysql -e "SHOW DATABASES" | sed '1d')
mkdir -p dumped_dbs/
for i in $dbs
do
        if [[ "$i" != "mysql" ]] && [[ "$i" != "information_schema" ]]; then
                echo "Dumping $i to dumped_dbs/${i}.sql"
                mysqldump $i > dumped_dbs/${i}.sql
        fi
done

count=$(ls dumped_dbs/ | wc -l)
echo "============================="
echo "DONE! Dumped $count databases"
```


While running the script, if you get the error saying `/root/.my.cnf` does not exist, then you need to create that file with the following content

```
[client]
user=root
password=your_mysql_password
```

This is the cnf file that helps us to run MySQL without having to type in the MySQL root password. Once the databases are dumped, you can find individual dumps under the folder `dumped_dbs`

