library(DBI)
library(RPostgreSQL)
driver <- dbDriver('PostgreSQL')
DB <- dbConnect(
  driver, 
  dbname="portal_StatHub", 
  host="localhost",
  port=5432,
  user="postgres",
  password="1234567"
)

conn2 <- DBI::dbConnect(RPostgres::Postgres(),
                        dbname = "portal_StatHub",
                        host = "localhost", 
                        port = 5432, 
                        user = "postgres",
                        password = "1234567")

wilayah <- read.csv("https://raw.githubusercontent.com/rizkyardhani/kelompok2_mds/main/data/wilayah_StatHub.csv", sep = ";")
str(wilayah)
View(wilayah)

for (i in 1:nrow(wilayah)){
  query <- paste0("INSERT INTO wilayah (id_wilayah, nama_kabkota, nama_prov) VALUES(",
                  "'", wilayah[i, ]$id_wilayah, "', ",
                  "'", wilayah[i, ]$nama_kabkota, "', ",
                  "'", wilayah[i, ]$nama_prov, "');")
  query_execute <- DBI::dbGetQuery(conn = conn2, statement=query)
}


universitas <- read.csv("https://raw.githubusercontent.com/rizkyardhani/kelompok2_mds/main/data/universitas_StatHub.csv", sep = ";")
str(universitas)
View(universitas)

for (i in 1:nrow(universitas)) { 
  query <- paste0("INSERT INTO universitas (id_univ, id_wilayah, nama_univ, akred_univ) VALUES(",
                  "'", universitas[i, ]$id_univ, "', ",
                  "'", universitas[i, ]$id_wilayah, "', ",
                  "'", universitas[i, ]$nama_univ, "', ",
                  "'", universitas[i, ]$akred_univ, "');")
  query_execute <- DBI::dbGetQuery(conn = conn2, statement=query)
}

prodi <- read.csv("https://raw.githubusercontent.com/rizkyardhani/kelompok2_mds/main/data/Prodi.csv", sep = ";")
str(prodi)
View(prodi)

for (i in 1:nrow(prodi)){
  query <- paste0("INSERT INTO prodi (id_prodi, id_univ, nama_prodi, jumlah_dosen, jumlah_mahasiswa, akred_prodi, jenjang) VALUES(",
                  "'", prodi[i, ]$id_prodi , "', ",
                  "'", prodi[i, ]$id_univ, "', ",
                  "'", prodi[i, ]$nama_prodi, "', ",
                  "'", prodi[i, ]$jumlah_dosen, "', ",
                  "'", prodi[i, ]$jumlah_mahasiswa, "', ",
                  "'", prodi[i, ]$akred_prodi, "', ",
                  "'", prodi[i, ]$jenjang, "');")
  query_execute <- DBI::dbGetQuery(conn = conn2, statement=query)
}

jalur <- read.csv("https://raw.githubusercontent.com/rizkyardhani/kelompok2_mds/main/data/jalur_masuk._.csv", sep = ";")
str(jalur)
View(jalur)

for (i in 1:nrow(jalur)){
  query <- paste0("INSERT INTO jalur (id_prodi, id_univ, jalur_masuk, daya_tampung, website) VALUES(",
                  "'", jalur[i, ]$id_prodi , "', ",
                  "'", jalur[i, ]$id_univ, "', ",
                  "'", jalur[i, ]$jalur_masuk, "', ",
                  "'", jalur[i, ]$daya_tampung, "', ",
                  "'", jalur[i, ]$website, "');")
  query_execute <- DBI::dbGetQuery(conn = conn2, statement=query)
}