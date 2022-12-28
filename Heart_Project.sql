SELECT *
FROM heart_project.heart_failure_clinical_records_dataset;



-- Does diabetes contribute to death

SELECT COUNT(diabetes) AS diabetics, diabetes, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY diabetes, DEATH_EVENT;

CREATE VIEW diabetes_associated_death AS
SELECT diabetes, Count(diabetes) AS diabetics, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
WHERE DEATH_EVENT is not null
GROUP BY diabetes, DEATH_EVENT;

SELECT *
FROM diabetes_associated_death;

SELECT diabetics * 100/(SELECT SUM(diabetics) FROM diabetes_associated_death) AS percent, diabetes, DEATH_EVENT
FROM diabetes_associated_death
GROUP BY diabetes, DEATH_EVENT;



-- Does smoking contribute to death

WITH CTE_smoking_deaths AS
(SELECT COUNT(smoking) AS smokers, smoking, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY smoking, DEATH_EVENT)
SELECT smokers * 100/(SELECT SUM(smokers) FROM CTE_smoking_deaths) AS percent, smoking, DEATH_EVENT
FROM CTE_smoking_deaths
GROUP BY smoking, DEATH_EVENT;


-- Does anaemia contribute to death

WITH CTE_anaemia_deaths AS
(SELECT COUNT(anaemia) AS patients, anaemia, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY anaemia, DEATH_EVENT)
SELECT patients * 100/(SELECT SUM(patients) FROM CTE_anaemia_deaths) AS percent, anaemia, DEATH_EVENT
FROM CTE_anaemia_deaths
GROUP BY anaemia, DEATH_EVENT;


-- Does sex affect liklihood of death

WITH CTE_deaths_based_on_sex AS
(SELECT COUNT(sex) AS patients, sex, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY sex, DEATH_EVENT)
SELECT patients * 100/(SELECT SUM(patients) FROM CTE_deaths_based_on_sex) AS percent, sex, DEATH_EVENT
FROM CTE_deaths_based_on_sex
GROUP BY sex, DEATH_EVENT;


-- Does age contribute to death


WITH CTE_age AS
(SELECT COUNT(age) AS patients, age, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY age, DEATH_EVENT)
SELECT *
FROM CTE_age
WHERE DEATH_EVENT = 1
ORDER BY age;



-- Does high blood pressure contribute to death

SELECT COUNT(high_blood_pressure) AS patients, high_blood_pressure, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY high_blood_pressure, DEATH_EVENT;

WITH CTE_blood_pressure AS
(SELECT COUNT(high_blood_pressure) AS patients, high_blood_pressure, DEATH_EVENT
FROM heart_project.heart_failure_clinical_records_dataset
GROUP BY high_blood_pressure, DEATH_EVENT)
SELECT patients * 100/(SELECT SUM(patients) FROM CTE_blood_pressure) AS percent, high_blood_pressure, DEATH_EVENT
FROM CTE_blood_pressure
GROUP BY high_blood_pressure, DEATH_EVENT;

CREATE TEMPORARY TABLE hypertension (
patients_percentage decimal(6,2),
high_blood_pressure varchar(50) not null,
DEATH_EVENT varchar(50) not null
);

INSERT INTO hypertension (patients_percentage, high_blood_pressure, DEATH_EVENT) values
(13.04, 'yes', 'yes'),
(19.06, 'no', 'yes'),
(22.07, 'yes', 'no'),
(45.82, 'no', 'no');

SELECT *
FROM hypertension



