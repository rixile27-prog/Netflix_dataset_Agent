-- Databricks notebook source
Select * 
From netflix_.netflix_dataset.netflix_dataset_agent;
-------------------------------------------------
--cleaning the data
------------------------------------------------
-------------------------------------------------
-- View Original Data
-------------------------------------------------
SELECT *
FROM netflix_.netflix_dataset.netflix_dataset_agent;

-------------------------------------------------
-- Step 1: Remove Duplicates
-------------------------------------------------
CREATE OR REPLACE VIEW netflix_.netflix_dataset.netflix_no_duplicates AS
SELECT DISTINCT *
FROM netflix_.netflix_dataset.netflix_dataset_agent;

-------------------------------------------------
-- Step 2: Standardize & Clean Data
-------------------------------------------------
CREATE OR REPLACE VIEW netflix_.netflix_dataset.netflix_cleaned AS
SELECT
    TRIM(netflix_dataset) AS show_id,
    INITCAP(TRIM(_c1)) AS title,
    UPPER(TRIM(_c2)) AS type,          -- MOVIE / TV SHOW
    _c3 AS release_year,
    INITCAP(TRIM(_c4)) AS genre,
    INITCAP(TRIM(_c5)) AS country,
    ROUND(CAST(_c6 AS DOUBLE), 1) AS rating,
    CAST(_c7 AS INT) AS duration_min,
    ROUND(CAST(_c8 AS DOUBLE), 1) AS views_millions
FROM netflix_.netflix_dataset.netflix_no_duplicates
WHERE netflix_dataset != 'show_id';

-------------------------------------------------
-- Step 3: Validation Rules
-------------------------------------------------
CREATE OR REPLACE VIEW netflix_.netflix_dataset.netflix_validated AS
SELECT
    *,
    CASE
        WHEN type IN ('MOVIE', 'TV SHOW') THEN 1
        ELSE 0
    END AS type_valid,
    CASE
        WHEN rating BETWEEN 0 AND 10 THEN 1
        ELSE 0
    END AS rating_valid,
    CASE
        WHEN duration_min > 0 THEN 1
        ELSE 0
    END AS duration_valid,
    CASE
        WHEN views_millions >= 0 THEN 1
        ELSE 0
    END AS views_valid
FROM netflix_.netflix_dataset.netflix_cleaned;

-------------------------------------------------
-- Step 4: Valid Records
-------------------------------------------------
CREATE OR REPLACE TABLE netflix_.netflix_dataset.netflix_valid AS
SELECT *
FROM netflix_.netflix_dataset.netflix_validated
WHERE type_valid = 1
  AND rating_valid = 1
  AND duration_valid = 1
  AND views_valid = 1;

-------------------------------------------------
-- Step 5: Invalid Records
-------------------------------------------------
CREATE OR REPLACE TABLE netflix_.netflix_dataset.netflix_invalid AS
SELECT *
FROM netflix_.netflix_dataset.netflix_validated
WHERE type_valid = 0
   OR rating_valid = 0
   OR duration_valid = 0
   OR views_valid = 0;

-------------------------------------------------
-- Step 6: Profiling Summary
-------------------------------------------------
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN type_valid = 0 THEN 1 ELSE 0 END) AS invalid_type,
    SUM(CASE WHEN rating_valid = 0 THEN 1 ELSE 0 END) AS invalid_rating,
    SUM(CASE WHEN duration_valid = 0 THEN 1 ELSE 0 END) AS invalid_duration,
    SUM(CASE WHEN views_valid = 0 THEN 1 ELSE 0 END) AS invalid_views
FROM netflix_.netflix_dataset.netflix_validated;