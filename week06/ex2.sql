-- Create Tables ---------------------------------------------
CREATE TABLE IF NOT EXISTS Author
(
	author_id INTEGER PRIMARY KEY,
	first_name TEXT, 
	last_name TEXT
);

CREATE TABLE IF NOT EXISTS Book
(
	book_id INTEGER PRIMARY KEY,
	book_title TEXT,
	month_ TEXT,
	year_ INTEGER,
	editor INTEGER,
	
	FOREIGN KEY (editor) REFERENCES Author(author_id)
);

CREATE TABLE IF NOT EXISTS Pub
(
	pub_id INTEGER PRIMARY KEY,
	title TEXT,
	book_id INTEGER,
	
	FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE IF NOT EXISTS AuthorPub
(
	author_id INTEGER,
	pub_id INTEGER,
	author_position INTEGER,
	
	PRIMARY KEY (author_id, pub_id),
	FOREIGN KEY (author_id) REFERENCES Author(author_id),
	FOREIGN KEY (pub_id) REFERENCES Pub(pub_id)
);

-- Insert Data ------------------------------------------------
INSERT INTO Author VALUES
(1, 'John', 'McCarthy'),
(2, 'Dennis', 'Ritchie'),
(3, 'Ken', 'Thompson'),
(4, 'Claude', 'Shannon'),
(5, 'Alan', 'Turing'),
(6, 'Alonzo', 'Church'),
(7, 'Perry', 'White'),
(8, 'Moshe', 'Vardi'),
(9, 'Roy', 'Batty');

INSERT INTO Book VALUES
(1, 'CACM', 'April', 1960, 8),
(2, 'CACM', 'July', 1974, 8),
(3, 'BTS', 'July', 1948, 2),
(4, 'MLS', 'November', 1936, 7),
(5, 'Mind', 'October', 1950, NULL),
(6, 'AMS', 'Month', 1941, NULL),
(7, 'AAAI', 'July', 2012, 9),
(8, 'NIPS', 'July', 2012, 9);

INSERT INTO Pub VALUES
(1, 'LISP', 1),
(2, 'Unix', 2),
(3, 'Info Theory', 3),
(4, 'Turing Machines', 4),
(5, 'Turing Test', 5),
(6, 'Lambda Calculus', 6);

INSERT INTO AuthorPub VALUES
(1,1,1),
(2,2,1),
(3,2,2),
(4,3,1),
(5,4,1),
(5,5,1),
(6,6,1);

-- Actions ---------------------------------------------------------------
SELECT *
FROM Author JOIN Book ON Author.author_id=Book.editor;

SELECT T1.first_name, T1.last_name
FROM (SELECT A1.author_id, A1.first_name, A1.last_name FROM Author AS A1
	 EXCEPT
	 SELECT B1.editor, Author.first_name, Author.last_name
	 FROM Book AS B1 JOIN Author ON B1.editor=Author.author_id
	 ) AS T1;
	 
SELECT author_id FROM Author
EXCEPT
SELECT editor FROM Book;
