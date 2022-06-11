--database name must be 'Ksiegarnia' or need to be change in main.py connection method
CREATE TABLE Autor (
    id_autor int  NOT NULL,
    imie varchar(50)  NULL,
    nazwisko varchar(50)  NOT NULL,
    CONSTRAINT Autor_pk PRIMARY KEY  (id_autor)
);


CREATE TABLE Ksiazka (
    id_ksiazka int  NOT NULL,
    tytul varchar(150)  NOT NULL,
    cena smallmoney  NOT NULL,
    Autor_id int  NOT NULL,
    Wydawca_id int  NOT NULL,
    CONSTRAINT Ksiazka_pk PRIMARY KEY  (id_ksiazka)
);


CREATE TABLE Wydawca (
    id_wydawca int  NOT NULL,
    nazwa varchar(150)  NOT NULL,
    CONSTRAINT Wydawca_pk PRIMARY KEY  (id_wydawca)
);


ALTER TABLE Ksiazka ADD CONSTRAINT Ksiazka_Autor
    FOREIGN KEY (Autor_id)
    REFERENCES Autor (id_autor);


ALTER TABLE Ksiazka ADD CONSTRAINT Ksiazka_Wydawca
    FOREIGN KEY (Wydawca_id)
    REFERENCES Wydawca (id_wydawca);



INSERT INTO Autor (id_autor, imie, nazwisko) VALUES (1, 'Donald', 'Knuth');
INSERT INTO Autor (id_autor, imie, nazwisko) VALUES (2, 'Mark', 'Lutz');
INSERT INTO Autor (id_autor, imie, nazwisko) VALUES (3, 'Rishal', 'Hurbans');
INSERT INTO Autor (id_autor, imie, nazwisko) VALUES (4, 'Ian', 'Stewart');
INSERT INTO Autor (id_autor, imie, nazwisko) VALUES (5, 'Cixin', 'Liu');

INSERT INTO Wydawca (id_wydawca, nazwa) VALUES (1, 'Rebis')
INSERT INTO Wydawca (id_wydawca, nazwa) VALUES (2, 'Prószyński i S-ka')
INSERT INTO Wydawca (id_wydawca, nazwa) VALUES (3, 'Helion')

INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (1, 'Python: wprowadzenie', 109.60, 2, 3);
INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (2, 'Algorytmy sztucznej inteligencji', 47.43, 3, 3);
INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (3, 'Podstawy matematyki', 72.00, 4, 2);
INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (4, 'Ciemny las', 29.32, 5, 1);
INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (5, 'Wędrująca Ziemia', 71.68, 5, 1);
INSERT INTO Ksiazka (id_ksiazka, tytul, cena, Autor_id, Wydawca_id) VALUES (6, 'Analiza transakcyjna dzisiaj', 31.98, 4, 1);
