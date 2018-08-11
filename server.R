# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

library(shiny)
library(shiny)
library(tidyverse)
library(rStrava)
library(lubridate)

app_name <- 'John Hutchinson visualizaer' # chosen by user
app_client_id  <- '24629' # an integer, assigned by Strava
#put app_secret in a .Rprofile file in the same folder as this app

stoken <- httr::config(token = strava_oauth(app_name, app_client_id, app_secret, app_scope="view_private", cache=TRUE))
my_acts <- get_activity_list(stoken)

dat <- compile_activities(my_acts) %>% tbl_df()
commutedat <- separate(dat, start_date, into=c("date", "time"), sep="T") %>% select(commute, distance, date)
commutedat <- commutedat %>% mutate(date=as.Date(date))

todaysdate <- format(Sys.time(), "%Y-%m-%d")
defaultstartdate <- as.Date(todaysdate)-30

# Define server logic required to summarize commute distances between two dates
shinyServer(function(input, output) {
  output$thedate <- renderText(as.character(filter(commutedat, date>input$start_date & 
                                                     date<input$end_date & 
                                                     commute==TRUE) %>% 
                                              summarize(sum=sum(distance))
  ))
})
