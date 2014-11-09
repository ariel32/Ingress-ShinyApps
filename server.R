library(shiny)
library(gstat)
library(sp)
library(raster)
library(rasterVis)
library(colorRamps)

set.seed(1)
x = rnorm(10,10,10)
y = rnorm(10,20,5)
capsula = rpois(10,10)
MalenkiyKiller = rnorm(10,100,4)
joras = rnbinom(10,10,0.545)
KORN = sample(1000, 10, T)
agents = as.data.frame(cbind(capsula,joras, KORN, MalenkiyKiller))

shinyServer(function(input, output) {
  
  dataset <- reactive(function(){
    
    data = as.data.frame(cbind(x,y,agents[input$agent]))
    names(data) <- c("x", "y", "z")
    
    
    x.range = seq(from = min(data$x-data$x/10), to = max(data$x+data$x/10), by = input$by)
    y.range = seq(from = min(data$y-data$y/10), to = max(data$y+data$y/10), by = input$by)
    
    g <- gstat(id="log", formula = data$z~1, locations = ~x+y,
               data = data)
    
    v.fit <- fit.variogram(variogram(g), vgm(input$psill,input$varModel,1000,0.01))
    grd <- expand.grid(x=x.range, y=y.range)
    pr_ok <- krige(id="log",z~1, locations=~x+y, model=v.fit, data=data, newdata=grd)
    
    nd = pr_ok[,1:3]
    names(nd) <- c("x", "y", "z")
    coordinates(nd) <- ~x+y
    
    rast <- raster(ncol = as.numeric(input$rasterSize), nrow = as.numeric(input$rasterSize))
    extent(rast) <- extent(nd)
    r = rasterize(nd, rast, nd$z, fun = mean)
    
  })
  
  
  
  
  output$plot <- renderPlot({
    
    levelplot(dataset(), margin = FALSE,
              contour = input$contour,
              par.settings = rasterTheme(region = matlab.like(n = 10)), 
              alpha.regions = 0.35)
  })
})
