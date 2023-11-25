--Berlinschi Alexandra Marina
--Grupa 142
--Exam 125

--Sa se afiseze utilizatorii care s-au inscris la examene de certificare pentru nivelul 'avansat'
SELECT DISTINCT U.NUME, U.PRENUME
FROM UTILIZATOR U
JOIN SE_INSCRIE SI ON U.ID = SI.ID_UTILIZATOR
JOIN EXAMEN_CERTIFICARE EC on EC.ID = SI.ID_EXAMEN_CERTIFICARE
JOIN CERTIFICARE C2 on C2.ID = EC.ID_CERTIFICARE
WHERE UPPER(C2.NIVEL) LIKE 'AVANSAT';

--Sa se afiseze utilizatorii care au participat la cel putin un examen de certificare in anul 2022
SELECT DISTINCT U.NUME, U.PRENUME
FROM UTILIZATOR U
JOIN SE_INSCRIE SI ON U.ID = SI.ID_UTILIZATOR
JOIN EXAMEN_CERTIFICARE EC ON EC.ID = SI.ID_EXAMEN_CERTIFICARE
WHERE EXTRACT(YEAR FROM EC.DATA_START) = 2022;

--Sa se afiseze lista examenelor la care s-au inscris mai putini candidati decat numarul total de locuri
SELECT EC.ID, EC.DATA_START, EC.NR_LOCURI, COUNT(SI.ID_UTILIZATOR) AS NUMAR_INSCRISI
FROM EXAMEN_CERTIFICARE EC
LEFT JOIN SE_INSCRIE SI on EC.ID = SI.ID_EXAMEN_CERTIFICARE
GROUP BY EC.ID, EC.DATA_START, EC.NR_LOCURI
HAVING COUNT(SI.ID_UTILIZATOR) < EC.NR_LOCURI;

--Sa se afiseze pentru fiecare tip de certificare pentru care s-au desfasurat atat examene online, dar si examene la un sediu (FMI sau UNIBUC), numarul total de utilizatori insrisi si numarul total de locuri

SELECT c.denumire,
       COUNT(DISTINCT CASE WHEN md.denumire = 'online' THEN si.id_utilizator END) AS numar_utilizatori_online,
       COUNT(DISTINCT CASE WHEN md.denumire IN ('FMI', 'UNIBUC') THEN si.id_utilizator END) AS numar_utilizatori_sediu,
       SUM(ec.nr_locuri) AS numar_locuri
FROM certificare c
JOIN EXAMEN_CERTIFICARE EC ON c.ID = EC.ID_CERTIFICARE
JOIN mod_desfasurare md ON ec.id_mod_desfasurare = md.id
JOIN se_inscrie si ON ec.id = si.id_examen_certificare
WHERE UPPER(md.denumire) IN ('ONLINE', 'FMI', 'UNIBUC')
GROUP BY c.denumire
HAVING COUNT(DISTINCT CASE WHEN md.denumire = 'online' THEN si.id_utilizator END) > 0
   AND COUNT(DISTINCT CASE WHEN md.denumire IN ('FMI', 'UNIBUC') THEN si.id_utilizator END) > 0;
