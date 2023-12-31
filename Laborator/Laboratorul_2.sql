--1.Scrieţi o cerere care are următorul rezultat pentru fiecare angajat: <prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori
--mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaţi atât funcţia CONCAT cât şi operatorul “||”. 

--OPERATORUL "||"
SELECT
    ( LAST_NAME || ' ' || FIRST_NAME || ' CASTIGA ' || SALARY || ' LUNAR DAR DORESTE ' || SALARY*3 ) AS "Salariu ideal"
FROM EMPLOYEES;

--OPERATORUL CONCAT -- codul e corect da nu merge gunoiu asta !!!???????
SELECT 
    CONCAT (LAST_NAME, ' ', FIRST_NAME, ' CASTIGA ', SALARY, ' LUNAR DAR DORESTE ', (SALARY*3) ) AS "Salariu ideal"
FROM EMPLOYEES;

--2.Scrieţi o cerere prin care să se afişeze prenumele salariatului cu prima litera majusculă şi toate celelalte litere minuscule, 
--numele acestuia cu majuscule şi lungimea numelui, pentru angajaţii al căror nume începe cu J sau M sau care au a treia literă din nume A. 
--Rezultatul va fi ordonat descrescător după lungimea numelui. Se vor eticheta coloanele corespunzător. Se cer 2 soluţii (cu operatorul LIKE şi funcţia SUBSTR). 

--VARIANTA CU LIKE
SELECT
    INITCAP(LAST_NAME) AS "Prima litera a prenumelui",
    UPPER(LAST_NAME)AS "Tot numele cu majuscule",
    LENGTH(LAST_NAME)AS "Lungimea prenumelui"
FROM EMPLOYEES
WHERE INITCAP(LAST_NAME) LIKE ('J%') OR INITCAP(LAST_NAME) LIKE ('M%') OR LAST_NAME LIKE ('__A%')
ORDER BY LENGTH(LAST_NAME) DESC;

--VARIANTA CU SUBSTR
SELECT
    INITCAP(LAST_NAME) AS "Prima litera a prenumelui",
    UPPER(LAST_NAME)AS "Tot numele cu majuscule",
    LENGTH(LAST_NAME)AS "Lungimea prenumelui"
FROM EMPLOYEES
WHERE SUBSTR(LAST_NAME,1,1) IN ('J','M') OR SUBSTR(LAST_NAME,3,1)='A'
ORDER BY LENGTH(LAST_NAME) DESC;

--3.Să se afişeze pentru angajaţii cu prenumele „Steven”, codul, numele şi codul departamentului în care lucrează. Căutarea trebuie să nu fie case-sensitive, 
--iar eventualele blank-uri care preced sau urmează numelui trebuie ignorate.
SELECT
    EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE UPPER(TRIM(FIRST_NAME)) LIKE 'STEVEN';

--4.Să se afişeze pentru toţi angajaţii al căror nume se termină cu litera 'e', codul, numele, lungimea numelui şi poziţia din nume
--în care apare prima data litera 'a'. Utilizaţi alias-uri corespunzătoare pentru coloane. 
SELECT
    EMPLOYEE_ID AS "COD ANGAJAT",
    FIRST_NAME AS "NUME",
    LENGTH(FIRST_NAME) AS "LUNGIME NUME",
    INSTR(UPPER(FIRST_NAME),'A',1,1) AS "POZITIA"
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) LIKE ('%E');

--5.Să se afişeze detalii despre salariaţii care au lucrat un număr întreg de săptămâni până la data curentă. 
--Este necesară rotunjirea diferentei celor două date calendaristice? 
SELECT
    *
FROM EMPLOYEES
WHERE MOD(TRUNC(SYSDATE-HIRE_DATE),7)=0;

--6.Să se afişeze codul salariatului, numele, salariul, salariul mărit cu 15%, exprimat cu două zecimale şi numărul de sute al salariului nou rotunjit la 2 zecimale.
--Etichetaţi ultimele două coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare salariaţii al căror salariu nu este divizibil cu 1000. 
SELECT
    EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, 
    TO_CHAR(SALARY+SALARY*15/100,'99999.99') AS "SALARIU NOU",
    ROUND(SALARY+SALARY*15/100,2) AS "NUMAR SUTE"
FROM EMPLOYEES
WHERE MOD(SALARY,1000)<>0;

--7.Să se listeze numele, salariul şi o coloana care sa reprezinte nivelul venitului (pentru fiecare 1000 sa fie folosit cate un simbol $). Ex: 6750 -> ‘$$$$$$’ 
SELECT
    FIRST_NAME, SALARY,
    LPAD('$',SALARY/1000,'$')
FROM EMPLOYEES;

--8.Să se afişeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile. 
SELECT
    TO_CHAR(SYSDATE+30,'YYYY-MM-DD HH-MI-SS')
FROM DUAL;

--9. Să se afişeze numărul de zile rămase până la sfârşitul anului. 
SELECT
    TO_DATE('31-DEC-' || TO_CHAR(SYSDATE,'YYYY'))-SYSDATE
FROM DUAL;

--10. a)Să se afişeze data de peste 12 ore.
SELECT
    SYSDATE+0.5
FROM DUAL;
    --b) Să se afişeze data de peste 5 minute 
SELECT
    SYSDATE+ 5/1/24
FROM DUAL;

--11. Să se afişeze numele şi prenumele angajatului (într-o singură coloană), data angajării şi data negocierii salariului, care este
--prima zi de Luni după 6 luni de serviciu. Etichetaţi această coloană “Negociere”. 
SELECT
    FIRST_NAME || ', ' || LAST_NAME,
    HIRE_DATE,
    NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'MONDAY')
FROM EMPLOYEES;

--12.Pentru fiecare angajat să se afişeze numele şi numărul de luni de la data angajării. Etichetaţi coloana “Luni lucrate”. 
--Să se ordoneze rezultatul după numărul de luni lucrate. Se va rotunji numărul de luni la cel mai apropiat număr întreg
SELECT
    FIRST_NAME,
    ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))AS "Luni lucrate"
FROM EMPLOYEES
ORDER BY MONTHS_BETWEEN(SYSDATE,HIRE_DATE);

--13.Să se afişeze numele, data angajării şi ziua săptămânii în care a început lucrul fiecare salariat. Etichetaţi coloana “Zi”. 
--Ordonaţi rezultatul după ziua săptămânii, începând cu Luni. 
SELECT
    FIRST_NAME, HIRE_DATE,
    TO_CHAR(HIRE_DATE,'DAY') AS "ZI"
FROM EMPLOYEES
ORDER BY TO_CHAR(HIRE_DATE,'DAY');

--14.Să se afişeze numele angajaţilor şi comisionul. Dacă un angajat nu câştigă comision, să se scrie “Fara comision”. Etichetaţi coloana “Comision”. 
SELECT
    FIRST_NAME, 
    NVL(TO_CHAR(COMMISSION_PCT,'0.99'),'FARA COMISION') AS "COMISION"
FROM EMPLOYEES;

--15.Să se listeze numele, salariul şi comisionul tuturor angajaţilor al căror venit lunar (salariu + valoare comision) depăşeşte 10000. 
SELECT
    FIRST_NAME,SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE (SALARY+SALARY*COMMISSION_PCT)>10000 OR SALARY>10000;

--16. Să se afişeze numele, codul job-ului, salariul şi o coloană care să arate salariul după mărire.
--Se presupune că pentru IT_PROG are loc o mărire de 20%, pentru SA_REP creşterea este de 25%, iar pentru SA_MAN are loc o mărire de 35%.
--Pentru ceilalţi angajaţi nu se acordă mărire. Să se denumească coloana "Salariu renegociat" (ambele solutii: CASE si DECODE).

--VARIANTA CU CASE
SELECT
    FIRST_NAME, JOB_ID, SALARY,
    CASE 
        WHEN UPPER(JOB_ID) LIKE 'IT_PROG' THEN SALARY*20/100
        WHEN UPPER(JOB_ID) LIKE 'SA_REP' THEN SALARY*25/100
        WHEN UPPER(JOB_ID) LIKE 'SA_MAN' THEN SALARY*35/100
    ELSE SALARY
    END "Salariu negociat"
FROM EMPLOYEES;

--VARIANTA CU DECODE
SELECT
    FIRST_NAME, JOB_ID, SALARY,
    DECODE (
        UPPER(JOB_ID),'IT_PROG',SALARY*20/100,
        'SA_REP',SALARY*25/100,
        'SA_MAN', SALARY*35/100,
        SALARY) "Salariu negociat"
FROM EMPLOYEES;
