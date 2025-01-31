# Olympic History Data Analysis

## Introduction

The Olympic Games, a prestigious global sporting event, have been held since 1896, bringing together nations in a showcase of athletic excellence. Over the years, participation has expanded across numerous sports in both Summer and Winter editions. This project aims to analyze historical Olympic trends, athlete performances, and country-wise medal distributions using structured data analysis.

## Data Processing

To ensure data accuracy and consistency, the following preprocessing steps were performed:

1. **Data Cleaning in Excel:**
   - Removed duplicate records.
   - Handled null and missing values.
   - Standardized formats for uniformity.
2. **Database Conversion:**
   - The cleaned data was imported into an SQL database.
   - Integer columns containing blank values were stored as `VARCHAR`.
   - When performing calculations, necessary `VARCHAR` columns were converted to `INTEGER`.

## SQL Queries and Insights

The following SQL queries were executed to derive key insights from the Olympic history dataset:

1. **Number of Olympic Games Held** - Total count of all Olympic Games to date.
2. **List of All Olympic Games** - A chronological list of events held so far.
3. **Total Participating Nations per Olympics** - Count of nations for each Olympic edition.
4. **Year with Highest and Lowest Participation** - Identifying peak and least represented years.
5. **Countries Participating in All Olympic Games** - Finding nations with consistent attendance.
6. **Sport Played in All Summer Olympics** - Identifying sports that have remained a staple.
7. **Sports Played Only Once** - Listing rare, one-time Olympic sports.
8. **Total Sports Played per Olympics** - Breakdown of different sports per edition.
9. **Oldest Gold Medalist Details** - Finding the oldest athlete to win a gold medal.
10. **Male-Female Athlete Participation Ratio** - Gender-wise distribution of athletes.
11. **Top 5 Athletes with Most Gold Medals** - Ranking by gold medal count.
12. **Top 5 Athletes with Most Medals (All Types)** - Counting total medals (gold, silver, bronze).
13. **Top 5 Most Successful Countries** - Based on overall medal tally.
14. **Total Gold, Silver, Bronze Medals by Country** - Summarizing medal wins by nation.
15. **Total Medals per Country by Olympic Games** - A per-edition breakdown of medal distribution.
16. **Countries with Most Gold, Silver, Bronze Medals per Olympics** - Identifying top-performing nations.
17. **Countries Winning the Most Medals in Each Olympics** - Overall top medal winners per edition.
18. **Countries with Silver/Bronze Medals but No Gold** - Listing nations that have never won gold.
19. **India’s Highest Medal-Winning Sport/Event** - Finding India's best-performing discipline.
20. **India’s Hockey Medal Breakdown** - Listing all Olympic Games where India won hockey medals.



## Conclusion

This project provides a comprehensive, data-driven look at Olympic history, identifying key patterns in athlete and country performances. The structured analysis allows for deeper exploration of trends and medal distributions over the years.

