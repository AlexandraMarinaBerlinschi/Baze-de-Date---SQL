--4. Să se listeze conţinutul tabelelor din schema considerată, afişând valorile tuturor câmpurilor. 
SELECT
    *
FROM EMPLOYEES;

--5.Să se afişeze codul angajatului, numele, codul job-ului, data angajarii. Ce fel de operaţie este aceasta
SELECT
    EMPLOYEE_ID,FIRST_NAME, JOB_ID,HIRE_DATE
FROM EMPLOYEES;

--6.Modificați cererea anterioară astfel încât, la rulare, capetele coloanelor să aibă numele cod, nume, cod job, data angajarii.
SELECT
    EMPLOYEE_ID AS "Cod",
    FIRST_NAME AS "Nume",
    JOB_ID AS "Cod job",
    HIRE_DATE AS "Data angajarii"
FROM EMPLOYEES;

--7.Să se listeze, cu şi fără duplicate, codurile job-urilor din tabelul EMPLOYEES

--CU DUPLICATE
SELECT
    JOB_ID
FROM EMPLOYEES;

--FARA DUPLICATE
SELECT
    DISTINCT JOB_ID
FROM EMPLOYEES;

--8.Să se afişeze numele concatenat cu job_id-ul, separate prin virgula și spatiu. Etichetați coloana “Angajat si titlu”
SELECT
    FIRST_NAME || ', ' || JOB_ID AS "Angajat si titlu"
FROM EMPLOYEES;

--9.Creați o cerere prin care să se afișeze toate datele din tabelul EMPLOYEES pe o singură coloană. Separaţi 
--fiecare coloană printr-o virgulă. Etichetati coloana ”Informatii complete”.
SELECT
    EMPLOYEE_ID || ', ' || FIRST_NAME || ', ' || LAST_NAME || ', ' || EMAIL || ', ' || PHONE_NUMBER || ', ' || HIRE_DATE || ', ' || JOB_ID || ', ' || SALARY || ', ' || MANAGER_ID || ', ' || DEPARTMENT_ID AS "Informatii complete"
FROM EMPLOYEES;

--10.Să se listeze numele si salariul angajaţilor care câştigă mai mult de 2850
SELECT
    FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 2850;

--11.Să se creeze o cerere pentru a afişa numele angajatului şi codul departamentului pentru angajatul având codul 104.
SELECT
    FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID=104;

--12.Să se afişeze numele şi salariul angajaţilor al căror salariu nu se află în intervalul [1500, 2850]. 
SELECT
    FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 1500 AND 2850;

--SAU
SELECT
    FIRST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY < 1500 OR SALARY > 2850;

--13.Să se afişeze numele, job-ul şi data la care au început lucrul salariaţii angajaţi între 20 Februarie 1987 şi 1 Mai 1989.
--Rezultatul va fi ordonat crescător după data de început.
SELECT
    FIRST_NAME,JOB_ID, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY HIRE_DATE;

--14.Să se afişeze numele salariaţilor şi codul departamentelor pentru toti angajaţii din departamentele 10, 30 și 50 în ordine alfabetică a numelor.
SELECT
    FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10,30,50)
ORDER BY FIRST_NAME;

--SAU 
SELECT 
    FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID=10 OR DEPARTMENT_ID=30 OR DEPARTMENT_ID=50
ORDER BY FIRST_NAME;

--15.Să se listeze numele şi salariile angajaților care câştigă mai mult decât 1500 şi lucrează în departamentul 10, 30 sau 50.
--Se vor eticheta coloanele drept Angajat si Salariu lunar. 
SELECT
    FIRST_NAME || ', ' || SALARY AS "Angajat si Salariu lunar"
FROM EMPLOYEES
WHERE SALARY > 1500 AND DEPARTMENT_ID IN (10,30,50);

--16.Care este data curentă? Afişaţi diferite formate ale acesteia.
SELECT
    SYSDATE
FROM DUAL;

--17.Să se afișeze numele şi data angajării pentru fiecare salariat care a fost angajat în 1987. 
--Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se formatează data.

--Varianta 1: Se lucreaza cu formatul implicit al datei
SELECT
    FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE ('%87%');

--Varianta 2 : se formateaza data
SELECT
    FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EXTRACT ( YEAR FROM HIRE_DATE) = 1987;

--SAU
SELECT
    FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY') = '1987';

--18. Să se afișeze numele, prenumele și data angajării persoanelor care au început activitatea într-o zi a lunii egală cu
--cea a datei curente.
SELECT
    FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EXTRACT(MONTH FROM HIRE_DATE) = EXTRACT ( MONTH FROM SYSDATE);

--19. Să se afişeze numele şi job-ul pentru toţi angajaţii care nu au manager
SELECT
    FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--20.. Să se afișeze numele, salariul și comisionul pentru toti salariații care câștigă comision(se presupune că aceasta înseamnă
-- prezența unei valori nenule în coloana respectivă). Să se sorteze datele în ordine descrescătoare a salariilor și comisioanelor.
SELECT
    FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

--21.Eliminaţi clauza WHERE din cererea anterioară. Unde sunt plasate valorile NULL în ordinea descrescătoare?
SELECT
    FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

--22.Să se listeze numele tuturor angajaților care au a treia literă din nume ‘A’.
SELECT
    FIRST_NAME
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE ('__a%');

--23.Să se listeze numele tuturor angajatilor care au 2 litere ‘L’ in nume şi lucrează în departamentul 30 sau managerul lor este 102.
SELECT
    FIRST_NAME
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE ('%l%l%') AND (DEPARTMENT_ID=30 OR MANAGER_ID=102);

--24.Să se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conţine şirul “CLERK” sau “REP” și salariul nu 
--este egal cu 1000, 2000 sau 3000. (operatorul NOT IN)
SELECT
    FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE (UPPER(JOB_ID) LIKE ('%CLERK%') OR UPPER(JOB_ID) LIKE ('%REP%') ) AND SALARY NOT IN (1000,2000,3000);

--25.Să se afișeze numele departamentelor care nu au manager. 
SELECT
    DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;
