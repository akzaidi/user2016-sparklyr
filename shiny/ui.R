library(shiny)
library(leaflet)

reasons <- c("all", as.list(reasonTbl[["reason"]]))
names(reasons) <- c(paste0("All (",format(sum(reasonTbl[["n"]]), big.mark=",", trim=FALSE),")"), reasonTbl[["pretty"]])

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  
  tags$head(tags$title("NYC Motor Vehicle Collisions")),
  div(
    div(class="menu-item",
        span("NYPD Accidents", class="title-nav")
    ),
    div(class="menu-item", id="selectize-container",
      shiny::selectInput("reason", "", reasons, width="280px", selected="all")
    ),
    div(class="menu-item",
      plotOutput("tod", width="250px", height="35px")    
    ),
    conditionalPanel("reason != 'All'",
      div(class="menu-item",
        plotOutput("legend", width="150px", height="35px")    
      )
    ),
    id="header"
  ),
  div(
      leafletOutput("map", width="100%", height="100%"),
      id="wrapper"
  )
))