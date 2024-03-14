/* The University Database from the textbook "Database System Concepts" by 
A. Silberschatz, H.F. Korth and S. Sudarshan, McGraw-Hill International Edition, 
Sixth Edition, 2011.*/

/* UniversityDB.sql is a script for creating tables for the University database of the book 
   and populating them with data */

# Names of tables and attributes are changed slightly to improve the naming standard!

# If the tables already exists, then they are deleted!
 
#Create a dummy database called test with the attribute names and types!

DROP DATABASE IF EXISTS University; 

CREATE DATABASE IF NOT EXISTS University;

USE University;


DROP TABLE IF EXISTS University;

DROP TABLE IF EXISTS PreReq;
DROP TABLE IF EXISTS TimeSlot;
DROP TABLE IF EXISTS Advisor;
DROP TABLE IF EXISTS Takes;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Teaches;
DROP TABLE IF EXISTS Sectiontbl;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Classroom;

# Table creation! Create Tables with Foreign Keys after the referenced tables are created!

CREATE TABLE Classroom
	(Building		VARCHAR(15),
	 Room			VARCHAR(7),
	 Capacity		DECIMAL(4,0),
	 PRIMARY KEY(Building, Room)
	);

CREATE TABLE Department
	(DeptName		VARCHAR(20), 
	 Building		VARCHAR(15), 
	 Budget		    DECIMAL(12,2),
	 PRIMARY KEY(DeptName)
	);

CREATE TABLE Course
	(CourseID		VARCHAR(8), 
	 Title			VARCHAR(50), 
	 DeptName		VARCHAR(20),
	 Credits		DECIMAL(2,0),
	 PRIMARY KEY(CourseID),
	  FOREIGN KEY(DeptName) REFERENCES Department(DeptName) ON DELETE SET NULL
	);

CREATE TABLE Instructor
	(InstID			VARCHAR(5), 
	 InstName		VARCHAR(20) NOT NULL, 
	 DeptName		VARCHAR(20), 
	 Salary			DECIMAL(8,2),
	 PRIMARY KEY (InstID),
	 FOREIGN KEY(DeptName) REFERENCES Department(DeptName) ON DELETE SET NULL
	);

CREATE TABLE Sectiontbl
	(CourseID		VARCHAR(8), 
     SectionID		VARCHAR(8),
	 Semester		ENUM('Fall','Winter','Spring','Summer'), 
	 StudyYear		YEAR, 
	 Building		VARCHAR(15),
	 Room			VARCHAR(7),
	 TimeSlotID		VARCHAR(4),
	 PRIMARY KEY(CourseID, SectionID, Semester, StudyYear),
	 FOREIGN KEY(CourseID) REFERENCES Course(CourseID)
		ON DELETE CASCADE,
	 FOREIGN KEY(Building, Room) REFERENCES Classroom(Building, Room) ON DELETE SET NULL
	);

CREATE TABLE Teaches
	(InstID			VARCHAR(5), 
	 CourseID		VARCHAR(8),
	 SectionID		VARCHAR(8), 
	 Semester		ENUM('Fall','Winter','Spring','Summer'),
	 StudyYear		YEAR,
	 PRIMARY KEY(InstID, CourseID, SectionID, Semester, StudyYear),
	 FOREIGN KEY(CourseID, SectionID, Semester, StudyYear) REFERENCES Sectiontbl(CourseID, SectionID, Semester, StudyYear) 
     ON DELETE CASCADE,
	 FOREIGN KEY(InstID) REFERENCES Instructor(InstID) ON DELETE CASCADE
	);

CREATE TABLE Student
	(StudID			VARCHAR(5), 
	 StudName		VARCHAR(20) NOT NULL, 
	 Birth 			DATE,
	 DeptName		VARCHAR(20),
     TotCredits		DECIMAL(3,0),
	 PRIMARY KEY(StudID),
	 FOREIGN KEY(DeptName) REFERENCES Department(DeptName) ON DELETE SET NULL
	);

CREATE TABLE Takes
	(StudID			VARCHAR(5), 
	 CourseID		VARCHAR(8),
	 SectionID		VARCHAR(8), 
	 Semester		ENUM('Fall','Winter','Spring','Summer'),
	 StudyYear		YEAR,
	 Grade		    VARCHAR(2),
	 PRIMARY KEY(StudID, CourseID, SectionID, Semester, StudyYear),
	 FOREIGN KEY(CourseID, SectionID, Semester, StudyYear) REFERENCES Sectiontbl(CourseID, SectionID, Semester, StudyYear) 
		ON DELETE CASCADE,
	 FOREIGN KEY(StudID) REFERENCES Student(StudID) ON DELETE CASCADE
	);

CREATE TABLE Advisor
	(StudID			VARCHAR(5),
	 InstID			VARCHAR(5),
	 PRIMARY KEY(StudID),
	 FOREIGN KEY(InstID) REFERENCES Instructor(InstID) ON DELETE SET NULL,
	 FOREIGN KEY(StudID) REFERENCES Student(StudID) ON DELETE CASCADE
	);

CREATE TABLE TimeSlot
	(TimeSlotID 	VARCHAR(4),
	 DayCode		ENUM('M','T','W','R','F','S','U'),
	 StartTime		TIME,
	 EndTime		TIME,
	 PRIMARY KEY(TimeSlotID, DayCode, StartTime)
	);

CREATE TABLE PreReq
	(CourseID		VARCHAR(8), 
	 PreReqID		VARCHAR(8),
	 PRIMARY KEY(CourseID, PreReqID),
	 FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE,
	 FOREIGN KEY(PreReqID) REFERENCES Course(CourseID)
);


