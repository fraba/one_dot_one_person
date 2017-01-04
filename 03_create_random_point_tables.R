library(DBI)
library(RPostgreSQL)

conn <- dbConnect(
  drv = PostgreSQL(),
  dbname = "istat_sez2011",
  host = "localhost",
  port = "5432",
  user = "francesco",
  password = "")

# dbGetQuery(conn, 'SELECT SUM("P1") AS tot FROM sez2011.census_data;')

# Resident population - tot
dbExecute(conn, 
          'CREATE TABLE sez2011.p1_point AS
            SELECT ST_GeneratePoints(geom, "P1") AS random_point
            FROM sez2011.census_poly JOIN sez2011.census_data 
            ON census_poly.SEZ2011 = census_data."SEZ2011" WHERE "P1" > 0;')

# Resident population - over 74
dbExecute(conn, 
          'CREATE TABLE sez2011.p29_point AS
          SELECT ST_GeneratePoints(geom, "P29") AS random_point
          FROM sez2011.census_poly JOIN sez2011.census_data 
          ON census_poly.SEZ2011 = census_data."SEZ2011" WHERE "P29" > 0;')

# Resident population - foreigner
dbExecute(conn, 
          'CREATE TABLE sez2011.st1_point AS
          SELECT ST_GeneratePoints(geom, "ST1") AS random_point
          FROM sez2011.census_poly JOIN sez2011.census_data 
          ON census_poly.SEZ2011 = census_data."SEZ2011" WHERE "ST1" > 0;')

# Resident population - foreigner (male)
dbExecute(conn, 
          'CREATE TABLE sez2011.st2_point AS
          SELECT ST_GeneratePoints(geom, "ST2") AS random_point
          FROM sez2011.census_poly JOIN sez2011.census_data 
          ON census_poly.SEZ2011 = census_data."SEZ2011" WHERE "ST2" > 0;')

# Resident population - foreigner (female)
dbExecute(conn, 
          'CREATE TABLE sez2011.st1_less_st2_point AS
          SELECT ST_GeneratePoints(geom, ("ST1" - "ST2")) AS random_point
          FROM sez2011.census_poly JOIN sez2011.census_data 
          ON census_poly.SEZ2011 = census_data."SEZ2011" WHERE ("ST1" - "ST2") > 0;')

dbExecute(conn, 'CREATE DATABASE postgis_testing;')

res <- dbGetQuery(conn, 'SELECT ST_NumGeometries(random_point) FROM sez2011.p1_point;')
sum(res$st_numgeometries)

dbDisconnect(conn)

