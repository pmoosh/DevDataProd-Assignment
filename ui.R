library(shiny)

shinyUI(fluidPage(
  titlePanel("Impact of car weight vs MPG"),
  
  sidebarLayout(
    sidebarPanel(
      
      br(),   
      selectInput("cyl","Choose the number of cylinders for the estimate:", 
                  choices = c("4", "6", "8", "any"),selected = "any"),
    
      sliderInput("weight", 
                  "Weight:", 
                  min = 1000,
                  max = 6000, 
                  value = 3000
    ),
   
      # submitButton("calculate the expected mpg"),
      
      br(),
 
      
      checkboxInput("pred", "Plot prediction interval", 
        value = FALSE),
      
      helpText("Note: We use the data from the mtcars dataset.",
               "A User can choose sets limited to the number of cylinders.",
               "Enter a value for the weight you want the mpg estimated for",
               "Optionally a prediction interval can be displayed.")
      
    ),
    
    mainPanel(
        
        plotOutput("plot"),
        br(),
        h3("Further details"),
        br(),
        
        p("When gas prices are high, it is important to understand the impact weight has on a cars performance."),
        p("In this discussion we particularily interested in estimating the MPG (miles per gallon) numbers based in the cars weight as a predictor"),
        p("The measured data are taken from the mtcar dataset. Estimates are calcutated via linear regression (lm)."),
        p("The existing data ranges from 1513 to 5424, therefore estimates are limited to range from 1000 to 6000 pounds")
    )
  )
))