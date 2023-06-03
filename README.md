# flight-reservation-app-flutter
A flight reservation app with Flutter

## Used Technologies and Libraries
- Flutter
- MySQL
- PHP

## Screens
<img src="flight_reservation/screenshots/screens/login.png" width=300>          <img src="flight_reservation/screenshots/screens/register.png" width=300>          <img src="flight_reservation/screenshots/screens/profile.png" width=300>

### As member
<img src="flight_reservation/screenshots/screens/member/member0.png" width=300>When the table is scrolled, price information is also available.<img src="flight_reservation/screenshots/screens/member/member1.png" width=300>          <img src="flight_reservation/screenshots/screens/member/member2.png" width=300>          <img src="flight_reservation/screenshots/screens/member/member3.png" width=300>          <img src="flight_reservation/screenshots/screens/member/member4.png" width=300>

### As admin
<img src="flight_reservation/screenshots/screens/admin/admin0.png" width=300>          <img src="flight_reservation/screenshots/screens/admin/admin1.png" width=300>          <img src="flight_reservation/screenshots/screens/admin/admin2.png" width=300>          <img src="flight_reservation/screenshots/screens/admin/admin3.png" width=300>
Admin can delete members by clicking on them.

## Database
### Conceptional Design
<img src="flight_reservation/screenshots/conceptual_design.png" width=500>

### Logical Design
<img src="flight_reservation/screenshots/logical_design.png" width=500>

### Physical Design
- To create database
```sql
CREATE DATABASE flight_reservation;
```
-To create "users" table
```sql
CREATE TABLE `flight_reservation`.`users` ( `id` INT(11) NOT NULL AUTO_INCREMENT , `email` VARCHAR(30) NOT NULL , `password` VARCHAR(30) NOT NULL , `first_name` VARCHAR(30) NOT NULL , `last_name` VARCHAR(30) NOT NULL , `level` VARCHAR(6) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
```


