
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyRGL)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Input Parameters"),
      numericInput("reps", "Reps", min = 1, max = 10, value = 5),
      sliderInput("sigma", "Sigma", min = 0.01, max = 2, value = 0.05, step = 0.01),
      sliderInput("mu", "Mean", min = 0, max = 10, value = 5),
      sliderInput("alpha", "alpha", min = -2, max = 2, value = 0, step = 0.05),
      sliderInput("beta", "beta", min = -2, max = 2, value = 0, step = 0.05),
      sliderInput("alpha.beta", "Interaction (alpha.beta)", 
                  min = -1, max = 1, value = 0, step = 0.05)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      webGLOutput("perspPlot", width = "100%", height = 600)
    )
  )
))
