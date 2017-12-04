#####################################################################################################
# Step 1: Loading Data into R
####################################################################################################
library(xlsx)
dat <- read.xlsx("assignment-02-data.xlsx", sheetName="Sheet1")

#####################################################################################################
# Step 2: Creating Server file
####################################################################################################
#####################################################################################################
# Step 3: Loading Libraries
####################################################################################################
library(shiny)   # load shiny
library(leaflet) # load leaflet
library(ggplot2) # load ggplot

#####################################################################################################
# Step 4: Creating server logic to plot the coral bleaching
####################################################################################################
shinyServer(function(input, output) {
  
#####################################################################################################
# Step 5: Printing caption on application
####################################################################################################
  output$caption <- reactiveText(function() {
    paste("Type ~", input$coral_types)
  })
  
#####################################################################################################
# Step 6: Plotting graph of bleching with respect to site
####################################################################################################
  
  output$bleachPlot <- reactivePlot(function() {
    # check for the input variable = blue corals
    if (input$coral_types == "blue corals") {
      newdata <- dat[ which(dat$kind ==input$coral_types), ]
    }
    else if (input$coral_types == "hard corals") {
      # check for the input variable = hard corals
      newdata <- dat[ which(dat$kind ==input$coral_types), ]
    }
    else if (input$coral_types == "sea fans") {
      # check for the input variable = sea fans
      newdata <- dat[ which(dat$kind ==input$coral_types), ]
    }
    else if (input$coral_types == "sea pens") {
      # check for the input variable = sea pens
      newdata <- dat[ which(dat$kind ==input$coral_types), ]
    }
    else if (input$coral_types == "soft corals") {
      # check for the input variable = soft corals
      newdata <- dat[ which(dat$kind == input$coral_types), ]
    }
    
    if (input$smoother_type == "lm") {
      # check for the input variable = linear smooths
      p <- ggplot(newdata, aes(year, bleaching)) + geom_point(aes(color = site)) + facet_wrap(c("latitude", "site"), labeller = "label_both") + stat_smooth(method = "lm")
      print(p)
    }
    else if (input$smoother_type == "glm") {
      # check for the input variable = generalised linear smooths
      p <- ggplot(newdata, aes(year, bleaching)) + geom_point(aes(color = site)) + facet_wrap(c("latitude", "site"), labeller = "label_both") + stat_smooth(method = "loess")
      print(p)
    }
    else if (input$smoother_type == "loess") {
      # check for the input variable = local smooths
      p <- ggplot(newdata, aes(year, bleaching)) + geom_point(aes(color = site)) + facet_wrap(c("latitude", "site"), labeller = "label_both") + stat_smooth(method = "glm")
      print(p)
    }
    else if (input$smoother_type == "gam") {
      # check for the input variable = Generalized Additive Models smooths
      p <- ggplot(newdata, aes(year, bleaching)) + geom_point(aes(color = site)) + facet_wrap(c("latitude", "site"), labeller = "label_both") + stat_smooth(method = "gam")
      print(p)
    }
#####################################################################################################
# Step 7: Plotting site locations on map in application
####################################################################################################    
    output$mymap <- renderLeaflet({ # create leaflet map
      leaflet(data = newdata) %>% 
        addTiles() %>%
        addMarkers(~longitude, 
                   ~latitude, 
                   popup = ~as.character(site)) # use the random generated points as markers on the map
    })
  })
  
})
