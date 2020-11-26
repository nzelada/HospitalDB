-- Create tables

CREATE TABLE EMPLOYEE (
    SSN VARCHAR(11) NOT NULL, 
	E_First_name VARCHAR(30) NOT NULL,
    E_Last_name VARCHAR(30) NOT NULL,
    E_mint CHAR(1),
	DOB DATE NOT NULL,
    E_Gender CHAR(1) NOT NULL,
    E_Salary INTEGER NOT NULL CHECK (E_Salary >= 0),
    House_numb VARCHAR(7) NOT NULL,
    Street VARCHAR(12) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip_code INTEGER NOT NULL,
    Type VARCHAR(12) NOT NULL,
    PRIMARY KEY (SSN)
    );

CREATE TABLE PATIENT (
    Patient_ID SMALLINT NOT NULL CHECK (Patient_ID >=0),
    SSN VARCHAR(11) NOT NULL, 
	P_First_name VARCHAR(30) NOT NULL,
    P_Last_name VARCHAR(30) NOT NULL,
    P_mint CHAR(1),
    DOB DATE NOT NULL,
    P_Gender CHAR(1) NOT NULL,
    House_numb VARCHAR(7) NOT NULL,
    Street VARCHAR(12) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip_code INTEGER NOT NULL,
    PRIMARY KEY (Patient_ID)
    );

CREATE TABLE SERVICE (
    Service_code VARCHAR(5) NOT NULL,
    Description VARCHAR(255),
    Ser_patient_ID SMALLINT NOT NULL CHECK (Ser_patient_ID >=0),
    Ser_SSN VARCHAR(11) NOT NULL, 
    PRIMARY KEY (Service_code),
    FOREIGN KEY (Ser_patient_ID) 
	REFERENCES PATIENT (Patient_ID),
    FOREIGN KEY (Ser_SSN) 
	REFERENCES EMPLOYEE (SSN)
    );

CREATE TABLE RECEPTIONIST (
    Receptionist_ID SMALLINT NOT NULL CHECK (Receptionist_ID >=0),
    Rec_SSN VARCHAR(11) NOT NULL, 
    PRIMARY KEY (Receptionist_ID),
    FOREIGN KEY (Rec_SSN) 
	REFERENCES EMPLOYEE (SSN)
    );

CREATE TABLE RECORD (
    Recp_number SMALLINT NOT NULL CHECK (Recp_number >=0),
    Rec_date DATE NOT NULL,
    Observation VARCHAR(255) DEFAULT NULL,
    Rec_receptionist_ID SMALLINT NOT NULL CHECK (Rec_receptionist_ID >=0),
    Rec_patient_ID SMALLINT NOT NULL CHECK (Rec_patient_ID >=0),
    PRIMARY KEY (Recp_number),
    FOREIGN KEY (Rec_receptionist_ID) 
	REFERENCES RECEPTIONIST (Receptionist_ID),
    FOREIGN KEY (Rec_patient_ID) 
	REFERENCES PATIENT (Patient_ID)
    );

CREATE TABLE NURSE (
    Nurse_ID SMALLINT NOT NULL CHECK (Nurse_ID >=0),
    Nur_SSN VARCHAR(11) NOT NULL, 
    PRIMARY KEY (Nurse_ID),
    FOREIGN KEY (Nur_SSN) 
	REFERENCES EMPLOYEE (SSN)
    );

CREATE TABLE ROOM (
    Room_numb SMALLINT NOT NULL CHECK (Room_numb >=0),
    Numb_Bed SMALLINT NOT NULL,
    Date_in DATE,
    Date_out DATE,
    Room_type VARCHAR(30),
    Roo_nurse_ID SMALLINT NOT NULL CHECK (Roo_nurse_ID >=0),
    Roo_patient_ID SMALLINT CHECK (Roo_patient_ID >=0),
    PRIMARY KEY (Room_numb),
    FOREIGN KEY (Roo_nurse_ID) 
	REFERENCES NURSE (Nurse_ID),
    FOREIGN KEY (Roo_patient_ID) 
	REFERENCES PATIENT (Patient_ID)
    );

CREATE TABLE DOCTOR (
    Doctor_ID SMALLINT NOT NULL CHECK (Doctor_ID >=0),
    Doc_SSN VARCHAR(11) NOT NULL, 
    Specialty VARCHAR(30) NOT NULL,
    PRIMARY KEY (Doctor_ID),
    FOREIGN KEY (Doc_SSN) 
	REFERENCES EMPLOYEE (SSN)
    );

CREATE TABLE VISIT (
    Vis_patient_ID SMALLINT NOT NULL CHECK (Vis_patient_ID >=0),
    Vis_doctor_ID SMALLINT NOT NULL CHECK (Vis_doctor_ID >=0),
    Visit_date DATE NOT NULL,
    FOREIGN KEY (Vis_patient_ID) 
	REFERENCES PATIENT (Patient_ID),
    FOREIGN KEY (Vis_doctor_ID) 
	REFERENCES DOCTOR (Doctor_ID)
     );

CREATE TABLE MEDICATION (
    Med_code SMALLINT NOT NULL CHECK (Med_code >=0),
    Med_name VARCHAR(30) NOT NULL,
    List_price NUMERIC(6,2) NOT NULL,
    Manufacturer VARCHAR(30) NOT NULL,
    Class VARCHAR(30) NOT NULL,
    Description VARCHAR(255),
    PRIMARY KEY(Med_code, Med_name)
    );
CREATE TABLE PRESCRIPTION (
    Presc_Code SMALLINT NOT NULL CHECK (Presc_Code >=0),
    Frequency VARCHAR(50) NOT NULL,
    Dosage VARCHAR(30) NOT NULL,
    Pre_med_code SMALLINT NOT NULL CHECK (Pre_med_code >=0),
    Pre_med_name VARCHAR(30) NOT NULL,
    Pre_patient_ID SMALLINT NOT NULL CHECK (Pre_patient_ID >=0),
    Pre_doctor_ID SMALLINT NOT NULL CHECK (Pre_doctor_ID >=0),
    PRIMARY KEY(Presc_Code),
    FOREIGN KEY (Pre_med_code,Pre_med_name) 
	REFERENCES MEDICATION (Med_code, Med_name),
    FOREIGN KEY (Pre_patient_ID) 
	REFERENCES PATIENT (Patient_ID),
    FOREIGN KEY (Pre_doctor_ID) 
	REFERENCES DOCTOR (Doctor_ID)
    );

CREATE TABLE TREATMENT (
    Tre_code SMALLINT NOT NULL CHECK (Tre_code >=0),
    Tre_cost NUMERIC(9,2) NOT NULL,
    Quantity SMALLINT NOT NULL CHECK (Quantity >=0),
    Tre_patient_ID SMALLINT NOT NULL CHECK (Tre_patient_ID >=0),
    PRIMARY KEY(Tre_code),
    FOREIGN KEY (Tre_patient_ID) 
	REFERENCES PATIENT (Patient_ID)
    );

CREATE TABLE TAKE_TREATMENT (
    Tak_med_code SMALLINT NOT NULL CHECK (Tak_med_code >=0),
    Tak_med_name VARCHAR(30) NOT NULL,
    Tak_trea_code SMALLINT NOT NULL CHECK (Tak_trea_code >=0), 
    FOREIGN KEY (Tak_med_code, Tak_med_name) 
	REFERENCES MEDICATION (Med_code, Med_name),
    FOREIGN KEY (Tak_trea_code) 
	REFERENCES TREATMENT (Tre_code)
    );

CREATE TABLE PHONE (
    Number VARCHAR(11) NOT NULL CHECK (Number >= 0),
    Type VARCHAR(8),
    Pho_patient_ID SMALLINT DEFAULT NULL CHECK (Pho_patient_ID >=0), 
    Pho_SSN VARCHAR(11) DEFAULT NULL,
    FOREIGN KEY (Pho_patient_ID) 
	REFERENCES PATIENT (Patient_ID),
    FOREIGN KEY (Pho_SSN) 
	REFERENCES EMPLOYEE (SSN)
    );

-- Adding data

-- Employee table
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('103-93-6483','Godfrey','O''Neal',NULL,'1962-07-11','M',42000,9,'Butterfield','Los Angeles','CA',90094,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('108-46-6826','Kala','Burfoot','T','1961-03-25','F',79000,2387,'Banding','Norwalk','CT',6854,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('116-97-0588','Steban','Perez',NULL,'1985-07-25','M',95000,8586,'Calzada','Los Angeles','CA',90094,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('116-97-9588','Niko','Scrivin','D','1989-11-21','M',94000,87,'Di Loreto','Albuquerque','NM',87180,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('125-75-7889','Vail','Crunkhurn',NULL,'1994-10-05','M',37000,29,'Green','Norfolk','VA',23520,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('152-16-9131','Eldin','Aris',NULL,'1963-04-05','M',59000,5,'Springview','Hollywood','FL',33023,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('153-08-5183','Sigismondo','Hanvey',NULL,'1991-01-30','M',91000,1660,'Artisan','Waterbury','CT',6705,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('191-39-5536','Curtice','Dagnall','E','1996-06-15','M',79000,3,'Sachs','Lubbock','TX',79415,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('201-02-4429','Debbi','Leicester',NULL,'1972-05-12','F',89000,878,'Hazelcrest','Hollywood','FL',33023,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('220-12-8066','Rem','Cawtheray',NULL,'1973-12-10','M',53000,81,'Maywood','Waco','TX',76796,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('220-60-1678','Vale','Howieson',NULL,'1995-01-16','F',32000,994,'Toban','Ashburn','VA',22093,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('225-46-0824','Cordy','Bellingham',NULL,'1970-12-28','M',73000,88797,'Farwell','Washington','DC',20420,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('227-69-7912','Roarke','Danton',NULL,'1996-06-16','M',39000,448,'Leroy','Las Vegas','NV',89140,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('231-31-2299','Richmond','Habin',NULL,'1985-07-09','M',98000,9659,'Donald','Grand Rapids','MI',49510,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('252-73-0584','Thornton','Ziemen',NULL,'1982-05-30','M',72000,934,'Valley Edge','Raleigh','NC',27610,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('252-79-3221','Marco','Lewing','R','1976-10-08','M',81000,841,'Oak Valley','Cedar Rapids','IA',52410,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('299-20-3598','Kris','Hebdon',NULL,'1973-12-28','M',57000,2,'Kenwood','Jacksonville','FL',32215,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('312-71-6169','Nilson','Ferrao',NULL,'1963-07-24','M',85000,9224,'Daystar','Washington','DC',20456,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('312-74-4316','Jemie','Scini','M','1975-02-08','F',51000,2487,'Shoshone','Myrtle Beach','SC',29579,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('319-15-2042','Eugenio','Beeby','H','1978-09-14','M',86000,5,'Tennessee','Pittsburgh','PA',15261,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('346-66-5591','Kiri','Chatband',NULL,'1966-08-08','F',34000,98922,'Saint Paul','Austin','TX',78721,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('352-85-9800','Erich','Richley',NULL,'1993-11-02','M',77000,8,'Superior','Louisville','KY',40293,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('367-88-5835','Yul','Rennles','F','1975-09-13','M',73000,6208,'Karstens','New York City','NY',10115,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('390-28-7016','Meridith','Donnellan',NULL,'1996-10-31','F',67000,14880,'Parkside','Naples','FL',33961,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('462-13-2675','Isidro','Blasik',NULL,'1966-05-11','M',30000,50974,'Porter','Santa Ana','CA',92705,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('465-45-4254','Neville','Bertram',NULL,'1995-03-27','M',48000,77,'Talmadge','Edmond','OK',73034,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('478-16-2172','Kaine','Grice',NULL,'1975-06-25','M',79000,522,'Autumn Leaf','North Little Rock','AR',72118,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('489-80-3517','Joice','Franchioni',NULL,'1984-07-31','F',74000,6,'Glendale','Gary','IN',46406,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('492-58-8333','Bella','Braikenridge',NULL,'1978-10-07','F',89000,3,'Hagan','Sacramento','CA',94257,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('512-69-4102','Donavon','Helbeck',NULL,'1985-12-21','M',97000,5298,'Packers','Tyler','TX',75705,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('535-55-5449','Clarabelle','Warsap',NULL,'1973-03-21','F',76000,64348,'Debra','Washington','DC',20046,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('545-58-6936','Alejandrina','Stoyles',NULL,'1989-04-27','F',34000,58588,'Sage','Springfield','MA',1152,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('565-91-1340','Carney','Errichiello',NULL,'1978-05-28','M',39000,9,'Drewry','Dallas','TX',75216,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('572-58-4474','Dallas','Admans','J','1963-11-20','F',54000,6865,'Rutledge','Savannah','GA',31405,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('587-76-4211','Lodovico','McElroy',NULL,'1964-03-23','M',79000,3,'Mendota','Atlanta','GA',30316,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('596-01-1699','Quinlan','Welham',NULL,'1972-08-25','M',49000,13,'Northview','Shawnee Mission','KS',66225,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('600-57-6537','Yuri','Drezzer',NULL,'1983-02-14','M',40000,4,'Maple','Dallas','TX',75353,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('608-04-7124','Katherina','Pascow',NULL,'1978-07-25','F',41000,28318,'Del Sol','Houston','TX',77228,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('623-99-7156','Leandra','Fermer',NULL,'1981-12-28','F',86000,6,'Larry','Fort Myers','FL',33994,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('655-75-4766','Koo','Surgener',NULL,'1962-11-26','F',48000,5167,'Clove','Fort Worth','TX',76110,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('656-91-6256','Alida','Winterbotham',NULL,'1961-07-24','F',62000,72524,'Basil','Amarillo','TX',79176,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('669-76-3171','Yolanthe','Pyne',NULL,'1966-10-21','F',44000,5237,'Grover','Boston','MA',2104,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('676-39-4059','Cissiee','Tomeo',NULL,'1976-04-13','F',59000,93906,'Straubel','Denver','CO',80299,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('685-39-9060','Dallas','O''Farrell',NULL,'1982-03-20','M',62000,62,'David','Birmingham','AL',35285,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('696-09-7294','Tabbie','Stainsby','S','1978-11-10','F',97000,9,'Arrowood','Louisville','KY',40266,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('743-97-5168','Walden','Hollingdale','G','1968-11-13','M',58000,76,'Mesta','Simi Valley','CA',93094,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('748-61-9581','Maddalena','Castledine',NULL,'1969-02-05','F',38000,6,'Canary','Miami','FL',33196,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('759-07-0650','Nari','O''Halloran',NULL,'1977-03-11','F',45000,7225,'Sachs','Homestead','FL',33034,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('760-81-1429','Aloin','Rigby',NULL,'1993-03-19','M',69000,8132,'Chive','Dayton','OH',45426,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('761-59-1002','Genvieve','Ronisch',NULL,'1961-08-11','F',79000,65,'Dottie','Dallas','TX',75310,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('781-48-4994','Lizzie','Strugnell',NULL,'1988-08-02','F',30000,864,'Mosinee','New Orleans','LA',70183,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('788-30-3311','Marilyn','Bunnell',NULL,'1987-06-20','F',50000,84,'Texas','Kansas City','MO',64190,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('788-94-4012','Tedmund','Roke',NULL,'1987-09-22','M',83000,59099,'Pepper Wood','El Paso','TX',88535,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('805-25-3849','Avrit','Jelf',NULL,'1995-09-30','F',64000,1,'Utah','Abilene','TX',79699,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('815-55-2301','Antin','Bindon',NULL,'1975-10-09','M',56000,8,'Tony','Indianapolis','IN',46231,'Nurse');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('832-98-1677','Mickey','Hollerin',NULL,'1969-06-10','M',96000,383,'Sheridan','Davenport','IA',52809,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('834-50-4860','Dredi','Luce',NULL,'1976-05-03','F',95000,29,'Rowland','Birmingham','AL',35215,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('839-88-1696','Serene','Partkya','I','1972-01-15','F',81000,6719,'Gerald','Chicago','IL',60619,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('847-24-3190','Janeta','Snelle',NULL,'1995-06-18','F',32000,54409,'Sutherland','Elizabeth','NJ',7208,'Recepcionist');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('867-51-5970','Christa','Boothroyd',NULL,'1977-07-10','F',89000,10,'Westridge','Arlington','VA',22244,'Doctor');
INSERT INTO Employee(SSN,E_First_name,E_Last_name,E_mint,DOB,E_Gender,E_Salary,House_numb,Street,City,State,Zip_code,Type) VALUES ('884-06-1502','Wileen','Bogies',NULL,'1974-10-15','F',31000,3225,'Hovde','Erie','PA',16550,'Recepcionist');

-- Patient table
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (1,'387-11-5702','Lucio','Megarrell',NULL,'1978-12-18','M',358,'Glacier Hill','Newton','MA',2162);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (2,'819-11-9347','Walton','Stivani','H','1971-02-22','M',2,'Melody','Toledo','OH',43666);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (3,'549-54-9973','Tasia','Jizhaki',NULL,'2013-04-09','F',1607,'Westend','Birmingham','AL',35210);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (4,'896-38-8378','Augustus','Kinnon',NULL,'1986-01-26','M',276,'Ryan','Houston','TX',77060);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (5,'612-21-7145','Milicent','Bamborough',NULL,'1967-07-01','F',2386,'Novick','Aurora','CO',80045);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (6,'435-03-3405','Gerladina','Blune','R','1971-04-11','F',54,'Coleman','Sacramento','CA',95865);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (7,'721-25-5224','Padget','Mousby',NULL,'1984-01-25','M',21,'Manitowish','Tulsa','OK',74184);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (8,'138-13-9500','Ed','Yukhov',NULL,'1970-02-21','M',924,'Southridge','Abilene','TX',79605);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (9,'164-66-7604','Jenifer','Biffen',NULL,'1993-05-08','F',23505,'Tennessee','Dallas','TX',75277);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (10,'775-09-2759','Jaymie','Rosoman',NULL,'2006-08-30','M',2437,'Sloan','Washington','DC',20088);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (11,'126-70-0717','Broddy','Hacquoil',NULL,'2004-11-02','M',2,'Thackeray','El Paso','TX',79940);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (12,'895-49-1813','Ashley','Laban',NULL,'1981-12-08','F',3323,'Graceland','Wichita Falls','TX',76310);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (13,'362-02-1978','Keary','Olden','L','1981-08-03','M',13384,'South','Pittsburgh','PA',15266);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (14,'841-06-9584','Taddeo','Skill',NULL,'1964-10-10','M',7197,'Northwestern','Lima','OH',45807);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (15,'490-82-0920','Giulio','Surcomb',NULL,'1981-11-01','M',33338,'Lerdahl','Knoxville','TN',37995);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (16,'820-45-1406','Daniele','Pepperill',NULL,'1966-02-05','F',543,'Novick','Mobile','AL',36670);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (17,'446-82-5000','Hort','McCumskay',NULL,'1987-12-13','M',856,'Raven','Fresno','CA',93794);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (18,'495-52-7601','Zachariah','Felce',NULL,'1995-01-09','M',7643,'Duke','Gadsden','AL',35905);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (19,'702-55-5395','Boot','Gerauld',NULL,'2003-10-06','M',49808,'Moose','Philadelphia','PA',19104);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (20,'744-32-9243','Konrad','Mangin','T','1978-11-05','M',9579,'Harbort','Levittown','PA',19058);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (21,'506-64-3574','Tonnie','Druett',NULL,'2018-11-08','M',45432,'Macpherson','Birmingham','AL',35231);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (22,'241-46-1143','Farrah','Kinnard',NULL,'1961-06-13','F',6567,'Westridge','Atlanta','GA',30351);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (23,'886-13-7375','Shandie','Jorry',NULL,'1997-10-07','F',1,'Gerald','Duluth','MN',55811);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (24,'765-06-6268','Aubry','Clace',NULL,'1965-10-20','F',2,'Erie','Spokane','WA',99252);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (25,'851-92-1857','Roana','Moy',NULL,'1987-11-24','F',592,'Rigney','Tampa','FL',33661);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (26,'743-38-9174','Cloris','Cescotti',NULL,'2001-11-23','F',8141,'Dennis','Sacramento','CA',94237);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (27,'193-57-3138','Zelma','Limeburn','N','1980-02-29','F',590,'Maple Wood','Trenton','NJ',8608);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (28,'462-77-5070','Rinaldo','Huntingford',NULL,'1986-02-06','M',12242,'Merrick','Buffalo','NY',14263);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (29,'322-89-6970','Tabina','Wainscoat',NULL,'1995-12-10','F',6,'School','Shawnee Mission','KS',66205);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (30,'176-29-5083','Kimbell','Russo',NULL,'2010-07-10','M',863,'Basil','Omaha','NE',68197);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (31,'677-72-2537','Mozelle','Culligan',NULL,'1984-12-03','F',8771,'Warner','Washington','DC',20099);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (32,'478-96-8949','Othello','Celli',NULL,'1987-11-06','M',1,'Mifflin','El Paso','TX',88553);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (33,'598-52-0995','Ferrell','Eden',NULL,'2016-03-18','M',365,'Rockefeller','Detroit','MI',48242);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (34,'831-15-5441','Rafi','Cramb',NULL,'1978-07-14','M',4016,'La Follette','Minneapolis','MN',55428);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (35,'137-23-8583','Pablo','Aphale',NULL,'1996-11-15','M',859,'Bunker Hill','Charlotte','NC',28210);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (36,'532-86-3139','Demetri','Prestner',NULL,'1975-04-16','M',2885,'Anthes','Baton Rouge','LA',70894);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (37,'587-68-9711','Elvin','Pietrusiak',NULL,'1987-12-12','M',11,'Delladonna','Colorado Springs','CO',80905);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (38,'880-87-2665','Sheffield','Marginson',NULL,'2003-06-04','M',69,'Kinsman','Silver Spring','MD',20918);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (39,'289-55-8088','Madalyn','Murrow','E','1969-03-19','F',6554,'Daystar','Fort Wayne','IN',46867);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (40,'486-58-1968','Jerri','Rusbridge',NULL,'1961-03-26','M',80,'Dixon','Saint Louis','MO',63143);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (41,'847-44-0799','Lindsey','Andrault',NULL,'2019-02-11','M',8454,'Shelley','Columbus','GA',31904);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (42,'714-54-0632','Cris','MacQueen',NULL,'1987-02-20','M',41663,'Maple','Atlanta','GA',31119);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (43,'179-94-3432','Sofia','Brayshay',NULL,'1987-08-22','F',6074,'Judy','Chattanooga','TN',37405);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (44,'205-27-0195','Alexandro','Brandle',NULL,'1988-11-28','M',988,'Village','Albany','NY',12242);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (45,'355-71-9098','Antonin','Hawkey',NULL,'1985-04-25','M',3757,'Pankratz','Dallas','TX',75236);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (46,'324-85-5214','Isa','Risebrow',NULL,'1995-07-02','M',8,'Graceland','Fresno','CA',93786);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (47,'218-62-2850','Darice','McIlrath',NULL,'1993-01-04','F',42,'Commercial','Columbus','OH',43284);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (48,'880-22-2527','Farrand','Wartnaby',NULL,'1981-01-27','F',28373,'Donald','Oakland','CA',94616);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (49,'231-87-4322','Brandea','Hawkeswood',NULL,'1995-03-17','F',165,'Annamark','Murfreesboro','TN',37131);
INSERT INTO Patient(Patient_ID,SSN,P_First_name,P_Last_name,P_mint,DOB,P_Gender,House_numb,Street,City,State,Zip_code) VALUES (50,'502-79-9810','Shandee','Hardacre',NULL,'1978-04-15','F',6576,'Mosinee','Las Vegas','NV',89125);

-- Service table
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('M239', 'Replacement of Left Internal Iliac Artery with Autologous Tissue Substitute, Open Approach', 2, '116-97-0588');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('Q32', 'Drainage of Right Ulna, Percutaneous Endoscopic Approach', 5, '116-97-9588');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S910', 'Drainage of Pancreatic Duct, Percutaneous Endoscopic Approach', 8, '153-08-5183');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('O648', 'Reposition Right Wrist Joint with Internal Fixation Device, Percutaneous Approach', 10, '201-02-4429');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S52', 'Insertion of Intraluminal Device into Right External Jugular Vein, Percutaneous Endoscopic Approach', 14, '231-31-2299');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('T43', 'Release Thoracic Aorta, Descending, Percutaneous Approach', 17, '312-71-6169');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S10', 'Destruction of Left Upper Femur, Open Approach', 19, '319-15-2042');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S703', 'Removal of Nonautologous Tissue Substitute from Urethra, Via Natural or Artificial Opening Endoscopic', 22, '352-85-9800');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S769', 'Excision of Glossopharyngeal Nerve, Open Approach, Diagnostic', 24, '478-16-2172');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S92', 'Destruction of Right Inferior Parathyroid Gland, Percutaneous Endoscopic Approach', 26, '492-58-8333');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S481', 'Drainage of Posterior Neck Subcutaneous Tissue and Fascia, Open Approach, Diagnostic', 28, '512-69-4102');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S723', 'Repair Bilateral Spermatic Cords, Percutaneous Approach', 30, '587-76-4211');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S599', 'Removal of Synthetic Substitute from Left Pleural Cavity, Percutaneous Approach', 33, '623-99-7156');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S01', 'Restriction of Right Ulnar Artery with Extraluminal Device, Percutaneous Approach', 36, '696-09-7294');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S808', 'Planar Nuclear Medicine Imaging of Lower Extremity using Iodine 131 (I-131)', 39, '761-59-1002');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S62', 'Repair Stomach, Via Natural or Artificial Opening Endoscopic', 40, '788-94-4012');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S523', 'Dilation of Right Vertebral Artery, Bifurcation, with Intraluminal Device, Percutaneous Approach', 43 , '832-98-1677');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S60', 'Fluoroscopy of Right Pulmonary Vein using Low Osmolar Contrast, Guidance', 44, '834-50-4860');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S89', 'Revision of Nonautologous Tissue Substitute in Right Metatarsal, Percutaneous Approach',47 , '839-88-1696');
Insert INTO Service (Service_code, Description, Ser_patient_ID, Ser_SSN) VALUES ('S72', 'Supplement Right External Ear with Synthetic Substitute, Open Approach', 49, '867-51-5970');

-- Recepcionist table
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (301,'103-93-6483');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (302,'125-75-7889');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (303,'220-60-1678');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (304,'227-69-7912');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (305,'312-74-4316');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (306,'346-66-5591');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (307,'462-13-2675');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (308,'545-58-6936');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (309,'565-91-1340');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (310,'596-01-1699');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (311,'600-57-6537');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (312,'608-04-7124');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (313,'655-75-4766');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (314,'669-76-3171');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (315,'743-97-5168');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (316,'748-61-9581');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (317,'759-07-0650');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (318,'781-48-4994');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (319,'788-30-3311');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (320,'847-24-3190');
INSERT INTO Receptionist(Receptionist_ID,Rec_SSN) VALUES (321,'884-06-1502');

-- Record table 
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3510,'2020-11-19',NULL,301,2);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3511,'2020-08-25',NULL,302,3);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3512,'2020-11-20',NULL,303,5);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3513,'2020-11-19',NULL,304,6);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3514,'2020-11-20',NULL,305,9);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3515,'2020-11-21',NULL,306,11);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3516,'2020-11-20',NULL,307,13);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3517,'2020-11-19',NULL,308,16);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3518,'2020-11-18',NULL,310,23);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3519,'2020-11-17',NULL,321,24);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3520,'2020-11-15',NULL,311,25);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3521,'2020-10-31',NULL,312,26);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3522,'2020-11-07',NULL,313,29);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3523,'2020-10-25',NULL,314,32);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3524,'2020-11-20',NULL,315,35);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3525,'2020-11-18',NULL,316,37);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3526,'2020-10-28',NULL,317,41);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3527,'2020-11-15',NULL,318,43);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3528,'2020-10-29',NULL,319,47);
INSERT INTO Record(Recp_number,Rec_date,Observation,Rec_receptionist_ID,Rec_patient_ID) VALUES (3529,'2020-10-15',NULL,320,48);

-- Nurse table 
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (210,'108-46-6826');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (211,'152-16-9131');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (212,'191-39-5536');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (213,'220-12-8066');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (214,'225-46-0824');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (215,'252-73-0584');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (216,'252-79-3221');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (217,'299-20-3598');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (218,'367-88-5835');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (219,'390-28-7016');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (220,'465-45-4254');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (221,'489-80-3517');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (222,'535-55-5449');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (223,'572-58-4474');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (224,'656-91-6256');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (225,'676-39-4059');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (226,'685-39-9060');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (227,'760-81-1429');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (228,'805-25-3849');
INSERT INTO Nurse(Nurse_ID,Nur_SSN) VALUES (229,'815-55-2301');

-- Room table
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1125,1,'2020-11-19',NULL,'via ER',210,2);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1126,2,'2020-08-25',NULL,'No via ER',210,3);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1127,1,'2020-11-20',NULL,'via ER',211,5);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1128,2,NULL,NULL,NULL,212,NULL);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1129,2,'2020-11-19',NULL,'No via ER',213,6);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1130,1,NULL,NULL,NULL,213,NULL);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1131,2,'2020-11-20',NULL,'via ER',213,9);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1132,1,'2020-11-21','2020-11-22','via ER',214,11);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1133,2,NULL,NULL,NULL,214,NULL);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1134,1,'2020-11-20',NULL,'via ER',215,13);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1135,1,'2020-11-19','2020-11-22','No via ER',216,16);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1136,1,NULL,NULL,NULL,217,NULL);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1137,1,NULL,NULL,NULL,218,NULL);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1138,1,'2020-11-18',NULL,'No via ER',219,23);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1139,2,'2020-11-17','2020-11-20','via ER',219,24);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1140,1,'2020-11-15','2020-11-18','No via ER',220,25);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1141,2,'2020-10-31','2020-11-03','No via ER',221,26);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1142,2,'2020-11-07','2020-11-20','No via ER',222,29);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1143,1,'2020-10-25','2020-11-01','via ER',223,32);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1144,1,'2020-11-20',NULL,'via ER',224,35);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1145,2,'2020-11-18','2020-11-22','via ER',225,37);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1146,1,'2020-10-28',NULL,'No via ER',226,41);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1147,1,'2020-11-15',NULL,'No via ER',227,43);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1148,1,'2020-10-29','2020-11-04','No via ER',228,47);
INSERT INTO Room(Room_numb,Numb_Bed,Date_in,Date_out,Room_type,Roo_nurse_ID,Roo_patient_ID) VALUES (1149,2,'2020-10-15',NULL,'via ER',229,48);

-- Doctor table
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (101,'116-97-0588','neurologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (102,'116-97-9588','endocrinologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (103,'153-08-5183','pulmonologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (104,'201-02-4429','endocrinologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (105,'231-31-2299','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (106,'312-71-6169','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (107,'319-15-2042','internist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (108,'352-85-9800','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (109,'478-16-2172','pulmonologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (110,'492-58-8333','cardiologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (111,'512-69-4102','neurologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (112,'587-76-4211','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (113,'623-99-7156','pulmonologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (114,'696-09-7294','endocrinologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (115,'761-59-1002','pulmonologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (116,'788-94-4012','neurologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (117,'832-98-1677','neurologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (118,'834-50-4860','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (119,'839-88-1696','nephrologist');
INSERT INTO Doctor(Doctor_ID,Doc_SSN,Specialty) VALUES (120,'867-51-5970','internist');

-- Visit table
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (2,101,'2020-11-19');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (3,102,'2020-08-25');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (5,103,'2020-11-20');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (6,104,'2020-11-19');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (9,107,'2020-11-20');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (11,105,'2020-11-21');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (13,116,'2020-11-20');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (16,106,'2020-11-19');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (23,108,'2020-11-18');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (24,120,'2020-11-17');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (25,111,'2020-11-15');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (26,117,'2020-10-31');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (29,118,'2020-11-07');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (32,112,'2020-10-25');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (35,115,'2020-11-20');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (37,114,'2020-11-18');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (41,113,'2020-10-28');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (43,119,'2020-11-15');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (47,109,'2020-10-29');
INSERT INTO Visit(Vis_patient_ID,Vis_doctor_ID,Visit_date) VALUES (48,110,'2020-10-15');

-- Medication table
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (140,'Benzoyl Peroxide',870.05,'Stiefel Laboratories','Topical Antibiotics','PanOxyl');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (158,'CHLORPHENIRAMINE MALEATE',641.65,'AAA Pharmaceutical','Antihistamines','Chlorpheniramine Maleate, Phenylephrine Hydrochloride');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (160,'Diphenhydramine',155.65,'Johnson & Johnson','Antihistamines','Benadryl');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (165,'CETIRIZINE HYDROCHLORIDE',958.73,'Northstar Rx LLC','Antihistamines','CETIRIZINE HYDROCHLORIDE');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (167,'Triamcinolone Acetonide',999.36,'Physicians Total Care, Inc.','Corticosteroids','Triamcinolone Acetonide');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (168,'Betamethasone Dipropionate',298.53,'E. Fougera & Co.','Corticosteroids','Betamethasone Dipropionate');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (196,'Salicylic Acid',551.66,'Santalis Pharmaceuticals','Keratolytic Agents','Santalia Clinical Acne');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (247,'Acetaminophen',35.50,'McNeil Consumer Healthcare','NSAID','Tylenol');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (249,'Ibuprofen',20.50,'Pfizer','NSAID','Advil');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (264,'Hydromorphone Hydrochloride',343.24,'Roxane Laboratories, Inc','Opioid Analgesics','Hydromorphone Hydrochloride');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (298,'Morphine Sulfate',61.99,'Mylan Pharmaceuticals Inc.','Opioid Analgesics','Morphine Sulfate');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (299,'CETYLPYRIDINIUM CHLORIDE',772.39,'Target Corporation','Oral Antiseptic','Antiseptic');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (301,'TRICLOSAN',998.29,'Johnson Labs, Inc.','Antiseptic and Germicides','DELUXE ALL-PURPOSE');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (493,'EUCALYPTOL,MENTHOL',141.30,'McKesson','Antiseptic','Antiseptic');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (626,'Alcohol',500.61,'Bath & Body Works, Inc.','Psychoactive','Anti-Bacterial Hand');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (640,'Petrolatum',774.46,'Delon Laboratories (1990) Ltd','Topical ointment','Petroleum');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (781,'Ondansetron',7260.03,'Sandoz Inc','Antiemetic','Ondansetron');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (1019,'BEE VENOM',79.82,'Remedy Makers','Anti-inflammatory','APIS MELLIFICA');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4094,'Spironolactone',330.79,'Bryant Ranch Prepack','Potassium-sparing Diuretic','Spironolactone');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4733,'Alfuzosin Hydrochloride',1079.40,'Sun Pharma Global FZE','Alpha-adrenergic Blocker','Alfuzosin Hydrochloride');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4903,'Benzoyl Peroxide',673.96,'Wal-Mart Stores Inc','Antibacterial','Equate Repairing');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4933,'Furosemide',956.14,'REMEDYREPACK INC.','Loop diuretic','Furosemide');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4934,'Etodolac',222.53,'REMEDYREPACK INC.','NSAID','Etodolac');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4935,'OXCARBAZEPINE',91.20,'REMEDYREPACK INC.','Anticonvulsant','OXCARBAZEPINE');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (4936,'Phenytoin',559.94,'VistaPharm Inc.','Anticonvulsant','Phenytoin');
INSERT INTO Medication(Med_code,Med_name,List_price,Manufacturer,Class,Description) VALUES (5528,'Dexamethasone',690.42,'PD-Rx Pharmaceuticals, Inc.','Glucocorticoid','Dexamethasone');

-- Prescription table
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5695,'3 times per day','2 caps',247,'Acetaminophen',2,101);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5696,'2 times','IV twice',298,'Morphine Sulfate',2,101);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5697,'No more than 3 times per day','2 caps',249,'Ibuprofen',3,102);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5698,'No more than 3 times per day','2 caps',249,'Ibuprofen',5,103);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5699,'When pain is present, no more than 3 times per day','2 caps',4934,'Etodolac',6,104);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5700,'Once per day after procedure','IV 2 doses',264,'Hydromorphone Hydrochloride',9,107);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5701,'3 times per day if pain','2 caps',249,'Ibuprofen',9,107);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5702,'Once after surgery','1 dose IV',298,'Morphine Sulfate',11,105);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5703,'3 times per day if pain','2 caps',249,'Ibuprofen',11,105);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5704,'Once per day','10 caps',167,'Triamcinolone Acetonide',13,116);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5705,'Once per day if signs of allergy','7 caps',160,'Diphenhydramine',13,116);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5706,'2 times','IV once per day',4936,'Phenytoin',16,106);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5707,'No more than 4 caps per day if bother is felt','18 caps',4934,'Etodolac',23,108);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5708,'Once per day, the 2 days following the procedure','IV 2 doses',264,'Hydromorphone Hydrochloride',24,120);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5709,'4 times per day','1 tube',140,'Benzoyl Peroxide',24,120);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5710,'Three times per day if needed','2 caps',247,'Acetaminophen',24,120);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5711,'Once per day, the 2 days following the procedure','IV 2 doses',298,'Morphine Sulfate',25,111);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5712,'4 times per day','1 tube',640,'Petrolatum',25,111);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5713,'Three times per day if needed','2 caps',249,'Ibuprofen',25,111);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5714,'Only if bother is felt after procedure','2 caps',247,'Acetaminophen',26,117);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5715,'Once after surgery','1 dose IV',298,'Morphine Sulfate',29,118);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5716,'Once after morphine has been applied','1 dose IV',1019,'BEE VENOM',29,118);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5717,'4 times per day','1 tube',140,'Benzoyl Peroxide',29,118);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5718,'As required but no more than 3 times per day','1 cap',299,'CETYLPYRIDINIUM CHLORIDE',29,118);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5719,'Three times per day if needed','2 caps',249,'Ibuprofen',32,112);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5720,'Three times after procedure, every 2 hours','3 doses',4903,'Benzoyl Peroxide',35,115);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5721,'Once per day, the 2 days following the procedure','IV 2 doses',264,'Hydromorphone Hydrochloride',37,114);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5722,'4 times per day','1 tube',140,'Benzoyl Peroxide',37,114);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5723,'Three times per day if needed','2 caps',247,'Acetaminophen',37,114);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5724,'Three times per day if needed','2 caps',249,'Ibuprofen',41,113);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5725,'Twice after surgery, every 5 hours','2 doses IV',298,'Morphine Sulfate',41,113);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5726,'As required but no more than 1 per day','12 caps',158,'CHLORPHENIRAMINE MALEATE',43,119);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5727,'Only if Chlorpheniramine is not working','6 caps',160,'Diphenhydramine',43,119);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5728,'Twice after procedure, every 3 hours','2 doses IV',4933,'Furosemide',47,109);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5729,'Once per day, the 2 days following the procedure','IV 2 doses',264,'Hydromorphone Hydrochloride',48,110);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5730,'4 times per day','1 tube',140,'Benzoyl Peroxide',48,110);
INSERT INTO Prescription(Presc_Code,Frequency,Dosage,Pre_med_code,Pre_med_name,Pre_patient_ID,Pre_doctor_ID) VALUES (5731,'Three times per day if needed','2 caps',247,'Acetaminophen',48,110);

-- Treatment table
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2545,35.50,1,2);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2546,123.98,2,2);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2547,20.50,1,3);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2548,20.50,1,5);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2549,222.53,1,6);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2550,686.48,2,9);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2551,20.50,1,9);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2552,123.98,2,11);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2553,20.50,1,11);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2554,999.36,1,13);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2555,155.65,1,13);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2556,1119.88,2,16);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2557,222.53,1,23);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2558,686.48,2,24);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2559,870.05,1,24);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2560,35.50,1,24);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2561,123.98,2,25);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2562,774.46,1,25);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2563,20.50,1,25);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2564,35.50,1,26);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2565,61.99,1,29);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2566,79.82,1,29);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2567,870.05,1,29);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2568,772.39,1,29);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2569,20.50,1,32);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2570,2021.88,3,35);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2571,686.48,2,37);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2572,870.05,1,37);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2573,35.50,1,37);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2574,20.50,1,41);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2575,123.98,2,41);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2576,641.65,1,43);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2577,155.65,1,43);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2578,1912.28,2,47);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2579,686.48,2,48);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2580,870.05,1,48);
INSERT INTO Treatment(Tre_code,Tre_cost,Quantity,Tre_patient_ID) VALUES (2581,35.50,1,48);

-- Take_treatment table
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (247,'Acetaminophen',2545);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (298,'Morphine Sulfate',2546);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2547);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2548);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (4934,'Etodolac',2549);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (264,'Hydromorphone Hydrochloride',2550);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2551);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (298,'Morphine Sulfate',2552);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2553);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (167,'Triamcinolone Acetonide',2554);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (160,'Diphenhydramine',2555);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (4936,'Phenytoin',2556);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (4934,'Etodolac',2557);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (264,'Hydromorphone Hydrochloride',2558);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (140,'Benzoyl Peroxide',2559);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (247,'Acetaminophen',2560);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (298,'Morphine Sulfate',2561);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (640,'Petrolatum',2562);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2563);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (247,'Acetaminophen',2564);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (298,'Morphine Sulfate',2565);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (1019,'BEE VENOM',2566);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (140,'Benzoyl Peroxide',2567);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (299,'CETYLPYRIDINIUM CHLORIDE',2568);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2569);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (4903,'Benzoyl Peroxide',2570);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (264,'Hydromorphone Hydrochloride',2571);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (140,'Benzoyl Peroxide',2572);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (247,'Acetaminophen',2573);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (249,'Ibuprofen',2574);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (298,'Morphine Sulfate',2575);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (158,'CHLORPHENIRAMINE MALEATE',2576);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (160,'Diphenhydramine',2577);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (4933,'Furosemide',2578);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (264,'Hydromorphone Hydrochloride',2579);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (140,'Benzoyl Peroxide',2580);
INSERT INTO Take_treatment(Tak_med_code,Tak_med_name,Tak_trea_code) VALUES (247,'Acetaminophen',2581);


-- Phone table
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9953241579,'office',NULL,'103-93-6483');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2876494274,'office',NULL,'108-46-6826');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2919185481,'office',NULL,'116-97-0588');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6621836986,'office',NULL,'116-97-9588');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1488217836,'office',NULL,'125-75-7889');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6813558662,'office',NULL,'152-16-9131');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5852976341,'office',NULL,'153-08-5183');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6597923075,'office',NULL,'191-39-5536');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5358107751,'office',NULL,'201-02-4429');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4614037095,'office',NULL,'220-12-8066');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4815662137,'office',NULL,'220-60-1678');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4772561285,'office',NULL,'225-46-0824');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5457069827,'office',NULL,'227-69-7912');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6377459605,'office',NULL,'231-31-2299');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8373406936,'office',NULL,'252-73-0584');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5762705222,'office',NULL,'252-79-3221');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9827470404,'office',NULL,'299-20-3598');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5085976408,'office',NULL,'312-71-6169');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6751246967,'office',NULL,'312-74-4316');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8903472940,'office',NULL,'319-15-2042');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1106290493,'office',NULL,'346-66-5591');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5517950925,'office',NULL,'352-85-9800');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3646615947,'office',NULL,'367-88-5835');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2154052226,'office',NULL,'390-28-7016');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1972759486,'office',NULL,'462-13-2675');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3299760234,'office',NULL,'465-45-4254');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7721979762,'office',NULL,'478-16-2172');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1018869141,'office',NULL,'489-80-3517');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2379326761,'office',NULL,'492-58-8333');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5423943015,'office',NULL,'512-69-4102');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6412469522,'office',NULL,'535-55-5449');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4993440606,'office',NULL,'545-58-6936');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5804147763,'office',NULL,'565-91-1340');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3041573812,'office',NULL,'572-58-4474');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7406537850,'office',NULL,'587-76-4211');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8456684679,'office',NULL,'596-01-1699');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3249386054,'office',NULL,'600-57-6537');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4039979679,'office',NULL,'608-04-7124');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5931966257,'office',NULL,'623-99-7156');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8655913035,'office',NULL,'655-75-4766');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2335846007,'office',NULL,'656-91-6256');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4072193244,'office',NULL,'669-76-3171');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7873129551,'office',NULL,'676-39-4059');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5328555366,'office',NULL,'685-39-9060');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7416530052,'office',NULL,'696-09-7294');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5309015028,'office',NULL,'743-97-5168');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8487528134,'office',NULL,'748-61-9581');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7972051127,'office',NULL,'759-07-0650');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1536334597,'office',NULL,'760-81-1429');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4909418628,'office',NULL,'761-59-1002');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8106250085,'office',NULL,'781-48-4994');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6691857997,'office',NULL,'788-30-3311');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7889947466,'office',NULL,'788-94-4012');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9194797591,'office',NULL,'805-25-3849');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8598547352,'office',NULL,'815-55-2301');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2188119493,'office',NULL,'832-98-1677');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2842620454,'office',NULL,'834-50-4860');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2266473345,'office',NULL,'839-88-1696');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1818775750,'office',NULL,'847-24-3190');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1443918840,'office',NULL,'867-51-5970');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1647143291,'office',NULL,'884-06-1502');
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4023975186,'mobile',1,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2063716611,'house',2,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9689651560,'office',3,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9776257071,'mobile',4,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3431845352,'house',5,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5025289456,'office',6,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3325513721,'mobile',7,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5419561740,'house',8,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4949924980,'office',9,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4985646272,'mobile',10,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2789046694,'house',11,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9847996889,'office',12,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5443616688,'mobile',13,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4289858829,'house',14,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1722608175,'office',15,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1077292265,'mobile',16,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7425391611,'house',17,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7692990578,'office',18,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1372214418,'mobile',19,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9722807624,'house',20,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4238085343,'office',21,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7622634939,'mobile',22,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2435588279,'house',23,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4894959273,'office',24,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6005988915,'mobile',25,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (9571135919,'house',26,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8886744943,'office',27,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5589365584,'mobile',28,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6606590506,'house',29,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7102952270,'office',30,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5517574199,'mobile',31,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3589333800,'house',32,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1927218121,'office',33,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7599541964,'mobile',34,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3439830318,'house',35,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2839480282,'mobile',36,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5909357658,'house',37,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (6312033425,'office',38,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2808998848,'mobile',39,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7426135000,'house',40,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8032495157,'office',41,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (1254162953,'mobile',42,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8309526464,'house',43,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4112297062,'office',44,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (2442387133,'mobile',45,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (3777122140,'house',46,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (5055980673,'office',47,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (4576489987,'mobile',48,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (7327461800,'house',49,NULL);
INSERT INTO Phone(Number,Type,Pho_patient_ID,Pho_SSN) VALUES (8892683886,'office',50,NULL);










