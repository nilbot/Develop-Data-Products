BMI<-function(wght,hght) {
        if (wght==0 | hght==0) return(NA) 
                else  return(round(wght/(hght/100)^2,1))
}

classBMI<-function(bmic) {
        if (is.na(bmic)) return ("")
        else {
                if (bmic<18.5) return("Your BMI is less than 18.5 you are considered UNDERWEIGHT") 
                if (bmic>=8.5 & bmic<24.9) return("Your BMI is in range 18.5 to 24.9 you are in HEALTHY WEIGHT RANGE")
                if (bmic>=25 & bmic<29.9) return("Your BMI is in range 25 to 29.9 you are OVERWEIGHT")
                if (bmic>=30) return("Your BMI is higher than 30 you are OBESE")
        }
}

library(shiny)
library(reshape2)
library(rCharts)
## loading data
ds = read.table('data/bodymeas.csv', header = T)
## Convert to the international
ds$WEIGHT = 0.4536 * ds$WEIGHTENG # kg
ds$HEIGHT = 2.54 * ds$HEIGHTENG # cm
## BMI calculate
ds$BMI = ds$WEIGHT/(ds$HEIGHT/100)^2
ds$ID = (1:1:nrow(ds))
ds <- na.omit(ds)

shinyServer(
        function(input, output) {
                
                output$oiweight <- renderPrint({input$weightM})
                output$oiheight <- renderPrint({input$heightM})
                output$oiBMI <- renderPrint({
                        input$goButton
                        isolate(BMI(input$weightM,input$heightM))
                        })
                output$oiBMIclass<-renderText({
                        input$goButton
                        isolate(classBMI(BMI(input$weightM,input$heightM)))
                        })
                output$histPlot <- renderChart({
                  input$goButton
                  hb1 = rPlot(x = "bin(BMI, 1)", y = "count(ID)", data = ds, type = "bar")
                  hb1$addParams(dom ='histPlot')
                  return(hb1)
                })

})