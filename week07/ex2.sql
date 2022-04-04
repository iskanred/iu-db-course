
---------------------- Initialization ----------------------------------------
create table if not exists Books
(
	book text primary key,
	publisher text
);

create table if not exists TeacherToSchool
(
	school text,
	teacher text primary key
);

create table if not exists Classes
(
	course text not null,
	teacher text not null references TeacherToSchool(teacher),
	room text not null, 
	loanDate date not null,
	book text references Books(book),
	grade text,
	
	primary key (course, teacher, room, loanDate)
);


insert into TeacherToSchool values
	('Horizon Education Institute', 'Chad Russell'),
 	('Horizon Education Institute', 'E.F.Codd'),
 	('Horizon Education Institute', 'Jones Smith'),
 	('Bright Institution', 'Adam Baker');

insert into Classes values
 	('Logical thinkging', 'Chad Russell', '1.A01', '2010-09-09', 'Learning and teaching in early childhood', '1st grade'),
 	('Writing', 'Chad Russell', '1.A01', '2010-05-05', 'Preschool,N56', '1st grade'),
 	('Numerical Thinking', 'Chad Russell', '1.A01', '2010-05-05', 'Learning and teaching in early childhood', '1st grade'),
 	('Spatial, Temporal and Causal Thinking', 'E.F.Codd', '1.B01', '2010-05-06', 'Early Childhood Education N9', '1st grade'),
 	('Numerical Thinking', 'E.F.Codd', '1.B01', '2010-05-06', 'Learning and teaching in early childhood', '1st grade'),
 	('Writting', 'Jones Smith', '1.A01', '2010-09-09', 'Learning and teaching in early childhood', '2nd grade'),
 	('English', 'Jones Smith', '1.A01', '2010-05-05', 'Know how to educate: guide for Parents and', '2nd grade'),
 	('Logical thinking', 'Adam Baker', '2.B01', '2010-12-18', 'Know how to educate: guide for Parents and', '1st grade'),
 	('Numerical Thinking', 'Adam Baker', '2.B01', '2010-05-06', 'Know how to educate: guide for Parents and', '1st grade');

insert into Books values
 	('Learning and teaching in early childhood', 'BOA Editions'),
 	('Preschool,N56', 'Taylor&Frances Publishing'),
 	('Early Childhood Education N9', 'Prentice Hall'),
 	('Know how to educate: guide for Parents and', 'McGraw Hill');


---------------------- Queries -----------------------------------------------

select distinct 
	school, Books.book, count(Books.book), publisher
from 
	Classes, Books, TeacherToSchool
where 
	Classes.book = Books.book and Classes.teacher = TeacherToSchool.teacher
group by 
	school, Books.book;


select distinct 
	on (school) school, Classes.book, loanDate, Classes.teacher
from 
	Classes, Books, TeacherToSchool
where 
	Classes.book = Books.book and TeacherToSchool.teacher = Classes.teacher
order by 
	school, loanDate desc, Classes.book;

