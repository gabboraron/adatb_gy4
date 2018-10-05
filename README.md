# adatb_gy4

>  leírás:  http://vopraai.web.elte.hu/tananyag/adatb1819/4.ora/feladat.txt

## Hasznos függvények

```` SQL

/* dátum megadása */ TO_DATE('94-11-30', 'YY-MM-DD') -> DATE 

/* kivág az első paraméterből a második paramétertől kezdve a harmadik paraméternyi karaktert */ SUBSTR('valami',2,1) -> a

/* a minusz az hátulról mér */ SUBSTR('valami',-2,1) -> m
/* az első stringben keres a második indextől a harmadik paraméternyi előfordulását, tehát itt az almában az leejétől a második a betű -> 4 */ INSTR('alma','a', 1, 2) -> 2. a betű pozíciója (ha > 0 van ilyen)
/* kerekítünk, ha nem adunk meg semmit egészre egyébként paraméterben megadjuk hány tizedesen */ ROUND(SQRT(4.4),2) -> 2.09
/* lefele kerekít*/ FLOOR (n)
/* felfele kerekít */ CEIL
/* dátumot hónapnévvé is alakíthat*/ TO_CHAR(DATE, 'month') -> hónapnév
LENGTH("alma") -> 4
/* a kezdeti stringhez hozzáfűzi a második paraméter minusz egyszer a harmadik paramétert */ RPAD(' ', 3, '#') -> "##"
/* ha nem konzisztensen van benn az adatbázisban */ UPPER("alma") -> ALMA

/* ha nem konzisztensen van benn az adatbázisban */ LOWER("ALMA") -> alma

/* ha egy oszlopban van Null akkor nem lehet vele műveletet végezni mert NULL + bármi = NULL így kiküszöbölhető */ NVL(NULL, "valami") -> valami (első nem null eredményt adja vissza)
/* han em akarok semmivel sem dolgozni akkor:  */ SELECT valami FROM DUAL; 
/* gépidő */ SYSDATE 

````

## DOLGOZO tábla

- Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?

````SQL
SELECT dolgozo.*,SYSDATE FROM dolgozo WHERE
belepes > TO_DATE('1982.01.01','YYYY.MM.DD');

````

- Adjuk meg azon dolgozókat, akik nevének második betűje 'A'.


````SQL
SELECT * FROM dolgozo WHERE
SUBSTR(DNEV,2,1) = 'A';

````

- Adjuk meg azon dolgozókat, akik nevében van legalább két 'L' betű. 


````SQL
SELECT * FROM dolgozo WHERE
 INSTR(dnev,'L',1,2) > 0;

````

- Adjuk meg a dolgozók nevének utolsó három betűjét.

````SQL
SELECT SUBSTR(dnev,-3,3) FROM dolgozo;
````

- Adjuk meg a dolgozók fizetéseinek négyzetgyökét két tizedesre, és ennek egészrészét. 

````SQL
  SELECT dnev, ROUND(ROUND(SQRT(fizetes),2)) FROM dolgozo;
````

- Adjuk meg, hogy hány napja dolgozik a cégnél ADAMS és milyen hónapban lépett be.

````SQL
Select FLOOR(SYSDATE-belepes), TO_CHAR(belepes, 'month') FROM dolgozo WHERE dnev = 'ADAMS';
````

- Adjuk meg azokat a (név, főnök) párokat, ahol a két ember neve ugyanannyi betűből áll. 

````SQL
SELECT * FROM dolgozo d1, dolgozo d2 WHERE d1.fonoke = d2.dkod AND
    LENGTH(d1.dnev) = LENGTH(d2.dnev);
````

- Listázzuk ki a dolgozók nevét és fizetését, valamint jelenítsük meg a fizetést grafikusan
  --úgy, hogy a fizetést 1000 Ft-ra kerekítve, minden 1000 Ft-ot egy '#' jel jelöl.

````SQL
  SELECT dnev, fizetes,
    RPAD(' ', ROUND(fizetes/1000)+1, '#') FROM dolgozo; 

````

- Listázzuk ki azoknak a dolgozóknak a nevét, fizetését, jutalékát, és a jutalék/fizetés
  --arányát, akiknek a foglalkozása eladó (salesman). Az arányt két tizedesen jelenítsük meg.


````SQL
  SELECT  dnev, fizetes, jutalek, ROUND(NVL(jutalek,0)/fizetes,2) FROM dolgozo
  WHERE foglalkozas = 'SALESMAN';
````

## SZERET tábla

- Kik szeretnek minden gyümölcsöt?

````SQL

(SELECT nev FROM szeret)
 MINUS
 (SELECT nev FROM
    ((SELECT * FROM
        (SELECT nev FROM szeret),
        (SELECT gyumolcs FROM szeret))
    MINUS
        (SELECT *FROM szeret)));
        
```

#  Kiterjesztett relációs algebra

````SQL

SELECT oazon from dolgozo group by oazon;

SELECT oazon, avg(fizetes), count(*) from dolgozo group by oazon;


SELECT max(fizetes) from dolgozo;
SELECT max(fizetes), count(*), avg(fizetes) from dolgozo;


SELECT oazon, jutalek, count(*) from dolgozo group by oazon, jutalek;

````


### Zhról

- papirosban beugró 1 óra alatt, semmit se lehet használni, kiterjesztett rel algebra, SQL
- utánna géptermi, ott bármit lehet használni,

#### 1.zh időpontja jövő hét utáni hét gyak időben
