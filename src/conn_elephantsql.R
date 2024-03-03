library(RPostgreSQL)
library(DBI)
driver <- dbDriver('PostgreSQL')
DB <- dbConnect(
  driver,
  dbname="dsdvkktq", # User & Default database
  host="topsy.db.elephantsql.com", # Server
  # port=5433,
  user="dsdvkktq", # User & Default database
  password="RZV_utpFs11bBSbA7J2q8JU5-SbcpSFi" # Password
)
dbhost <- dbConnect(
  driver, 
  dbname="portal_StatHub", 
  host="localhost",
  port=5432,
  user="postgres",
  password="1234567"
)

# select departemen dari table departemen
wilayah =dbReadTable(dbhost,'wilayah')
universitas=dbReadTable(dbhost,'universitas')
prodi=dbReadTable(dbhost,'prodi')
jalur=dbReadTable(dbhost,'jalur')
dbWriteTable(DB,'wilayah',wilayah,overwrite=T,row.names=F)
dbWriteTable(DB,'universitas',universitas,overwrite=T,row.names=F)
dbWriteTable(DB,'prodi',prodi,overwrite=T,row.names=F)
dbWriteTable(DB,'jalur',jalur,overwrite=T,row.names=F)
