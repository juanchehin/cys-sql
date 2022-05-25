-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cys
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cys
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cys` DEFAULT CHARACTER SET utf8 ;
USE `cys` ;

-- -----------------------------------------------------
-- Table `cys`.`Emp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cys`.`Emp` (
  `ID` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Posicion` VARCHAR(60) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cys`.`Sueldos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cys`.`Sueldos` (
  `id` INT NOT NULL,
  `id_emp` INT NOT NULL,
  `sueldo` FLOAT NULL,
  PRIMARY KEY (`id`, `id_emp`),
  INDEX `fk_Sueldos_Emp_idx` (`id_emp` ASC) ,
  CONSTRAINT `fk_Sueldos_Emp`
    FOREIGN KEY (`id_emp`)
    REFERENCES `cys`.`Emp` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cys`.`vacaciones_2021`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cys`.`vacaciones_2021` (
  `id` INT NOT NULL,
  `id_emp` INT NOT NULL,
  `fecha` DATETIME NULL,
  PRIMARY KEY (`id`, `id_emp`),
  INDEX `fk_vacaciones_2021_Emp1_idx` (`id_emp` ASC),
  CONSTRAINT `fk_vacaciones_2021_Emp1`
    FOREIGN KEY (`id_emp`)
    REFERENCES `cys`.`Emp` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
