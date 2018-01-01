library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
    data(mpg)
    modelCity <- lm(cty ~ displ, data = mpg)  #linear regression on city/hwy MPG with repsect to engine displacement
    modelHwy <- lm(hwy ~ displ, data = mpg)
  
    modelCitypred <- reactive({
        displInput <- input$sliderdispl   #get slider input for dispalcement
        round(predict(modelCity, newdata = data.frame(displ = displInput)), 2)
    })   #predict city MPG based on slider input and the calculated linear model
  
    modelHwypred <- reactive({
        displInput <- input$sliderdispl    #get slider input for dispalcement
        round(predict(modelHwy, newdata = data.frame(displ = displInput)), 2)
    })    #predict Hwy MPG based on slider input and the calculated linear model
  
    output$plot1 <- renderPlot({
        displInput <- input$sliderdispl
        if(input$showModelCity){    #if city MPG box from input is checked
            plot(mpg$displ, mpg$cty, xlab = "Engine Displacement (L)", ylab = "City MPG", bty = "n", pch = 16, xlim = c(0, 8), ylim = c(0, 40))
            abline(modelCity, col = "red", lwd = 2)   #add line to show the linear regression line
            legend(25, 250, c("Model City Prediction"), pch = 16, col = c("red"), bty = "n", cex = 1.2)
            points(displInput, modelCitypred(), col = "red", pch = 16, cex = 2)
        }    #plot the input point
        if(input$showModelHwy){    #same as above except for Highway MPG
            plot(mpg$displ, mpg$hwy, xlab = "Engine Displacement (L)", ylab = "Highway MPG", bty = "n", pch = 16, xlim = c(0, 8), ylim = c(0, 40))
            abline(modelHwy, col = "blue", lwd = 2)
            legend(25, 250, c("Model Hwy Prediction"), pch = 16, col = c("blue"), bty = "n", cex = 1.2)
            points(displInput, modelHwypred(), col = "blue", pch = 16, cex = 2)
        }
    })
  
    output$pred <- renderText({
        if(input$showModelCity) {
            paste("City MPG: ", modelCitypred())   #print predicted city MPG based on input
        } else if (input$showModelHwy) {
            paste("Highway MPG: ", modelHwypred())    #print predicted highway MPG based on input
        }
    })
})