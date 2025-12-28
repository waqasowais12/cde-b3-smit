create table employee(
	emp_ID int primary key identity,
	emp_name varchar(50),
	emp_standard varchar(20)
);


create schema procurement;

create table procurement.vendor_groups(
	 group_id INT IDENTITY PRIMARY KEY,
	 group_name VARCHAR (100) NOT NULL
);


CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
);

DROP TABLE procurement.vendors;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES procurement.vendor_groups(group_id)
);


CREATE SCHEMA hr;
GO

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);



INSERT INTO procurement.vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');


INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('ABC Corp',1);


INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('XYZ Corp',3);



CONSTRAINT fk_group FOREIGN KEY (group_id) 
REFERENCES procurement.vendor_groups(group_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;




