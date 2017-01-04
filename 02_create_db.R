library(DBI)
library(RPostgreSQL)

conn <- dbConnect(
  drv = PostgreSQL(),
  dbname = "francesco",
  host = "localhost",
  port = "5432",
  user = "francesco",
  password = "")

dbExecute(conn, 'CREATE DATABASE istat_sez2011;')
dbDisconnect(conn)

conn <- dbConnect(
  drv = PostgreSQL(),
  dbname = "istat_sez2011",
  host = "localhost",
  port = "5432",
  user = "francesco",
  password = "")

dbExecute(conn, 'CREATE EXTENSION postgis;')
res <-  dbGetQuery(conn, 'SELECT postgis_full_version();')

dbExecute(conn, 'CREATE SCHEMA sez2011;')

# Load/prepare/write census data
setwd('/Users/francesco/Desktop/projects/istat_one_dot_one_person/istat_census_data')
path_to_files <- list.files(path = ".", full.names = TRUE)

census_data <- data.frame()

for(path_to_file in path_to_files) {
  extracted_files <- unzip(path_to_file)
  require(readr)
  tmp_data <- read_delim(extracted_files[grepl('indicatori', extracted_files)], 
                         ";", escape_double = FALSE, trim_ws = TRUE, 
                         locale = locale(encoding = "latin1"))
  unlink(extracted_files)
  census_data <- rbind(census_data, tmp_data)
  rm(tmp_data)
}

dbWriteTable(conn, c("sez2011", "census_data"), value = census_data)
  
# Load/prepare/write census shapefiles
library(sp)
library(rgdal)
library(stringr)
setwd('/Users/francesco/Desktop/projects/istat_one_dot_one_person/istat_shapefile')
path_to_files <- list.files(path = ".", full.names = TRUE)

# Create table
dbExecute(conn, 
"CREATE TABLE sez2011.census_poly (
      gid SERIAL NOT NULL,  
      COD_REG smallint,
      COD_ISTAT integer,
      PRO_COM integer,
      SEZ2011 bigint,
      SEZ integer,
      COD_STAGNO integer,
      COD_FIUME integer,
      COD_LAGO integer,
      COD_LAGUNA integer,
      COD_VAL_P integer,
      COD_ZONA_C integer,
      COD_IS_AMM integer,
      COD_IS_LAC integer,
      COD_IS_MAR integer,
      COD_AREA_S integer,
      COD_MONT_D integer,
      LOC2011 bigint,
      COD_LOC integer,
      TIPO_LOC integer,
      COM_ASC integer,
      COD_ASC varchar(10),
      ACE smallint,
      geom geometry(MULTIPOLYGON, 32632),
      CONSTRAINT pk_census_poly PRIMARY KEY (gid)
      );
CREATE INDEX idx_census_poly ON sez2011.census_poly USING gist(geom);
")

library(rpostgis)
for(path_to_file in path_to_files) {
  print(path_to_file)
  extracted_files <- unzip(path_to_file)
  tmp_sp <- readOGR(dsn = str_extract(extracted_files[1], "^\\./R\\d{2}_11_WGS84"),
                    layer = str_extract(extracted_files[1], "R\\d{2}_11_WGS84"))
  tmp_sp$Shape_Leng <- NULL
  tmp_sp$Shape_Area <- NULL
  unlink(gsub("./|.zip", "", path_to_file), recursive=TRUE)
  pgInsert(conn, name=c("sez2011","census_poly"), data.obj=tmp_sp, geom = "geom", new.id = NULL)
  rm(tmp_sp)
}
  
  
  
  