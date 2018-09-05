library(shiny)
library(MASS)
library(datasets)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "Animals" = Animals,
           "InsectSprays" = InsectSprays,
           "pressure" = pressure)
  })
  output$caption <- renderText({
    input$caption
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  output$structure <- renderPrint({
    dataset <- datasetInput()
    str(dataset)
  })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  output$documentation <-renderText({ 
    paste("-This is a Shiny App Project that was developed to show the various widgets that can be used to the App. 
          -This App has 2 sections, a sidebar which is on the left of the App and on the right is main screen that contains the tabs. 
          -The sidebar panel have fours(4) control items. 
          -Title textbox allow user to customize the main page title description. 
          -The second (2) control item allows the user to select dataset 
          -Third item is to controls on how many observatrions will be showed under the Table tab. 
          -The forth control allow the use to select the color of the histogram. 
          -On the Main Page, there are 4 tabs:- 
          1.First tab displays the histogram of the dataset selected. 
          2.Second tab show the summary while the 
          3.Third tab shows the observations. The no of observations displayed 
          is based on the number selected by user in the sidebar. 
          4.Forth tab displays the dataset structure. The Documentation tab is 
          to display this text")
  })
  
  output$plot <- renderPlot({
    dataset <- datasetInput()
    hist(dataset[,1],breaks=seq(0,as.integer(max(dataset[,1])),l=input$obs),col=input$color,xlab=names(dataset[1]))
  })
  })