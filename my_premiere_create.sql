-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema my_premiere
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `my_premiere` ;

-- -----------------------------------------------------
-- Schema my_premiere
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `my_premiere` DEFAULT CHARACTER SET utf8 ;
USE `my_premiere` ;

-- -----------------------------------------------------
-- Table `my_premiere`.`rep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_premiere`.`rep` ;

CREATE TABLE IF NOT EXISTS `my_premiere`.`rep` (
  `rep_num` CHAR(2) NOT NULL,
  `last_name` CHAR(15) NULL,
  `first_name` CHAR(15) NULL,
  `street` CHAR(15) NULL,
  `city` CHAR(15) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  `commission` DECIMAL(7,2) NULL,
  `rate` DECIMAL(3,2) NULL,
  PRIMARY KEY (`rep_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_premiere`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_premiere`.`customer` ;

CREATE TABLE IF NOT EXISTS `my_premiere`.`customer` (
  `customer_num` CHAR(3) NOT NULL,
  `customer_name` CHAR(35) NOT NULL,
  `street` CHAR(15) NULL,
  `city` CHAR(15) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  `balance` DECIMAL(8,2) NULL,
  `credit_limit` DECIMAL(8,2) NULL,
  `rep_num` CHAR(2) NULL,
  PRIMARY KEY (`customer_num`),
  INDEX `fk_customer_rep_idx` (`rep_num` ASC) VISIBLE,
  CONSTRAINT `fk_customer_rep`
    FOREIGN KEY (`rep_num`)
    REFERENCES `my_premiere`.`rep` (`rep_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_premiere`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_premiere`.`orders` ;

CREATE TABLE IF NOT EXISTS `my_premiere`.`orders` (
  `order_num` CHAR(5) NOT NULL,
  `order_date` DATE NULL,
  `customer_num` CHAR(3) NOT NULL,
  PRIMARY KEY (`order_num`),
  INDEX `fk_orders_customer1_idx` (`customer_num` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customer1`
    FOREIGN KEY (`customer_num`)
    REFERENCES `my_premiere`.`customer` (`customer_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_premiere`.`part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_premiere`.`part` ;

CREATE TABLE IF NOT EXISTS `my_premiere`.`part` (
  `part_num` CHAR(4) NOT NULL,
  `description` CHAR(15) NULL,
  `on_hand` DECIMAL(4,0) NULL,
  `class` CHAR(2) NULL,
  `warehouse` CHAR(1) NULL,
  `price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`part_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_premiere`.`order_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_premiere`.`order_line` ;

CREATE TABLE IF NOT EXISTS `my_premiere`.`order_line` (
  `order_num` CHAR(5) NOT NULL,
  `part_num` CHAR(4) NOT NULL,
  `num_ordered` DECIMAL(3,0) NULL,
  `quoted_price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`order_num`, `part_num`),
  INDEX `fk_order_line_part1_idx` (`part_num` ASC) VISIBLE,
  CONSTRAINT `fk_order_line_orders1`
    FOREIGN KEY (`order_num`)
    REFERENCES `my_premiere`.`orders` (`order_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_line_part1`
    FOREIGN KEY (`part_num`)
    REFERENCES `my_premiere`.`part` (`part_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
