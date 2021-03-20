-- MySQL Script generated by MySQL Workbench
-- Sat Jun 27 00:35:59 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_107403510
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_107403510` ;

-- -----------------------------------------------------
-- Schema db_107403510
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_107403510` DEFAULT CHARACTER SET utf8 ;
USE `db_107403510` ;

-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_user` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_user` (
  `user_id` INT(10) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `fname` VARCHAR(100) NOT NULL,
  `lname` VARCHAR(100) NOT NULL,
  `dob` DATE NOT NULL,
  `salt` CHAR(64) NOT NULL,
  `register_datetime` DATE NOT NULL,
  `isdelete` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `salt_UNIQUE` (`salt` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_station` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_station` (
  `station_id` INT(10) NOT NULL,
  `station_name` VARCHAR(45) NOT NULL,
  `location_marker` INT(10) NOT NULL,
  `time_maker` INT(10) NOT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE INDEX `station_name_UNIQUE` (`station_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_train`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_train` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_train` (
  `train_id` INT(11) NOT NULL AUTO_INCREMENT,
  `arr_time` TIME NULL,
  `dep_time` TIME NULL,
  `departure_station` INT(10) NOT NULL,
  `off_date` DATE NULL,
  `on_date` DATE NULL,
  PRIMARY KEY (`train_id`, `departure_station`),
  INDEX `station_id_idx` (`departure_station` ASC),
  INDEX `train_id_idx` (`train_id` ASC),
  CONSTRAINT `train_station_id_fk`
    FOREIGN KEY (`departure_station`)
    REFERENCES `db_107403510`.`tbl_station` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_seat` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_seat` (
  `seat_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`seat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_ticket` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_ticket` (
  `ticket_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `train_date` DATE NOT NULL,
  `train_id` INT(11) NOT NULL,
  `departure_station` INT(10) NOT NULL,
  `arrival_station` INT(10) NOT NULL,
  `seat_id` VARCHAR(20) NOT NULL,
  `price` INT(10) NOT NULL,
  `book_time` DATETIME NOT NULL,
  `pay_time` DATETIME NULL,
  PRIMARY KEY (`ticket_id`, `user_id`, `train_id`, `departure_station`, `arrival_station`, `seat_id`),
  INDEX `ticket_user_id_fk_idx` (`user_id` ASC),
  INDEX `ticket_seat_id_fk_idx` (`seat_id` ASC),
  INDEX `ticket_station_id_fk_idx1` (`arrival_station` ASC),
  INDEX `fk_tbl_ticket_tbl_train1_idx` (`train_id` ASC, `departure_station` ASC),
  CONSTRAINT `ticket_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_107403510`.`tbl_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_seat_id_fk`
    FOREIGN KEY (`seat_id`)
    REFERENCES `db_107403510`.`tbl_seat` (`seat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_station_id_fk`
    FOREIGN KEY (`arrival_station`)
    REFERENCES `db_107403510`.`tbl_station` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_ticket_tbl_train1`
    FOREIGN KEY (`train_id` , `departure_station`)
    REFERENCES `db_107403510`.`tbl_train` (`train_id` , `departure_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_107403510`.`tbl_userCredential`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_107403510`.`tbl_userCredential` ;

CREATE TABLE IF NOT EXISTS `db_107403510`.`tbl_userCredential` (
  `userCredential` INT(10) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `hashedpwd` CHAR(255) NOT NULL,
  `create_datetime` DATE NOT NULL,
  `isdelete` INT(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userCredential`, `user_id`),
  UNIQUE INDEX `hashedpwd_UNIQUE` (`hashedpwd` ASC),
  CONSTRAINT `pswd_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_107403510`.`tbl_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
