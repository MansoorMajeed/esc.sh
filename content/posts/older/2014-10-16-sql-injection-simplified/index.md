---
author: Mansoor A
categories:
- HomePage
date: "2014-10-16T15:47:58Z"
description: ""
draft: false
tags:
- HomePage
title: SQL Injection simplified
url: blog/sql-injection-simplified
---


SQL injection, we have all heard of it. Some of you might have even tried to inject SQL into a vulnerable website. 
But, most people still don't know what exactly it is. 

So, today, I'm going to explain to you guys and girls what exactly is SQL injection. 
This is a simple explanation of what SQL injection actually means and how SQLi works. 
This is not a post about how to hack websites using SQL injection, but it's about 
understanding the concepts and by that, you may or may not be able to conduct attacks. 

But, please note that injecting any kind of code to the web applications you're not 
authorized to do such tests, is illegal and I'm not to be held responsible for that.

This post is gonna be an easily comprehensible one so that people with all kind of 
knowledge  level can follow it. So let's begin. This post could get long, feel free to skip to the section you're interested in.

### First things first, what is a database?

Let's see what wikipedia has to say about a database

> A database is an organized collection of data. It is the collection of schemes, tables, queries, reports, views and other objects. The data is typically organized to model aspects of reality in a way that supports processes requiring information, such as modelling the availability of rooms in hotels in a way that supports finding a hotel with vacancies.

Well simply put, a database is a collection of data that is organized in  such a way that we can access or modify it easily.

For example, let's say you are a teacher and you want to collect information about the grades of your students for different subjects. Now, what is the best way to store this information? a database. Take a look at the following image.


{{< figure src="table.png" alt="Table" caption="<em>Table</em>" class="border-0" >}}


This is an Excel sheet. This is identical to a database in structure. 

The data is stored in a table-column manner, it is easy to understand, easy to modify and access. 

A database contains tables. Each table can contain a number of columns, 
and we store information in these tables. Now check the below image, 
this is from a table inside a database. It looks almost similar to the above calc sheet, doesn't it?

{{< figure src="database_marks.png" alt="Marks" caption="<em>Marks table</em>" class="border-0" >}}


I think you got an idea about "what is a database".

### What is SQL and MySQL?

SQL stands for "Structure Query Language". It is a language, that is used to communicate to a database. 

We can get information from the database, edit or add information into the database and stuff like that.

For example, in the above image, we used the query `SELECT * FROM marks`. 
Here, this query is used to retrieve information from the table named "marks". 
I'm not going to teach you guys "SQL" right now, even though I wish if I could 

So, what is MySQL? well, MySQL is a database software, using which you can create and manipulate databases. 

We communicate with the software using  SQL, the structured query language. Got the connection now?

Okay, that's all the information we need, for now. Now let's create a login form and see if we can break it using SQL injection.

### Let's create a Login Page

I have an ubuntu VM in which I have installed Apache, MySQL and PHP. 

Let us quickly create a login page which we will bypass later in this post itself. In your web server's document root, create a file, let's name it "index.php"

Copy the below content into it and save it.

```php
<?php
if(!$_POST['login']){
?>
    <html>         
        <title>Insanely insecure banks co</title>
        <center>
            <h1>Welcome to My high security bank</h1>
            <h3>Please login to continue</h3>
            <!-- the login form -->
            <form action="index.php" method="POST">
            <p>UserName:<input type='text' name='username' ></p>
            <p>  
            Pass:<input type='text' name='pass'></p>
            <input type="submit" name="login" value="Sign in" />
            </form>
        </center>        
    <html>
<?php    
}
?>

<?php 
    $dbhost = 'localhost';
    $db = 'bank';
    $dbuser = 'sqli';
    $password = 'password';
    $con=mysql_connect("$dbhost","$dbuser","$password") or die("Failed to connect to MySQL: " . mysql_error()); 
    mysql_select_db("$db") or die("Failed to connect to MySQL: " . mysql_error());
    
    $username = $_POST['username'];
    $password = $_POST['pass']; 

    $res = mysql_query("SELECT * FROM users where username='$username' and password='$password'");
    $result = mysql_fetch_array($res);
    if($_POST['login']){
        if($result){
            print "<h2>Login successful</h2>";
        }
        else{
            print "<h2>Login Failed. Invalid username or password</h2>";
        }
    }
?>
```

### Setting up the database

Now that we have a login page, we need to set up a database where we will be storing our username and passwords.

For  this, you need MySQL installed and running in your machine.

#### Create  a database and a user to use the datbase

Login to your mysql server as root

```shell
mysql -u root -p <your mysql password>
```

Create a database and assign a user 

```shell
CREATE DATABASE bank;
CREATE USER sqli IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES TO 'sqli' ON bank.* IDENTIFIED BY 'password';
```

Right now we have created a database named 'bank',  

We have created a database user `sqli` with password as `password`, and we have given the user all privileges on the database `bank` 
    
Create  a table `users` and add users into it. This is where all the user information is saved. Let`s say, this is where all the registered users' information will be stored. 
```shell
CREATE TABLE users ( id INT(5), username VARCHAR(100), password VARCHAR(100) );
```     

We have created the table with columns `id, username, and password`. Let us add some users now.
```shell   
INSERT INTO users (id, username, password) VALUES ('1', 'admin', 'awesomepassword');
```     

What did we do? Well we added a user `admin` with password `awesomepassword`. Now, this user is allowed to log in if he enters the correct password.
This is how our users table looks now.

{{< figure src="users_table.png" alt="User table" caption="<em>User table</em>" class="border-0" >}}

That's it. We have everything we need. Now, load the page `http://<your ip>/index.php` in your browser and you should see the login page like below.

{{< figure src="login_page.png" alt="Login Page" caption="<em>Login Page</em>" class="border-0" >}}

Now, go ahead and login using the username `admin` and the password `awesomepassword`. If you entered the correct username and password, you will be shown a "login successful" message. If the username or password is invalid, you will be shown "Login Failed. Invalid username or password". Now, this is how it should work, normally. But, we're going to break it and we will be able to login without  a password.

### Breaking the Login form : SQL Injection

Before we get into hacking the login form, let's take a look at how the user authentication is done.

```php
$username = $_POST['username'];
$password = $_POST['pass']; 
$res = mysql_query("SELECT * FROM users where username='$username' and password='$password'");
$result = mysql_fetch_array($res);
if($_POST['login']){
    if($result){
        print "<h2>Login successful</h2>";
    }
    else{
        print "<h2>Login Failed. Invalid username or password<h2>";
    }
}
```   

1. The form receives the username and password from the user input
2. The page now runs an SQL query against the users table looking for any matching pair of username and password supplied by the user.
3. If there is a match, the user is allowed to login, and if not, the user is presented with a login failed message.
        
Okay, let's crack it. In the username field, let's put `admin`, and in password field, put the following. Check the screenshot

```shell
aaa' or  '1=1
```
You can replace that `aaa` with whatever you want. But make sure that you have the single quotes correct. Don't put any quotes at the end, just do it as in the screenshot.

{{< figure src="sqli.png" alt="SQLi" caption="<em>Injecting SQL</em>" class="border-0" >}}

Click sign in, and BAM!! We're in. We have logged in without a valid password, by injecting SQL queries of our own, into the web application.

### What the heck happened there?

Alright, let's take a look at what happened here. In the username field, you entered `admin`, which is fine because you know there is a user with that username. But in the password field, what happened there?. Let's see the SQL query with the variables in place.
    
```php
# This is the original query, before injection.
$res = mysql_query("SELECT * FROM users where username='$username' and password='$password'");
# This is the query during a normal successful validation
$res = mysql_query("SELECT * FROM users where username='admin' and password='awesomepassword'");

# This is the query when we inject SQL into the form
$res = mysql_query("SELECT * FROM users where username='admin' and password='aaa' or '1=1'");
```    
See what happened there? The third query,  `assword='aaa' or 1=1'` which is always going to return true because '1=1' is always true.

So, now you know the importance of sanitizing the user input, and thus protecting your web application from getting hacked easily.

Now, this was a simple demonstration of how SQL injection happens. This is not the case with most modern web applications, it is much more sophisticated than this, but the idea is the same.

### How to prevent SQL injection in your web applications?

There are different methods you can adopt to avoid SQL injections in your web application. Stackoverflow has a very good thread regarding the same. You can check this out <a href="http://stackoverflow.com/questions/60174/how-can-i-prevent-sql-injection-in-php" target="_blank">HERE</a>


If you have liked this post, like our facebook page in the right side for more updates, and Have a good day

If you have any suggestions or questions, leave  a comment and I'll try my best to address them.

