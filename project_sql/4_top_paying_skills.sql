/*
Question: What are the top skills based on salary? 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills_dim.skills,
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
    -- AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
ORDER BY
    salary_avg DESC
LIMIT 25;


/*
Top Paying Skill:
    svn commands the highest average salary at $400,000 — a massive outlier compared to all other skills.

Other Highly Paid Skills:
solidity ($179,000), couchbase ($160,515), datarobot ($155,486), and golang ($155,000) round out the next highest salaries.

Strong AI/ML Representation:
    AI/ML tools like mxnet, keras, pytorch, hugging face, and tensorflow offer salaries above $120,000.

DevOps and Cloud Tools Highly Rewarded:
    Tools like terraform, vmware, puppet, ansible, and airflow also pay over $115,000.

Programming Languages Stay Strong:
    Skills like golang, scala, perl, and solidity are valued at $115,000 - $155,000.

Salary Distribution:
    Most skills offer salaries between $115,000 and $180,000.

svn is an extreme outlier far above the main cluster.

Career Advice:
    Specializing in AI/ML frameworks and DevOps/cloud infrastructure skills offers the highest salary potential.
    Emerging technologies like blockchain development (e.g., solidity) are also extremely lucrative.
*/

[
  {
    "skills": "svn",
    "salary_avg": "400000"
  },
  {
    "skills": "solidity",
    "salary_avg": "179000"
  },
  {
    "skills": "couchbase",
    "salary_avg": "160515"
  },
  {
    "skills": "datarobot",
    "salary_avg": "155486"
  },
  {
    "skills": "golang",
    "salary_avg": "155000"
  },
  {
    "skills": "mxnet",
    "salary_avg": "149000"
  },
  {
    "skills": "dplyr",
    "salary_avg": "147633"
  },
  {
    "skills": "vmware",
    "salary_avg": "147500"
  },
  {
    "skills": "terraform",
    "salary_avg": "146734"
  },
  {
    "skills": "twilio",
    "salary_avg": "138500"
  },
  {
    "skills": "gitlab",
    "salary_avg": "134126"
  },
  {
    "skills": "kafka",
    "salary_avg": "129999"
  },
  {
    "skills": "puppet",
    "salary_avg": "129820"
  },
  {
    "skills": "keras",
    "salary_avg": "127013"
  },
  {
    "skills": "pytorch",
    "salary_avg": "125226"
  },
  {
    "skills": "perl",
    "salary_avg": "124686"
  },
  {
    "skills": "ansible",
    "salary_avg": "124370"
  },
  {
    "skills": "hugging face",
    "salary_avg": "123950"
  },
  {
    "skills": "tensorflow",
    "salary_avg": "120647"
  },
  {
    "skills": "cassandra",
    "salary_avg": "118407"
  },
  {
    "skills": "notion",
    "salary_avg": "118092"
  },
  {
    "skills": "atlassian",
    "salary_avg": "117966"
  },
  {
    "skills": "bitbucket",
    "salary_avg": "116712"
  },
  {
    "skills": "airflow",
    "salary_avg": "116387"
  },
  {
    "skills": "scala",
    "salary_avg": "115480"
  }
]