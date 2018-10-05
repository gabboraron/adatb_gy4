SELECT dolgozo.*,SYSDATE FROM dolgozo WHERE
belepes > TO_DATE('1982.01.01','YYYY.MM.DD');

/* Adjuk meg azon dolgozókat, akik nevének második betûje 'A'.*/

SELECT * FROM dolgozo WHERE
SUBSTR(DNEV,2,1) = 'A';

/* Adjuk meg azon dolgozókat, akik nevében van legalább két 'L' betû.*/

SELECT * FROM dolgozo WHERE
 INSTR(dnev,'L',1,2) > 0;

/* Adjuk meg a dolgozók nevének utolsó három betûjét. */
SELECT SUBSTR(dnev,-3,3) FROM dolgozo;

 /* Adjuk meg a dolgozók fizetéseinek négyzetgyökét két tizedesre, és ennek egészrészét.  */
 SELECT dnev, ROUND(ROUND(SQRT(fizetes),2)) FROM dolgozo;
 
 /*Adjuk meg, hogy hány napja dolgozik a cégnél ADAMS és milyen hónapban lépett be.*/
 Select FLOOR(SYSDATE-belepes), TO_CHAR(belepes, 'month') FROM dolgozo WHERE dnev = 'ADAMS';
 
/*Adjuk meg azokat a (név, fõnök) párokat, ahol a két ember neve ugyanannyi betûbõl áll. */
SELECT * FROM dolgozo d1, dolgozo d2 WHERE d1.fonoke = d2.dkod AND 
    LENGTH(d1.dnev) = LENGTH(d2.dnev);

Select * FROM dolgozo;
 /* Listázzuk ki a dolgozók nevét és fizetését, valamint jelenítsük meg a fizetést grafikusan
  --úgy, hogy a fizetést 1000 Ft-ra kerekítve, minden 1000 Ft-ot egy '#' jel jelöl.*/
  
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

