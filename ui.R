library(shiny)
library(DT)

shinyUI(
  
  fluidPage(
    titlePanel(
      fluidRow( 
        column(4, h3(strong("CPRD Variable")),offset = 1 ),
        column(4, offset = 7, img(src='CNODES_logo.png', align = "right", height = "25px"))
      )
      ),
    sidebarPanel(
        fluidPage( 
          br(),
          column(12,
            fileInput('file1', 'Choose Variable',
                      accept = c(".xlsx")
            ), align="center"
          )

        )

        ),

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Search", fluidRow(dataTableOutput(outputId= "search"))),
                  tabPanel("Edit/add", fluidRow(dataTableOutput(outputId= "contents"))),
                  tabPanel("About", "") )
    )


    

  
)
)

