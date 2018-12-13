create user `student`@`localhost` identified by 'student';

create database student character set=utf8;

grant all privileges on student.* to `student`@`localhost`;





create table users(
       id int auto_increment primary key ,
       name varchar(20) not null,
       gender varchar(5) not null,
       email varchar(50) not null,
       clsid int not null,
       fireBaseId varchar(50) null,
       pw varchar(50)
       
);

create table classes(
       id int primary key,
       name varchar(10) not null
);



insert into users values(1,'Zhang','F','123@qq.com',1 , null, null);
insert into users values(null,'LI','M','123@qq.com',2, null, null);
insert into users values(null,'TOM','M','123@qq.com',3, null, null);
insert into users values(null,'JAY','F','123@qq.com',1, null, null);
insert into users values(null,'Andy','M','123@qq.com',2, null, null);
insert into users values(null,'james','F','123@qq.com',3, null, null);
insert into users values(null,'Kobe','M','123@qq.com',1, null, null);
insert into users values(null,'YI','F','123@qq.com',2, null, null);
insert into users values(null,'YAO','M','123@qq.com',3, null, null);
insert into users values(null,'YIN','F','123@qq.com',1, null, null);
commit;

insert into classes values(1,'S1');
insert into classes values(2,'S2');
insert into classes values(3,'Y2');
commit;


 




