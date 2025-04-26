/*
Question: What are the top-paying data analyst jobs, and what skills are required? 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_skills AS (
SELECT
    job_id,
    job_title,
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
LIMIT 10
)
SELECT
    *,
    skills AS job_skills_required
FROM
    top_paying_skills
INNER JOIN
    skills_job_dim ON top_paying_skills.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Dataset Summary:

Rows: 66

Columns: 11

The dataset links jobs, companies, salaries, and skills.

Some columns are duplicated (job_id and job_id (1), skill_id and skill_id (1)).

Key columns:

        job_title, company_name

        salary_year_avg (average yearly salary)

        skills (individual skill)

        type (e.g., programming, cloud)

        job_skills_required (required skills for the job)

Early Observations:

Each job appears multiple times, once per skill linked to that job.

Top-paying jobs in the dataset seem to have cloud and programming skills like Azure, Databricks, SQL, Python, and R.

Salaries are relatively high, with at least one example (Associate Director- Data Insights at AT&T) offering an average salary of $255,829.5.
*/

/*
[
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 5,
    "skill_id (1)": 5,
    "skills": "r",
    "type": "programming",
    "job_skills_required": "r"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 74,
    "skill_id (1)": 74,
    "skills": "azure",
    "type": "cloud",
    "job_skills_required": "azure"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 75,
    "skill_id (1)": 75,
    "skills": "databricks",
    "type": "cloud",
    "job_skills_required": "databricks"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 76,
    "skill_id (1)": 76,
    "skills": "aws",
    "type": "cloud",
    "job_skills_required": "aws"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 93,
    "skill_id (1)": 93,
    "skills": "pandas",
    "type": "libraries",
    "job_skills_required": "pandas"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 95,
    "skill_id (1)": 95,
    "skills": "pyspark",
    "type": "libraries",
    "job_skills_required": "pyspark"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 102,
    "skill_id (1)": 102,
    "skills": "jupyter",
    "type": "libraries",
    "job_skills_required": "jupyter"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 181,
    "skill_id (1)": 181,
    "skills": "excel",
    "type": "analyst_tools",
    "job_skills_required": "excel"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 183,
    "skill_id (1)": 183,
    "skills": "power bi",
    "type": "analyst_tools",
    "job_skills_required": "power bi"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "company_id": 5835,
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "job_id (1)": 552322,
    "skill_id": 196,
    "skill_id (1)": 196,
    "skills": "powerpoint",
    "type": "analyst_tools",
    "job_skills_required": "powerpoint"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_id": 183972,
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "job_id (1)": 99305,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_id": 183972,
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "job_id (1)": 99305,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_id": 183972,
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "job_id (1)": 99305,
    "skill_id": 5,
    "skill_id (1)": 5,
    "skills": "r",
    "type": "programming",
    "job_skills_required": "r"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_id": 183972,
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "job_id (1)": 99305,
    "skill_id": 97,
    "skill_id (1)": 97,
    "skills": "hadoop",
    "type": "libraries",
    "job_skills_required": "hadoop"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_id": 183972,
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "job_id (1)": 99305,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_id": 381287,
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "job_id (1)": 1021647,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_id": 381287,
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "job_id (1)": 1021647,
    "skill_id": 23,
    "skill_id (1)": 23,
    "skills": "crystal",
    "type": "programming",
    "job_skills_required": "crystal"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_id": 381287,
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "job_id (1)": 1021647,
    "skill_id": 79,
    "skill_id (1)": 79,
    "skills": "oracle",
    "type": "cloud",
    "job_skills_required": "oracle"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_id": 381287,
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "job_id (1)": 1021647,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_id": 381287,
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "job_id (1)": 1021647,
    "skill_id": 215,
    "skill_id (1)": 215,
    "skills": "flow",
    "type": "other",
    "job_skills_required": "flow"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 8,
    "skill_id (1)": 8,
    "skills": "go",
    "type": "programming",
    "job_skills_required": "go"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 80,
    "skill_id (1)": 80,
    "skills": "snowflake",
    "type": "cloud",
    "job_skills_required": "snowflake"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 93,
    "skill_id (1)": 93,
    "skills": "pandas",
    "type": "libraries",
    "job_skills_required": "pandas"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 94,
    "skill_id (1)": 94,
    "skills": "numpy",
    "type": "libraries",
    "job_skills_required": "numpy"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 181,
    "skill_id (1)": 181,
    "skills": "excel",
    "type": "analyst_tools",
    "job_skills_required": "excel"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_id": 19724,
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 168310,
    "skill_id": 220,
    "skill_id (1)": 220,
    "skills": "gitlab",
    "type": "other",
    "job_skills_required": "gitlab"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 74,
    "skill_id (1)": 74,
    "skills": "azure",
    "type": "cloud",
    "job_skills_required": "azure"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 76,
    "skill_id (1)": 76,
    "skills": "aws",
    "type": "cloud",
    "job_skills_required": "aws"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 79,
    "skill_id (1)": 79,
    "skills": "oracle",
    "type": "cloud",
    "job_skills_required": "oracle"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 80,
    "skill_id (1)": 80,
    "skills": "snowflake",
    "type": "cloud",
    "job_skills_required": "snowflake"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 183,
    "skill_id (1)": 183,
    "skills": "power bi",
    "type": "analyst_tools",
    "job_skills_required": "power bi"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 189,
    "skill_id (1)": 189,
    "skills": "sap",
    "type": "analyst_tools",
    "job_skills_required": "sap"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 211,
    "skill_id (1)": 211,
    "skills": "jenkins",
    "type": "other",
    "job_skills_required": "jenkins"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 218,
    "skill_id (1)": 218,
    "skills": "bitbucket",
    "type": "other",
    "job_skills_required": "bitbucket"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 219,
    "skill_id (1)": 219,
    "skills": "atlassian",
    "type": "other",
    "job_skills_required": "atlassian"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 233,
    "skill_id (1)": 233,
    "skills": "jira",
    "type": "async",
    "job_skills_required": "jira"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_id": 1261,
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "job_id (1)": 731368,
    "skill_id": 234,
    "skill_id (1)": 234,
    "skills": "confluence",
    "type": "async",
    "job_skills_required": "confluence"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 5,
    "skill_id (1)": 5,
    "skills": "r",
    "type": "programming",
    "job_skills_required": "r"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 210,
    "skill_id (1)": 210,
    "skills": "git",
    "type": "other",
    "job_skills_required": "git"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 218,
    "skill_id (1)": 218,
    "skills": "bitbucket",
    "type": "other",
    "job_skills_required": "bitbucket"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 219,
    "skill_id (1)": 219,
    "skills": "atlassian",
    "type": "other",
    "job_skills_required": "atlassian"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 233,
    "skill_id (1)": 233,
    "skills": "jira",
    "type": "async",
    "job_skills_required": "jira"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_id": 4707,
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "job_id (1)": 310660,
    "skill_id": 234,
    "skill_id (1)": 234,
    "skills": "confluence",
    "type": "async",
    "job_skills_required": "confluence"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 8,
    "skill_id (1)": 8,
    "skills": "go",
    "type": "programming",
    "job_skills_required": "go"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 80,
    "skill_id (1)": 80,
    "skills": "snowflake",
    "type": "cloud",
    "job_skills_required": "snowflake"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 93,
    "skill_id (1)": 93,
    "skills": "pandas",
    "type": "libraries",
    "job_skills_required": "pandas"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 94,
    "skill_id (1)": 94,
    "skills": "numpy",
    "type": "libraries",
    "job_skills_required": "numpy"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 181,
    "skill_id (1)": 181,
    "skills": "excel",
    "type": "analyst_tools",
    "job_skills_required": "excel"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 182,
    "skill_id (1)": 182,
    "skills": "tableau",
    "type": "analyst_tools",
    "job_skills_required": "tableau"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_id": 19724,
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "job_id (1)": 1749593,
    "skill_id": 220,
    "skill_id (1)": 220,
    "skills": "gitlab",
    "type": "other",
    "job_skills_required": "gitlab"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_id": 2686,
    "salary_year_avg": "184000.0",
    "company_name": "Get It Recruit - Information Technology",
    "job_id (1)": 387860,
    "skill_id": 0,
    "skill_id (1)": 0,
    "skills": "sql",
    "type": "programming",
    "job_skills_required": "sql"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_id": 2686,
    "salary_year_avg": "184000.0",
    "company_name": "Get It Recruit - Information Technology",
    "job_id (1)": 387860,
    "skill_id": 1,
    "skill_id (1)": 1,
    "skills": "python",
    "type": "programming",
    "job_skills_required": "python"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_id": 2686,
    "salary_year_avg": "184000.0",
    "company_name": "Get It Recruit - Information Technology",
    "job_id (1)": 387860,
    "skill_id": 5,
    "skill_id (1)": 5,
    "skills": "r",
    "type": "programming",
    "job_skills_required": "r"
  }
]
*/