# library(shiny)
# library(gstat)
# library(sp)
# library(raster)
# library(rasterVis)
# library(colorRamps)


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
      selectInput("agent", label = h3("Select box"), 
                  list("capsula" = 1, "KORN" = 2, "joras" = 3, "MalenkiyKiller" = 4), 
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
)
)
