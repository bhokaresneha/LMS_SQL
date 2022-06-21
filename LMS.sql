-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Office_LMS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Office_LMS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Office_LMS` ;
USE `Office_LMS` ;

-- -----------------------------------------------------
-- Table `Office_LMS`.`User_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`User_Details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `contact_number` LONGBLOB NOT NULL,
  `verified` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Password_UNIQUE` (`Password` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Tech_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Tech_Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  `cur_status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Tech_Stack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Tech_Stack` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tech_name` VARCHAR(45) NOT NULL,
  `image_path` VARCHAR(45) NOT NULL,
  `framework` VARCHAR(45) NOT NULL,
  `cur_status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Mentor_Tech_Stack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Mentor_Tech_Stack` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mentor_id` INT NOT NULL,
  `tech_stack_id` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Mentor_Tech_Stack_1_idx` (`tech_stack_id` ASC) VISIBLE,
  INDEX `fk_Mentor_Tech_Stack_2_idx` (`mentor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mentor_Tech_Stack_1`
    FOREIGN KEY (`tech_stack_id`)
    REFERENCES `LMS`.`Tech_Stack` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mentor_Tech_Stack_2`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `LMS`.`Mentor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Mentor_Ideation_Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Mentor_Ideation_Map` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_mentor_id` INT NOT NULL,
  `mentor_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Mentor_Ideation_Map_1_idx` (`mentor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mentor_Ideation_Map_1`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `LMS`.`Mentor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Mentor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Mentor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `mentor_type` VARCHAR(45) NOT NULL,
  `lab_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Mentor_1_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mentor_1`
    FOREIGN KEY (`lab_id`)
    REFERENCES `LMS`.`Lab` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Maker_Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Maker_Program` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `program_name` VARCHAR(45) NOT NULL,
  `program_type` VARCHAR(45) NOT NULL,
  `program_link` VARCHAR(45) NOT NULL,
  `tech_stack_id` INT NOT NULL,
  `tech_type_id` INT NOT NULL,
  `is_program_approved` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Maker_Program_1_idx` (`tech_stack_id` ASC) VISIBLE,
  INDEX `fk_Maker_Program_2_idx` (`tech_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maker_Program_1`
    FOREIGN KEY (`tech_stack_id`)
    REFERENCES `LMS`.`Tech_Stack` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maker_Program_2`
    FOREIGN KEY (`tech_type_id`)
    REFERENCES `LMS`.`Tech_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Lab_Threshold`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Lab_Threshold` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lab_id` INT NOT NULL,
  `lab_capacity` INT NOT NULL,
  `lead_threshold` VARCHAR(45) NOT NULL,
  `ideation_engg_threshold` VARCHAR(45) NOT NULL,
  `buddy_engg_threshold` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Lab_Threshold_1_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `fk_Lab_Threshold_1`
    FOREIGN KEY (`lab_id`)
    REFERENCES `LMS`.`Lab` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Lab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Lab` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Hired_Candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Hired_Candidate` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Middle_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email_Id` VARCHAR(45) NOT NULL,
  `Hired_City` VARCHAR(45) NOT NULL,
  `Degree` VARCHAR(45) NOT NULL,
  `Hired_Date` DATE NOT NULL,
  `Mobile_Number` INT(10) NOT NULL,
  `Permanent_Pincode` INT(6) NOT NULL,
  `Hired_Lab` VARCHAR(45) NOT NULL,
  `Attitude` INT NOT NULL,
  `Communication_Remark` INT NOT NULL,
  `Knowledge_Remark` INT NOT NULL,
  `Aggregate_Remark` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_Stamp` DATETIME NOT NULL,
  ` Creator_User` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = MRG_MyISAM;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Fellowship_Candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Fellowship_Candidate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Middle_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email_Id` VARCHAR(45) NOT NULL,
  `Hired_City` VARCHAR(45) NOT NULL,
  `Degree` VARCHAR(45) NOT NULL,
  `Hired_Date` DATE NOT NULL,
  `Mobile_Number` INT(10) NOT NULL,
  `Permanent_Pincode` INT NOT NULL,
  `Hired_Lab` VARCHAR(45) NOT NULL,
  `Attitude` INT NOT NULL,
  `Communication_Remark` INT NOT NULL,
  `Knowledge_Remark` INT NOT NULL,
  `Aggregate_Remark` INT NOT NULL,
  `creator_Stamp` DATETIME NOT NULL,
  `creator_User` VARCHAR(45) NOT NULL,
  `Birth_Date` DATE NOT NULL,
  `Is_Birth_Date_Verified` VARCHAR(45) NOT NULL,
  `Parent_Name` VARCHAR(45) NOT NULL,
  `Parent_Occupation` VARCHAR(45) NOT NULL,
  `Parents_Mobile_Number` INT(10) NOT NULL,
  ` Parents_Annual_Salary` DOUBLE NOT NULL,
  `Local_Address` VARCHAR(45) NOT NULL,
  `Permanent_Address` VARCHAR(45) NOT NULL,
  `Photo_Path` VARCHAR(45) NOT NULL,
  `Joinig_Date` DATE NOT NULL,
  `Candidate_Status` VARCHAR(45) NOT NULL,
  `Personal_Information` VARCHAR(45) NOT NULL,
  `Bank_Information` VARCHAR(45) NOT NULL,
  `Educational_Information` VARCHAR(45) NOT NULL,
  `Document_Status` VARCHAR(45) NOT NULL,
  ` Remark` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Company_Requirement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Company_Requirement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `requested_month` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `is_doc_verifrication` VARCHAR(45) NOT NULL,
  `requirement_doc_path` VARCHAR(45) NOT NULL,
  `no_of_engg` INT NOT NULL,
  `tech_stack_id` INT NOT NULL,
  `tech_type_id` INT NOT NULL,
  `maker_program_id` INT NOT NULL,
  `lead_id` INT NOT NULL,
  `ideation_engg_id` INT NOT NULL,
  `buddy_engg_id` INT NOT NULL,
  `special_remark` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Company_Requirement_1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_Company_Requirement_2_idx` (`tech_stack_id` ASC) VISIBLE,
  INDEX `fk_Company_Requirement_3_idx` (`tech_type_id` ASC) VISIBLE,
  INDEX `fk_Company_Requirement_4_idx` (`maker_program_id` ASC) VISIBLE,
  CONSTRAINT `fk_Company_Requirement_1`
    FOREIGN KEY (`company_id`)
    REFERENCES `LMS`.`Company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Company_Requirement_2`
    FOREIGN KEY (`tech_stack_id`)
    REFERENCES `LMS`.`Tech_Stack` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Company_Requirement_3`
    FOREIGN KEY (`tech_type_id`)
    REFERENCES `LMS`.`Tech_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Company_Requirement_4`
    FOREIGN KEY (`maker_program_id`)
    REFERENCES `LMS`.`Maker_Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Company` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Candidate_Stack_Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Candidate_Stack_Assignment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `requirement_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  `assign_date` DATE NOT NULL,
  `complete_date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Candidate_Stack_Assignment_1_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_Candidate_Stack_Assignment_1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `LMS`.`Fellowship_Candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Candidate_Qualification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Candidate_Qualification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `diploma` VARCHAR(45) NOT NULL,
  `degree_name` VARCHAR(45) NOT NULL,
  `is_degree_name_verified` VARCHAR(45) NOT NULL,
  `employee_decipline` VARCHAR(45) NOT NULL,
  `is_employee_decipline_verified` VARCHAR(45) NOT NULL,
  `passing_year` INT NOT NULL,
  `is_passing_year_verified` INT NOT NULL,
  `aggr_per` DOUBLE NOT NULL,
  `is_passing_year_verified,` VARCHAR(45) NOT NULL,
  `final_year_per` INT NOT NULL,
  `is_final_year_per_verified,` VARCHAR(45) NOT NULL,
  `training_institute` VARCHAR(45) NOT NULL,
  `is_training_institute_verified` VARCHAR(45) NOT NULL,
  `training_duration_month` INT NOT NULL,
  `is_training_duration_month_verified` VARCHAR(45) NOT NULL,
  `other_training` VARCHAR(45) NOT NULL,
  `is_other_training_verified` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ Candidate_Qualification_1_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_ Candidate_Qualification_CandidateId`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `LMS`.`Fellowship_Candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Candidate_Documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Candidate_Documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `doc_type` VARCHAR(45) NOT NULL,
  `doc_path` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Candidate_Documents_1_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_Candidate_Documents_1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `LMS`.`Fellowship_Candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`Candidate_Bank_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`Candidate_Bank_Details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `candidate_Id` INT NOT NULL,
  `Account_Number` INT(20) NOT NULL,
  `Is_Account_Num_Verified` VARCHAR(45) NOT NULL,
  `Ifsc_code` VARCHAR(45) NOT NULL,
  `is_ifsc_code_verified` VARCHAR(45) NOT NULL,
  ` pan_number` VARCHAR(45) NOT NULL,
  `  is_pan_number_verified` VARCHAR(45) NOT NULL,
  `addhaar_number` VARCHAR(45) NOT NULL,
  `is_addhaar_number_verified` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Candidate_Bank_Details_1_idx` (`candidate_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Candidate_Bank_Details_1`
    FOREIGN KEY (`candidate_Id`)
    REFERENCES `LMS`.`Fellowship_Candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Office_LMS`.`App_Parameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Office_LMS`.`App_Parameters` (
  `id` INT NOT NULL,
  `key_type` VARCHAR(45) NOT NULL,
  `key_value` VARCHAR(45) NOT NULL,
  `key_text` VARCHAR(45) NOT NULL,
  `cur_status` VARCHAR(45) NOT NULL,
  `lastupd_user` VARCHAR(45) NOT NULL,
  `lastupd_stamp` VARCHAR(45) NOT NULL,
  `creator_stamp` DATETIME NOT NULL,
  `creator_user` VARCHAR(45) NOT NULL,
  `seq_num` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
