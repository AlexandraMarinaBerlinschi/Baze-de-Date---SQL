SELECT
    *
FROM DEPARTMENTS;

SELECT
    *
FROM JOBS;

--1.Să se determine numărul de angajaţi care sunt şefi.
SELECT
    COUNT(T.MANAGER_ID)
FROM (
    SELECT
        DISTINCT E.MANAGER_ID
    FROM EMPLOYEES E
    )T;
    
--2.Scrieți o cerere pentru a se afişa numele departamentului, locaţia, numărul de angajaţi şi salariul mediu pentru 
--angajaţii din acel departament. Coloanele vor fi etichetate corespunzător. 
--Este necesara precizarea coloanei department_id in clauza GROUP BY?
SELECT
    D.DEPARTMENT_NAME, D.LOCATION_ID,
    COUNT(E.EMPLOYEE_ID), AVG(E.SALARY)
FROM EMPLOYEES E 
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.LOCATION_ID;

--3. Să se afişeze codul şi numele angajaţilor care câștigă mai mult decât salariul mediu din firmă.
SELECT
    E.EMPLOYEE_ID, E.LAST_NAME
FROM EMPLOYEES E 
WHERE E.SALARY > (
    SELECT
        AVG(E2.SALARY)
    FROM EMPLOYEES E2 );
    
--4. Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost plătit subordonat. Se vor exclude cei pentru care 
--codul managerului nu este cunoscut. De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 4000$. 
--Sortaţi rezultatul în ordine descrescătoare a salariilor.
SELECT
    E.MANAGER_ID, MIN(E.SALARY)
FROM EMPLOYEES E
WHERE E.MANAGER_ID IS NOT NULL
GROUP BY E.MANAGER_ID
HAVING MIN(E.SALARY) > 4000;


--5.Să se afişeze maximul salariilor medii pe departamente
SELECT
    MAX(AVG(E.SALARY))
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID;

--6.Scrieți o cerere pentru a afișa, pentru departamentele avand codul > 80, salariul total pentru fiecare job din cadrul 
--departamentului. Se vor afișa orașul, numele departamentului, jobul și suma salariilor. Se vor eticheta coloanele corespunzător.
SELECT
    L.CITY AS "ORAS", 
    D.DEPARTMENT_NAME AS "DEPARTAMENT",
    E.JOB_ID, 
    SUM(E.SALARY) AS "SALARIU TOTAL"
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.DEPARTMENT_ID > 80
GROUP BY L.CITY, D.DEPARTMENT_NAME, E.JOB_ID;


--7.Să se calculeze comisionul mediu din firmă, luând în considerare toate liniile din tabel.
SELECT
    AVG(NVL(COMMISSION_PCT, 0))
FROM EMPLOYEES;

--8. Sa se afiseze codul, numele departamentului și numărul de angajați care lucrează în acel departament, pentru departamentele 
--în care lucrează mai puțin de 4 angajați
SELECT
    E.EMPLOYEE_ID, E.LAST_NAME , D.DEPARTMENT_NAME
FROM EMPLOYEES E 
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME, E.EMPLOYEE_ID, E.LAST_NAME
HAVING COUNT(E.EMPLOYEE_ID) < 4;

--9. Să se obțină codul, titlul şi salariul mediu al job-ului pentru care salariul mediu este minim.
SELECT
   E.JOB_ID, J.JOB_TITLE, AVG(E.SALARY)
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY E.JOB_ID,J.JOB_TITLE
HAVING AVG(E.SALARY) = (
    SELECT
        MIN(AVG(E.SALARY))
    FROM EMPLOYEES E
    GROUP BY E.JOB_ID );
    
--10. Să se afişeze numele departamentului și cel mai mic salariu din departamentul avand cel mai mare salariu mediu.
SELECT
    D.DEPARTMENT_NAME , AVG(E.SALARY)
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING AVG(E.SALARY) = (
    SELECT
        MAX(AVG(SALARY))
    FROM EMPLOYEES  
    GROUP BY DEPARTMENT_ID );
    
--11.Sa se afiseze salariații care au fost angajați în aceeaşi zi a lunii în care cei mai mulți dintre salariati au fost angajați.

