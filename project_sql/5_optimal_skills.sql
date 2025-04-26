/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst?: 

- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis.
*/

WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
), average_salary AS (
SELECT
    skills_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS salary_avg
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    salary_avg
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    salary_avg DESC
LIMIT 
    25;

-- Revised version in more summarized format:
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    salary_avg DESC,
    demand_count DESC
LIMIT
    25;

/*
Highest Average Salary:

go ($115,320)

Most In-Demand Skills (by job count):
    python (236 listings)
    tableau (230 listings)
    r (148 listings)

Top Skills by Demand and Salary:
    python — very high demand (236), strong salary (~$101,397)
    tableau — very high demand (230), decent salary (~$99,288)
    r — high demand (148), ~$100,499 salary

High Salary, Moderate Demand Skills:
    go — highest salary (~$115K) but lower demand (27 listings)
    snowflake, azure, aws — salaries over $108K with 30+ listings
    Cloud & Data Engineering Skills Are Valuable:
    snowflake, aws, azure, bigquery, redshift, hadoop are popular with salaries above $100K.

Other Technical Skills:
    java, oracle, spark, nosql, c++ — strong presence with salaries ranging between ~$98K to ~$107K.

BI & Analytics Tools:
    looker, qlik, tableau, ssrs show solid demand and competitive salaries (~$99K–$104K).

⭐ Main Findings
Python is the most in-demand skill, followed closely by Tableau and R.
Go developers are the best paid on average (~$115K), despite lower demand compared to Python.
Data engineering and cloud skills (Snowflake, AWS, BigQuery) command both good salaries and strong demand.
Business Intelligence (BI) tools like Looker, Tableau, and Qlik remain important and well-paid.
Traditional programming languages like Java and C++ still offer solid salaries, but with lower demand compared to newer tech skills.

*/