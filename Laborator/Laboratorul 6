SELECT
    *
FROM EMPLOYEES;

SELECT
    *
FROM JOBS;

SELECT
    *
FROM LOCATIONS;

SELECT
    *
FROM COUNTRIES;

SELECT
    *
FROM DEPARTMENTS;

--1.Folosind subcereri, scrieţi o cerere pentru a afişa numele şi salariul pentru toţi colegii (din acelaşi departament) lui Gates. 
--Se va exclude Gates
SELECT
    E.LAST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = (
    SELECT 
        E2.DEPARTMENT_ID
    FROM EMPLOYEES E2
    WHERE UPPER(E2.LAST_NAME) LIKE 'GATES' AND E2.LAST_NAME <> E.LAST_NAME );

--2.Afișați pentru fiecare angajat codul, numele, salariul, precum și numele șefului direct.
SELECT
    E.EMPLOYEE_ID, E.LAST_NAME, E.SALARY,
    (   SELECT 
            E2.LAST_NAME
        FROM EMPLOYEES E2
        WHERE E2.EMPLOYEE_ID = E.MANAGER_ID )
FROM EMPLOYEES E;

--3. Folosind subcereri, să se afişeze numele, salariul și numele colegului de departament cu cel mai mare salariu, 
--al angajaţilor conduşi direct de preşedintele companiei (acesta este considerat angajatul care nu are manager).
SELECT
    E.LAST_NAME, E.SALARY,
        (
            SELECT
                E2.LAST_NAME
            FROM EMPLOYEES E2
            WHERE E2.SALARY >= ALL (
                SELECT
                    E3.SALARY
                FROM EMPLOYEES E3
                WHERE E3.DEPARTMENT_ID = E2.DEPARTMENT_ID
                ) AND E2.DEPARTMENT_ID = E.DEPARTMENT_ID
        )
FROM EMPLOYEES E
WHERE E.MANAGER_ID = (
    SELECT
        E2.EMPLOYEE_ID
    FROM EMPLOYEES E2
    WHERE E2.MANAGER_ID IS NULL );

--4.Scrieți o cerere pentru a afişa numele, codul departamentului și salariul angajatilor a căror număr de departament și 
--salariu coincid cu numărul departamentului și salariul unui angajat care castiga comision.

SELECT
    E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E 
WHERE (E.DEPARTMENT_ID,E.SALARY) IN (
    SELECT 
        E2.DEPARTMENT_ID,E2.SALARY
    FROM EMPLOYEES E2
    WHERE COMMISSION_PCT IS NOT NULL AND E.EMPLOYEE_ID <> E2.EMPLOYEE_ID);
    
--5.Scrieți o cerere pentru a afișa angajații care castiga mai mult decat oricare funcționar (job-ul conţine şirul “CLERK”). 
--Sortati rezultatele după salariu, in ordine descrescatoare.

SELECT
    E.LAST_NAME,E.SALARY
FROM EMPLOYEES E 
WHERE E.SALARY >= ALL (
    SELECT
        E2.SALARY
    FROM EMPLOYEES E2
    JOIN JOBS J ON E2.JOB_ID = J.JOB_ID
    WHERE UPPER(J.JOB_TITLE) LIKE '%CLERK%' AND E2.EMPLOYEE_ID <> E.EMPLOYEE_ID )
ORDER BY E.SALARY DESC;

--6.Scrieţi o cerere pentru a afişa numele, numele departamentului şi salariul angajaţilor care nu câştigă comision, dar al 
--căror şef direct câştigă comision.
SELECT
    E.LAST_NAME, E.DEPARTMENT_ID,E.SALARY
FROM EMPLOYEES E
WHERE E.COMMISSION_PCT IS NULL AND E.MANAGER_ID IN(
    SELECT
        E2.EMPLOYEE_ID
    FROM EMPLOYEES E2
    WHERE E2.COMMISSION_PCT IS NOT NULL);
    
--7.Sa se afișeze numele, departamentul, salariul şi job-ul tuturor angajatilor al căror salariu si comision coincid cu salariul
--si comisionul unui angajat din Oxford.
SELECT
    E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY, J.JOB_TITLE
FROM EMPLOYEES E 
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE (E.SALARY, E.COMMISSION_PCT) IN (
    SELECT
        E2.SALARY, E2.COMMISSION_PCT
    FROM EMPLOYEES E2
    JOIN DEPARTMENTS D ON E2.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
    WHERE UPPER(L.CITY) LIKE 'OXFORD');
    
--8.Pentru fiecare departament, să se obțina numele salariatului avand cea mai mare vechime din departament. 
--Să se ordoneze rezultatul după numele departamentului.
SELECT
    E.LAST_NAME, D.DEPARTMENT_NAME, E.HIRE_DATE
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.HIRE_DATE <= ALL (
    SELECT
        E2.HIRE_DATE
    FROM EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID )
ORDER BY D.DEPARTMENT_NAME;

--9.Sa se obtina numele primilor 7 angajați avand salariul maxim. Rezultatul se va afişa în ordine crescătoare a salariilor
SELECT
    LAST_NAME, SALARY
FROM (
    SELECT
       LAST_NAME, SALARY
    FROM EMPLOYEES 
    ORDER BY SALARY DESC 
    ) WHERE ROWNUM <=7;

--10.Sa se obtina numele angajatilor care castiga unul dintre cele mai mari 7 salarii. Rezultatul se va afişa în ordine crescătoare 
--a salariilor.
SELECT
    LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT
        *
    FROM (
        SELECT
            DISTINCT SALARY
        FROM EMPLOYEES 
        ORDER BY SALARY DESC
        )WHERE ROWNUM <= 7 
    );
    
    


