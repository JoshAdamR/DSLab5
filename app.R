# Load required libraries
library(shiny)

# Load the iris dataset
iris <- read.csv("D:\\RStudio\\lab 5_ds\\Iris.csv")

# Define the UI
ui <- fluidPage(
  titlePanel("Shiny Text"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "dataset",
        label = "Choose a dataset to view:",
        choices = c("Iris" = "iris", "Rock Types" = "rock", "Atmospheric Pressure" = "pressure", "Car Speeds" = "cars")
      ),
      numericInput(
        inputId = "obs",
        label = "Number of observations to view:",
        value = 10
      ),
      downloadButton("downloadData", "Download Selected Dataset"),
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv", "text/comma-seperated-values, text/plain", ".csv")),
      tags$hr(),
      checkboxInput("header", "Header", TRUE),
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                   selected = ","),
      tags$hr(),
      radioButtons(
        "disp",
        "Display",
        choices = c(Head = "head", All = "all"),
        selected = "head"
      ),
      tags$hr(),
      p("Current time:"),
      textOutput("time")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("view")),
      )
    )
  )
)
