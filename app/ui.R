# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)
library(plotly)
library(tidyverse)
library(rvest)
library(shinythemes)


#==========================USER INTERFACE (FRONT-END)===============================#

fluidPage(
  dashboardPage(
  #---------------------------PART HEADER----------------------------------#
  dashboardHeader(
    title = div(
      img(src = "logo5.png", height = 60, width = 60),
  
      style = "font-size:25px; color:#000000; font-weight:bold; text-align:center;"
    ),
    
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Admin",
                   message = "Halo, Selamat datang di StatHub!",
                   icon = icon("info")
                 ),
                 messageItem(
                   from = "Sistem",
                   message = "Jangan lupa senyum hari ini sobat!",
                   icon = icon("exclamation-triangle", type = "fas")
      )
    )
  ),
  
  
  #-----------------------------PART SIDEBAR--------------------------------#
  
  sidebar = dashboardSidebar(
    collapsed = FALSE,
    width = 200 ,
    style = "background-color: #C1E3FC; font-size:15px; font-weight:bold; padding: 10px; border-radius: 8px;",
    sidebarMenu(
      menuItem(
        text = "Beranda",
        tabName = "beranda",
        icon = icon("home")
      ),
      
      menuItem(
        text = "Cari Provinsi",
        tabName = "prov",
        icon = icon("globe")
      ),
      
      menuItem(
        text = "Cari Universitas",
        tabName = "univ",
        icon = icon("search-location")
      ),
      
      menuItem(
        text = "Yuk Daftar Kuliah",
        tabName = "daftar",
        icon = icon("trophy")
      ),
      
      menuItem(
        text = "Galeri Univ",
        tabName = "galeri",
        icon = icon("camera")
      ),
      
      menuItem(
        text = "Info",
        tabName = "info",
        icon = icon("info-circle")
      )
    )
  ),


  
  #------------------------- PART BODY----------------------------------------#
    body = dashboardBody(
      tabItems(
        #-------------------------Tab Beranda-------------------------#
        tabItem(
          tabName = "beranda",
          jumbotron(
              img(src = "logo5.png", height = 300, width = 300),
              "StatHub: Portal Informasi Jurusan Statistika di Indonesia",
                style = "font-size:50px;color: #FFFFFF;font-weight:bold;display: flex;align-items: center;",
                tags$p("Halo, Selamat Datang di StatHub!",  style = "font-size:30px;color: #FFEA00;"), 
                 tags$br(),
                href = "https://pddikti.kemdikbud.go.id/",
                status="primary"
          ),
          
          fluidRow(
          box(title = "Apa itu StatHub?",solidHeader = TRUE,status="maroon",
          tags$p("Stathub adalah portal info jurusan statistika perguruan tinggi negeri terlengkap di Indonesia.
                 Seperti yang kita ketahui bersama, perguruan tinggi memiliki banyak jenis, mulai dari Universitas, Institut, Sekolah Tinggi. 
                 Banyaknya jenis perguruan tinggi ini memberikan banyak pilihan bagi siswa untuk melanjutkan pendidikan ke jenjang Sarjana(S1). 
                 Selain itu terdapat info jenjang bagi freshgraduate untuk melanjutkan ke jenjang Master(S2) dan Doktor(S3). 
                 StatHub hadir untuk membantu kamu untuk menemukan pilihan kampus yang terbaik. 
                 Tersedia 30 info jurusan statistika di beberapa perguruan tinggi yang tersebar di 34 provinsi dari seluruh Indonesia mulai dari Aceh hingga Papua. Kamu bisa lakukan dengan mudah dengan fitur lokasi kampus.",
          style = "background-color: #C1E3FC;color: black;font-size:15px;display: flex;align-items: center;text-align: justify; padding: 10px; border-radius: 5px;"), width = 6, collapsible = TRUE,
          collapsed = TRUE 
          ),
          
          box(title = "Bagaimana cara penggunaannya?",solidHeader = TRUE,status="maroon",
              tags$p("Pada Navigasi Bar, klik Cari Provinsi dan input Provinsi yang diinginkan. Kemudian, akan muncul detail informasi Universitas yang
                     mempunyai jurusan statistika di Provinsi tersebut. Pada Bar Cari Universitas input universitas (dapat lebih dari 1) dan input jenjang
                     kemudian akan muncul detail informasi universitas berdasarkan jenjang. Pada Bar Yuk Daftar Kuliah input universitas (dapat lebih dari 1) dan 
                     input jalur kemudian akan muncul detail informasi universitas berdasarkan jalur masuk. Pada Bar Gallery berisi foto foto universitas program
                     studi Statistik di Indonesia, Terakhir Bar Info berisi informasi terkait dengan pengembangan website",
                     style = "background-color: #C1E3FC;color: black;font-size:15px;display: flex;align-items: center;text-align: justify; padding: 10px; border-radius: 5px;"), width = 6, collapsible = TRUE,
              collapsed = TRUE 
          ),
       ),
          
          box(title = "Did You Know?",solidHeader = TRUE,status="primary", width=12,div(
            img(src = "Peta.png", height = 400, width = 1000), style = "display: flex; justify-content: center; align-items: center;"),
            tags$br(),
            tags$p("Selamat datang di StatHub: Portal Informasi Jurusan Statistika! Tempat Anda dapat menjelajahi berbagai program studi Statistika yang tersedia di berbagai pulau di Indonesia. Dari Sumatra hingga Papua nih! Mari kita jelajahi!",
                   style = "color: black;font-size:18px;align-items: center;text-align: justify; padding: 10px; border-radius: 5px;"),
            tags$ul(
              tags$li("Pulau Jawa:"),
                tags$p("Pulau Jawa merupakan pusat pendidikan tinggi di Indonesia, dan berbagai perguruan tinggi ternama 
                menawarkan program studi Statistika. Institut Pertanian Bogor, Institut Teknologi Sepuluh November, Universitas Brawijaya,
                dan Universitas Padjajaran adalah beberapa institusi yang menawarkan program sarjana dan pascasarjana dalam bidang Statistika. 
                Program-program ini mencakup pengajaran teori statistika, pemodelan data, dan aplikasi dalam berbagai industri."),
              
              tags$li("Pulau Sumatra"),
                tags$p("Di Pulau Sumatra, Universitas Sumatera Utara (USU) dan Universitas Negeri Padang (UNP) merupakan institusi 
                yang menawarkan program studi Statistika. Program-program ini memberikan landasan kuat dalam statistika matematika dan aplikasi statistika 
                dalam konteks regional, seperti analisis data ekonomi dan sosial."),
              
              tags$li("Pulau Kalimantan:"),
                tags$p("Meskipun lebih terkenal dengan kekayaan alamnya, Pulau Kalimantan juga memiliki beberapa universitas yang menawarkan 
                program studi Statistika. Salah satunya adalah Universitas Tanjungpura di Pontianak. Program studi ini fokus pada aplikasi statistika 
                dalam pengelolaan sumber daya alam dan masalah lingkungan yang relevan dengan wilayah Kalimantan."),
              
              tags$li("Pulau Sulawesi:"),
                tags$p("Universitas Hasanuddin di Makassar adalah salah satu institusi di Pulau Sulawesi yang menawarkan program studi Statistika. 
                Program ini mengintegrasikan konsep statistika dengan penelitian tentang ekologi, pertanian, dan sumber daya alam, yang merupakan bagian 
                integral dari kekayaan Sulawesi."),
            
              tags$li("Pulau Papua:"),
                tags$p("Pulau Papua, dengan keanekaragaman budaya dan lingkungan alamnya, juga memiliki beberapa institusi pendidikan yang menawarkan 
                program studi Statistika. Universitas Cenderawasih di Jayapura adalah salah satu universitas di wilayah ini yang menawarkan program tersebut. 
                Program ini menekankan pada analisis data geospasial, biodiversitas, dan masalah sosial yang unik bagi wilayah Papua."),
              style = "color: black;font-size:18px;align-items: center;text-align: justify; padding: 10px; border-radius: 5px;")
          ),
        ),
        
        
        #--------------------------Tab Provinsi--------------------------#
        tabItem(
          tabName = "prov",
          fluidRow(
            tags$h1("Pencarian Universitas berdasarkan Provinsi", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
        
          box(
            title = "Cari Universitas berdasarkan Provinsi yang Kamu pilih",solidHeader = TRUE,status="primary",
            uiOutput("filter_1"),
            width = 10
          ),
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl1"),
               width = 10
          )
        ),
        #------------------------Tab Universitas---------------------------#
        tabItem(
          tabName = "univ",
          fluidRow(
            tags$h1("Detail Prodi Berdasarkan Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
            tags$br(),
          
          fluidRow(
          box(
            title = "Pilih Universitas",solidHeader = TRUE,status="primary",
            uiOutput("filter_2"),
            width = 6
          ),
          box(
            title = "Pilih Jenjang",solidHeader = TRUE,status="primary",
            uiOutput("filter_3"),
            width = 6
             ),
         ),
        
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl2"),
               width = 12
          ),
          fluidRow(
          box( title = "Barchart Jumlah Mahasiswa",solidHeader = TRUE,status="primary",
               
               plotlyOutput("bar_chart1"),
               width = 6
          ),
          box( title = "Barchart Jumlah Dosen",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart2"),
                 width = 6
            ),
          )
        ),
        
        #-------------------------------Tab Daftar--------------------------------#
        tabItem(
          tabName = "daftar",
          fluidRow(
            tags$h1("Jalur Pendaftaran Tiap Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          fluidRow(
            box(
              title = "Pilih Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_4"),
              width = 6
            ),
            box(
              title = "Pilih Jalur",solidHeader = TRUE,status="primary",
              uiOutput("filter_5"),
              width = 6
            ),
          ),
          
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl3"),
               width = 12
          ),
          fluidRow(
            box( title = "Barchart Daya Tampung Mahasiswa",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart3"),
                 width = 12
            ),
          )
        ),
      
        #--------------------------Tab Gallery--------------------------#
        tabItem(
          tabName = "galeri",
          fluidRow(
            tags$h1("Gallery Universitas Prodi Statistika di Indonesia", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          fluidRow(
            box(
              title = "Universitas Negeri Makassar",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNM.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Padang",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNP.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Mulawarman",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNMUL.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Gorontalo",solidHeader = TRUE,status="primary", width = 3,
              img(src = "GORONTALO.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Institut Teknologi Kalimantan",solidHeader = TRUE,status="primary", width = 3,
              img(src = "ITK.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Riau",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNRI.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Lambung Mangkurat",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNLAM.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Bengkulu",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNIB.png", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Tanjungpura",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNTAN.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Cendrawasih",solidHeader = TRUE,status="primary", width = 3,
              img(src = "CENDRAWASIH.png", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Tadulako",solidHeader = TRUE,status="primary", width = 3,
              img(src = "TADULAKO.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Halo Oleo",solidHeader = TRUE,status="primary", width = 3,
              img(src = "HALU_OLEO.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Hassanudin",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNHAS_REKTORAT.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Patimura",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNRAM.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Sekolah Tinggi Ilmu Statistika",solidHeader = TRUE,status="primary", width = 3,
              img(src = "STIS.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Terbuka Tangerang",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UT.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Hassanudin",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNPAD.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Patimura",solidHeader = TRUE,status="primary", width = 3,
              img(src = "IPB.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Sekolah Tinggi Ilmu Statistika",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNNES.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Terbuka Tangerang",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNDIP.png", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Indonesia",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UI.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Institut Teknologi Sepuluh November",solidHeader = TRUE,status="primary", width = 3,
              img(src = "ITS.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Sebelas Maret",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNS.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Jember",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNJ.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Airlangga",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNAIR.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Yogyakarta",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UNY.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Sumatera Utara",solidHeader = TRUE,status="primary", width = 3,
              img(src = "USU.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Gajah Mada",solidHeader = TRUE,status="primary", width = 3,
              img(src = "UGM.jpg", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Syiah Kuala",solidHeader = TRUE,status="primary", width = 6,
              img(src = "UNSYIAH.png", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Brawijaya",solidHeader = TRUE,status="primary", width = 6,
              img(src = "UNBRAW.png", height = 200, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
        ),
             #--------------------------Tab Info--------------------------#
        tabItem(
          tabName = "info",
          fluidRow(
            tags$h1("Info Pengembang Situs", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          fluidRow(
          box(
            title = "Haiii, Kami Kelompok 2!",solidHeader = TRUE,status="primary", width = 3,
            img(src = "fotokel2.jpg", height = 220, width = 200), style = "display: flex; justify-content: center; align-items: center;"
          ),
          box(
            title = "Yuk kenalan dengan kita!!",solidHeader = TRUE,status="primary", width =9,
          tags$p("Situs ini dibuat dengan cinta oleh kelompok 2 yang merupakan projek praktikum mata kuliah Manajemen Data Statistika (STA1582) dari Program Studi Statistika dan Sains Data Pascasarjana IPB University."),  
          tags$h3("Kontributor :"),
          tags$ul(
            tags$li("Windy Ayu Pratiwi sebagai Database Manager"),
            tags$li("Devi Permata Sari sebagai Back-end Developer"),
            tags$li("Rizky Ardhani sebagai Front-end dan Back-end Developer"),
            tags$li("Tukhfatur Rizmah A. sebagai Technical Writer"),style = "font-size:17px;"
          ),
          tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
          tags$a(href="https://github.com/rizkyardhani/kelompok2_mds", "link github")
          ),
          
          )
        )
      )
    ),
    #-----------------FOOTER-----------------#
    
    footer = dashboardFooter(
      right = "© 2024 Kelompok 2",
      
      
    )
  )
)

