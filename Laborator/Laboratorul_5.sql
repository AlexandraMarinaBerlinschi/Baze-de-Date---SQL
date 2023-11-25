SELECT
    *
FROM EMPLOYEES;

SELECT
    *
FROM JOBS;

SELECT
    *
FROM DEPARTMENTS;

SELECT 
    *
FROM LOCATIONS;

SELECT
    *
FROM COUNTRIES;

--1. Să se listeze job-urile care există în departamentul 30.
SELECT
    DISTINCT J.JOB_TITLE
FROM JOBS J
JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID 
WHERE E.DEPARTMENT_ID = 30;

--2.Să se afişeze numele salariatului şi numele departamentului pentru toţi salariaţii care au litera A inclusă în nume
SELECT
    E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(E.LAST_NAME)LIKE ('%A%');

--3.Să se afişeze numele, job-ul, codul şi numele departamentului pentru toţi angajaţii care lucrează în Oxford.
SELECT
    D.DEPARTMENT_NAME, E.EMPLOYEE_ID, J.JOB_TITLE, E.LAST_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE UPPER(L.CITY) LIKE 'OXFORD';

--4.Să se afişeze codul angajatului şi numele acestuia, împreună cu numele şi codul şefului său direct.Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.
SELECT
    E.EMPLOYEE_ID AS "Ang#", 
    E.LAST_NAME AS "Angajat", 
    E2.EMPLOYEE_ID AS "Mgr#", 
    E2.LAST_NAME AS "Manager"
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID;

--5.Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.
SELECT
    E.LAST_NAME,E.HIRE_DATE
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON E.HIRE_DATE > E2.HIRE_DATE
WHERE UPPER(E2.LAST_NAME) LIKE 'GATES';

--6.Sa se afișeze codul şi numele angajaţilor care lucrează în același departament cu cel puţin un angajat al cărui nume conţine litera “t”. 
--Se vor afişa, de asemenea, codul şi numele departamentului respectiv. Rezultatul va fi ordonat alfabetic după nume.
SELECT
    DISTINCT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E2.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(E.LAST_NAME) LIKE ('%T%')
ORDER BY E.LAST_NAME;

--7.Sa se afișeze numele, salariul, titlul job-ului, oraşul şi ţara în care lucrează angajatii condusi direct de King.
SELECT
    E.LAST_NAME, E.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.MANAGER_ID=E2.EMPLOYEE_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE UPPER(E2.LAST_NAME) LIKE ('KING');

--8.Sa se afișeze codul departamentului, numele departamentului, numele și job-ul tuturor angajaților din departamentele al căror nume conţine şirul ‘ti’. 
--De asemenea, se va lista salariul angajaţilor, în formatul “$99,999.00”. Rezultatul se va ordona alfabetic după numele departamentului, şi în cadrul acestuia, 
--după numele angajaţilor.
SELECT
    D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.LAST_NAME, J.JOB_TITLE,
    '$' || TO_CHAR(E.SALARY, '99,999.99') 
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE UPPER(D.DEPARTMENT_NAME) LIKE ('%TI%')
ORDER BY D.DEPARTMENT_NAME, E.LAST_NAME;

--9.Să se afișeze departamentele fără angajați.
SELECT
    D.DEPARTMENT_NAME
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NULL;



