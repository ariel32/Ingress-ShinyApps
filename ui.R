library(shiny)
library(gstat)
library(sp)
library(raster)
library(rasterVis)
library(colorRamps)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Game from Google: Ingress"),
  hr(),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("by",
                  "Precision of kriging:",
                  min = 0.1,
                  max = 0.5,
                  value = 0.1),
      sliderInput("psill",
                  "Partial sill of variogramm model:",
                  min = 0.1,
                  max = 1.0,
                  value = 0.5),
      
      
      selectInput("agent", label = h3("Select agent name"), 
                  list("capsula" = "capsula", "KORN" = "KORN", "joras" = "joras", "MalenkiyKiller" = "MalenkiyKiller"), 
                  selected = "capsula"),
      
      checkboxInput("contour", label = "Enable contour", value = TRUE),
      
      sliderInput("alpha",
                  "Alpha regions:",
                  min = 0,
                  max = 1,
                  value = 0.35),
      
      selectInput("varModel", label = h3("Select Variogram Model"), 
                  list("Exponential" = "Exp", "Spherical" = "Sph", "Gaussian" = "Gau", "Mat" = "Mat"), 
                  selected = "Spherical"),
      
      selectInput("rasterSize", label = h3("Select raster size"), 
                  list("50" = 50, "100" = 100, "150" = 150, "200" = 200), 
                  selected = "100")
      

    ),
    
    # Show a plot of the generated distribution test
    mainPanel(
      p("This apps create a heatmap of activity selected player in Ingress - geoposition game from Google"),
      p("Please be patient. Applying changes will take some time."),
      plotOutput("plot", width="700px"),
      h1("Docs will be here"),
      p("This Help")
    )
  )
)
)
