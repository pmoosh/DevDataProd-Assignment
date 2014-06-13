
library(caret)
data(mtcars)
# helper function to calulate the data we want to explore 
# uses data from mtcars
# We want to predict the MPG as a resutt of the cars weight

calcmpg <- function(cyl = 0, wt = 3000) {
    
    # 0 if we include all types of cars
    if (cyl == 0) {
        mpg <- mtcars$mpg
        weight <- mtcars$wt
    } 
    else {
        mpg <- mtcars[mtcars$cyl == cyl,]$mpg
        weight <- mtcars[mtcars$cyl == cyl,]$wt
    }
    
    # generate a linear regression model
    lM <- lm(mpg ~ weight)
    
    # predict the mpg for a given weight
    newdata = data.frame(weight = wt/1000)
    p1 <- predict(lM, newdata, interval = "predict")
    return(list(weight = weight,mpg = mpg,p = p1))
}