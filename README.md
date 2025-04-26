# Introduction
Hey there! 👋
Welcome to my deep dive into the data analytics job market.
In this project, I break down the highest-paying roles, most in-demand skills, and where big salaries meet big opportunities — all through the lens of SQL-driven analysis.

💻 Check out all the queries and insights here: [project_sql](/project_sql/).

# Project Inspiration
Curious about where the real opportunities lie for data analysts, I launched this project to decode the market:
Which skills command the biggest paychecks? Which ones are truly in demand?
By answering these questions, I aimed to sharpen my own career strategy and help others navigate the data job landscape more effectively.

The dataset powering this exploration comes from Luke Barousse’s SQL course (link here).
It’s packed with information on job titles, salaries, skills, and locations — the perfect playground for SQL-driven analysis.

### 🔍 Key Questions Behind the Analysis
- Which data analyst roles offer the highest salaries?
- What technical skills are most common among top earners?
- Which skills are consistently in high demand?
- How do different skills impact salary outcomes?
- What skill set should a data analyst master to maximize career value?

# Tools Used in Project
To power this analysis, I worked with a solid set of tools, namely:
 - **SQL** — The backbone of the project, used to dig into the data, run complex queries, and surface actionable insights.

- **PostgreSQL** — My database of choice for managing, querying, and transforming the job market dataset with speed and reliability.

- **Visual Studio Code** — My go-to code editor for writing, tweaking, and executing SQL queries, all within a streamlined, developer-friendly environment.

# The Analysis
Each query in this project was designed to explore distinct facets of the data analyst job market. Here's an overview of how I tackled each research question.
### 1. Top Paying Data Analyst Jobs

To zoom in on the best-paying opportunities, I filtered data analyst roles based on average annual salary and remote work options.
By running targeted SQL queries, I surfaced the highest-value positions — giving a clear view of where the top earning potential lies in the data analytics space.

```sql
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
```

The **Main Findings** from this analysis:

- **Job Positions**: The data includes various full-time positions for data analysts, with titles such as "Data Analyst," "Director of Analytics," and "Principal Data Analyst."

 - **Locations** : All positions are remote or location-flexible, listed as "Anywhere."

 - **Companies**: The jobs are offered by a range of companies, including notable names like Mantys, Meta, AT&T, Pinterest, and SmartAsset.

- **Salaries**: Salaries for these roles range from $184,000 to $650,000 annually, with roles like "Data Analyst" at Mantys offering the highest average salary.

- **Job Posting Dates**: Positions were posted throughout 2023, with the earliest in January and the latest in December.


### 2. Skills Powering Top-Paying Roles
I cross-referenced job postings with skill datasets to pinpoint the technical expertise and competencies most associated with high-salary data analyst positions. This fusion of data reveals what skill sets employers prioritize for premium compensation.

```sql
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
```
The **Main Findings** from this analysis:
- 8 senior data analyst roles analyzed across top companies like AT&T, Pinterest, and UCLA.

- Salaries range from $184K to $256K, with the highest at AT&T.

- SQL, Python, and Tableau are the most in-demand skills.

- Cloud knowledge (AWS, Azure, Snowflake) and tools like Pandas, Git, and Jira are frequently required.

- Strong programming, cloud, and collaboration tool skills are key trends.

![Top paying job skills](assets\efac6b70-da36-4b12-a5f8-ef86e2b9baf7.png)
*This is a visual representation of key findings from analysing the top paying skills. Here we see: The top 10 most in-demand skills (top left), distribution of skill types (top right), Top 10 highest paying job titles (bottom left), and Companies offering the highest paying jobs (bottom right). ChatGPT generated this image from my SQL query results*

### 3. In-Demand Skills for Data Analysts
This analysis leveraged job posting data to surface the most commonly required skills, enabling a targeted focus on high-demand technical proficiencies.

```sql
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
```

The **Main Findings** from this analysis:
- SQL is the most in-demand skill with 7,291 mentions.
- Excel and Python follow, with 4,611 and 4,330 mentions respectively.
- Tableau and Power BI are also highly sought-after, particularly for data visualization and business intelligence roles.

![Top in-demand skills](assets\7e0e59e6-e0ab-48f1-af2d-21cff60ed8d6.png)
*Bar graph visualising the Top 5 in-demand skills within the Data Analytics field. ChatGPT generated this image from my SQL query results*

### 4. Skills Based on Salary
Analyzing salary trends across various skills highlighted the highest-paying competencies, providing insights into the market value of in-demand technical expertise.

```sql
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
```
The **Main Findings** from this analysis:
- **svn** commands the highest average salary at $400,000 — a massive outlier compared to all other skills.

- **Other Highly Paid Skills:**
solidity ($179,000), couchbase ($160,515), datarobot ($155,486), and golang ($155,000) round out the next highest salaries.

- **Strong AI/ML Representation:**
    AI/ML tools like mxnet, keras, pytorch, hugging face, and tensorflow offer salaries above $120,000.

- **DevOps and Cloud Tools Highly Rewarded:**
    Tools like terraform, vmware, puppet, ansible, and airflow also pay over $115,000.

- **Programming Languages Stay Strong:**
    Skills like golang, scala, perl, and solidity are valued at $115,000 - $155,000.

- **Salary Distribution:**
    Most skills offer salaries between $115,000 and $180,000.

- **svn** is an extreme outlier far above the main cluster.

### 5. Most Optimal Skills to Learn
By synthesizing demand and salary data, this analysis identifies the skills that offer the best balance of market demand and high earning potential, guiding strategic decisions for skill development.

```sql
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
```

The **Main Findings** from this analysis:

- Python is the most in-demand skill, followed closely by Tableau and R.
- Go developers are the best paid on average (~$115K), despite lower demand compared to Python.
- Data engineering and cloud skills (Snowflake, AWS, BigQuery) command both good salaries and strong demand.
- Business Intelligence (BI) tools like Looker, Tableau, and Qlik remain important and well-paid.
- Traditional programming languages like Java and C++ still offer solid salaries, but with lower demand compared to newer tech skills.

# What I Learned

Throughout this project, I refined several advanced SQL techniques and skills:

- **Advanced Query Development:** Mastered crafting complex SQL queries that integrate multiple tables and leverage functions like WITH clauses for creating temporary result sets.

- **Data Aggregation & Summarization:** Applied GROUP BY and aggregation functions like COUNT() and AVG() to efficiently summarize and extract key insights from large datasets.

- **Problem-Solving with SQL:** Enhanced my ability to translate business requirements into optimized SQL queries that deliver actionable, data-driven insights.

# Insights
**Key takeaways from the analysis include:**

- **Top-Paying Data Analyst Roles:** Remote-friendly data analyst positions offer a diverse salary range, with the highest reaching $650,000.

- **Skills for Premium Salaries:** High-paying data analyst roles emphasize advanced SQL proficiency, underscoring its importance in securing top-tier compensation.

- **Most In-Demand Skills:** SQL dominates as the most sought-after skill in the data analyst job market, making it essential for job seekers.

- **Specialized Skills & High Salaries:** Niche skills like SVN and Solidity command premium salaries, highlighting the value of specialized expertise.

- **Optimal Skills for Maximizing Market Value:** SQL remains the most in-demand skill, offering a competitive salary, making it a key focus for data analysts looking to maximize their marketability.

# Key Conclusions
This project significantly advanced my SQL expertise while delivering key insights into the data analyst job market. The findings act as a strategic guide for optimizing skill development and job search strategies. By focusing on high-demand, high-value skills, aspiring data analysts can better position themselves in a competitive landscape. This exploration underscores the critical need for ongoing learning and agility in adapting to evolving trends within the data analytics domain.