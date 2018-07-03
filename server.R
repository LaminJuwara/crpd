library(shiny)
library(ggplot2)
library(dplyr)
library(xlsx)
library(DT)


shinyServer(function(input, output, session){ 
  observeEvent(input$submitSearch, {
    updateTabsetPanel(session = session, inputId = "tabs", selected = "Search")
  })
  
  observeEvent(input$submitEdit, {
    updateTabsetPanel(session = session, inputId = "tabs", selected = "Edit/add")
  })

  output$contents <- renderDT({  
    inFile <- input$file1
    
    if(is.null(inFile))
      return(NULL)
    
    ext <- tools::file_ext(inFile$name)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ext, sep="."))
    read.xlsx(paste(inFile$datapath, ext, sep="."), 1) 
  },editable=TRUE)
  
  datasearch<-reactive({
    foo<-{ 
      inFile <- input$file1
      if(is.null(inFile))
        return(NULL)               
      
      ext <- tools::file_ext(inFile$name)
      file.rename(inFile$datapath,
                  paste(inFile$datapath, ext, sep="."))
      read.xlsx(paste(inFile$datapath, ext, sep="."), 1) 
    }
    datatable(foo, filter = list(position = 'top', clear = FALSE),
              extensions = c('Buttons','AutoFill'), 
              options = list(
                search = list(regex = TRUE, caseInsensitive = FALSE, search = ""),
                pageLength = dim(foo)[1], dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel'), 
                autoFill=TRUE),
              escape = T)
  })
  output$search<-renderDT({datasearch()}) 

## Including the dashboard variable
  # setwd("~/Desktop/crpdvariable/")
  # dashdata<-read.xlsx("CPRD VARIABLE DEFINITION LOG.XLSX",keepFormulas = TRUE,sheetIndex = 1,header = TRUE)
  # dashdata$File.path<-NA
  # names(dashdata)<-c("Shorthand","broad","granular","file path","Purpose","Creator","Date Created",
  #                    "Date Edited","Update Descriptions","Datebase Used","ICD Codes","ATC Codes",
  #                    "Last Update","Codebrowser Version")
  # write.csv(x = dashdata,"dashfile.csv",row.names = FALSE)
  
  dashtab<-reactive({
    data<-read.csv(file = "dashfile.csv",header = TRUE)
    return(datatable(data,editable = TRUE,))
  })
  output$dash<-renderDT({
    dashtab()
  })
  
}) 

