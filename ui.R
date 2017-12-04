#####################################################################################################
# Step 1: Creating UI file
####################################################################################################    
library(shiny)

# Define UI for bleaching application
shinyUI(fluidPage( 
  
  # Application title
  headerPanel("Bleaching per Year"),
  
#####################################################################################################
# Step 2: Adding select inputs for coral types and smoothers
####################################################################################################    
  sidebarLayout(
    sidebarPanel(
      selectInput("coral_types", "Coral Types:", 
                  c("Blue Corals" = "blue corals", 
                    "Hard Corals" = "hard corals",
                    "Sea Fans" = "sea fans",
                    "Sea Pens" = "sea pens",
                    "Soft Corals" = "soft corals")
      ),
      selectInput("smoother_type", "Smoother Type:", 
                  c("Linear Smooth" = "lm", 
                    "Generalised Linear Smooths" = "glm",
                    "Local Smooths" = "loess",
                    "Generalized Additive Models" = "gam")
                  
      )
      
    ),
    
#####################################################################################################
# Step 3: Show the caption, plot and map for bleaching
####################################################################################################    
    mainPanel(
      h3(textOutput("caption")),
      leafletOutput("mymap"),
      plotOutput("bleachPlot")
    )
  )
))

