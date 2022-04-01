-- Create Tables -------------------------------------------------
CREATE TABLE IF NOT EXISTS Suppliers(
	sid INTEGER PRIMARY_KEY,
	sname TEXT,
	address TEXT
);

CREATE TABLE IF NOT EXISTS Parts(
	pid INTEGER PRIMARY_KEY,
	pname TEXT,
	color TEXT
);

CREATE TABLE IF NOT EXISTS Catalogg(
	sid INTEGER REFERENCES Suppliers(sid),
	pid INTEGER REFERENCES Parts(pid),
	cost REAL,
	PRIMARY_KEY(sid, pid)
);

-- Insert Data -------------------------------------------------

INSERT INTO Suppliers VALUES
(1, 'Yosemithe Sham', 'Devil''s canyon, AZ'),
(2, 'Waley E. Coyote', 'RR Asylum, NV'),
(3, 'Elmer Fudd', 'Carrot Patch, MN');

INSERT INTO Parts VALUES
(1, 'Red1', 'Red'),
(2, 'Red2', 'Red'),
(3, 'Green1', 'Green'),
(4, 'Blue1', 'Blue'),
(5, 'Red3', 'Red');

INSERT INTO Catalogg VALUES
(1, 1, 10.),
(1, 2, 20.),
(1, 3, 30.),
(1, 4, 40.),
(1, 5, 50.),
(2, 1, 9.),
(2, 3, 34.),
(2, 5, 48.);
(3, 1, 53.);


-- Actions -------------------------------------------------------------------------

-- 1) ------------------------------------------------------------------------------
SELECT DISTINCT sname
FROM Suppliers, Parts, Catalogg
WHERE color='Red' AND Catalogg.sid=Suppliers.sid AND Catalogg.pid=Parts.pid;

-- 2) ------------------------------------------------------------------------------
SELECT DISTINCT Suppliers.sid
FROM Parts JOIN Catalogg ON Parts.pid=Catalogg.pid 
		   JOIN Suppliers ON Suppliers.sid=Catalogg.sid
WHERE Parts.color='Red' OR Parts.color='Green';

-- 3) ------------------------------------------------------------------------------
SELECT DISTINCT Suppliers.sid
FROM Parts JOIN Catalogg ON Parts.pid=Catalogg.pid 
		   JOIN Suppliers ON Suppliers.sid=Catalogg.sid
WHERE Parts.color='Red' 
UNION SELECT sid FROM Suppliers WHERE address LIKE '%221 Packer Street%';

-- 4) ------------------------------------------------------------------------------
SELECT DISTINCT T4.sid
FROM Catalogg AS T4
EXCEPT
SELECT DISTINCT T3.sid
FROM (
	SELECT Suppliers.sid, Parts.pid FROM Suppliers, Parts 
	WHERE Parts.color='Red'
	EXCEPT
	SELECT T2.sid, T2.pid FROM Catalogg AS T2
	)
AS T3
UNION
SELECT DISTINCT sid FROM Catalogg, Parts WHERE Catalogg.pid=Parts.pid
AND Parts.color='Green';

-- 5) ------------------------------------------------------------------------------
SELECT DISTINCT T4.sid
FROM Catalogg AS T4
EXCEPT
SELECT DISTINCT T3.sid
FROM (
	SELECT Suppliers.sid, Parts.pid FROM Suppliers, Parts 
	WHERE Parts.color='Red'
	EXCEPT
	SELECT T2.sid, T2.pid FROM Catalogg AS T2
	)
AS T3
UNION
SELECT DISTINCT T4.sid
FROM Catalogg AS T4
EXCEPT
SELECT DISTINCT T3.sid
FROM (
	SELECT Suppliers.sid, Parts.pid FROM Suppliers, Parts 
	WHERE Parts.color='Green'
	EXCEPT
	SELECT T2.sid, T2.pid FROM Catalogg AS T2
	)
AS T3;

-- 6) ------------------------------------------------------------------------------
SELECT S1.sid, S2.sid
FROM Catalogg AS S1, Catalogg AS S2
WHERE S1.sid!=S2.sid AND S1.pid=S2.pid AND S1.cost_>S2.cost_;

-- 7) -----------------------------------------------------------------------------
SELECT DISTINCT C1.pid
FROM Catalogg AS C1, Catalogg AS C2
WHERE C1.pid=C2.pid AND C1.sid!=C2.sid;

-- 8) ------------------------------------------------------------------------------
SELECT AVG(Catalogg.cost_), Catalogg.sid, Parts.color
FROM Catalogg JOIN Parts ON Catalogg.pid=Parts.pid AND Parts.color='Red'
GROUP BY Catalogg.sid, Parts.color
UNION
SELECT AVG(Catalogg.cost_), Catalogg.sid, Parts.color
FROM Catalogg JOIN Parts ON Catalogg.pid=Parts.pid AND Parts.color='Green'
GROUP BY Catalogg.sid, Parts.color;

-- 9) ------------------------------------------------------------------------------
SELECT DISTINCT S1.sid
FROM Catalogg AS S1
WHERE (SELECT MAX(S2.cost_) FROM Catalogg AS S2 WHERE S1.sid=S2.sid) >= 50.;
