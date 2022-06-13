CREATE TABLE AUTHORS(
ID_AUTHOR NUMBER,
A_NAME VARCHAR2(100),
BIOGRAPHY VARCHAR2(500),
BIRTHDATE DATE,
DEATHDATE DATE,
NACIONALITY VARCHAR2(100),
CONSTRAINT PK_ID_AUTHOR PRIMARY KEY(ID_AUTHOR)
);

CREATE TABLE USERS(
ID_USER NUMBER,
U_NAME VARCHAR2(100),
USERNAME VARCHAR2(50),
PASWORD VARCHAR2(50),
BIOGRAPHY VARCHAR2(500),
EMAIL VARCHAR2(100),
ROLE VARCHAR(10),
CONSTRAINT PK_ID_USER PRIMARY KEY(ID_USER)
);

CREATE TABLE GENRES(
ID_GENRE NUMBER,
G_NAME VARCHAR2(100),
DESCRIPTION VARCHAR2(500),
CONSTRAINT PK_ID_GENRE PRIMARY KEY(ID_GENRE)
);

CREATE TABLE BOOKS(
ISBN VARCHAR2(30),
ID_AUTHOR NUMBER,
ID_GENRE NUMBER,
TITLE VARCHAR2(100),
DESCRIPTION VARCHAR2(500),
PAGES NUMBER,
CONSTRAINT PK_ISBN PRIMARY KEY(ISBN),
CONSTRAINT FK_ID_AUTHOR_BOOKS FOREIGN KEY(ID_AUTHOR) REFERENCES AUTHORS,
CONSTRAINT FK_ID_GENRE_BOOKS FOREIGN KEY(ID_GENRE) REFERENCES GENRES
);

CREATE TABLE REVIEWS(
ID_REVIEW NUMBER,
ISBN VARCHAR2(30),
ID_USER NUMBER,
TITLE VARCHAR2(50),
DESCRIPTION VARCHAR(500),
STARS NUMBER,
CONSTRAINT PK_ID_REVIEW PRIMARY KEY(ID_REVIEW),
CONSTRAINT FK_ISBN_REVIEWS FOREIGN KEY(ISBN) REFERENCES BOOKS,
CONSTRAINT FK_ID_USER_BOOKS FOREIGN KEY(ID_USER) REFERENCES USERS
);

CREATE TABLE USERLIBRARY(
ISBN VARCHAR2(30),
ID_USER NUMBER,
STATUS VARCHAR2(30),
PAGE NUMBER,
CONSTRAINT FK_ISBN_USERLIBRARY FOREIGN KEY(ISBN) REFERENCES BOOKS,
CONSTRAINT FK_ID_USER_USERLIBRARY FOREIGN KEY(ID_USER) REFERENCES USERS
);

CREATE TABLE MAIL(
ID_MAIL NUMBER,
ID_USER_FROM NUMBER,
ID_USER_TO NUMBER,
TIMESTAMP_M DATE,
CONSTRAINT FK_ID_USER_FROM_MAIL FOREIGN KEY(ID_USER_FROM) REFERENCES USERS,
CONSTRAINT FK_ID_USER_TO_MAIL FOREIGN KEY(ID_USER_TO) REFERENCES USERS
);

CREATE SEQUENCE SEQUENCE_AUTHORS
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE;

CREATE OR REPLACE TRIGGER TRIGGER_ID_AUTHORS
BEFORE INSERT ON AUTHORS
FOR EACH ROW
BEGIN
    SELECT SEQUENCE_AUTHORS.NEXTVAL INTO :NEW.ID_AUTHOR FROM dual;
END;
/

CREATE SEQUENCE SEQUENCE_USERS
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE;

CREATE OR REPLACE TRIGGER TRIGGER_ID_USERS
BEFORE INSERT ON USERS
FOR EACH ROW
BEGIN
    SELECT SEQUENCE_USERS.NEXTVAL INTO :NEW.ID_USER FROM dual;
END;
/

CREATE SEQUENCE SEQUENCE_GENRES
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE;

CREATE OR REPLACE TRIGGER TRIGGER_ID_GENRES
BEFORE INSERT ON GENRES
FOR EACH ROW
BEGIN
    SELECT SEQUENCE_GENRES.NEXTVAL INTO :NEW.ID_GENRE FROM dual;
END;
/

CREATE SEQUENCE SEQUENCE_REVIEWS
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE;

CREATE OR REPLACE TRIGGER TRIGGER_ID_REVIEWS
BEFORE INSERT ON REVIEWS
FOR EACH ROW
BEGIN
    SELECT SEQUENCE_REVIEWS.NEXTVAL INTO :NEW.ID_REVIEW FROM dual;
END;
/

CREATE SEQUENCE SEQUENCE_MAIL
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE;

CREATE OR REPLACE TRIGGER TRIGGER_ID_MAIL
BEFORE INSERT ON MAIL
FOR EACH ROW
BEGIN
    SELECT SEQUENCE_MAIL.NEXTVAL INTO :NEW.ID_MAIL FROM dual;
END;
/
