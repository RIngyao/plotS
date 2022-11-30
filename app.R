
source("global.R", local = TRUE)
ui <- fluidPage(
  #CSS----------------
  tags$head(
    tags$style(
      HTML("
      /*general*/
      body{ 
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      font-size:17px;
      }
      .help-block{
      margin-top:0;
      margin-bottom:30px
      }
      .shiny-output-error-validation {
        /*position:fixed;*/
        color: #ff0000;
        font-weight: bold;
        /*top: calc(50%);*/
        /*left: calc(50%);*/
        padding:10%;
        font-size: 130%;
        background-color:white;
        margin:10%;
      }
      .shiny-notification {
             position:fixed;
             top: calc(50%);
             left: calc(50%);
             color: black;
             font-weight:bold;
             font-size:25px;
      }
      .box{
      -moz-box-shadow:none !important;
      -webkit-box-shadow:none !important;
      -goog-ms-box-shadow:none !important;
      box-shadow:none !important;
      }
      .nav-tabs,li,a{
      font-size:20px;
      }
      
      
      
      /*Header*/
      
      #header {
        overflow: hidden;
       /* background-image:linear-gradient(to bottom, rgba(69, 215, 250, 0.3), white);*/
        /*background-image:linear-gradient(70deg, white, rgba(69, 215, 250, 0.3), white);*/
        background-image:radial-gradient(rgba(12, 191, 227, 1), white, white);
      }
      
      #projectTitle{
      overflow: hidden;
      border-radius:50%;
      width:100px;
      height:100px;
      background-image: radial-gradient(at 90% 20%,  white, #45D7FA);
      box-shadow: 12px -9px 17px #06BBE7 inset,  3px 2px 10px white;
      margin-bottom:5px;
      }
      
      /*perfect 90% 90%  45D7FA
      box-shadow: 10px 2px 10px #45D7FA inset,  3px 2px 10px white*/
      
      #projectTitle h1{
      text-align:center;
      color: #057C94 ; /*;0890AB*/
      font-weight:bold;
      font-size:37px;
      font-family:'Times New Roman', Times, serif, Arial, Helvetica, sans-serif;
      padding: 5% 0 0 10%;
      text-shadow:2px 4px 1px #45D7FA, 2px 0 10px white;
      }
      
      
      
      /*Main content*/
      #plotTabset:not(#chartBox){
      display:flex !important;
      flex-direction:row;
      justify-content:center;
      margin:auto;
      }
      /*About*/
      hr{
        border:solid 0.4px;
      }
      .inst p{
        font-size:17px;
      }
      .inst li{
       font-size:15px;
      }
      
      /*analyze and visualyze*/
      .chartPanel > #chartBox > .tabbable > .nav-tabs {
      background-image:linear-gradient(white 50%, rgba(56, 168, 249, 0.2))
      }
      /*.col-sm-12 > .nav-tabs-custom > .nav{
        background-image:linear-gradient(white 50%, rgba(56, 168, 249, 0.2))
        }*/
      /*Tables*/
      .tableMainPanel{
      margin:auto
      }
      .tableSidePanel{
      max-width:400px;
      }
      .rawTable, .organizedTable{
      text-align:center;
      text-color:black;
      margin:center;
      }
      .rawTable h3{
      font-weight:bold;
      color:#025A9E
      }
      .rawTable{
      max-width: 800px;
      margin-left: 10%;
      margin-right: 10%;
      margin-bottom: 50px;
      min-height: 30px;
      box-shadow:none;
      }
      #organizedDownload{
      float:right;
      }
      .organizedTable h3{
      font-weight:bold;
      size:15;
      color:#3ABCF4;
      }
      .organizedTable{
      max-width: 800px;
      margin-left: 10%;
      margin-right:10%;
      min-height: 200px
      }
      /*reshape*/
      #goAction{
      margin:auto;
      font-weight:bold;
      }
      /*input and transform table*/
      #textInputTable{
      font-weight:bold;
      font-size:120%;
      text-align:center;
      background:#f2f2f2
      }
      #textTransformTable{
      font-weight:bold;
      font-size:120%;
      text-align:center;
      background:#f2f2f2
      }
      /*Graph*/
      .figureMainPanel{
      margin:auto;
      color:#F4F4F4;
      }
      .figureSidebarPanel{
      max-width:600px;
      }
      .figurePlotBox, .figureTheme{
      max-width: 800px;
      margin-left:10%;
      margin-right:10%;
      padding:auto;
      }
      .figurePlotBox{
      margin-bottom:10px;
      }
      #figDownloadFormat{
      float:right;
      margin-right:0;
      font-weight:bolder;
      color:black;
      padding-top: 10px;
      }
      #figDownload{
      float:left;
      margin-left:0;
      font-weight:bolder;
      }
      #figHeight, #figWidth{
      margin:0;
      text-color:green;
      }
      .figHWDFluidRow{
      margin:0;
      }
      .figDownloadDiv{
      /*background-color: rgba(247, 79, 114, 0.2);*/
      /*background-image:linear-gradient(360deg, white, rgba(247, 79, 114, 0.2), white);*/
      /*background-image:linear-gradient(to top, rgba(255,0,0,0.7), white, white);*//*padding-top: px;*/
      margin-bottom:7px;
      padding-top: 10px;
      border-bottom:solid;
      border-color:red;
      }
      /*aesthetic setting*/
      #UiColorSet{
      margin-top:0;
      padding-top:0;
      }
      #UiShapeLine{
      margin-bottom:20px
      }
      
      /*statistic*/
      #UiChooseSignif{
      margin:0;
      padding:0;
      align:left
      }
      #UiChooseSignifMethod{
      margin:0;
      padding:0;
      align:left
      }
      #UiPairedData{
      /*text-align:center;*/
      margin-top:0px;
      margin-bottom:10%;
      padding-top:0;
      }
      #UiChooseSignifLabel{
      /*text-align:center;*/
      font-weight:bold;
      margin-top:5%
      }
      #showListGroup{
      background:white
      }
      
      .summaryPanel{
      max-width: 1200px;
      padding-left:5%;
      padding-right:5%;
      background-color:transparent;
      display:flex;
      }
      
      .helpPanel{
      
      }
      
      
           ")
    )
  ), #end of css-----------------
  
  # Application title
  div(id="header",
      div(
        id="projectTitle",
        tags$h1("PlotS")
      )
  ),
  
  #content-------------------
  div(
    id="content",
    tabsetPanel(
      id = "plotTabset",
      
      tabPanel(
        #Here instruction for data type will be given
        title = "About", 
        # includeHTML("www/plotS_about.html"),
        # includeMarkdown("www/plotS_about.Rmd"),
        # HTML instruction---------------
        HTML('
                    <div class = "inst">
                      <hr></hr>
                      <p>
                      <b>PlotS</b> is a web-based application for data analysis and visualization. It is free and easy to use. You can analyze your data in an engaging way by running statistical tests while plotting the graphs. We hope that it will be a useful tool for performing quick analysis.
                      </p>
                      <p>
                      The list of graphs currently available for plotting:
                      <ul>
                        <li>Bar plot</li>
                        <li>Box plot</li>
                        <li>Density plot</li>
                        <li>Frequency polygone</li>
                        <li>Histogram</li>
                        <li>Line plot</li>
                        <li>Scatter plot</li>
                      </ul>
                      For statistical analysis, we have included the most commonly used parametric and non-parametric methods:
                      <ul>
                        <li><b>Parametric test</b></li>
                        <ul>
                          <li>T-test</li>
                          <li>ANOVA (One-way and Two-way)</li>
                       </ul>
                       <li><b>Non-parametric test</b></li>
                       <ul>
                        <li>Wilcoxon test</li>
                        <li>Kruskal-Wallis test</li>
                       </ul>
                      </p>
                    </div>'
        )#end HTML
        
        
      ) %>% tagAppendAttributes(class="instructionPanel"),#end instruction tab
      
      #Analyze & visualize-------------------
      tabPanel(
        #This panel will be shown as interactive when the figure is ready
        title = "Analyze & visualize", value = "chart", icon = icon("chart-pie"),
        
        div(
          id="chartBox",
          #box for containing all the display tab: table, figure and summary
          width = 12,
          #panel for table------
          tabsetPanel(
            type="pills",
            tabPanel(
              title = span("Data", style = "font-weight:bold; font-family: 'Times New Roman',Times, Georgia, Serif, sans-serif; text-shadow:1px 4px 5px #C1BEBD"),
              # icon=icon("table"),
              #require sidebar (Input panel) and main panel (display panel)
              sidebarLayout(
                sidebarPanel(
                  width=3,
                  # style = "position:fixed;width:inherit;margin-right:2%",
                  #panel for input parameters of table
                  #This parameter will have option for choosing the data
                  h3("", br(), align = "center", style = "color:green"), #just in case if i want to add text
                  selectInput(inputId = "pInput", label = "Input data", choices = list("","query result","upload data"), selected = ""),
                  #ui for uploading the data, 
                  uiOutput(outputId = "pUpload"),
                  #ui for alerting invalid file type
                  uiOutput(outputId = "UiUploadInvalid"),
                  #ui for present or absent of replicates
                  uiOutput(outputId = "UiReplicatePresent"),
                  
                  conditionalPanel(condition = "input.replicatePresent == 'yes'",
                                   helpText("Manage the replicates", style = "margin-top:5px; margin-bottom: 10px;"),
                                   div(
                                     style = "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:10px; padding:5px 0 5px 0;",
                                     #Ui for number of header in the table
                                     # helpText("Provide correct number of header!", style = "margin-top:10px; margin-bottom:0;color:#F49F3A"), 
                                     helpText("Provide number of header and group/variables.", style = "margin-top:20px; margin-bottom:7px;font-weight:bold; color:#F4763A"), 
                                     fluidRow(
                                       column(6,uiOutput("UiHeaderNumber")),
                                       #let user specify number of variables:
                                       # It is easier to process
                                       column(6, uiOutput("UiDataVariables"))
                                     ),
                                     textOutput("UiVarList"),
                                     uiOutput("UiReplicateNumber"),
                                     helpText("Provide variable's name and index of the replicate columns", style = "margin-top:15px; margin-bottom:7px;font-weight:bold;color:#F4763A"), #3ABFF4
                                     #Ui for adding variable name and replicates column
                                     uiOutput("UiVarNameRepCol"),
                                     # #Ui for replicate statistic
                                     # uiOutput("UiReplicateStat"),
                                     # helpText("Calculate 'mean' to use the parametric statistical method and 'median' for non-parametric method."), #Compute 'mean' to apply parametric statistic method, 'median' for non-parametric.
                                     #action button for running replicates parameter
                                     uiOutput("UiReplicateActionButton"),
                                     uiOutput("UiAfterReplicate"),
                                     #show error message
                                     uiOutput("UiReplicateError")
                                   )
                  ),
                  
                  #reshape input data
                  selectInput(inputId = "transform", label = "Reshape the data", choices = list("No", "Yes"), selected = "No"),
                  #ui output for choosing columns to transform the data
                  #for names 
                  uiOutput(outputId = "trName"),
                  #for value
                  uiOutput(outputId = "trValue"),
                  #error message for reshape
                  conditionalPanel(condition = "input.enterName == 'value'",
                                   helpText("Provide a different name, not 'value'.",
                                            style = "color:red; margin-bottom: 10px; font-weight:bold; font-size:12")
                  ),
                  #error message for reshape: when user try to combine numeric and character column
                  uiOutput("UiReshapeError"),
                  #ui output to take action for transformation
                  uiOutput(outputId = "trAction"),
                  
                  #Ui for normalization and standardization of data  
                  selectInput(inputId = "normalizeStandardize", label = "Transform", choices = c('none', NS_methods), selected = 'none'),
                  
                  conditionalPanel(condition = "input.normalizeStandardize != 'box-cox'",
                                   uiOutput("UiNsNumVar")
                  ),
                  conditionalPanel(condition = "input.normalizeStandardize == 'box-cox'",
                                   
                                   fluidRow(
                                     column(6, uiOutput("UiNsCatVar")),
                                     column(6, uiOutput("UiNsNumVar2"))
                                   )
                  ),
                  #ui action button for normalization and standardization
                  uiOutput("UiNsActionButton")
                ) %>%tagAppendAttributes(class="tableSidePanel"),
                
                mainPanel(
                  title="Table",
                  # style= "margin-left:2%",
                  box(
                    # class = "rawTable",
                    width = 12,
                    # height = '500px',
                    title = "Input table",
                    status = "primary",
                    collapsible = TRUE,
                    #show text
                    # textOutput("textInputTable"),
                    #show table here when input data is choosen
                    dataTableOutput("pShowTable")
                  ) %>% tagAppendAttributes(class = "rawTable"),
                  
                  # #Ui to display table without header
                  # dataTableOutput("pShowTable2"),
                  
                  conditionalPanel(condition = " input.pInput !='' && ( (input.replicatePresent == 'yes' || input.transform == 'Yes') || (input.normalizeStandardize != 'none' ) )",
                                   
                                   box(#title = "Transformed table: it will be used for plotting",
                                     
                                     title = "Organized table",
                                     width = 12,
                                     footer = "* This table will be used for plotting figures and statistical analysis",
                                     status = "info",
                                     #show text
                                     # textOutput("textTransformTable"),
                                     #download button
                                     downloadButton("organizedDownload"),
                                     #show transform table here
                                     dataTableOutput("pShowTransform")
                                   ) %>% #end of box
                                     tagAppendAttributes(class = "organizedTable"),                
                                   
                  )
                ) %>% tagAppendAttributes(class= "tableMainPanel")#end of main panel for table panel
              )#end of sidebarLayout for table panel
            ),#end of panel for table-------
            
            #figure tab panel-------------
            tabPanel(
              title = span("Graph", style = "font-weight:bold; font-family: 'Times New Roman',Times, Georgia, Serif, sans-serif; text-shadow:1px 4px 5px #C1BEBD;"),
              # icon=icon("bar-chart-o"),
              #layout for input and display panel
              sidebarLayout(
                fluid = FALSE,
                sidebarPanel(
                  width = 5,
                  style="margin:0; background-image:linear-gradient(to right, #F2F0EF, #FEFEFE)",
                  h3("", br(), align = "center", style = "color:green"),
                  #two column
                  fluidRow(
                    
                    column(6, 
                           #input panel for figure and statistics
                           #choice of plot
                           uiOutput(outputId = "UiPlotType"),
                           #ui alert for bar plot
                           conditionalPanel(condition = "input.plotType == 'bar'",
                                            helpText(list(tags$p("Use bar graph for categorical or count data!!"), tags$p("Users are encouraged to use other graph that show data distribution.")), style= "margin-bottom:10px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
                           ),
                           #additional param for histogram
                           uiOutput(outputId = "UiHistParam"),
                           #ui output to specify axis
                           fluidRow(
                             column(6, uiOutput("xAxisUi")),
                             column(6, uiOutput("yAxisUi"))
                           ),
                           # #Ui for normalization and standardization
                           # conditionalPanel(condition = "input.plotType != 'none'",
                           #                  uiOutput("UiNormStand")
                           #                  ),
                           
                           #Ui for bar graph positon: stack or dodge
                           uiOutput(outputId = "UiStackDodge"),
                           # #Ui color and fill for histogram
                           fluidRow(
                             column(6, uiOutput("UiHistBarColor")),
                             column(6, uiOutput("UiHistBarFill"))
                           ),
                           #Ui to select variable to connect the path
                           uiOutput("UiLineConnectPath"),
                           #Ui to add error bar for line type
                           uiOutput("UiLineErrorBar"),
                           #ui to compute for error bar
                           uiOutput("UiErrorBarStat"),
                           #ui to display error for sd
                           uiOutput("UiSdError"),
                           #Ui to compute or specify the computed sd
                           uiOutput("UilineComputeSd"),
                           #Ui to group by for computing standard deviation 
                           uiOutput("UiLineGroupVar"),
                           #Ui for scatter plot, jitter the points
                           uiOutput("UiJitter"),
                           #Ui to add color for error bar
                           uiOutput("UiErrorBarColor"),
                           #line size for frequency polygon and line
                           uiOutput("UiFreqPolySize"),
                           #mean for histogram
                           uiOutput("UiHistMean"),
                           #variables for group mean
                           uiOutput("UiHistGroupVar"),
                           #linetype and color for the mean of histogram
                           fluidRow(
                             column(6, uiOutput("UiHistMeanLine")),
                             column(6, uiOutput("UiHistMeanColor"))
                           ),
                           uiOutput("UiHistMeanSize"),
                           #ui for density
                           fluidRow(
                             column(6, uiOutput("UiDensityKernel")),
                             column(6, uiOutput("UiDensityStat"))
                           ),
                           fluidRow(
                             column(6, uiOutput("UiDensityBandwidth")),
                             column(6, uiOutput("UiDensityAdjust")),
                           ),
                           #option for theme
                           uiOutput("UiTheme"),
                           uiOutput(outputId = "uiForMoreParameters"),
                           
                           #Aesthetic setting
                           div(
                             style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:10px; 
                             background-image:linear-gradient(to top, #F2F4F5,#FBFBFB)",##F2F0EF
                             helpText("Aesthetic options", style = "text-align:center; margin-top: 5px margin-bottom: 0; font-weight:bold;"),
                             #ui for color
                             uiOutput("UiColorSet"),
                             #ui to give option to auto set colors or customize
                             uiOutput("uiAutoCustome"),
                             #ui for entering color
                             uiOutput("UiColorAdd"),
                             
                             #UI for positioning of density and alpha
                             fluidRow(
                               column(6, uiOutput("UiDensityPosition")),
                               column(6, uiOutput("UiAlpha"))
                             ),
                             #ui for adding shape and linetype
                             uiOutput("UiShapeLine"),
                             #ui for shape
                             map(1:3,function(.)uiOutput(paste0("shape_",.))),
                             #1. variable 2. 
                             #ui for line
                             map(1:3,function(.)uiOutput(paste0("line_",.)))
                             
                           )#end of div aesthetic
                           
                    ),#end of 1st column
                    
                    column(6,
                           #setting for statistical computing
                           #ui for stat method
                           #blankUi("forSignif", 4)
                           uiOutput("UiStatMethod"),
                           #ui alert message for t-test
                           uiOutput("UiTtestAlert"),
                           #stats additional parameter
                           conditionalPanel(condition = "input.stat != 'none'",
                                            #grey:F2F0EF
                                            div(
                                              # style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px; padding:7px;
                                              style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px; margin-right:0; 
                                            background-image:linear-gradient(rgba(206,247,250, 0.3), rgba(254, 254, 254, 0), rgba(206,247,250, 0.5)) ", #F2F0EF ##C3F6FB, #F2F0EF, #C3F6FB
                                              #add help text for krukal test
                                              conditionalPanel(condition = "input.stat == 'Kruskal test'",
                                                               helpText("Dunn's test used for post-hoc analysis")
                                              ),
                                              #Ui for selecting test method of statistics
                                              conditionalPanel(condition = "input.stat == 't.test'",
                                                               uiOutput("UiTtestMethod"),
                                                               # radioButtons(inputId = "ttestMethod", label = "Test method", choiceNames = choices, choiceValues = c(FALSE, TRUE), inline = TRUE)}
                                                               helpText("Refer the summary and change the method, if necessary.")
                                              ),
                                              #Ui for data type: paired or unpaired
                                              uiOutput("UiPairedData"),
                                              uiOutput("UiAlertPairedData"),
                                              #help test for post hoc test of anova
                                              conditionalPanel(condition = "input.stat == 'anova'",
                                                               helpText("Tukey's HSD test used for post-hoc analysis")
                                              ),
                                              #UI for anova model
                                              conditionalPanel(condition = "input.stat == 'anova' && input.pairedData == 'two'",
                                                               {models <- list(tags$span("Additive", style = "font-weight:bold; color:#0099e6"), 
                                                                               tags$span("Non-additive", style = "font-weight:bold; color:#0099e6"))
                                                               radioButtons(inputId = "anovaModel", label = "Model", choiceNames = models, choiceValues = c("additive", "non-additive"), inline = TRUE)
                                                               }
                                              ),
                                              
                                              #Ui for selecting other variables for two-way anova
                                              uiOutput("UiTwoAovVar"),
                                              
                                              #error type for anova
                                              conditionalPanel(condition = "input.stat == 'anova' && input.pairedData == 'one'",
                                                               {er_lst <- list(tags$span("I", style = "font-weight:bold; color:#0099e6"), 
                                                                               tags$span("II", style = "font-weight:bold; color:#0099e6"),
                                                                               tags$span("III", style = "font-weight:bold; color:#0099e6"))
                                                               # selectInput(inputId = "ssType", label = "Error type",
                                                               #              choice = c(1,2,3), selected = 2)
                                                               radioButtons(inputId = "ssType", label = "Type of sum of squares", inline = TRUE,
                                                                            choiceNames = er_lst, choiceValues = list(1, 2, 3), selected = 2)
                                                               }),
                                              #Ui for anova figure:
                                              uiOutput("UiAnovaFigure"),
                                              #Ui for color of anova. Different from the general colorSet
                                              uiOutput("UiAnovaColor"),
                                              #ui for option to auto or customize
                                              uiOutput("UiAnovaAutoCust"),
                                              #ui for adding color
                                              uiOutput("UiAnovaAddColor"),
                                              
                                              #Ui for padjusted value,
                                              fluidRow(
                                                id = "pAdjustRow",
                                                column(5, uiOutput("UiChooseSignif")),
                                                #ui for p adjust method
                                                column(7, uiOutput("UiChooseSignifMethod"))
                                              ),
                                              #ui for display label
                                              uiOutput("UiChooseSignifLabel"),  #value or symbol (*, **, ***)
                                              
                                              
                                              #for comparing groups
                                              uiOutput("UiCompareOrReference"),
                                              conditionalPanel(condition = "input.compareOrReference != 'none'",
                                                               div(
                                                                 style= "margin-bottom:20px; background-image:linear-gradient(rgba(253,231,177, 0.2), rgba(253,231,177, 0.2), rgba(253,231,177, 0.2)) ",
                                                                 #ui compare or reference group
                                                                 
                                                                 #ui to add group for comparison or reference group
                                                                 uiOutput("UiListGroup"),
                                                                 #text helper
                                                                 conditionalPanel(condition = "input.compareOrReference != 'none' && input.listGroup == 'all'",
                                                                                  # helpText(span("Each grouping variable levels is compared against all (i.e. basemean)", style = "color:#2FAFF3"))
                                                                                  helpText("Each grouping variable levels is compared against all (i.e. basemean)")
                                                                 ),
                                                                 
                                                                 fluidRow(
                                                                   column(6,#ui to take action for grouping
                                                                          uiOutput("UiAddGroupAction")),
                                                                   column(6, #ui to delete groups
                                                                          uiOutput("UiDeleteGroupAction"))
                                                                 ),
                                                                 #ui to show the variable(s) chosen for comparison or referencing
                                                                 tags$head(
                                                                   #style for displaying the selected groups
                                                                   tags$style("#showListGroup{height:50px; color:blue}")
                                                                 ),
                                                                 uiOutput("UiShowListGroup")
                                                               )#end div for compareOrRefere
                                                               
                                                               
                                              ), #end conditional for compareOrRefere
                                              
                                              
                                              #Ui for pariwise comparison: Yes or no
                                              uiOutput("UiPairwiseComparison")
                                            )#end of div for statistic test
                           ), #end of conditional panel for stat
                           #ui for facet
                           map(1:2, function(.) uiOutput(paste0("UiFacet_",.))),
                           conditionalPanel(condition = "input.facet != 'none'",
                                            
                                            div(
                                              style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px;
                                            background-image:linear-gradient(rgba(206,247,250, 0.2), #F2F0EF, rgba(206,247,250, 0.3)",
                                              
                                              fluidRow(
                                                #ui for choosing variable: row ~ col
                                                map(1:2, function(.) column(6,uiOutput(paste0("UiVar_",.))))
                                              ),
                                              #1. type 2. variable 3. formula
                                              #row and column
                                              fluidRow(
                                                map(1:2, function(.) column(6,uiOutput(paste0("UiRowColumn_",.)))),
                                                conditionalPanel(condition = "input.facet != 'none'",
                                                                 helpText("0 = default row or column", style = "text-align:center; margin-top:0; margin-bottom: 7px")
                                                )
                                              ),
                                              #scale for facet
                                              uiOutput("UiScales"),
                                            )
                           ), #end of conditional panel facet
                           
                           #Ui for additional layer
                           uiOutput("UiLayer"),
                           uiOutput("UiLayerSize")
                    ) #end of 2nd column
                  )
                ) %>% tagAppendAttributes(class="figureSidebarPanel"), #end of figure sidebar panel
                
                # end of sidbar---------------
                mainPanel(
                  width = 7,
                  title = "Figure",
                  
                  #div for download
                  div(
                    #download button
                    
                    fluidRow(
                      column(6,
                             radioButtons(inputId = "figDownloadFormat", label = NULL, choices = sort(c("PDF", "EPS", "PNG", "TIFF", "SVG")), selected = "PDF", inline = TRUE)
                      ),
                      # column(6, downloadButton("figDownload"))
                      column(6,
                             fluidRow(
                               column(4, textInput(inputId = "figHeight", label = NULL, placeholder = "Height(in)")), #in inch 3.3 default for 1 coulmn wide (https://www.elsevier.com/__data/promis_misc/JBCDigitalArtGuidelines.pdf),
                               column(4, textInput(inputId = "figWidth", label = NULL, placeholder = "Width (in)")),
                               column(4, downloadButton("figDownload", label = NULL, class = "btn-info btn-l")),
                             ) %>% tagAppendAttributes(class="figHWDFluidRow")
                      )
                    )
                  )%>% tagAppendAttributes(class="figDownloadDiv"),
                  #display figure
                  div(
                    width = 12,
                    # style= "position:fixed;width:inherit",
                    height = '400px',
                    plotOutput(outputId = "figurePlot")
                  ) %>% tagAppendAttributes(class = "figurePlotBox"),
                  
                  #box for figure settings:theme  
                  box(
                    width = 12,
                    collapsible = TRUE,
                    #font size
                    column(6, uiOutput("uiTitleSize")),
                    column(6, uiOutput("uiTextSize")),
                    fluidRow(
                      column(6, uiOutput("uiYlable")),
                      column(6, uiOutput("uiXlable")),
                    ),
                    #ui for bin width of histogram
                    fluidRow(column(8, uiOutput("uiBinWidth"))),
                    #ui for legend
                    fluidRow(
                      fluidRow(
                        #Legend: on & off
                        column(3, uiOutput("UiLegendTitle")),
                        #position
                        column(3, uiOutput("UiLegendPosition")),
                        #direction
                        column(3, uiOutput("UiLegendDirection")),
                        #font size
                        column(3,uiOutput("UiLegendSize"))
                      ),
                      #title switch
                      fluidRow(
                        uiOutput("UiRemoveBracket"),
                        uiOutput("UiStripBackground")
                        
                      )
                    )#end for legend
                  ) %>% tagAppendAttributes(class="figureTheme")#end figure box
                ) %>% tagAppendAttributes(class="figureMainPanel")#end mainpanel----------
                
              ) %>% tagAppendAttributes(class = "figureSidebarLayout")#end of figure sidebar layout
            ) %>% tagAppendAttributes(class="figTabPanel"),# end of figure tab panel---------
            
            #summary tabpanel------------------
            tabPanel(
              title = span("Summary", style = "font-weight:bold; font-family: 'Times New Roman',Times, Georgia, Serif, sans-serif; text-shadow:1px 4px 5px #C1BEBD;"),
              id = "statSummary",
              # icon=icon("list-alt"),
              div( class="summaryDiv",
                   #display the summary table of statistical computation
                   h3("Summary of data and statistical analysis", style = "text-align:center; font-weight:bold;"),
                   
                   #caption for data summary
                   helpText("Table 1. summary of the data", style = "margin-top:30px; margin-bottom:0; font-weight:bold; font-size:20px"),
                   #Ui for data summary
                   verbatimTextOutput("UiDataSummary"), #show summary of all the data
                   # textOutput("statSummaryText"),
                   
                   #Ui for parametric test
                   #Display normality and homogeneity test for parametric statistic
                   conditionalPanel(condition = "input.stat.includes('t.test')| input.stat.includes('anova')",
                                    #ui for testing the assumptions of parametric tests
                                    uiOutput("UiAssumptionTitle"),
                                    fluidRow(
                                      column(4,
                                             #ui for normality test
                                             plotOutput("UiResidualPlot"),
                                      ),
                                      
                                      column(4,
                                             #ui for homogeneity test
                                             plotOutput("UiNDensityPlot")
                                      ),
                                      
                                      column(4,
                                             #ui for normality test
                                             plotOutput("UiQqplot")
                                      )
                                    ),
                                    
                                    #caption: for normality and homoscedasticity
                                    uiOutput("UiTestCaption")
                                    
                                    
                   ),
                   
                   #ui for statistic summary
                   conditionalPanel(condition = "input.stat != 'none'",
                                    #caption
                                    uiOutput("UiStatSumCaption"),
                                    #sub caption for stat summary
                                    uiOutput("UiStatSubCaption"),
                                    #Ui for stat summary
                                    reactableOutput("UiStatSummaryTable",
                                                    width = '90%'),
                                    
                   ),
                   #ui for effect size
                   conditionalPanel(condition = "input.stat != 'anova' | input.stat != 'none'",
                                    #Ui caption
                                    uiOutput("UiCapEffectSize"),
                                    uiOutput("UiSubCapEffectSize"),
                                    
                                    #ui for effect size
                                    reactableOutput("UiEffectSize", width = '90%')
                                    
                   ),
                   #ui for post hoc test
                   conditionalPanel(condition = "input.stat=='Kruskal test'| input.stat=='anova'",
                                    uiOutput("UiPostHocCaption"),
                                    uiOutput("UiPostHoc")
                   )
              )#end of summary div
            ) %>% tagAppendAttributes(class= "summaryPanel")#end of summary tab panel
          )
          
        ) %>% tagAppendAttributes(class="analyzeTabBox") #end of tabBox
        
      ) %>% tagAppendAttributes(class="chartPanel"), #end Analyze & visualize
      
      #help panel----------------
      tabPanel(
        title = "Help", icon = icon("book-open"),
        # includeHTML("www/plotS.Rmd")
        includeMarkdown("www/plotS_help.Rmd")
      ) %>% tagAppendAttributes(class="helpPanel")#end of help section-----------------
    )
  )
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)