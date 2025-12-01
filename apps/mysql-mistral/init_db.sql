ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
create database users;
create database dataset;
use users;

CREATE USER 'toto'@'localhost' IDENTIFIED BY 'toto';
GRANT SELECT ON *.* TO 'toto'@'localhost' WITH GRANT OPTION;
flush privileges; 

CREATE USER 'tata'@'localhost' IDENTIFIED BY 'tata';
GRANT ALL PRIVILEGES ON dataset.* TO 'tata'@'localhost';
flush privileges; 