library(shiny)
library(ggplot2)
library(dplyr)
library(xlsx)
library(DT)


shinyServer(function(input, output, session){ 

  output$contents <- renderDT({ # need to update this renaming | some issues 
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
                pageLength = dim(foo)[1], dom = 'Bfrtip', buttons = c('copy', 'csv', 'excel'), 
                autoFill=TRUE),
              escape = T)
  })
  output$search<-renderDT({datasearch()}) 


}) 

