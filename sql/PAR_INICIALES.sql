insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('William shakespeare','English playwright, poet and actor','23-04-1564','03-05-1616','British');
insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('Brandon Sanderson','American author of epic fantasy and science fiction.','19-12-1975',null,'American');
insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('Eiichiro Oda','Japanese manga artist ','01-01-1975',null,'Japanese');
insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('Agatha Christie',' English writer known for her 66 detective novels and 14 short story collections.','15-09-1890','12-01-1976','British');
insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('Leo Tolstoy',' Russian writer who is regarded as one of the greatest authors of all time.','09-09-1828','20-11-1910','Russian');
insert into AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) values ('Paulo Coelho','Brazilian lyricist and novelist and a member of the Brazilian Academy of Letters since 2002.','24-08-1947',null,'Brazilian');

insert into GENRES (G_NAME, DESCRIPTION) values ('Drama', 'Stories composed in verse or prose, usually for theatrical performance, where conflicts and emotion are expressed through dialogue and action');
insert into GENRES (G_NAME, DESCRIPTION) values ('Fable', 'Narration demonstrating a useful truth, especially in which animals speak as humans; legendary, supernatural tale. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Fairy tale', 'Story about fairies or other magical creatures, usually for children. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Fantasy', 'Fiction with strange or other worldly settings or characters; fiction which invites suspension of reality. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Fiction', 'Narrative literary works whose content is produced by the imagination and is not necessarily based on fact. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Folklore', 'The songs, stories, myths, and proverbs of a people or "folk" as handed down by word of mouth.');
insert into GENRES (G_NAME, DESCRIPTION) values ('Horror', 'Fiction in which events evoke a feeling of dread in both the characters and the reader. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Humor', 'Fiction full of fun, fancy, and excitement, meant to entertain; but can be contained in all genres');
insert into GENRES (G_NAME, DESCRIPTION) values ('Legend', 'Story, sometimes of a national or folk hero, which has a basis in fact but also includes imaginative material.');
insert into GENRES (G_NAME, DESCRIPTION) values ('Mystery', 'Fiction dealing with the solution of a crime or the unraveling of secrets. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Mythology', 'Legend or traditional narrative, often based in part on historical events, that reveals human behavior and natural phenomena by its symbolism; often pertaining to the actions of the gods.');
insert into GENRES (G_NAME, DESCRIPTION) values ('Poetry', 'Verse and rhythmic writing with imagery that creates emotional responses. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Science Fiction ', 'Story based on impact of actual, imagined, or potential science, usually set in the future or on other planets. ');
insert into GENRES (G_NAME, DESCRIPTION) values ('Manga ', 'comics or graphic novels created in Japan.');
insert into GENRES (G_NAME, DESCRIPTION) values ('Biography', 'Narrative of a person''s life, a true story about a real person.');

insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (0194209520,1,1,'Romeo and Juliet','This is the most famous of all Shakespeares plays - a story of young love. Whats in a name? Does it really matter if you are called Montague or Capulet? When Romeo, son of Lord Montague, falls in love with the most beautiful girl hes ever seen, he finds that it does matter. It makes all the difference in the world, because both families hate each other. For a time, Romeo and Juliet manage to keep their love secret. But when Romeo is sent away from Verona, hope begins to die.',64);
insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (0174434669,1,1,'Macbeth','Book by Shakespeare William',128);
insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (9780765311771,2,4,'Elantris','The story follows three main characters: Prince Raoden of Arelon, Princess Sarene of Teod, and the priest Hrathen of Fjorden. At the beginning of the story, Raoden is cursed by an ancient transformation known as the Shaod and secretly exiled to the city of Elantris just days before his betrothed, princess Sarene of Teod, arrives for their wedding. As Raoden tries to avoid gangs, keep his sanity, and unite the people of Elantris.',800);
insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (9780765326355,2,4,'The Way of Kings','The story rotates between the points of view of Kaladin, Shallan Davar, Szeth-son-son-Vallano, Dalinar Kholin, Adolin Kholin, and several other minor characters, who lead seemingly unconnected lives. Szeth, a Shin man cast out by his people and condemned to obey his constantly changing masters, is sent to assassinate the king of one of the world''s most powerful nations, Alethkar. ',1008);
insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (9788468471525,3,14,'One piece Nº1','-',50);
insert into BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) values (0062074377,4,14,'The Man in the Brown Suit','Pretty, young Anne Beddingfeld has come to London looking for adventure. But adventure finds her when a strange-smelling man falls off an Underground platform and is electrocuted on the rails. The police verdict is accidental death. But who was the man in the brown suit who examined the body before running away? Armed with only one cryptic clue, Anne is determined to track him down and bring the mysterious killer to justice. ',288);


insert into USERS (U_NAME, USERNAME, PASWORD, BIOGRAPHY, EMAIL, ROLE) values ('Antonio','SrToska','1234','-','-','USER');
insert into USERS (U_NAME, USERNAME, PASWORD, BIOGRAPHY, EMAIL, ROLE) values ('Juan','JuanPe','1234','-','-','USER');
insert into USERS (U_NAME, USERNAME, PASWORD, BIOGRAPHY, EMAIL, ROLE) values ('Daniel','Dani75','1234','-','-','USER');
insert into USERS (U_NAME, USERNAME, PASWORD, BIOGRAPHY, EMAIL, ROLE) values ('Manager','STARMGR','1234','-','-','MGR');





