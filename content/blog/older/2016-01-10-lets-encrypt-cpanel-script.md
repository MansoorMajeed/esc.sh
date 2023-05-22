---
author: Mansoor A
date: "2016-01-10T23:04:28Z"
description: ""
draft: false
title: '[Script] How to set up Let''s Encrypt in cPanel/WHM ( Centos 6.x / 7.x )'
url: blog/lets-encrypt-cpanel-script
---


Let's be quick and clear. If you're here, you don't need a preface for Let's Encrypt. You probably know how awesome it is. So today I'll show you guys how to quickly and easily setup let's encrypt in your cPanel server, and install SSL certificates for your domains with ease. Please note that you need a dedicated server/VPS for this. Shared hosting is not supported. So, let's get started

 

### Setting up Let's Encrypt

#### For Centos 6.x

The thing about CentOs 6.x is it comes with Python 2.6 where as Let's Encrypt supports Python 2.7+ only. But, installing Python 2.7 in Centos 6.x is pretty simple.

##### Installing Python 2.7 in cPanel ( Centos 6.x )

This step is only for Centos 6.x only

```# Install Epel Repository
yum install epel-release

# Install IUS Repository
rpm -ivh https://rhel6.iuscommunity.org/ius-release.rpm

# Install Python 2.7 and Git
yum --enablerepo=ius install git python27 python27-devel python27-pip python27-setuptools python27-virtualenv -y
```

Make sure that the installation was successful.

```
which python2.7

# The above command should display : /usr/bin/python2.7
```

So , now we know that Python 2.7 is installed properly.

#### The following steps are common for CentOs 6.x and 7.x

```
# Install Git
yum -y install git

cd /root

# Clone the letsencrypt Repo

git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt

# Run the letsencrypt script
./letsencrypt-auto --verbose
```

This will take few minutes. At the end, you will probably receive a message like _"No installers are available on your OS yet"_

That's it, you're ready to retrieve SSL certificates for your domains. Issue the following command to retrieve an SSL certificate for your domain "example.com"

> Note: I have made a simple php script to automate the installation and retrieval of SSL certificates, feel free to skip to that part

```
./letsencrypt-auto --text --agree-tos --email you@example.com certonly --renew-by-default --webroot --webroot-path /home/username/public_html/ -d example.com -d www.example.com
```

It's pretty simple, isn't? Now, you will receive something like the following

> Congratulations! Your certificate and chain have been saved at
  
> /etc/letsencrypt/live/example.com/fullchain.pem. Your cert will
  
> expire on 2016-04-08. To obtain a new version of the certificate in
  
> the future, simply run Let's Encrypt again.

You can find your certificate and key under /etc/letsencrypt/live/example.com/.

Now you have to install the certificates from the cPanel/WHM interface.

#### Automating SSL certificate installation in cPanel

So I have made a simple PHP script which will do the job for you. Copy the below and save it as "letsencrypt-cpanel.php" Simply run the script in the server itself ( php letsencrypt-cpanel.php ), enter the domain name, email address and username for the domain and it will install the SSL certificate for you. You don't have to manually install the certificates.

Before running the below script, make sure that you have the cPanel access hash. Issue the command

```
cat /root/.accesshash
```

It should display a random string. If it does not, login as root in WHM, and search for "Remote Access", and click on it. Now it should generate the access hash. You can verify it by running the above command. Once you have made sure that the accesshash is generated, you can use the script.

```php
<?php
# Please note that no proper validation is done in the script as I'm too lazy for that
# make sure that the domain is pointed to the server's ip correctly
# and, do it at your own risk
# Location of the letsencrypt script
$le = "/root/letsencrypt/letsencrypt-auto";
$handle = fopen("php://stdin","r");
echo "Welcome to Letsencrypt SSL Setup Script\n";
echo "Please Enter the details requested\n";
echo "Domain : ";
$domain = trim(fgets($handle));
echo "cPanel username : ";
$username = trim(fgets($handle));
echo "Email : ";
$email = trim(fgets($handle));

echo "Retrieving the SSL certificates for the domain $domain..!!\n";
$cmd = "$le --text --agree-tos --email $email certonly --renew-by-default --webroot --webroot-path /home/$username/public_html/ -d $domain";
echo "The command is: $cmd";
echo "\n\nAre you sure you wanna continue? If not, press Ctrl+C now\n";
fgets($handle);
$result = shell_exec($cmd);
echo "Command completed: \n$result\n";
echo "Setting up certificates for the domain\n";

$whmusername = 'root';
$hash = file_get_contents('/root/.accesshash');
$query = "https://127.0.0.1:2087/json-api/listaccts?api.version=1&search=$username&searchtype=user";

$curl = curl_init();
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST,0);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER,0);
curl_setopt($curl, CURLOPT_RETURNTRANSFER,1);
  
$header[0] = "Authorization: WHM $whmusername:" . preg_replace("'(\r|\n)'","",$hash);
curl_setopt($curl,CURLOPT_HTTPHEADER,$header);
curl_setopt($curl, CURLOPT_URL, $query);
$ip = curl_exec($curl);
if ($ip == false) {
        echo "Curl error: " . curl_error($curl);
}
$ip = json_decode($ip, true);
$ip = $ip['data']['acct']['0']['ip'];

$cert = urlencode(file_get_contents("/etc/letsencrypt/live/" . $domain . "/cert.pem"));
$key = urlencode(file_get_contents("/etc/letsencrypt/live/" . $domain . "/privkey.pem"));
$chain = urlencode(file_get_contents("/etc/letsencrypt/live/" . $domain . "/chain.pem"));
$query = "https://127.0.0.1:2087/json-api/installssl?api.version=1&domain=$domain&crt=$cert&key=$key&cab=$chain&ip=$ip";
curl_setopt($curl, CURLOPT_URL, $query);
$result = curl_exec($curl);
if ($result == false) {
        echo "Curl error: " . curl_error($curl);
}
curl_close($curl);
  
print $result;
echo "All Done\n";```
```

Please note that I have not added any error catching, so if there is any error in the submitted data, you will probably get some weird error. I'll try to add proper error handling in the future. You can find the latest version of the script <a href="https://github.com/MansoorMajeed/Letsencrypt-Cpanel-Installer" target="_blank">Here</a>

And, use it at your own risk 😉 If you need any help, leave a comment.

