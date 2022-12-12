drop database if exists my_movies;
create database my_movies;
use my_movies;


create table Genre(
	GenreID int primary key auto_increment,
    Genre_Desc varchar(120)
);

create table Rating(
	RatingID int primary key auto_increment,
    Rating_Desc varchar(120)
);

create table Actor (
	ActorID int primary key auto_increment,
    First_Name varchar(45) not null,
    Last_Name varchar(45) not null,
    DOB date
);

create table Movie (
	MovieID int primary key auto_increment,
    Movie_Title varchar(45) not null,
    Movie_Release date not null,
    RatingID int,
    GenreID int,
    foreign key (RatingID) references Rating(RatingID),
    foreign key (GenreID) references Genre(GenreID)
);

create table tblCharacter(
	MovieID int,
    ActorID int,
    Char_Name varchar(45) not null,
    primary key (MovieID, ActorID),
    foreign key (MovieID) references Movie(MovieID),
    foreign key (ActorID) references Actor(ActorID)
);

create table Copy (
	CopyID int,
    MovieID int,
    Runtime time,
    format varchar(45),
    primary key (CopyID, MovieID),
    foreign key (MovieID) references Movie(MovieID)
);

