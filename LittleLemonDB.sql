-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `ContactNo` INT NOT NULL,
  `CustomerType` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeFirstName` VARCHAR(100) NOT NULL,
  `EmployeeLastName` VARCHAR(100) NOT NULL,
  `Role` VARCHAR(200) NOT NULL,
  `Address` VARCHAR(300) NOT NULL,
  `EmployeeContactNo` INT NOT NULL,
  `Email` VARCHAR(200) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `BookingSlotTime` TIME NOT NULL,
  `BookingSlotDate` DATE NOT NULL,
  PRIMARY KEY (`BookingID`),
  UNIQUE INDEX `BookingID_UNIQUE` (`BookingID` ASC) VISIBLE,
  INDEX `Customerid_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `employeeid-fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `Customerid_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employeeid-fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Items` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(200) NOT NULL,
  `Type` VARCHAR(80) NOT NULL,
  `BuyPrice` INT NOT NULL,
  `QuantityinStock` VARCHAR(45) NULL,
  `SellPrice` INT NULL,
  PRIMARY KEY (`ItemID`),
  UNIQUE INDEX `ItemID_UNIQUE` (`ItemID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`MenuID`),
  UNIQUE INDEX `MenuID_UNIQUE` (`MenuID` ASC) VISIBLE,
  INDEX `item_fk_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `item_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `LittleLemonDB`.`Items` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` DECIMAL NOT NULL,
  `Quantity` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE INDEX `OrderID_UNIQUE` (`OrderID` ASC) VISIBLE,
  INDEX `Menu_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `Booking_fk_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `Menu_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Booking_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDelivery` (
  `OrderDeliveryID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NULL,
  `Status` VARCHAR(100) NULL,
  `OrderDeliveryDate` DATE NULL,
  PRIMARY KEY (`OrderDeliveryID`),
  UNIQUE INDEX `OrderDeliveryID_UNIQUE` (`OrderDeliveryID` ASC) VISIBLE,
  INDEX `orderid_fk_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `orderid_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
