library(shiny)
library(DT)

shinyUI(
  
  fluidPage(
    titlePanel(
      fluidRow( 
        column(4, h3(strong("CPRD Database")),offset = 1 ),
        column(4, offset = 7, img(src='CNODES_logo.png', align = "right", height = "25px"))
      )
      ),
    sidebarPanel(
        fluidPage( 
          br(),
          fluidRow(column(12,fileInput('file1','Choose Variable',
                                       accept = c(".xlsx")), align="center")),
          fluidRow(column(6, actionButton(inputId = "submitSearch", label = "Search") , align='center'),
                   column(4, actionButton(inputId = "submitEdit", label = "Edit Variable") , align='center')))),

    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel(
          title = "Dashboard: CPRD variable definition log",
          fluidRow(dataTableOutput(outputId= "dash"))),
        tabPanel("Search", fluidRow(dataTableOutput(outputId= "search"))),
        tabPanel("Edit/add", fluidRow(dataTableOutput(outputId= "contents"))),
        tabPanel("About", textOutput("about.txt")) 
        
      )
    )


    

  
)
)

