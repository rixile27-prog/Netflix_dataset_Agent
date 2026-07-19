# Netflix_dataset_agent 
This project analyses Netflix titles acrosss movies and TV shows, focusing on atrributes such as release year, genre, country of origin origin, rating, duration, and viewership.
The dataset provides a snapshot of global content trends and audience engagement on the platform.

🎯 PROJECT OBJECTIVES
* Clean and validate the Netflix dataset for reliable analysis.
* Explore relationships between ratings, genres, and viewership.
* Identify country‑level trends in content production and popularity.
* Build a foundation for visualization dashboards and predictive modeling.
  
🛠 TOOLS USED TO CLEAN THAT DATA
* SQL (Databricks / Spark SQL) for cleaning, validation, and profiling.
* SQL functions for trimming, rounding, deduplication, and validation checks.
* Delta/Parquet storage for efficient querying and reproducibility.
  
🔄 PROCESS
1. Data Ingestion: Imported raw Excel/CSV into Databricks SQL.
2. Standardization: Normalized column names, trimmed spaces, and formatted categorical values (e.g., type, genre, country).
3. Numeric Cleaning: Rounded ratings and views to fix floating precision issues.
4. Deduplication: Removed duplicate entries.
5. Validation: Applied rules to ensure ratings fall between 0–10, durations are positive, and views are non‑negative.
6. Profiling: Generated summary statistics for ratings, genres, and country distributions.

📊 KEY FINDINGS/Overview 
* Some ratings contained floating precision errors (e.g., 8.1999999999) that required rounding.
* A few records had unrealistic values (e.g., negative or zero durations).
* * Genre distribution showed strong representation in Drama, Romance, and Documentary categories.
* Countries like USA, UK, Japan, and South Korea dominate Netflix’s catalog in this dataset.
💡 INSIGHTS
* Higher ratings are often associated with Thriller, Sci‑Fi, and Comedy genres.
* Viewership tends to be concentrated in titles from the USA and UK, but South Korea and Japan show strong engagement in specific genres.
* Documentaries and Romance titles show mixed ratings but steady audience interest.
🤝 ENGAGEMENT
This dataset is useful for:
* Content strategists analyzing global viewing trends.
* Data scientists building recommendation models.
* Students and researchers studying cultural patterns in streaming media.
📈 ANALYTICAL TAKEAWAYS
* Cleaning categorical and numeric fields is essential for meaningful insights.
* Profiling by genre and country reveals clear audience preferences.
* Splitting valid vs. invalid data ensures transparency and reproducibility in analysis.
