# server.R

library(ggplot2)
source("helpers.R")
shinyServer(function(input, output) {

    # User can choose a category of cars by the number cylinders
    
    datasetInput <- reactive({
        switch(input$cyl,
               "any" = 0,
               "4" = 4,
               "6" = 6,
               "8" = 8)
    
    })
    
    
    finalInput <- reactive({
        # call helper function, if values changed    
        calcmpg(datasetInput(), input$weight)
        
    })
    
    output$plot <- renderPlot({
        res <- finalInput()
        
        # this part of the plot is always the same
        p1 <- qplot(res$weight*1000,res$mpg)+ xlab("Car Weight") + ylab("Miles per Gallon") +
            stat_smooth(method="lm") + ggtitle( "Miles per Gallon vs car weight in lbs")
        
        # optionally the prediction inteval can be plotted
        if (input$pred == TRUE) {
             p <- p1 + geom_pointrange(aes(x=input$weight, y=res$p[1,1], 
                                ymin=res$p[1,2], ymax=res$p[1,3]), size = 1, shape = 22, colour = "red")
        } else {
            p <- p1 + geom_point(aes(x=input$weight, y=res$p[1,1]), size = 5, shape = 22, colour = "red")
        }
        print(p)

    })
})