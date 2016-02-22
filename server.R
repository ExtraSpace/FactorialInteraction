
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$perspPlot <- renderPlot({
    
    rootreps = 5; reps = rootreps ^ 2;
    
    # Creating Data for plotting using given replicates
    x1 <- rep(c(-1, -1, 1, 1), each = reps)
    x2 <- rep(c(-1, 1, -1, 1), each = reps)
    x1x2 <- x1 * x2

    # Design Matrix computer simulation
    ones <- rep(1, 4 * reps)
    design <- cbind(ones, x1, x2, x1x2)
    
    # Sets fixed seed for noise simulation
    set.seed(10)
    err <- rnorm(4 * reps, 0, 1)
    errors <- err * input$sigma
    
    # Model parameters
    coefs <- matrix(c(input$mu, input$alpha, input$beta, input$alpha.beta), ncol = 1)
    
    # Simulate data
    y <- design %*% coefs + errors
    
    # Ordering data for plotting
    yarr <- array(0,c(rootreps, rootreps, 4))
    for (i in 1:4) {
      yarr[,,i] <- matrix(y[((i - 1) * reps + 1):(i * reps)], rootreps, rootreps)
    }
    ymat <- rbind(cbind(yarr[, , 1], yarr[, , 2]), cbind(yarr[, , 3], yarr[, , 4]))
    
    # Prespective Plot
    z1 <- seq(0, 1, 1 / (2 * rootreps - 1))
    persp(z1, z1, ymat, expand = 0.5, col = "green", 
          xlab = "A", ylab = "B", zlab = "y",
          ticktype = "detailed", nticks = 2, zlim = c(3,7),
          theta = input$theta, phi = input$phi)
  })
})
