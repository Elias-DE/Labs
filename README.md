# TMDB Movie Data Analysis with Pandas and APIs #
This project implements a movie data analysis pipeline using Pandas. It fetches movie data from The Movie Database (TMDB) API, performs data cleaning and transformation, and conducts various analyses to extract meaningful insights about movies.

### Project Overview
The application analyzes movie data from TMDB to identify trends, compare performance metrics, and visualize key findings. It demonstrates real-world data engineering techniques for handling semi-structured data and implementing analytical workflows.

### How It Works
The project follows a multi-phase approach to analyze movie data:

1. Data Extraction  
Movie data from the TMDB API is fetched for a list of movie IDs. API rate limiting and error conditions are handled to ensure robust data collection.

2. Data Cleaning & Preprocessing
Raw API data is processed to extract useful information from complex JSON structures and handle missing/incorrect values:

- Extracting collection names from belongs_to_collection
- Processing lists of genres, countries, companies, and languages
- Converting currency values to millions USD
- Handling missing and invalid data points
- Standardizing data types

4. Visualization  
The analysis results are visualized using Matplotlib to identify trends and patterns:
- Revenue vs. Budget: Scatter plot showing the relationship between production budget and box office revenue  
- ROI by Genre: Bar chart showing average return on investment across different genres  
- Popularity vs. Rating: Scatter plot correlating movie popularity with critical ratings  
- Yearly Trends: Line chart tracking budget and revenue changes over time  
- Franchise Comparison: Bar chart comparing franchise performance against standalone films

### Acknowledgments  
Data provided by The Movie Database (TMDB)  
This project is for educational purposes, and is not affiliated with TMDB.
