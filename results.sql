-- Finding number of diagnosed female and male patients -- 
SELECT
    gender,
    COUNT(*) AS count
FROM thyroid_diff
WHERE gender IN ('F', 'M')
GROUP BY gender;
 
 -- Counting how many patients from both genders that have T, N, M stages -- 
SELECT gender, T, N, M, 
		COUNT(*) AS PatientCount
FROM thyroid_diff
GROUP BY gender , T , N , M;

-- Checking for risk levels for ages 50 and older -- 
SELECT
	Risk,
    AverageAge
FROM 
	(
		SELECT
			Risk,
            AVG(Age) AS AverageAge
		FROM
			thyroid_diff
		GROUP BY
			Risk
	) AS RiskAges
WHERE
	AverageAge <= 50; 
    
-- Counting the patients and average age for each combination of T, N, M stages -- 
SELECT
	T,
    N,
    M,
    PatientCount
    AverageAge
FROM 
	(
		SELECT 
			T,
            N,
            M,
            COUNT(*) AS PatientCount,
            AVG(Age) AS AverageAge
		FROM
        thyroid_diff
        GROUP BY 
			T, N, M
	) AS StageAges
WHERE
	PatientCount >= 10 

-- Distribution of pathology results among patients and percentage of reoccurrence after tx -- 
SELECT
	Pathology,
    COUNT(*) AS TotalPatients,
    SUM(CASE WHEN Recurred = 'Yes' THEN 1 ELSE 0 END) AS RecurredPatients,
    (SUM(CASE WHEN Recurred = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS RecurrencePercentage
FROM 
	thyroid_diff
GROUP BY
	Pathology;
    