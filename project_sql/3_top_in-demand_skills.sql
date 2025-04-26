/*
Question: What are the most in-demand skills for data analysts?

- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

-- This is Solution 1 for this question:
WITH remote_job_skills AS (
SELECT 
	skill_id, 
	COUNT(*) as skill_count
FROM 
	skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE 
	job_postings.job_work_from_home = TRUE
    AND job_postings.job_title_short = 'Data Analyst'
GROUP BY 
	skill_id
)

SELECT 
	skills.skill_id, 
	skills as skill_name, 
	skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
	skill_count DESC
LIMIT 5;


-- This is Solution 2 for this question:
SELECT
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
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
📋 Dataset Overview
Entries: 5
Columns: 2 (skills, demand_count)

Description:
This dataset shows the top 5 in-demand skills and how often they are required (based on demand_count).


🔑 Key Findings
SQL is the most in-demand skill with 7,291 mentions.
Excel and Python follow, with 4,611 and 4,330 mentions respectively.
Tableau and Power BI are also highly sought-after, particularly for data visualization and business intelligence roles.
*/

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]