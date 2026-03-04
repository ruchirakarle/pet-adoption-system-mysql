DROP DATABASE pet_adoption_system;
CREATE DATABASE pet_adoption_system;

USE pet_adoption_system;

-- Table 1: Species
CREATE TABLE Species (
    species_id INT PRIMARY KEY AUTO_INCREMENT,
    species_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

-- Table 2: Breeds
CREATE TABLE Breeds (
    breed_id INT PRIMARY KEY AUTO_INCREMENT,
    breed_name VARCHAR(100) NOT NULL,
    species_id INT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (species_id) REFERENCES Species(species_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
    UNIQUE KEY unique_breed_species (breed_name, species_id)
);

-- Table 3: Shelter
CREATE TABLE Shelter (
    shelter_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    capacity INT DEFAULT 50,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (capacity > 0)
);

-- Table 4: Staff
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    shelter_id INT NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Table 5: Pets
CREATE TABLE Pets (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    status ENUM('Available', 'Adopted', 'Under Review') DEFAULT 'Available',
    species_id INT NOT NULL,
    breed_id INT NOT NULL,
    shelter_id INT NOT NULL,
    intake_date DATE DEFAULT (CURRENT_DATE),
    adoption_date DATE NULL,
    CHECK (age >= 0 AND age <= 30),
    FOREIGN KEY (species_id) REFERENCES Species(species_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
    FOREIGN KEY (breed_id) REFERENCES Breeds(breed_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Table 6: Adopters
CREATE TABLE Adopters (
    adp_id INT PRIMARY KEY AUTO_INCREMENT,
    adp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'USA',
    registration_date DATE DEFAULT (CURRENT_DATE)
);

-- Table 7: Application
CREATE TABLE Application (
    app_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT NOT NULL,
    adp_id INT NOT NULL,
    app_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    staff_id INT NULL,
    review_date DATE NULL,
    notes TEXT,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (adp_id) REFERENCES Adopters(adp_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
    UNIQUE KEY unique_pet_adopter (pet_id, adp_id)
);


-- ADOPTION DATABBASE *****************

-- Insert Species
INSERT INTO Species (species_name) VALUES 
('Dog'), ('Cat'), ('Bird'), ('Rabbit'), ('Guinea Pig');

-- Insert Shelters
INSERT INTO Shelter (name, city, phone, capacity) VALUES
('Happy Paws Shelter', 'Boston', '617-555-0101', 100),
('Safe Haven Animal Rescue', 'Cambridge', '617-555-0102', 75),
('Furry Friends Sanctuary', 'Brookline', '617-555-0103', 50);

-- Insert Staff
INSERT INTO Staff (staff_name, role, shelter_id, email, hire_date) VALUES
('John Smith', 'Manager', 1, 'john.smith@happypaws.org', '2020-01-15'),
('Sarah Johnson', 'Veterinarian', 1, 'sarah.j@happypaws.org', '2021-03-20'),
('Mike Brown', 'Adoption Coordinator', 2, 'mike.b@safehaven.org', '2019-06-10'),
('Emily Davis', 'Manager', 2, 'emily.d@safehaven.org', '2018-09-05'),
('Chris Wilson', 'Volunteer Coordinator', 3, 'chris.w@furryfriends.org', '2022-02-14'),
('Laura Green', 'Veterinarian', 3, 'laura.green@furryfriends.org', '2021-01-10'),
('Daniel Evans', 'Manager', 1, 'daniel.evans@happypaws.org', '2017-05-19'),
('Rebecca Turner', 'Adoption Coordinator', 2, 'rebecca.t@safehaven.org', '2020-11-22');

-- Insert Breeds
INSERT INTO Breeds (breed_name, species_id, description) VALUES
('Golden Retriever', 1, 'Friendly and intelligent dog breed'),
('Labrador Retriever', 1, 'Outgoing and active dog'),
('Husky', 1, 'Energetic and friendly'),
('German Shepherd', 1, 'Confident and courageous'),
('Beagle', 1, 'Curious and friendly'),
('Persian Cat', 2, 'Quiet and sweet-tempered'),
('Siamese Cat', 2, 'Vocal and affectionate'),
('Maine Coon', 2, 'Gentle giants'),
('Bulldog', 1, 'Calm and courageous'),
('Poodle', 1, 'Intelligent and active'),
('Sphynx', 2, 'Hairless and affectionate'),
('Cockatoo', 3, 'Playful and talkative'),
('Rex Rabbit', 4, 'Soft fur and friendly'),
('Parakeet', 3, 'Social and intelligent'),
('Cockatiel', 3, 'Friendly and easy to care for'),
('Holland Lop', 4, 'Compact and friendly rabbit'),
('American Guinea Pig', 5, 'Gentle and social');

-- Insert Pets
INSERT INTO Pets (pet_name, age, gender, status, species_id, breed_id, shelter_id, intake_date) VALUES
('Max', 3, 'Male', 'Available', 1, 1, 1, '2024-10-01'),
('Bella', 2, 'Female', 'Available', 1, 2, 1, '2024-10-15'),
('Charlie', 4, 'Male', 'Under Review', 1, 3, 2, '2024-09-20'),
('Luna', 1, 'Female', 'Available', 2, 5, 1, '2025-06-01'),
('Cooper', 5, 'Male', 'Available', 1, 4, 2, '2024-08-10'),
('Daisy', 2, 'Female', 'Adopted', 2, 6, 1, '2024-07-15'),
('Rocky', 3, 'Male', 'Available', 1, 1, 3, '2024-11-10'),
('Milo', 1, 'Male', 'Available', 2, 7, 2, '2023-10-25'),
('Tweety', 2, 'Female', 'Available', 3, 8, 3, '2025-05-05'),
('Sunny', 1, 'Male', 'Available', 3, 9, 1, '2024-01-30'),
('Fluffy', 3, 'Female', 'Available', 4, 10, 2, '2024-09-15'),
('Coco', 1, 'Female', 'Available', 5, 11, 3, '2023-11-12'),
('Buddy', 6, 'Male', 'Available', 1, 12, 1, '2024-10-10'),
('Nala', 3, 'Female', 'Under Review', 2, 13, 1, '2024-10-12'),
('Ghost', 2, 'Male', 'Available', 1, 7, 2, '2024-08-12'),
('Misty', 4, 'Female', 'Adopted', 2, 6, 3, '2024-05-25'),
('Pablo', 1, 'Male', 'Available', 3, 14, 2, '2025-01-01'),
('Choco', 3, 'Female', 'Available', 4, 15, 1, '2024-07-07'),
('Snowy', 2, 'Female', 'Available', 5, 11, 3, '2023-12-12'),
('Shadow', 5, 'Male', 'Under Review', 1, 4, 2, '2024-07-30'),
('Whiskers', 2, 'Male', 'Available', 2, 7, 3, '2024-11-01'),
('Ruby', 1, 'Female', 'Available', 3, 9, 1, '2025-02-05');


-- Insert Adopters
INSERT INTO Adopters (adp_name, email, phone, city, country, registration_date) VALUES
('Emma Wilson', 'emma.wilson@gmail.com', '617-555-1001', 'Boston', 'USA', '2024-12-20'),
('James Taylor', 'james.taylor@gmail.com', '617-555-1002', 'Brookline', 'USA', '2025-03-22'),
('Olivia Martinez', 'olivia.m@gmail.com', '617-555-1003', 'Cambridge', 'USA', '2025-07-01'),
('William Brown', 'william.b@gmail.com', '617-555-1004', 'Rhode Island', 'USA', '2024-11-05'),
('Sophia Anderson', 'sophia.a@gmail.com', '617-555-1005', 'Quincy', 'USA', '2024-05-15'),
('Henry Carter', 'henry.carter@gmail.com', '617-555-2001', 'Boston', 'USA', '2024-09-12'),
('Megan Reed', 'megan.reed@gmail.com', '617-555-2002', 'Cambridge', 'USA', '2024-06-15'),
('Lucas Gray', 'lucas.gray@gmail.com', '617-555-2003', 'Somerville', 'USA', '2025-02-20'),
('Ava Scott', 'ava.scott@gmail.com', '617-555-2004', 'Fenway', 'USA', '2024-03-18'),
('Ryan Cooper', 'ryan.cooper@gmail.com', '617-555-2005', 'Vermont', 'USA', '2025-01-10'),
('Ella White', 'ella.white@gmail.com', '617-555-3001', 'Boston', 'USA', '2025-02-12'),
('Jack Harris', 'jack.harris@gmail.com', '617-555-3002', 'Cambridge', 'USA', '2025-03-01'),
('Mia Thompson', 'mia.thompson@gmail.com', '617-555-3003', 'Brookline', 'USA', '2024-11-25'),
('Noah King', 'noah.king@gmail.com', '617-555-3004', 'Somerville', 'USA', '2025-01-05');

-- Insert Applications
INSERT INTO Application (pet_id, adp_id, app_date, status, staff_id, review_date, notes) VALUES
(3, 1, '2024-11-15', 'Pending', 3, NULL, 'First time adopter, needs home visit'),
(6, 2, '2024-07-20', 'Approved', 1, '2024-07-25', 'Excellent home environment'),
(1, 3, '2024-11-18', 'Pending', NULL, NULL, 'Awaiting review'),
(5, 4, '2024-11-10', 'Rejected', 3, '2024-11-12', 'Not suitable for apartment living'),
(9, 5, '2024-11-16', 'Pending', NULL, NULL, 'Interested in bird adoption'),
(12, 6, '2024-08-05', 'Pending', NULL, NULL, 'Interested in rabbit'),
(7, 7, '2024-12-01', 'Approved', 1, '2025-01-03', 'Great adopter'),
(2, 11, '2024-10-05', 'Approved', 2, '2024-10-08', 'Excellent home environment'),
(4, 12, '2024-09-18', 'Approved', 1, '2025-09-10', 'Adopter has previous pet experience'),
(10, 8, '2024-11-25', 'Rejected', 4, '2025-10-28', 'Not suitable'),
(8, 13, '2024-12-02', 'Approved', 3, '2024-12-05', 'Great match for the cat'),
(9, 14, '2024-10-22', 'Approved', 5, '2023-10-25', 'Perfect fit for family with kids'),
(14, 10, '2024-12-15', 'Pending', NULL, NULL, 'Excited about adoption');


-- STORED PROCEDURES ( CURD) *******************

DELIMITER //
-- Procedure 1: Add new pet
CREATE PROCEDURE sp_add_pet(
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_species_id INT,
    IN p_breed_id INT,
    IN p_shelter_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error adding pet to database';
    END;
    START TRANSACTION;
    -- Validate inputs
    IF p_age < 0 OR p_age > 30 THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Invalid age: must be between 0 and 30';
    END IF;
    INSERT INTO Pets (pet_name, age, gender, species_id, breed_id, shelter_id)
    VALUES (p_name, p_age, p_gender, p_species_id, p_breed_id, p_shelter_id);
    COMMIT;
END //

-- Tests 
CALL sp_add_pet('TestPet', 2, 'Male', 1, 1, 1);
SELECT * FROM Pets WHERE pet_name = 'TestPet';



DELIMITER //
-- Procedure 2: Submit adoption application
CREATE PROCEDURE sp_submit_application(
    IN p_pet_id INT,
    IN p_adp_id INT,
    IN p_notes TEXT
)
BEGIN
    DECLARE v_pet_status VARCHAR(20);
    DECLARE v_existing_app INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error submitting application';
    END;
    START TRANSACTION;
    -- Check if pet exists and is available
    SELECT status INTO v_pet_status FROM Pets WHERE pet_id = p_pet_id;
    IF v_pet_status IS NULL THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Pet does not exist';
    END IF;
    IF v_pet_status != 'Available' THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Pet is not available for adoption';
    END IF;
    -- Check for duplicate application
    SELECT COUNT(*) INTO v_existing_app 
    FROM Application 
    WHERE pet_id = p_pet_id AND adp_id = p_adp_id;
    IF v_existing_app > 0 THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Application already exists for this pet';
    END IF;
    -- Insert application
    INSERT INTO Application (pet_id, adp_id, app_date, status, notes)
    VALUES (p_pet_id, p_adp_id, CURDATE(), 'Pending', p_notes);
    -- Update pet status
    UPDATE Pets SET status = 'Under Review' WHERE pet_id = p_pet_id;
    COMMIT;
END //

-- Test 
SELECT status FROM Pets WHERE pet_id = 1;


DELIMITER //
-- Procedure 3: Update application status
CREATE PROCEDURE sp_update_application_status(
    IN p_app_id INT,
    IN p_status VARCHAR(20),
    IN p_staff_id INT,
    IN p_notes TEXT
)
BEGIN
    DECLARE v_pet_id INT;
    DECLARE v_current_status VARCHAR(20);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error updating application status';
    END;
    START TRANSACTION;
    SELECT pet_id, status INTO v_pet_id, v_current_status
    FROM Application WHERE app_id = p_app_id;
    IF v_pet_id IS NULL THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Application does not exist';
    END IF;
    -- Update application
    UPDATE Application 
    SET status = p_status, 
	staff_id = p_staff_id,
	review_date = CURDATE(),
	notes = CONCAT(IFNULL(notes, ''), '\n[', CURDATE(), '] ', p_notes)
    WHERE app_id = p_app_id;
    -- Update pet status based on application decision
    IF p_status = 'Approved' THEN
	UPDATE Pets 
	SET status = 'Adopted', adoption_date = CURDATE() 
	WHERE pet_id = v_pet_id;
	-- Reject all other pending applications for this pet
	UPDATE Application
	SET status = 'Rejected',
	notes = CONCAT(IFNULL(notes, ''), '\n[', CURDATE(), '] Auto-rejected: Pet was adopted')
	WHERE pet_id = v_pet_id AND app_id != p_app_id AND status = 'Pending';
    ELSEIF p_status = 'Rejected' THEN
	-- Check if there are other pending applications
	IF NOT EXISTS (SELECT 1 FROM Application WHERE pet_id = v_pet_id AND status = 'Pending' AND app_id != p_app_id) THEN
		UPDATE Pets SET status = 'Available' WHERE pet_id = v_pet_id;
		END IF;
    END IF;
    COMMIT;
END //



DELIMITER //
-- Procedure 4: Get available pets
CREATE PROCEDURE sp_get_available_pets(
    IN p_species_id INT,
    IN p_breed_id INT
)
BEGIN
    IF p_species_id IS NOT NULL AND p_breed_id IS NOT NULL THEN
	SELECT p.pet_id, p.pet_name, p.age, p.gender, 
	s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available' 
	AND p.species_id = p_species_id 
	AND p.breed_id = p_breed_id
	ORDER BY p.intake_date DESC;
    ELSEIF p_species_id IS NOT NULL THEN
	SELECT p.pet_id, p.pet_name, p.age, p.gender, s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available' AND p.species_id = p_species_id
	ORDER BY p.intake_date DESC;
    ELSE
	SELECT p.pet_id, p.pet_name, p.age, p.gender, s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available'
	ORDER BY p.intake_date DESC;
    END IF;
END //


DELIMITER //
-- Procedure 5: Delete pet (with safety checks)
CREATE PROCEDURE sp_delete_pet(IN p_pet_id INT)
BEGIN
DECLARE v_pet_status VARCHAR(20);
DECLARE v_pending_apps INT;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error deleting pet';
END;    
START TRANSACTION;
-- Check pet status
SELECT status INTO v_pet_status FROM Pets WHERE pet_id = p_pet_id;
IF v_pet_status IS NULL THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Pet does not exist';
END IF;
IF v_pet_status = 'Adopted' THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Cannot delete adopted pet - archive instead';
END IF;
-- Check for pending applications
SELECT COUNT(*) INTO v_pending_apps 
FROM Application 
WHERE pet_id = p_pet_id AND status = 'Pending';
IF v_pending_apps > 0 THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Cannot delete pet with pending applications';
END IF;
DELETE FROM Pets WHERE pet_id = p_pet_id;
    COMMIT;
END //


DELIMITER //
-- Procedure 6: Update pet information
CREATE PROCEDURE sp_update_pet(
    IN p_pet_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_shelter_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error updating pet information';
    END;
    START TRANSACTION;
    IF p_age < 0 OR p_age > 30 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid age: must be between 0 and 30';
    END IF;
    UPDATE Pets 
    SET pet_name = p_name, age = p_age, shelter_id = p_shelter_id
    WHERE pet_id = p_pet_id;
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Pet not found';
    END IF;
    COMMIT;
END //


DELIMITER //
-- Procedure 7: Add new adopter
CREATE PROCEDURE sp_add_adopter(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_city VARCHAR(100),
    IN p_country VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error adding adopter - email may already exist';
    END;
    START TRANSACTION;
    INSERT INTO Adopters (adp_name, email, phone, city, country)
    VALUES (p_name, p_email, p_phone, p_city, p_country);
    COMMIT;
END //



-- STORED FUNCTIONS ******************

DELIMITER //
-- Function 1: Count pets by status
CREATE FUNCTION fn_count_pets_by_status(p_status VARCHAR(20))
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE pet_count INT;
    SELECT COUNT(*) INTO pet_count 
    FROM Pets 
    WHERE status = p_status;
    RETURN pet_count;
END //

DELIMITER //
-- Function 2: Get adopter's application count
CREATE FUNCTION fn_adopter_application_count(p_adp_id INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE app_count INT;
    SELECT COUNT(*) INTO app_count 
    FROM Application 
    WHERE adp_id = p_adp_id;
    RETURN app_count;
END //


DELIMITER //
-- Function 3: Calculate shelter occupancy percentage
CREATE FUNCTION fn_shelter_occupancy_rate(p_shelter_id INT)
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE current_pets INT;
    DECLARE max_capacity INT;
    DECLARE occupancy_rate DECIMAL(5,2);
    SELECT COUNT(*) INTO current_pets 
    FROM Pets 
    WHERE shelter_id = p_shelter_id AND status != 'Adopted';
    SELECT capacity INTO max_capacity 
    FROM Shelter 
    WHERE shelter_id = p_shelter_id;
    IF max_capacity > 0 THEN
        SET occupancy_rate = (current_pets / max_capacity) * 100;
    ELSE
        SET occupancy_rate = 0;
    END IF;
    RETURN occupancy_rate;
END //


DELIMITER //
-- Function 4: Get average pet age by species
CREATE FUNCTION fn_avg_pet_age_by_species(p_species_id INT)
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE avg_age DECIMAL(5,2);
    SELECT AVG(age) INTO avg_age
    FROM Pets
    WHERE species_id = p_species_id;
    RETURN IFNULL(avg_age, 0);
END //



-- TRIGGERS *********************

DELIMITER //
-- Trigger 1: Prevent deletion of pets with pending applications
CREATE TRIGGER trig_before_pet_delete
BEFORE DELETE ON Pets
FOR EACH ROW
BEGIN
    DECLARE pending_count INT;
    SELECT COUNT(*) INTO pending_count
    FROM Application
    WHERE pet_id = OLD.pet_id AND status = 'Pending';
    IF pending_count > 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Cannot delete pet with pending applications';
    END IF;
END //

DELIMITER //
-- Trigger 2: Auto-update pet status when application approved
CREATE TRIGGER trig_after_application_approval
AFTER UPDATE ON Application
FOR EACH ROW
BEGIN
IF NEW.status = 'Approved' AND OLD.status != 'Approved' THEN
-- Ensure pet is marked as adopted (redundant safety check)
	UPDATE Pets 
	SET status = 'Adopted', adoption_date = CURDATE()
	WHERE pet_id = NEW.pet_id AND status != 'Adopted';
    END IF;
END //


DELIMITER //
-- Trigger 3: Validate application before insert
CREATE TRIGGER trig_before_application_insert
BEFORE INSERT ON Application
FOR EACH ROW
BEGIN
    DECLARE pet_status VARCHAR(20);
    SELECT status INTO pet_status FROM Pets WHERE pet_id = NEW.pet_id;
    IF pet_status = 'Adopted' THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Cannot apply for an adopted pet';
    END IF;
    -- Set default application date if not provided
    IF NEW.app_date IS NULL THEN
	SET NEW.app_date = CURDATE();
    END IF;
END //
DELIMITER ;



-- Events ***************

DELIMITER //
-- Event 1 : Clean up old rejected applications every day
CREATE EVENT event_cleanup_old_applications
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO BEGIN
-- Delete applications rejected more than 6 months ago
DELETE FROM Application
WHERE status = 'Rejected' 
AND review_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END //
DELIMITER ;

-- Event verification 
SHOW EVENTS;
SELECT * FROM information_schema.EVENTS 
WHERE EVENT_SCHEMA = 'pet_adoption_system';


-- View *********

-- View 1: Complete pet information for project 
CREATE VIEW vw_pets_detailed AS
SELECT 
    p.pet_id,
    p.pet_name,
    p.age,
    p.gender,
    p.status,
    s.species_name,
    b.breed_name,
    sh.name AS shelter_name,
    sh.city AS shelter_city,
    p.intake_date,
    p.adoption_date,
    DATEDIFF(IFNULL(p.adoption_date, CURDATE()), p.intake_date) AS days_in_shelter
FROM Pets p
JOIN Species s ON p.species_id = s.species_id
JOIN Breeds b ON p.breed_id = b.breed_id
JOIN Shelter sh ON p.shelter_id = sh.shelter_id;

-- verfiying View 
SHOW FULL TABLES WHERE Table_type = 'VIEW';

SELECT * FROM vw_pets_detailed;



