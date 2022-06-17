
create table AUTHORS
(
    ID_AUTHOR   NUMBER not null
        constraint PK_ID_AUTHOR
            primary key,
    A_NAME      VARCHAR2(100),
    BIOGRAPHY   VARCHAR2(500),
    BIRTHDATE   DATE,
    DEATHDATE   DATE,
    NACIONALITY VARCHAR2(100)
);

create table USERS
(
    ID_USER   NUMBER not null
        constraint PK_ID_USER
            primary key,
    U_NAME    VARCHAR2(100),
    USERNAME  VARCHAR2(50),
    PASWORD   VARCHAR2(50),
    BIOGRAPHY VARCHAR2(500) default ' ',
    EMAIL     VARCHAR2(100),
    ROLE      VARCHAR2(10)  default 'USER'
);


create table GENRES
(
    ID_GENRE    NUMBER not null
        constraint PK_ID_GENRE
            primary key,
    G_NAME      VARCHAR2(100),
    DESCRIPTION VARCHAR2(500)
);


create table BOOKS
(
    ISBN        VARCHAR2(30) not null
        constraint PK_ISBN
            primary key,
    ID_AUTHOR   NUMBER
        constraint FK_ID_AUTHOR_BOOKS
            references AUTHORS,
    ID_GENRE    NUMBER
        constraint FK_ID_GENRE_BOOKS
            references GENRES,
    TITLE       VARCHAR2(100),
    DESCRIPTION VARCHAR2(500),
    PAGES       NUMBER
);

create table REVIEWS
(
    ID_REVIEW   NUMBER not null
        constraint PK_ID_REVIEW
            primary key,
    ISBN        VARCHAR2(30)
        constraint FK_ISBN_REVIEWS
            references BOOKS,
    ID_USER     NUMBER
        constraint FK_ID_USER_BOOKS
            references USERS,
    TITLE       VARCHAR2(50),
    DESCRIPTION VARCHAR2(500),
    STARS       NUMBER
);


create table USERLIBRARY
(
    ISBN    VARCHAR2(30)
        constraint FK_ISBN_USERLIBRARY
            references BOOKS,
    ID_USER NUMBER
        constraint FK_ID_USER_USERLIBRARY
            references USERS,
    STATUS  VARCHAR2(30),
    PAGE    NUMBER
);

create table MAIL
(
    ID_MAIL      NUMBER,
    ID_USER_FROM NUMBER
        constraint FK_ID_USER_FROM_MAIL
            references USERS,
    ID_USER_TO   NUMBER
        constraint FK_ID_USER_TO_MAIL
            references USERS,
    TIMESTAMP_M  DATE,
    MESSAGE      VARCHAR2(500)
);

create sequence SEQUENCE_AUTHORS
start with 1
increment by 1
nominvalue
nomaxvalue;

create or replace trigger TRIGGER_ID_AUTHORS
before insert on AUTHORS
for each row
begin
    select SEQUENCE_AUTHORS.nextval into :NEW.ID_AUTHOR from dual;
end;
/

create sequence SEQUENCE_USERS
start with 1
increment by 1
nominvalue
nomaxvalue;

create or replace trigger TRIGGER_ID_USERS
before insert on USERS
for each row
begin
    select SEQUENCE_USERS.nextval into :NEW.ID_USER from dual;
end;
/

create sequence SEQUENCE_GENRES
start with 1
increment by 1
nominvalue
nomaxvalue;

create or replace trigger TRIGGER_ID_GENRES
before insert on GENRES
for each row
begin
    select SEQUENCE_GENRES.nextval into :NEW.ID_GENRE from dual;
end;
/

create sequence SEQUENCE_REVIEWS
start with 1
increment by 1
nominvalue
nomaxvalue;

create or replace trigger TRIGGER_ID_REVIEWS
before insert on REVIEWS
for each row
begin
    select SEQUENCE_REVIEWS.nextval into :NEW.ID_REVIEW from dual;
end;
/

create sequence SEQUENCE_MAIL
start with 1
increment by 1
nominvalue
nomaxvalue;

create or replace trigger TRIGGER_ID_MAIL
before insert on MAIL
for each row
begin
    select SEQUENCE_MAIL.nextval into :NEW.ID_MAIL from dual;
end;
/


create table AUTHORS
(
    ID_AUTHOR   NUMBER not null
        constraint PK_ID_AUTHOR
            primary key,
    A_NAME      VARCHAR2(100),
    BIOGRAPHY   VARCHAR2(500),
    BIRTHDATE   DATE,
    DEATHDATE   DATE,
    NACIONALITY VARCHAR2(100)
);

create table USERS
(
    ID_USER   NUMBER not null
        constraint PK_ID_USER
            primary key,
    U_NAME    VARCHAR2(100),
    USERNAME  VARCHAR2(50),
    PASWORD   VARCHAR2(50),
    BIOGRAPHY VARCHAR2(500) default ' ',
    EMAIL     VARCHAR2(100),
    ROLE      VARCHAR2(10)  default 'USER'
);


create table GENRES
(
    ID_GENRE    NUMBER not null
        constraint PK_ID_GENRE
            primary key,
    G_NAME      VARCHAR2(100),
    DESCRIPTION VARCHAR2(500)
);


create table BOOKS
(
    ISBN        VARCHAR2(30) not null
        constraint PK_ISBN
            primary key,
    ID_AUTHOR   NUMBER
        constraint FK_ID_AUTHOR_BOOKS
            references AUTHORS,
    ID_GENRE    NUMBER
        constraint FK_ID_GENRE_BOOKS
            references GENRES,
    TITLE       VARCHAR2(100),
    DESCRIPTION VARCHAR2(500),
    PAGES       NUMBER
);

create table REVIEWS
(
    ID_REVIEW   NUMBER not null
        constraint PK_ID_REVIEW
            primary key,
    ISBN        VARCHAR2(30)
        constraint FK_ISBN_REVIEWS
            references BOOKS,
    ID_USER     NUMBER
        constraint FK_ID_USER_BOOKS
            references USERS,
    TITLE       VARCHAR2(50),
    DESCRIPTION VARCHAR2(500),
    STARS       NUMBER
);


create table USERLIBRARY
(
    ISBN    VARCHAR2(30)
        constraint FK_ISBN_USERLIBRARY
            references BOOKS,
    ID_USER NUMBER
        constraint FK_ID_USER_USERLIBRARY
            references USERS,
    STATUS  VARCHAR2(30),
    PAGE    NUMBER
);

create table MAIL
(
    ID_MAIL      NUMBER,
    ID_USER_FROM NUMBER
        constraint FK_ID_USER_FROM_MAIL
            references USERS,
    ID_USER_TO   NUMBER
        constraint FK_ID_USER_TO_MAIL
            references USERS,
    TIMESTAMP_M  DATE,
    MESSAGE      VARCHAR2(500)
);


