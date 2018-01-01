library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict City/Highway Fuel Efficiency from Engine Displacement"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderdispl", "What is the engine displacement (L) of the car?", 0, 8.0, step = 0.1, value = 4),
            checkboxInput("showModelCity", "Show/Hide City MPG", value = TRUE),
            checkboxInput("showModelHwy", "Show/Hide Highway MPG", value = FALSE),
            submitButton("Submit"),
            h3("Instructions:"),
            h5("This web page predicts city and highway fuel efficiency (MPG) based on the engine displacement (L). The slider on the side bar panel control the input for engine displacement, and the checkboxes below determines whether the user wants to calculate city or highway MPG. The linear regression models are calculated using the mpg dataset in ggplot2. The resulting scatter plot with colored linear regression line is shown on the right, along with the actual predicted MPG shown below the plot.")
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted MPG:"),
            h3(textOutput("pred"))
        )
    )
))