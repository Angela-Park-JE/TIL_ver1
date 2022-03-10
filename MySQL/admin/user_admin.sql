-- show databases in now
show databases; 

-- Create database
CREATE database glory;
-- We have to set the encoding but else Korean will be broken
CREATE schema glory default character set utf8; 
commit;

-- delete
-- DROP database DBname;

-- Giving the administrating roll : GRANT / REVOKE
GRANT ALL PRIVILEGES ON glory.* TO angela;
flush privileges;
-- GRANT ALL PRIVILEGES ON DBname.* TO userid@localhost IDENTIFIED BY 'password';

-- Check the granted privileges
SHOW GRANTS FOR angela;

-- Delete the privileges : REVOKE ALL ON DBname.* FROM USERid;

commit;

-- After the commit, I could see the new scheme named by 'glory' :)
