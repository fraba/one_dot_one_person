# Shapefiles

base_path_to_files <- 'http://www.istat.it/storage/cartografia/basi_territoriali/WGS_84_UTM/2011/'

setwd("/Users/francesco/Desktop/projects/istat_one_dot_one_person")

for (i in 1:20) {
  if (i %in% c(2, 10)) next
  print(i)
  path_to_file <- paste0(base_path_to_files, "R", sprintf("%02d", i), "_11_WGS84.zip")
  system(paste0("wget ", path_to_file, " -P /Users/francesco/Desktop/projects/istat_one_dot_one_person/istat_shapefile/") )
  Sys.sleep(10)
}

# Dati censimento 2011

path_to_files <- 
  c('http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Piemonte_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Valle_d_Aosta_Vallee_d_Aoste_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Lombardia_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Trentino_Alto_Adige_Sudtirol_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Veneto_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Friuli_Venezia_Giulia_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Liguria_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Emilia_Romagna_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Toscana_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Umbria_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Marche_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Lazio_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Abruzzo_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Molise_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Campania_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Puglia_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Basilicata_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Calabria_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Sicilia_SezioniCensimento.zip',
    'http://datiopen.istat.it/dat/dataset/partizioniterritorialisubcomunali/Sardegna_SezioniCensimento.zip')

for (path_to_file in  path_to_files) {
  # if (i %in% c(2, 10)) next
  print(path_to_file)
  system(paste0("wget ", path_to_file, " -P /Users/francesco/Desktop/projects/istat_one_dot_one_person/istat_census_data/") )
  Sys.sleep(10)
}

