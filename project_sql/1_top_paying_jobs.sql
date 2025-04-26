/*
Question: What are the top-paying data analyst jobs?

- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries.
- Why? Aims to highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_posted_date,
    job_schedule_type,
    company_dim.company_id,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_work_from_home = TRUE
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;