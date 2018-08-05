#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


  
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Strava commuter distance"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      dateInput("start_date",
                "Start Date",
                min = "2011-01-01",
                max = todaysdate,
                value = defaultstartdate,
                format = "yyyy-mm-dd", 
                startview = "month", 
                weekstart = 0,
                language = "en"),
      dateInput("end_date",
                "End Date",
                min = "2010-01-01",
                max = todaysdate,
                value = todaysdate,
                format = "yyyy-mm-dd", 
                startview = "month", 
                weekstart = 0,
                language = "en")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
     textOutput(outputId="thedate")
    )
  )
))
