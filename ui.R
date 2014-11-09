library(shiny)
library(gstat)
library(sp)
library(raster)
library(rasterVis)
library(colorRamps)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Game from Google: Ingress"),
  h1("Geoprofiling"),
  hr(),
  h3("Please, wait..."),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      selectInput("agent", label = h3("Select agent name"), 
                  list("capsula" = "capsula", "KORN" = "KORN", "joras" = "joras", "MalenkiyKiller" = "MalenkiyKiller"), 
                  selected = "capsula")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot", width="700px")
    )
  )
)
)
