# Define the server
server <- function(input, output) {
  
  # Create a reactive timer with interval 1000 milliseconds
  autoInvalidate <- reactiveTimer(1000)
  
  # Display the current time
  output$time <- renderText({
    paste("The current time is:", Sys.time())
  })
  
  datasetInput <- reactive({
    switch (
      input$dataset,
      "rock" = rock,
      "pressure" = pressure,
      "cars" = cars,
      "iris" = iris
    )
  })
  
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
  # Trigger the reactive timer every second to update the current time
  observe({
    autoInvalidate()
  })
}

# Run the app
shinyApp(ui = ui, server = server)