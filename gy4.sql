SELECT dolgozo.*,SYSDATE FROM dolgozo WHERE
belepes > TO_DATE('1982.01.01','YYYY.MM.DD');

/* Adjuk meg azon dolgoz�kat, akik nev�nek m�sodik bet�je 'A'.*/

SELECT * FROM dolgozo WHERE
SUBSTR(DNEV,2,1) = 'A';

/* Adjuk meg azon dolgoz�kat, akik nev�ben van legal�bb k�t 'L' bet�.*/

SELECT * FROM dolgozo WHERE
 INSTR(dnev,'L',1,2) > 0;

/* Adjuk meg a dolgoz�k nev�nek utols� h�rom bet�j�t. */
SELECT SUBSTR(dnev,-3,3) FROM dolgozo;

 /* Adjuk meg a dolgoz�k fizet�seinek n�gyzetgy�k�t k�t tizedesre, �s ennek eg�szr�sz�t.  */
 SELECT dnev, ROUND(ROUND(SQRT(fizetes),2)) FROM dolgozo;
 
 /*Adjuk meg, hogy h�ny napja dolgozik a c�gn�l ADAMS �s milyen h�napban l�pett be.*/
 Select FLOOR(SYSDATE-belepes), TO_CHAR(belepes, 'month') FROM dolgozo WHERE dnev = 'ADAMS';
 
/*Adjuk meg azokat a (n�v, f�n�k) p�rokat, ahol a k�t ember neve ugyanannyi bet�b�l �ll. */
SELECT * FROM dolgozo d1, dolgozo d2 WHERE d1.fonoke = d2.dkod AND 
    LENGTH(d1.dnev) = LENGTH(d2.dnev);

Select * FROM dolgozo;
 /* List�zzuk ki a dolgoz�k nev�t �s fizet�s�t, valamint jelen�ts�k meg a fizet�st grafikusan
  --�gy, hogy a fizet�st 1000 Ft-ra kerek�tve, minden 1000 Ft-ot egy '#' jel jel�l.*/
  
  SELECT dnev, fizetes,
    RPAD(' ', ROUND(fizetes/1000)+1, '#') FROM dolgozo;  
    
  SELECT  dnev, fizetes, jutalek, ROUND(NVL(jutalek,0)/fizetes,2) FROM dolgozo
  WHERE foglalkozas = 'SALESMAN';
 
 
 Select * from szeret;
 
 /**/
 (SELECT nev FROM szeret)
 MINUS
 (SELECT nev FROM
    ((SELECT * FROM
        (SELECT nev FROM szeret),
        (SELECT gyumolcs FROM szeret))
    MINUS
        (SELECT *FROM szeret)));
 
 /*******/
 
SELECT oazon from dolgozo group by oazon;
 
SELECT oazon, avg(fizetes), count(*) from dolgozo group by oazon;
 
SELECT max(fizetes) from dolgozo; 
SELECT max(fizetes), count(*), avg(fizetes) from dolgozo; 

SELECT oazon, jutalek, count(*) from dolgozo group by oazon, jutalek; 

