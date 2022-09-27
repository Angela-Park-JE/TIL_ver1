-- remember!!!

> brew services {start/restart/stop/..} mysql
> mysql -u `username` -p
> [password]

-- set the scheme what I'm going to use
mysql> USE `scheme name`;

-- run from a local .sql file
mysql> SOURCE `file path`;

-- check the tables in scheme
mysql> USE `scheme name`;
mysql> SHOW tables;

-- check the describtio of a table
mysql> {DESC/DESCRIBE} `table name`;
