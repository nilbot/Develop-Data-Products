library(shiny)
library(rCharts)

shinyUI(pageWithSidebar(
        headerPanel("Body Mass Index(BMI) Calculator"),
        sidebarPanel(
                numericInput(inputId="heightM", label="Your height in cm", value= 0,min=0),
                numericInput(inputId="weightM", label="Your weight in kg", value= 0,min=0),
                actionButton("goButton", "submit"),
                hr(),
                p(strong(em("Documentation:",a("Body Mass Index(BMI) Calculator",href="READMe.html")))),
                p(strong(em("Github repository:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/nilbot/Develop-Data-Products"))))
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel('Your results',
                                h5('Your BMI'),
                                verbatimTextOutput("oiBMI"),
                                h5('Your diagnose'),
                                verbatimTextOutput("oiBMIclass"),
                                img(src="WHOBMI.png", height = 600, width =600),
                                p("Source: ", a("WHO BMI classification",
                                    href = "http://apps.who.int/bmi/index.jsp?introPage=intro_3.html"))
                                ),
                        tabPanel('Plot:Sample BMI distribution',
                                 h5('BMI histplot'),
                                 showOutput("histPlot","polycharts"),
                                 p("Source: ", a("Statcrunch BODYMEAS",
                                                 href = "http://www.statcrunch.com/app/index.php?dataid=304881"))
                                 )
                )
               )
)
)
