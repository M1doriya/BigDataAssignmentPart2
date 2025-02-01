/* @bruin
name: la_liga
type: duckdb.sql

description: This asset loads a CSV file into a DuckDB database.
columns:
  - name: Position
    type: integer
    description: ""
    
  - name: Team
    type: varchar
    description: ""
    
  - name: Played
    type: integer
    description: ""
    
  - name: Wins
    type: integer
    description: ""
    
  - name: Draws
    type: integer
    description: ""

  - name: Losses
    type: integer
    description: ""

  - name: Goals_For
    type: integer
    description: ""

  - name: Goals Against
    type: integer
    description: ""

  - name: Goal Difference
    type: integer
    description: ""

  - name: Points
    type: integer
    description: ""


#        - name: pattern
#        value: "^[A-Z][a-z]*$"
   
   @bruin */

DROP TABLE simplified_standings;
CREATE TABLE simplified_standings AS
SELECT 
    CAST(Position AS INTEGER) AS Position,
    CAST (Team AS varchar) AS Team,
    CAST(Played AS INTEGER) AS Played,
    CAST(Wins AS INTEGER) AS Wins,
    CAST(Draws AS INTEGER) AS Draws,
    CAST(Losses AS INTEGER) AS Losses,
    CAST(Points AS INTEGER) AS Points
FROM raw.la_liga;
COPY (SELECT * FROM simplified_standings) TO 'simplified_standings.csv' (HEADER, DELIMITER ',');


DROP TABLE goals_analysis;
CREATE TABLE goals_analysis AS
SELECT 
    CAST (Team AS varchar) AS Team,
    CAST(Goals_For AS INTEGER) AS Goals_For,
    CAST(Goals_Against AS INTEGER) AS Goals_Against,
    CAST(Goal_Difference AS INTEGER) AS Goal_Difference
FROM raw.la_liga;
COPY (SELECT * FROM goals_analysis) TO 'goals_analysis.csv' (HEADER, DELIMITER ',');


DROP TABLE performance_efficiency;
CREATE TABLE performance_efficiency AS
SELECT 
    CAST (Position AS INTEGER) AS Position,
    CAST (Team AS varchar) AS Team,
    CAST(Played AS INTEGER) AS Played,
    CAST(Wins AS INTEGER) AS Wins,
    CAST(Draws AS INTEGER) AS Draws,
    CAST(Losses AS INTEGER) AS Losses,
    CAST(Points AS INTEGER) AS Points,
    
    -- New calculated columns
    CAST(Goals_For AS FLOAT) / CAST(Played AS FLOAT) AS Goals_Per_Game,
    (CAST(Wins AS FLOAT) / CAST(Played AS FLOAT)) * 100 AS Win_Percentage

FROM raw.la_liga;
COPY (SELECT * FROM performance_efficiency) TO 'performance_efficiency.csv' (HEADER, DELIMITER ',');