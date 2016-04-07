/* Create the Database */
CREATE DATABASE tctas DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

/* Set up grants for the Database */
GRANT all ON *.* TO 'tasadm'@'%' identified by 'tasadm' ;
GRANT all ON *.* TO 'tasadm'@'localhost' identified by 'tasadm' ;

/* Remove the Test Database */
/* DROP DATABASE test; */

/* Flush PRIVILEGES */
FLUSH PRIVILEGES;
