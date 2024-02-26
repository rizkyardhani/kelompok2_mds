#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)

#=========================== Interface (Front-End) ============================#

fluidPage(
  dashboardPage(
    #--------------HEADER-----------------#
    header = dashboardHeader(
      titleWidth = 300  # Menyesuaikan lebar judul
    ),
    #------------SIDEBAR-----------------#
    sidebar = dashboardSidebar(
      collapsed = TRUE,
      sidebarMenu(
        menuItem(
          text = "Beranda",
          tabName = "beranda",
          icon = icon("house")
        ),
        menuItem(
          text = "Cari Universitas",
          tabName = "univ",
          icon = icon("file")
        )
      ),
      style = "background-color: #ADD8E6;"  # Warna latar belakang sidebar
    ),
    #-----------------BODY-----------------#
    body = dashboardBody(
      tags$style(HTML("
        beranda .jumbotron {
          background-color: #001F3F;  # Warna latar belakang jumbotron
          color: blue;  # Warna teks
        }
        beranda h2, #beranda h3, #beranda h1 {
          color: #FF0000;  # Warna teks header
        }
        beranda p {
          color: black;  # Warna teks paragraf
        }
        beranda a {
          color: #337AB7;  # Warna teks tautan
        }
        beranda a:hover {
          color: #23527C;  # Warna teks tautan saat dihover
        }
      ")),
      tabItems(
        #-------------------------Tab Beranda-------------------------#
        tabItem(
          tabName = "beranda",
          jumbotron(
            title = span(
              img(src = "logomds.png", height = 50, width = 50),
              "StatHub: Portal Informasi Jurusan Statistika",
              style = "font-size:46px;font-weight:bold;"
            ),
            lead = span("Selamat Datang di StatHub!",style = "font-size:20px;font-weight:bold;"
            ), 
            span("Stathub adalah portal info jurusan statistika perguruan tinggi negeri terlengkap di Indonesia.
                 Seperti yang kita ketahui bersama, perguruan tinggi memiliki banyak jenis, mulai dari Universitas, Institut, Sekolah Tinggi. 
                 Banyaknya jenis perguruan tinggi ini memberikan banyak pilihan bagi siswa untuk melanjutkan pendidikan ke jenjang Sarjana(S1). 
                 Selain itu terdapat info jenjang bagi freshgraduate untuk melanjutkan ke jenjang Master(S2) dan Doktor(S3). 
                 StatHub hadir untuk membantu kamu untuk menemukan pilihan kampus yang terbaik. 
                 Tersedia 30 info jurusan statistika di beberapa perguruan tinggi yang tersebar di 34 provinsi dari seluruh Indonesia mulai dari Aceh hingga Papua. Kamu bisa lakukan dengan mudah dengan fitur lokasi kampus.",
            style = "font-size:20px;text-align:justify;"),
             status = "info",
            href = "https://pddikti.kemdikbud.go.id/"
          ),
          tags$h2("Panduan"),
          tags$p("Arahkan kursor ke sisi kiri layar atau klik ikon garis tiga pada sisi pojok kanan atas untuk mengakses bilah sisi (side bar). 
           Fitur utama pada StatHub adalah sebagai berikut :"),
          tags$ol(
            tags$li("Cari Universitas"),
            tags$p("Pencarian Universitas berdasarkan Provinsi. Lengkapi kriteria penyaringan agar didapatkan Universitas yang kamu inginkan."),
            tags$br(),
          ),
          tags$h2("Info Pengembang Situs"),
          tags$p("Situs ini merupakan projek praktikum kelompok mata kuliah Manajemen Data Statistika (STA1582) dari Program Statistika dan Sains Data Pascasarjana IPB University."),
          tags$ul(
            tags$li("Windy Ayu Pratiwi sebagai Database Manager"),
            tags$li("Devi Permata Sari sebagai Back-end Shiny Developer"),
            tags$li("Rizky Ardhani sebagai Front-end Shiny Developer"),
            tags$li("Tukhfatur Rizmah A. sebagai Technical Writer")
          ),
          tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
          tags$a(href="https://github.com/rizkyardhani/kelompok2_mds", "link github")
        ),
        #--------------------------Tab Univ--------------------------#
        tabItem(
          tabName = "univ",
          fluidRow(
            tags$h1("Pencarian Universitas berdasarkan Provinsi")
          ),
          fluidRow(
            # Filter provinsi
            box(
              tags$h3("Filter Provinsi"),
              tags$p("Pilih provinsi yang ingin ditampilkan"),
              tags$br(),
              uiOutput("filter_1"),
              width = 4
            ),
          ),
          fluidRow(
            # Display tabel 
            box(
              tags$h3("Tabel"),
              dataTableOutput("out_tbl1"),
              width = 12
            )
          )
        )
      )
    ),
    #-----------------FOOTER-----------------#
    footer = dashboardFooter(
      left = "by Kelompok 2",
      right = "Bogor, 2024",
      
    )
  )
)
