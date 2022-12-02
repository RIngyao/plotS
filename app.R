
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
      
      .header{
        overflow: hidden;
       /* background-image:linear-gradient(to bottom, rgba(69, 215, 250, 0.3), white);*/
        /*background-image:linear-gradient(70deg, white, rgba(69, 215, 250, 0.3), white);*/
        background-image:radial-gradient(rgba(12, 191, 227, 1), white, white);
        text-align:center;
      }
      
      .projectLogo{
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
      
      .projectLogo h1{
      text-align:center;
      color: #057C94 ; /*;0890AB*/
      font-weight:bold;
      font-size:37px;
      font-family:'Times New Roman', Times, serif, Arial, Helvetica, sans-serif;
      padding: 5% 0 0 10%;
      text-shadow:-7px 7px 1px #45D7FA, 2px 0 10px white;
      }
      
      /*Main body: it has 3 sections (column1, column2 and column3)*/
      .column{
      float: left;
      padding: 10px;
      text-color:black;
      }
      /*allocate space: middle column will occupy largest space*/
      .column1, .column3{
      width:15%;
      }
      .column2{
      align-items:center;
      width:70%;
      }
      /* Clear floats after the columns */
      .mainContent:after{
      content: '';
      display: table;
      clear: both;
      }
      /* Responsive layout*/
      @media screen and (max-width: 1600px) {
      .column2{
        width:100% !important;
      }
      .column1, .column3{
      display:none !important;
      }
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
      
      #chartBox > .tabbable > .nav {
      background-image:linear-gradient(white 50%, rgba(56, 168, 249, 0.3))
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
      overflow-y:auto;
      max-width: 1000px;
      margin-left: 10%;
      margin-right: 10%;
      margin-bottom: 50px;
      margin-top: 10px;
      min-height: 30px;
      box-shadow:none;
      border-top: solid;
      border-color:#025A9E;
      }
      #pShowTable, #pShowTransform{
      overflow-y:auto;
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
      max-width: 1000px;
      margin-left: 10%;
      margin-right:10%;
      min-height: 200px;
      border-top: solid;
      border-color:#3ABCF4;
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
      /*color:#F4F4F4;*/
      }
      
      .figureSidebarPanel{
      max-width:600px;
      }
      .figurePlotBox, .figureTheme{
      max-width: 800px;
      margin-left:10%;
      margin-right:10%;
      padding:auto;
      text-color:black;
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
      margin-bottom:15px;
      padding-top: 5px;
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
      display:flex;
      }
      
      .helpPanel{
      
      }
      
      
           ")
    )
  ), #end of css-----------------
  
  #header-------------
  # Application title
  div(class="header",
      div(
        class="projectLogo",
        tags$h1("PlotS")
      )
  ), 
  #main content------------
  div(
    class="mainContent",
    div(class = "column column1"
    ),
    div(class = "column column2",
        #all content will be put here
        
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
              #Data panel ---------------------
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
                                                helpText(list(tags$p("Use bar graph for categorical or count data!!"), tags$p("Users are encouraged to use other graph that show data distribution.")), style= "margin-bottom:10px; border-radius:10px; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
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
                                                                   #alert for welch and student test
                                                                   uiOutput("ttestMethodAlert")
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
                    
                    # end of sidbar
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
                    ) %>% tagAppendAttributes(class="figureMainPanel")#end mainpanel
                    
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
                       uiOutput("summaryDataCaption"),
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
                  )#end of summary div---------
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
        
    ),
    div(class = "column column3")
    
  )
)


#server------------------------
server <- function(input, output){
  
  #plot figures:-----------------
  #refresh button for different parameters to none-------------
  refresh_1 <- reactive({if(isTruthy(input$pInput) | isTruthy(input$transform) | isTruthy(input$pFile)) TRUE})
  refresh_2 <- reactive({
    #this will be used for parameters of more setting (color, stat, facet, etc)
    if(isTruthy(input$pInput) | isTruthy(input$transform) | isTruthy(input$pFile) | 
       isTruthy(input$plotType) | isTruthy(input$xAxis) | isTruthy(input$yAxis)) TRUE
  })
  refresh_3 <- reactive({if(isTruthy(input$pInput) | isTruthy(input$transform) | isTruthy(input$pFile) | 
                            isTruthy(input$plotType)) TRUE})
  refresh_afterColor <- reactive({if(isTruthy(input$colorSet)) TRUE})
  refresh_afterStat <- reactive({if(isTruthy(input$stat)) TRUE})
  #various input parameters--------------------------------
  
  #input option for uploading data
  output$pUpload <- renderUI(
    if(input$pInput == "upload data"){
      fileInput(inputId = "pFile", label = "Upload", placeholder = "csv/tsv/xlsx/rds/txt", accept = c(".csv",".tsv", ".txt",".xlsx",".rds"))
    }
  )
  
  observeEvent(req(input$pInput),
               
               output$UiReset <- renderUI(
                 if(input$pInput == "upload data") actionButton(inputId = "removeFile", label = "reset")
               )
  )
  observeEvent(req(input$removeFile), shinyjs::reset("pFile"))
  # observeEvent(req(input$pInput), shinyjs::reset("pFile"))
  
  #Get the input data for the plot
  
  #user's file path: reactive value so that user can change the file
  upPath <- reactive({
    if(req(input$pInput, cancelOutput = TRUE) == "upload data") req(input$pFile)
  })
  
  #This is the modified code for user's input table. 
  #I've use reactiveValues, just in case if required to convert the data to Null
  # This will be updated to manage replicates in the data
  uploadError <- 0 #for alerting error
  
  pInputTable_orig <- reactiveValues(data = reactive({
    # browser()
    #Choose the uploaded table or query result
    if(req(input$pInput, cancelOutput = TRUE) == "upload data"){
      #get the extension of the file
      ext <- tools::file_ext(upPath()$datapath)
      
      #alert and validate the file type
      output$UiUploadInvalid <- renderUI({
        if(!ext %in% c("csv","tsv","xlsx", "xls","rds", "txt") ){
          helpText(list(tags$p("Invalid file!!"), tags$p("Please upload a valid file: csv/tsv/txt/xlsx/xls/rds")), style= "color:red; text-align:center")
        }
      })
      shiny::validate(
        need(ext %in% c("csv","tsv","xlsx", "xls","rds", "txt"), "Please upload a valid file: csv/tsv/txt/xlsx/xls/rds")
      )
      
      tryCatch({
        #read the data
        pData <- switch(ext,
                        "csv" = fread(upPath()$datapath) %>% as.data.frame(),
                        "tsv" = fread(upPath()$datapaht) %>% as.data.frame(),
                        "txt" = fread(upPath()$datapaht) %>% as.data.frame(),
                        "xlsx" = read_excel(upPath()$datapath),
                        "xls" = read_excel(upPath()$datapath),
                        "rds" = readRDS(upPath()$datapath))
        uploadError <<- 0
        pData
      }, error = function(e){
        uploadError <<- 1
        # uploadErrorMessage <<- e
        print(e)
        validate(
          "Unable to load the file!"
        )
      })
      
      
    }else if (input$pInput == "query result"){
      #sepcify the result (the last query result will be chosen)
      #...........
      message("Implement later")
    }
    
  })
  )
  
  
  #signal the change of data-----------------
  oldData <- reactiveValues(df = NULL)
  oldPath <- reactiveValues(df = NULL)
  # dataChanged<- reactiveValues(df = NULL)
  
  dataChanged <- eventReactive( upPath()$datapath,{
    "
    Initial value will be null.
    If user change the data, than it will be TRUE, else FALSE.
    "
    req(oldData$df, pInputTable_orig$data())
    if(is_empty(oldData$df)){
      
      #No data: start of program
      oldData$df <- pInputTable_orig$data() 
      oldPath$df <- upPath()$datapath 
      NULL
    }else{
      
      if(nrow(pInputTable_orig$data()) == nrow(oldData$df) &&
         ncol(pInputTable_orig$data()) == ncol(oldData$df) &&
         colnames(pInputTable_orig$data()) == colnames(oldData$df) #&& oldPath$df == upPath()$dataPath
      ){
        
        #data remain unchanged 
        FALSE
      }else{
        
        #Data has changed
        oldData$df <<- pInputTable_orig$data() 
        oldPath$df <<- upPath()$datapath #reactive({upPath()$datapath})
        
        #reset all other data
        replicateData <<- reactiveValues(df=NULL)
        tidy_tb <<- reactiveValues(df = NULL)
        reshapeError <<- reactive(0)
        organizedSwitch(0)
        TRUE
      }
    }
  })
  
  
  #managing replicates----------------
  output$UiReplicatePresent <- renderUI({
    opts <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                 tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
    radioButtons(inputId = "replicatePresent", label = "Data with replicates/multiple headers", 
                 choiceNames = opts, choiceValues = c("no", "yes"), selected = "no", inline = TRUE
    )
  })
  
  observe({
    req(dataChanged())
    if(isTRUE(dataChanged())){ #!is.null(oldData$df) && 
      
      opts <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                   tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
      
      updateRadioButtons(inputId = "replicatePresent", label = "Data has replicates", 
                         choiceNames = opts, choiceValues = c("no", "yes"), selected = "no", inline = TRUE
      )
    }
  })
  
  observe({
    req(pInputTable_orig$data(), input$replicatePresent == "yes")
    output$UiHeaderNumber <- renderUI({
      if(isTruthy(input$pInput) &&  input$replicatePresent == "yes"){
        selectInput(inputId = "headerNumber", label = "Header", choices = 0:5, selected = 1)
        #Number of table's header
      }
    })
    
    # if(input$replicatePresent == "yes" && req(input$headerNumber) != 0){
    #   message(pInputTable$data)
    #   data <- pInputTable$data %>% as.data.frame()
    #   #it is expected that data with replicates will have more than one header
    #   nVar <- getDataVariable(x= data , nh = input$headerNumber, re=1)
    #   varTable <- getDataVariable(x= data, nh = input$headerNumber, re=2)
    # }else{
    #   #In case when data with replicates have only one header
    #   nVar <- 1
    #   varTable <- data.frame( number = (ncol(pInputTable$data) - 1) )
    # }
    # #Replicates: number of variables
    # output$UiDataVariables <- renderUI({
    #   # req(input$headerNumber)
    #   # browser()
    #   
    #   
    #   # nVar <- getDataVariable(x= pInputTable$data, nh = input$headerNumber, re=1)
    #   # varTable <- getDataVariable(x= pInputTable$data, nh = input$headerNumber, re=2)
    #   #
    #   
    #     message(varTable$number)
    #     selectInput(inputId = "dataVariables", label = "Group/variables", #Number of group/variables
    #                 choices = c(1:max(varTable$number)), selected = nVar)
    # })
    output$UiDataVariables <- renderUI({
      # req(input$headerNumber)
      # browser()
      if(input$replicatePresent == "yes" && req(as.numeric(input$headerNumber)) != 0){
        message(pInputTable$data)
        data <- pInputTable$data %>% as.data.frame()
        #it is expected that data with replicates will have more than one header
        nh <- as.numeric(input$headerNumber)
        nVar <- getDataVariable(x= data , nh = nh, re=1)
        varTable <- getDataVariable(x= data, nh = nh, re=2)
      }else{
        #In case when data with replicates have only one header
        nVar <- 1
        varTable <- data.frame( number = (ncol(pInputTable$data) - 1) )
      }
      
      # nVar <- getDataVariable(x= pInputTable$data, nh = input$headerNumber, re=1)
      # varTable <- getDataVariable(x= pInputTable$data, nh = input$headerNumber, re=2)
      #
      if(input$replicatePresent == "yes"){
        message(varTable$number)
        selectInput(inputId = "dataVariables", label = "Group/variables", #Number of group/variables
                    choices = c(1:max(varTable$number)), selected = nVar)
      }
    })
    
  })
  
  #replicates: column number of replicate
  output$UiVarNameRepCol <- renderUI({
    req(input$replicatePresent == "yes", input$dataVariables)
    #number of variables
    varNum <- reactive(paste0("Variable", seq_len(input$dataVariables)))
    map(varNum(), ~ fluidRow(
      column(5, textInput(inputId = .x, label = paste0(.x, " name"))),
      column(7, selectInput(inputId = paste0(.x,"R"), label = "Replicate columns", choices = seq_len(ncol(pInputTable$data)), multiple = TRUE))
    ))
  })
  #User choice for mean or median of replicates
  # output$UiReplicateStat <- renderUI({
  #   lst <- list(tags$span("Mean", style = "font-weight:bold; color:#0099e6"), 
  #               tags$span("Median", style = "font-weight:bold; color:#0099e6"))
  #   radioButtons(inputId = "replicateStat", label = "Compute", choiceNames = lst, choiceValues = c("mean", "median"), inline = TRUE)
  # })
  
  #action button to run the replicate parameters
  output$UiReplicateActionButton <- renderUI({
    #Button will be available only when all the parameters are filled
    req(pInputTable$data, input$headerNumber, input$dataVariables)
    varNum <- input$dataVariables
    #check whether name of all the variables has been provided or not
    gName <- all(
      unlist(
        map(1:varNum, ~ str_detect( 
          req( eval(str2expression(paste0("input$Variable",.x))) ), regex("[:alnum:]")
        ) )
      ) )
    
    #convert to numeric and check whether all the replicate columns have been selected
    # the above strategy does not work in selectInput, so run for loop
    rCol <- FALSE
    for (i in seq_len(varNum)){
      if( all(
        str_detect( 
          as.numeric(unlist( req( eval(str2expression(paste0("input$Variable",i,"R"))) ) )), regex("[:digit:]")
        ) 
      ) ){
        
        rCol <- TRUE
        
      }else{
        rCol <- FALSE
        break
      }
    }
    # rCol <- all(
    #             unlist(
    #               map(1:varNum, ~ str_detect(as.numeric(eval(str2expression(paste0("input$Group",.x,"R")))), regex("[:digit:]")) )
    #           ))
    if(isTRUE(gName) && isTRUE(rCol)){
      actionButton(inputId = "replicateActionButton", label = span("Apply", style="color:white; font-weight:bold"), width = '100%', class = "btn-primary")
    }
    
  })
  
  #notify the user to reshape the data after managing replicates
  observe({
    req(input$replicatePresent == "yes", isTruthy(input$replicateActionButton))
    
    output$UiAfterReplicate <- renderUI({
      if(input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)){
        helpText("Apply reshape after managing replicates (Recommended)", 
                 style = "margin-top:7px; margin-bottom:10px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
      }
      
    })
  })
  #error setting-------------------------------------------
  #Message to display for various type of errors
  #message to display for calculating replicates mean and median
  # value = 0, no error
  # value = 1, error occured, mostly unable to convert to numeric data type
  replicateError <- eventReactive( req(input$replicatePresent) == "no", { 0 }) #use this to provide error message
  reshapeError <- eventReactive( req(input$transform) == "No", { 0 }) #user must not combine numeric and character column
  #end of error setting------------------------------------
  
  #provide error message to the user
  observe({
    req(replicateError())
    output$UiReplicateError <- renderUI({
      message("replicaterrororrrrr")
      message(replicateError())
      if(isTruthy(input$replicateActionButton) && replicateError() == 1) helpText("Error: cannot convert to numeric. Provide correct header and replicate columns!!", style = "margin-top: 10px; font-size = 12; color:red; font-weight:bold")
    })
  })
  # output$UiReplicateError <- renderUI({
  #   req(isTruthy(input$replicateActionButton))
  #   if(req(input$replicatePresent) == "yes" && req(replicateError()) == 1) helpText("Error: cannot convert to numeric. Provide correct header and replicate columns!!", style = "margin-top: 10px; font-size = 12; color:red; font-weight:bold")
  # })
  
  #get the tidied data of replicates for each group------
  replicateData <- reactiveValues(df=NULL)
  
  #execute the below code every time user press action button
  observeEvent( req(isTruthy(input$replicateActionButton)), {
    
    req(input$replicatePresent == "yes", input$dataVariables)
    
    #main data
    data <- pInputTable$data %>% as.data.frame()
    #number of header
    headerNo <- reactive(as.numeric(input$headerNumber))
    #variables id 
    varId <- reactive(paste0("Variable", seq_len(input$dataVariables)))
    
    #get replicates detail from the user's input as list
    repDetails <- lapply(1:input$dataVariables, function(x) eval(str2expression(paste0("input$Variable",x,"R"))))
    #count the replicates for each group
    repCount <- lapply(repDetails, length)
    #make sure that the data has equal replicates for all the group
    output$UiReplicateError <- renderUI({
      if(any(repCount != repCount[[1]])){
        
        helpText("Variables have unequal replicates", style="color:red; ")
        validate("Variables have unequal replicates")
      }
    })
    validate(need(all(repCount == repCount[[1]]),"Variables have unequal replicates"))
    
    
    #unlist and convert to numeric
    repCol <- repDetails %>% unlist() %>% as.numeric()
    message(repCol)
    #separate data to replicate and non-replicate [if any (not all data will have variables other than replicates)]
    message("repl started")
    #no replicate data
    noRep_df <- data[, -repCol, drop=FALSE] 
    message(colnames(noRep_df))
    
    #dummy data frame to collect the replicates data after iteration and processing for each variable.
    mergeData <- data.frame()
    #stopwatch for processing columns other than replicates
    stp <- 0 # 0 to 1: 1 is to stop
    #for loop to tidy up the replicate for each group [[change code later]]
    for(i in seq_along(varId())){
      
      #name of variable given by the user
      colName <- eval(str2expression(paste0("input$Variable",i)))
      
      #replicates column for the given variable
      no <- eval(str2expression(paste0("input$Variable",i,"R")))
      #convert to numeric: replicate columns
      colNo <- as.numeric(no)
      #use trycatch()
      tryCatch({
        #run the tidy function
        rstat <- tidyReplicate(x=data, y = noRep_df, headerNo = 1:headerNo(),
                               colName= colName, colNo = colNo, stp=stp)
        stp <- 1
        message("hello rstat00000000000000000000000000000000")
        
        
        # meanOrMedian <<- stat() #this will be used in the table caption!!
        # message(meanOrMedian)
        # 
        
        message("000000000000000000000000helo")
        replicateError <<- reactive(0)
        
      }, error = function(e){ 
        
        replicateError <<- reactive(1)
        
        print(e)
        validate(
          need(replicateError() == 0, "Cannot convert to numeric. Provide correct header and replicate columns!!")
        )
      })
      
      #tidy the computed data.: output will have all the columns and computed stat
      #remove not necessary column
      rstat2 <- rstat %>% select(!starts_with("Replicate_"))
      
      if(is_empty(mergeData)){
        mergeData <- rstat2
      }else{
        #select only the necessary column and append to the data frame
        newDf <- rstat2 %>% select_if(is.numeric)
        mergeData <- cbind(mergeData, newDf)
      }
    }
    
    #save the final data for display
    replicateData$df <<- mergeData
    
  })
  
  
  #textOutput("textInputTable"),textOutput("textTransformTable"),
  #plot input table----------------------------
  output$textInputTable <- renderText({
    req(pInputTable$data)
    if(isTruthy(input$pInput)){
      "Input Table"
    }
  })
  #not require---------
  output$textTransformTable <- renderText({
    if(isTruthy(input$pInput) & input$transform == "Yes"){
      "Reshaped Table"
    }
  })
  #end not require----------------
  
  
  #js not require just for reference-----------------
  # observeEvent(req(pInputTable$data, input$replicatePresent), {
  #   if(input$replicatePresent == "yes"){
  #     # req(input$headerNumber)
  #     #Display the table without any header, so that user don't 
  #     # confused with the number of header in the table
  #     df_nproper <- pInputTable$data 
  #     #get number of columns 
  #     col_n <- ncol(df_nproper)
  #     #create empty header name
  #     names(df_nproper) <- c(rep(" ", col_n))
  #     
  #     headrN <- reactive(req(input$headerNumber))
  #     if( headrN() != 0 ){
  #       modes <- "multiple"
  #       selected <- 1:input$headerNumber
  #     }else{
  #       modes <- "none"
  #       selected <- NULL
  #     }
  #     #show the new table
  #     output$pShowTable <- renderDataTable({
  #       
  #       # message(c(eval(str2expression(paste0("input$Group",1:req(input$dataVariables),"R")))))
  #       datatable(
  #         df_nproper,
  #         selection = list(mode=modes, selected = selected, target= "row", 
  #                          selectable = selected, caption="Table 1: Input table")
  #       )
  #     })
  #     
  #   }else{
  #     
  #     output$pShowTable <- renderDataTable({
  #       datatable(
  #         pInputTable$data,
  #         selection = "single",
  #         caption="Table 1: Input table"
  #       )
  #     })
  #     # output$pShowTable <- renderReactable({
  #     #   reactable(pInputTable$data,highlight = TRUE, outlined = TRUE, compact = TRUE,
  #     #             wrap = FALSE, resizable = TRUE, defaultPageSize = 20)#,height = 850)
  #     # })
  #     
  #   }
  #   
  # })
  
  
  
  
  #update Reshape----------
  observe({
    # req(isTRUE(dataChanged()))
    if( isTRUE(dataChanged()) || (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton)) ){
      updateSelectInput(inputId = "transform", label = "Reshape the data", choices = list("No", "Yes"), selected = "No")
    }
  })
  
  
  #Reshape parameters
  #variables for reshape
  output$trName <- renderUI({
    req(pInputTable$data, input$transform == "Yes")
    
    if(req(input$replicatePresent) == "no"){
      if(input$transform == "Yes") varSelectInput(inputId = "variables", label = "Specify the column(s) to reshape", data = pInputTable$data, multiple = TRUE)
    }else if(req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)){
      if(input$transform == "Yes") varSelectInput(inputId = "variables", label = "Specify the column(s) to reshape", data = replicateData$df, multiple = TRUE)
    }
    
  }
  )
  
  #Name to be used as column name for the reshaped
  output$trValue <- renderUI({
    req(pInputTable$data, input$transform == "Yes")
    message("trValue")
    #this should be compulsory, so that user understand the transformation
    if(input$transform == "Yes") textInput(inputId = "enterName", label = "Enter a name for the reshaped column")
  })
  
  #Action for transforming the data
  output$trAction <- renderUI({
    req(input$pInput, 
        # !isEmpty(input$pFile), 
        #input$transform == "Yes",
        input$variables,
        isTruthy(input$enterName)
    )
    
    if(input$transform == "Yes") actionButton(inputId = "goAction", label = span("Reshape", style="color:white"), class = "btn-primary", width = "100%")
  })
  
  #tidy up the data and save the table
  # tidy_tb <- reactive({
  #   req(input$goAction)
  #   
  #   #selected column as variables
  #   cols <- pInputTable$data %>% dplyr::select(!!!input$variables) %>% colnames()
  #   
  #   #choosen name for the column
  #   name_col <- input$enterName
  #   
  #   #pivot the table as required
  #   pivot_longer(pInputTable$data,
  #                cols = as.character(cols),
  #                names_to = name_col)
  # }
  # )
  tidy_tb <- reactiveValues(df=NULL)
  
  #include the table from replicates in the final reshaped table, if data has replicates
  observeEvent(req(isTruthy(input$goAction)),{
    
    #choosen name for the reshaped column
    name_col <- input$enterName
    
    #reshape the data
    tryCatch({
      
      if( input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df) ){
        
        #data has replicates
        message("replicate calllll")
        df_replicate <- req(replicateData$df)
        #get the column names provided by the user for reshaping the data to pivot
        cols <- df_replicate %>% dplyr::select(!!!input$variables) %>% colnames()
        #pivot
        tidy_tb$df <- pivot_longer(df_replicate, cols = as.character(cols), names_to = name_col)
        
      }else{
        
        #data has no replicate
        message("reshape callll")
        #original data
        df <- pInputTable$data
        #selected column as variables
        cols <- df %>% dplyr::select(!!!input$variables) %>% colnames()
        
        message("reshape inside2")
        #pivot the table as required
        tidy_tb$df <<- pivot_longer(df,
                                    cols = as.character(cols),
                                    names_to = name_col)
        
      }
      
      #reshape completed 
      reshapedDone <<- "rehaped" #require for table caption
      message("reshape donessssss")
      reshapeError <<- reactive(0) #no error message
      
    }, error = function(e){
      
      message("wrong reshape")
      reshapeError <<- reactive(1) #error message to  be displayed to the user
      print(e)
      #message below is not that necessary
      #validate( "Error: duplicated names 'value'. Provide different name")
      # validate(reshapeError() == 0, "Error: duplicated names 'value'. Provide different name")
    }) #end of trycatch
    
  })
  
  #error message for reshape.
  # Mostly, when user try to combine numeric and character column
  observe({
    req(reshapeError())
    output$UiReshapeError <- renderUI({
      message(glue::glue("reshape rror value: {reshapeError()}"))
      if(isTruthy(input$goAction) && req(reshapeError()) == 1 ){
        helpText("Error: failed to reshape the column. Select different columns!",
                 style = "color:red; margin-bottom: 10px; font-weight:bold; font-size:12")
      }
    })
  })
  
  #reset the replicateData and reshape data
  observe({
    req(input$replicatePresent, input$transform)
    
    if( req(input$replicatePresent == "no") ){
      replicateData <<- reactiveValues(df=NULL)
    }
    
    if( req(input$transform == "No") || (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) ){
      #reshaped data has to be null, 
      # case 1: if reshape is reset to no
      # case 2: if user re-apply the replicate action button
      message("convert tidy to null")
      tidy_tb <<- reactiveValues(df=NULL)
    }
  })
  
  # tidy_tb <- eventReactive(req(input$goAction) ,{
  #   
  #   #selected column as variables
  #   cols <- pInputTable$data %>% dplyr::select(!!!input$variables) %>% colnames()
  #   
  #   #choosen name for the column
  #   name_col <- input$enterName
  #   
  #   #pivot the table as required
  #   pivot_longer(pInputTable$data,
  #                cols = as.character(cols),
  #                names_to = name_col)
  #   
  # })
  
  
  
  
  
  # observe({
  #   req(is.data.frame(ptable()), input$normStand != 'none')
  #   if(!is.null(replicateData$df) && is.null(tidy_tb$df)){
  #     #update the replicateData with the transformed data
  #     replicateData$df <- ptable()
  #   }else if( !is.null(tidy_tb$df) ){
  #     #update with the transformed data
  #     tidy_tb$df <- ptable()
  #   }else if(is.null(replicateData$df) && is.null(tidy_tb$df)){
  #     #if no replicate or reshape applied, than display the transformed data
  #     output$pShowTransform2 <- renderDataTable({ 
  #       if(input$normStand != "none"){
  #         datatable(ptable(), selection = "single", options = list(searching = FALSE),
  #                   caption = glue::glue("Table 2. {input$normStand} transformed table")) 
  #       }
  #       
  #     })
  #   }
  # })
  # observeEvent({ (isTruthy(input$replicateActionButton) && input$replicatePresent == "yes") || (isTruthy(input$goAction) && input$trasform == "Yes") }, {
  #   # observe({
  #   req(replicateError() == 0) #must not have error while calculating mean and median of replicates
  #   message("entering pshowtra")
  # 
  #   output$pShowTransform <- renderDataTable({
  #     message(glue::glue("transfo: {input$transform}"))
  #     message(glue::glue("truthygo: {!isTruthy(input$goAction)}"))
  #     message(glue::glue("tidy empty: {is_empty(tidy_tb$df)}"))
  #     # if( (!isTruthy(input$goAction) || is_empty(tidy_tb$df)) && (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton)) ){
  #     if( (is_empty(tidy_tb$df)) && (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton)) ){
  #       #display this only when replicate arangement is requested
  #       message("only replicate data shown")
  #       req(!is_empty(replicateData$df))
  #       tbl <- replicateData$df
  #     }else if( isTruthy(input$goAction) && req(input$transform) == "Yes" ){
  #       #display this when reshape is requested irrespective of presence or absence of replicates
  #       message("Only tidytb=============------")
  #       message(is_empty(tidy_tb$df))
  #       req(!is_empty(tidy_tb$df))
  #       tbl <- tidy_tb$df
  #     }
  # 
  #     if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) && (input$transform == "Yes" && isTruthy(input$goAction)) ){
  #       datatable(tbl, selection = "single",
  #                 caption = glue::glue("Table 2. reshaped table and {meanOrMedian} calculated from the replicates of the group/variables."))
  #     }else if(input$transform == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
  #       datatable(tbl, selection = "single",
  #                 caption = "Table 2. Reshaped table")
  #     }else if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) && ( input$transform == "No" || !isTruthy(input$goAction)) ){
  #       datatable(tbl, selection = "single",
  #                 caption = glue::glue("Table 2. table of {meanOrMedian} calculated from the replicates of the group/variables."))
  #     }
  #     # reactable(tbl,
  #     #           highlight = TRUE, outlined = TRUE, compact = TRUE,
  #     #           wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
  #   })
  # })
  # observeEvent(req(!is_empty(tidy_tb$df)),{
  #   
  #   output$pShowTransform <- renderReactable({
  #     
  #     reactable(tidy_tb$df,
  #               highlight = TRUE, outlined = TRUE, compact = TRUE,
  #               wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
  #   })
  # })
  # observeEvent(req(isTruthy(input$replicateActionButton)) || req(tidy_tb()),{
  #   output$pShowTransform <- renderReactable({
  # 
  #     if(input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !isTruthy(input$goAction)){ #!is_empty(replicateData$df) &&
  #       reactable(
  #         replicateData$df,
  #         highlight = TRUE, outlined = TRUE, compact = TRUE,
  #         wrap = FALSE, resizable = TRUE, defaultPageSize = 20
  #       )
  #     }else if(input$transform == "Yes" && isTruthy(input$goAction)){
  #       reactable(tidy_tb(),
  #                 highlight = TRUE, outlined = TRUE, compact = TRUE,
  #                 wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
  #     }
  #   })
  # })
  
  # observeEvent(
  #   req(isTruthy(input$replicateActionButton)),{
  #     output$pShowTransform <- renderReactable({
  # 
  #       if(input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df) && input$transform == "No"){
  #         reactable(
  #           replicateData$df,
  #           highlight = TRUE, outlined = TRUE, compact = TRUE,
  #           wrap = FALSE, resizable = TRUE, defaultPageSize = 20
  #         )
  #       }else if(input$transform == "Yes"){
  #         reactable(tidy_tb$df,
  #                   highlight = TRUE, outlined = TRUE, compact = TRUE,
  #                   wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
  #       }
  #     })
  #   })
  #data before transformation------------------
  bf_ptable <- reactive({
    #browser()
    message("ptable")
    req(refresh_1(), input$normalizeStandardize)
    if( input$pInput == "" || (input$pInput != "" & is.null(input$pFile)) ){
      message("still empty ptable")
      #This is require to avoid error message in the UI (more settings)
      #Those that depend of ptable() require data frame.
      ""
    }else if( (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)) && (req(input$transform) == "Yes" && isTruthy(input$goAction) && !is_empty(tidy_tb$df)) ){
      tidy_tb$df #reshape table with replicates rearrange
    }else if(req(input$transform) == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
      tidy_tb$df #reshaped table without replicates
      #previous and this data are derived from the same data name, but keep different not to confuse the usage
    }else if( (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton)) ){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
      replicateData$df #replicate table not requested for re-arrangement
    }else{
      #show the input table, if nothin apply
      message("no other available for ptable")
      pInputTable$data
    }
  })
  
  #normalization or standardization of data----------------------
  # output$UiNormStand <- renderUI({
  # 
  #   NS_methods <- list(Normalization= c("log2", "log10", "square-root", "box-cox"), Standardization = c("scale","") )
  #   selectInput(inputId = "normStand", label = "Transform y-axis",
  #               choices = c('none', NS_methods), selected = 'none')
  # 
  # })
  # 
  # conditionalPanel(condition = "input.normStand != 'box-cox'",
  #                  uiOutput("UiNsNumVar")
  # )
  # conditionalPanel(condition = "input.normStand == 'box-cox",
  #                  
  #                  fluidRow(
  #                    column(6, uiOutput("UiNsCatVar")),
  #                    column(6, uiOutput("UiNsNumVar"))
  #                  )
  # )
  
  #select variable to transform
  observe({
    req(is.data.frame(bf_ptable()), input$normalizeStandardize != 'none')
    
    
    output$UiNsNumVar <- renderUI({
      if(is.data.frame(bf_ptable()) && !input$normalizeStandardize %in% c("none","box-cox")){
        numVar <- allNumCharVar(checks="integer", data = bf_ptable())
        selectInput(inputId = "nsNumVar", label = "Variable to transform", choices = numVar)
      }
    })
    
    output$UiNsCatVar <- renderUI({
      if(is.data.frame(bf_ptable()) && input$normalizeStandardize == "box-cox"){
        numVar <- allNumCharVar(checks="character", data = bf_ptable())
        selectInput(inputId = "nsCatVar", label = "Categorical variable", choices = numVar)
      }
    })
    
    output$UiNsNumVar2 <- renderUI({
      if(is.data.frame(bf_ptable()) && input$normalizeStandardize == "box-cox"){
        numVar <- allNumCharVar(checks="integer", data = bf_ptable())
        selectInput(inputId = "nsNumVar2", label = "Numeric variable", choices = numVar)
      }
    })
    
    
  })
  #action button for transformation
  observe({
    req(is.data.frame(bf_ptable()), input$normalizeStandardize != 'none')
    output$UiNsActionButton <- renderUI({
      if( (!input$normalizeStandardize %in% c('box-cox', 'none') && isTruthy(input$nsNumVar)) || ( input$normalizeStandardize == 'box-cox' && (isTruthy(input$nsNumVar2) && isTruthy(input$nsCatVar)) ) ){
        actionButton(inputId = "nsActionButton", label = span("Apply", style="color:white; font-weight:bold"), width = '100%', class = "btn-primary" )
      }
    })
    
  })
  
  # ptable <- eventReactive({req(input$normStand)}, {
  #   if(input$normStand != 'none'){
  #     ns_ptable$df
  #   }else{
  #     ptable_ori()
  #   }
  # })
  
  #transform the data: normalize or standardize
  # step 1: transform y-axis
  # step 2: update ptable() by adding the transformed column, saved the 
  #         original data as well so that it can revert back to the original.
  # step 3: update variable of y-axis.
  
  ns_input <- reactive(input$normalizeStandardize)
  
  ns_ptable <- eventReactive(req(isTruthy(input$nsActionButton)), {
    #browser()
    if(ns_input() != 'none'){
      
      #get variables for transformation
      if(ns_input() == 'box-cox'){
        req(input$nsCatVar, input$nsNumVar2)
        cVar <- input$nsCatVar
        nVar <- input$nsNumVar2
      }else{
        req(input$nsNumVar)
        cVar <- NULL
        nVar <- input$nsNumVar
      }
      #transformed given numeric variable
      message("inside ns and table")
      message(head(bf_ptable()))
      
      ns_df <- ns_func(data = bf_ptable(), ns_method = ns_input(), x = cVar, y = nVar)
      message("transofrm done]]]]]]]]]]]]]]]]]")
      ns_df
    }
  })
  
  #Final data:---------------------
  # Includes all data before and/or after transformation
  # To be used for all further analysis
  ptable <- reactive({
    #browser()
    if(ns_input() == 'none'){
      #using the name 'variable' for column (x-axis) generate duplicate name error
      # while using T-test and wilcox-test. So, change the name to variables, if exists
      if(any(colnames(bf_ptable()) == 'variable')){
        dplyr::rename(bf_ptable(), variables = variable)
      }else{
        bf_ptable()
      }
      
    }else {
      if(isTruthy(input$nsActionButton)){
        req(ns_ptable()) #normalized and/or standardized table
        if(any(colnames(ns_ptable()) == 'variable')){
          dplyr::rename(ns_ptable(), variables = variable)
        }else{
          ns_ptable() #bf_ptable()
        }
        
      }else{
        
        if(any(colnames(bf_ptable()) == 'variable')){
          dplyr::rename(bf_ptable(), variables = variable)
        }else{
          bf_ptable()
        }
        
      }
    }
  })
  #end of final data---------------
  
  #create switch:
  # This will be used to display as table (below)
  # switch is required to add
  organizedSwitch <- reactiveVal(0) #update to 1 when transformation is applied
  # update the display of organized table
  observe({
    req(input$normalizeStandardize != 'none')
    if(req(isTruthy(input$nsActionButton))){
      organizedSwitch(1)
    }else{
      organizedSwitch(0)
    }
  })
  
  #update the original pInput table
  # Reason:
  #   1. Necessary to process the data according to the number of header in managing replicates
  #     or with more than one header
  # change in header number will trigger the processing
  updated_df <- reactiveVal(NULL)
  observe({
    req(pInputTable_orig$data(), input$replicatePresent == "yes" )
    
    if(input$replicatePresent == "yes" && req(input$headerNumber) > 0){
      df_nproper <- pInputTable_orig$data() %>% as.data.frame()
      
      #data has header
      #get all the header and add as row dataset
      # browser()
      #header name: vector
      message("greater than 0")
      realColN <- colnames(df_nproper) #header name
      message(realColN)
      if(as.numeric(input$headerNumber) > 1){
        #if user specified more than 1 header, than require more steps to process
        #get the data for the header from the row
        userColN <- df_nproper[1:as.numeric(input$headerNumber), ,drop=FALSE]
        
        #create one duplicate rows and append real colnames to it
        add_df <- df_nproper[1, ,drop=FALSE]
        message(head(add_df))
        df_nproper2 <- rbind(add_df, df_nproper)
        message(head(df_nproper2))
        #start appending
        df_nproper2[1,] <- realColN
        # df_nproper2[2:nrow(userColN)+1, ] <- userColN[1:nrow(userColN),]
        
        # add_df <- df_nproper[1:nrow(userColN)+1, ]
        # message(head(add_df))
        # df_nproper2 <- rbind(add_df, df_nproper)
        # message(head(df_nproper2))
        # #start appending
        # df_nproper2[1,] <- realColN
        # df_nproper2[2:nrow(userColN)+1, ] <- userColN[1:nrow(userColN),]
        
        message(head(df_nproper2))
      }else if(as.numeric(input$headerNumber) == 1){
        #for just one header: add the column name as header
        df_nproper2 <- rbind(df_nproper[1,], df_nproper) %>% as.data.frame()
        message(head(df_nproper2))
        message(str(realColN))
        message(realColN)
        message(df_nproper2[1, ])
        df_nproper2[1, ] <- realColN
      }
      
      #Note:R will add header if needed (not always)
      # check for addition of header by R: V1, V2, .....Vn
      # removed the header if present. 
      if( all( str_detect(df_nproper2[1,], regex("^V[:digit:]")) ) ){
        df_nproper2 <- df_nproper2[-1, ]
      }
      
      #update the oiginal input table
      updated_df(df_nproper2)
      message("\\\\\\\\\\\\\\\\\\\\\\\\")
      message(updated_df())
    }else{
      updated_df(pInputTable_orig$data())
    }
    
  })
  
  #Table to be used for input display and further analysis
  pInputTable <- reactiveValues(data = NULL)
  observe({
    req(pInputTable_orig$data(), input$replicatePresent, input$transform)
    
    if(input$replicatePresent == "yes" && !is.null(updated_df())){
      message(updated_df())
      pInputTable$data <- updated_df()
    }else{
      #original input table
      pInputTable$data <- pInputTable_orig$data()
    }
  })
  #Table: input and reshaped table---------------------------
  #if data is uploaded, then show the table
  observeEvent(req(pInputTable$data, input$replicatePresent), {
    if(input$replicatePresent == "yes"){
      #if replicate is present, then
      # Inlcude all the header in the row and 
      # display the table without any header, so that user don't 
      # confused with the number of header in the table
      df_nproper <- pInputTable$data 
      #get number of columns 
      col_n <- ncol(df_nproper)
      #create empty header name
      names(df_nproper) <- c(rep(" ", col_n))
      message(colnames(df_nproper))
      message("done df_nproper")
      #show the new table
      output$pShowTable <- renderDataTable({
        
        # message(c(eval(str2expression(paste0("input$Group",1:req(input$dataVariables),"R")))))
        if(req(input$headerNumber) != 0){
          #i
          datatable(
            as.data.frame(df_nproper),width = '10px',
            selection = list(mode="multiple", selected = 1:req(input$headerNumber), target= "row", selectable = 1:req(input$headerNumber)),
            options = list(searching = FALSE), caption="Table 1: Input table"
          ) #%>%formatRound(columns = 1:ncol(pInputTable$data))
        }else{
          datatable(
            df_nproper,
            selection = "single",
            options = list(searching = FALSE), caption="Table 1: Input table"
          ) #%>%formatRound(columns = 1:ncol(pInputTable$data))
        }
      })
      
    }else{
      
      output$pShowTable <- renderDataTable({
        datatable(
          pInputTable$data,
          selection = "single",
          options = list(searching = FALSE), caption="Table 1: Input table"
        ) #%>%formatRound(columns = 1:ncol(pInputTable$data))
      })
      # output$pShowTable <- renderReactable({
      #   reactable(pInputTable$data,highlight = TRUE, outlined = TRUE, compact = TRUE,
      #             wrap = FALSE, resizable = TRUE, defaultPageSize = 20)#,height = 850)
      # })
    }
  })
  
  #display the tidied or transformed table
  
  observe({ #req(!is_empty(tidy_tb$df) || !is_empty(replicateData$df)) #},{# (isTruthy(input$replicateActionButton) && input$replicatePresent == "yes") || (isTruthy(input$goAction) && input$trasform == "Yes") }, {
    # observe({
    req(input$replicatePresent, input$transform, replicateError() == 0, reshapeError() == 0, input$normalizeStandardize) #must not have error while calculating mean and median of replicates
    
    
    #for caption
    if( input$normalizeStandardize == 'none' || (input$normalizeStandardize != 'none' && !isTruthy(input$nsActionButton)) ){
      addCaption <- "."
    }else if(input$normalizeStandardize != 'none' && isTruthy(input$nsActionButton)){
      addCaption <- paste0(". Applied ", input$normalizeStandardize," transformation.")
    }
    
    #add caption to the table
    if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)) && (input$transform == "Yes" && isTruthy(input$goAction) && !is_empty(tidy_tb$df)) ){
      
      captions <- glue::glue("Table 2. Reshaped table{addCaption}")
      # if(meanOrMedian == 'mean'){
      #   # captions <- glue::glue("Table 2. reshaped table. 'value' column is the {meanOrMedian} and 'std_deviation' column is the standard deviation of the replicates{addCaption}")
      #   captions <- glue::glue("Table 2. reshaped table{addCaption}")
      # }else{
      #   # captions <- glue::glue("Table 2. reshaped table. 'value' column is the {meanOrMedian} and 'ma_deviation' column is the median absolute deviation of the replicates{addCaption}")
      #   
      # }
    }else if(input$transform == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
      captions <- glue::glue("Table 2. Reshaped table{addCaption}")
    }else if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) ){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
      #general table for replicate only
      df_display <- replicateData$df
      #get table caption
      captions <- glue::glue("Table 2. Re-arranged table for replicates")
      
      # if(meanOrMedian == "mean"){
      #   captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables. 'sd_*' column is the standard deviation (sd). {meanOrMedian} and sd are calculated from the replicates of the group{addCaption}")
      # }else{
      #   captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables. 'mad_*' column is the median absolute deviation (mad). {meanOrMedian} and mad are calculated from the replicates of the group{addCaption}")
      # }
      #end of only replicate 
    }else if(input$normalizeStandardize != "none" && isTruthy(input$nsActionButton)){
      #for normalization and standardization
      captions <- glue::glue("Table 2. {input$normalizeStandardize} transformed table.")
    }else{
      captions <- NULL
    }
    
    
    message("enter pshowtra")
    message(captions)
    #display the table
    output$pShowTransform <- renderDataTable({
      if(!is.null(captions)){
        datatable(ptable(), selection = "single", options = list(searching = FALSE),
                  caption = captions) #%>%formatRound(columns = 1:ncol(df_display))
      }
      
      
      # reactable(tbl,
      #           highlight = TRUE, outlined = TRUE, compact = TRUE,
      #           wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
    })
    
  })
  
  
  # observe({ #req(!is_empty(tidy_tb$df) || !is_empty(replicateData$df)) #},{# (isTruthy(input$replicateActionButton) && input$replicatePresent == "yes") || (isTruthy(input$goAction) && input$trasform == "Yes") }, {
  #   # observe({
  #   req(organizedSwitch(), input$replicatePresent, input$transform, replicateError() == 0, reshapeError() == 0) #must not have error while calculating mean and median of replicates
  #   df_display <- NULL
  #   if(organizedSwitch() == 0){
  #     #general table of reshape or replicate and reshape are applied.
  #     df_display <- tidy_tb$df
  #     #get caption
  #     if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)) && (input$transform == "Yes" && isTruthy(input$goAction) && !is_empty(tidy_tb$df)) ){
  #       req(meanOrMedian)
  #       if(meanOrMedian == 'mean'){
  #         captions <- glue::glue("Table 2. reshaped table. 'value' column is the {meanOrMedian} and 'std_deviation' column is the standard deviation of the replicates.")
  #       }else{
  #         captions <- glue::glue("Table 2. reshaped table. 'value' column is the {meanOrMedian} and 'ma_deviation' column is the median absolute deviation of the replicates.")
  #       }
  #     }else if(input$transform == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
  #       captions <- "Table 2. Reshaped table"
  #       
  #       
  #     }else if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) ){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
  #       req(meanOrMedian)
  #       #general table for replicate only
  #       df_display <- replicateData$df
  #       
  #       #get table caption
  #       if(meanOrMedian == "mean"){
  #         captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables. 'sd_*' column is the standard deviation (sd). {meanOrMedian} and sd are calculated from the replicates of the group.")
  #       }else{
  #         captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables. 'mad_*' column is the median absolute deviation (mad). {meanOrMedian} and mad are calculated from the replicates of the group.")
  #       }
  #       
  #     }#end of only replicate
  #     
  #     
  #     #end of pre-transformation 
  #   }else if(organizedSwitch() == 1){
  #     req(input$normalizeStandardize)
  #     #if transormation: normalization or standardization is applied
  #     # display ptable()
  #     # add transform message to the captions.
  #     df_display <- ptable()
  #     #transformed method
  #     ns_msg <- input$normalizeStandardize
  #     
  #     if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)) && (input$transform == "Yes" && isTruthy(input$goAction) && !is_empty(tidy_tb$df)) ){
  #       req(meanOrMedian)
  #       if(meanOrMedian == 'mean'){
  #         captions <- glue::glue("Table 2. reshaped and {ns_msg} transformed table. 'value' column is the {meanOrMedian} and 'std_deviation' column is the standard deviation of the replicates.")
  #       }else{
  #         captions <- glue::glue("Table 2. reshaped and {ns_msg} transformed table. 'value' column is the {meanOrMedian} and 'ma_deviation' column is the median absolute deviation of the replicates.")
  #       }
  #     }else if(input$transform == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
  #       captions <- glue::glue("Table 2. Reshaped and {ns_msg} transformed table")
  #       
  #       
  #     }else if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) ){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
  #       req(meanOrMedian)
  #       #get table caption
  #       if(meanOrMedian == "mean"){
  #         captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables and {ns_msg} transformed. 'sd_*' column is the standard deviation (sd). {meanOrMedian} and sd are calculated from the replicates of the group.")
  #       }else{
  #         captions <- glue::glue("Table 2. table of {meanOrMedian} for the given groups/variables and {ns_msg} transformed. 'mad_*' column is the median absolute deviation (mad). {meanOrMedian} and mad are calculated from the replicates of the group.")
  #       }
  #     }else{
  #       #display only the transform data
  #       captions <- glue::glue("Table 2. {ns_msg} transformed table.")
  #     }
  #     
  #   }#end of transformed
  #   
  #   message("enter pshowtra")
  #   #display the table
  #   output$pShowTransform <- renderDataTable({
  #     message(glue::glue("transfo: {input$transform}"))
  #     message(glue::glue("truthygo: {!isTruthy(input$goAction)}"))
  #     message(glue::glue("tidy empty: {is_empty(tidy_tb$df)}"))
  #     if(!is.null(df_display)){
  #       datatable(df_display, selection = "single", options = list(searching = FALSE),
  #                 caption = captions) #%>%formatRound(columns = 1:ncol(df_display))
  #     }
  #     
  #     
  #     # reactable(tbl,
  #     #           highlight = TRUE, outlined = TRUE, compact = TRUE,
  #     #           wrap = FALSE, resizable = TRUE, defaultPageSize = 20)
  #   })
  #   
  # })
  #end of input and transformed table------------------------
  # observeEvent(req(isTruthy(input$nsActionButton)), {
  #   message(glue::glue("ns counter: {ns_counter}"))
  #   message(glue::glue("head original: {head(original_ptable())}"))
  #   if(input$normalizeStandardize != "none"){
  #     message("entering transform--")
  #     if(ns_counter != 0){
  #       message("counter not 0")
  #       #use the original ptable
  #       ptable <<- reactive(original_ptable())
  #     }
  #     message("after counter check2")
  #     
  #     #get the variables
  #     if(ns_input() == 'box-cox'){
  #       req(input$nsCatVar, input$nsNumVar2)
  #       cVar <- input$nsCatVar
  #       nVar <- input$nsNumVar
  #     }else{
  #       req(input$nsNumVar)
  #       cVar <- NULL
  #       nVar <- input$nsNumVar
  #     }
  #     #increase the counter before transformation
  #     ns_counter <<- 1
  #     
  #     #transformed y-axis
  #     ns_df <- ns_func(data = ptable(), ns_method = input$normalizeStandardize, x = cVar, y = nVar)
  #     message("transofrm done]]]]]]]]]]]]]]]]]")
  #     #update ptable()
  #     ptable <<- reactive(ns_df)
  #     
  #     message("done transform")
  #   }else if(input$normalizeStandardize == "none" && ns_counter == 1){
  #     message("ns_counter is 0")
  #     message(colnames(original_ptable()))
  #     #reset ptable to original
  #     ptable <<- reactive(original_ptable())
  #     message(head(ptable()))
  #     message(colnames(ptable()))
  #     
  #     #reset counter to 0
  #     ns_counter <<- 0
  #   }
  #   
  # })
  
  
  
  
  #update y-axis if normalization or standardization is on----------
  # observe({
  #   req(is.data.frame(ptable()), pltType() != 'none',  input$normStand != 'none')
  #   updateSelectInput(inputId = "yAxis", label = "Y-axis", choices = colnames(ptable()), selected = selCol)
  # })
  
  
  
  # ptable <- reactive({
  #   message("ptable")
  #   req(refresh_1())
  #   if( input$pInput == "" || (input$pInput != "" & is.null(input$pFile)) ){
  #     message("still empty ptable")
  #     #This is require to avoid error message in the UI (more settings)
  #     #Those that depend of ptable() require data frame.
  #     ""
  #   }else if( is_empty(tidy_tb$df) && !is_empty(replicateData$df)){
  #     #if reshape is not applied
  #     message("only replicate data for ptable")
  #     replicateData$df
  # 
  #   }else if( !is_empty(tidy_tb$df) ){
  #     #if reshape is applied
  #    message("tidy data is not empty")
  #      tidy_tb$df
  # 
  #   }else{
  #     #show the input table, if nothin apply
  #     message("no other available for ptable")
  #     pInputTable$data
  #   }
  # })
  
  # ptable <- reactive({
  #   message("ptable")
  #   req(refresh_1())
  #   if(input$pInput == ""){
  #     #This is require to avoid error message in the UI (more settings)
  #     ""
  #   }else if(input$pInput != "" & is.null(input$pFile)){
  #     ""
  #   }
  #   else if(input$pInput != "" &
  #           req(input$transform) == "Yes" &
  #           isTruthy(input$enterName) &
  #           isTruthy(input$goAction)){
  #     message("yes")
  #     req(input$variables, cancelOutput = TRUE)
  #     tidy_tb$df
  #   } else if(input$pInput != "" & req(input$transform) == "No"){
  #     message("no")
  #     if(is.null(pInputTable$data)){
  #       #Not yet implemented: this may require if I want to delete the cached data (reset the uploaded file)
  #       ""
  #     }else{
  #       pInputTable$data
  #     }
  #   }
  # })
  
  
  #plot choice for different--------------------------
  planPlotList <- c("none", "box","bar", "histogram", "scatter plot",
                    "density plot", "heatmap", "line", "frequency polygon",
                    "violin","jitter","area", "pie chart", "venn", "upset", "tile")
  plotList <- c("box","Violine plot", "density", "frequency polygon", "histogram","line", "scatter", "bar")
  
  output$UiPlotType <- renderUI({
    req(refresh_1())
    #requires to add check so that user can change the data without crashing the app
    
    selectInput(inputId = "plotType", label = "Choose type of plot",
                choices = c("none",sort(plotList)), selected = "none")
    
  })
  #update plot
  observe({
    req(input$replicatePresent, input$transform)
    if( isTRUE(dataChanged()) || isTruthy(input$replicateActionButton) || isTruthy(input$goAction) ) {
      updateSelectInput(inputId = "plotType", label = "Choose type of plot",
                        choices = c("none",sort(plotList)), selected = "none")
    }
  })
  #update plot -----------------------------------------
  # oldData <- reactive({
  #   req(pltType() != "none", input$xAxis)
  #   message(glue::glue("old file: {input$pFile$datapath}"))
  #   input$pFile$datapath
  # })
  # observe({
  #   # if(!is.null(input$pFile$datapath) && is.null(oldData())){
  #   #   updateSelectInput(inputId = "plotType", label = "Choose type of plot",
  #   #                     choices = c("none",sort(plotList)), selected = "none")
  #   # }else 
  #   message(glue::glue("old file: {oldData()}"))
  #   message(glue::glue("new file: {input$pFile$datapath}"))
  #   if (!is.null(input$pFile$datapath) && input$pFile$datapath != oldData()){
  #     updateSelectInput(inputId = "plotType", label = "Choose type of plot",
  #                       choices = c("none",sort(plotList)), selected = "none")
  #   }
  # })
  #reactive plot type
  pltType <- reactive({
    req(refresh_1())
    input$plotType
  })
  # #additional parameter for histogram
  # output$UiHistParam <- renderUI({
  #   req(pltType())
  #   if(pltType() %in% c("histogram")){
  #     radioButtons(inputId = "countIdentity", label = NULL, choices = c("count", "use the value as is" ))
  #   }
  # })
  # 
  #set x- and/or y-axis-----------------------
  #plot that require x and y-axis
  # xyRequire <- c("box", "Violine plot", "bar", "line", "scatter") 
  
  #get x- and/or y-axis based on the type of plot
  needYAxis <-reactive({
    #check for requirement of y axis for histogram 
    req(pltType())
    if(pltType() == "histogram"){
      FALSE
    }
  })
  
  
  observe({ 
    req(refresh_3(),  is.data.frame(ptable()), pltType() != "none") #empty input or upload will have string, not data frame
    #display x-axis option: will be used for all types of plot
    #selected variable
    
    if(pltType() %in% c("scatter", "line")){
      var <- selectedVar2(data = ptable(), "integer")
    }else{
      var <- selectedVar(data = ptable()) 
    }
    message("x ptable value")
    message(glue::glue("for x: {head(ptable())}"))
    output$xAxisUi <- renderUI({
      message(glue::glue("xVar: {var}"))
      if(pltType() != "none") selectInput(inputId = "xAxis", label = "X-axis", choices = colnames(ptable()), selected = var)
    })
    
    #selected variable for y-axis
    if(pltType() == "line"){
      varC <- selectedVar2(data = ptable(), check = "integer", index = 2)
    }else{
      varC <- selectedVar2(data = ptable(), check = "integer", index = 2)
    } 
    #y-axis
    output$yAxisUi <- renderUI({
      if(req(pltType() %in% xyRequire || isTRUE(needYAxis()))){
        message(glue::glue("varC: {varC}"))
        selectInput(inputId = "yAxis", label = "Y-axis", choices = colnames(ptable()), selected = varC)
      }
    })
  })
  
  
  # observeEvent({ req(pltType() != "none", refresh_3(), is.data.frame(ptable())) },{ #empty input or upload will have string, not data frame
  #   #display x-axis option: will be used for all types of plot
  #   #selected variable
  #   if(pltType() != "none"){
  #     if(pltType() %in% c("frequency polygon", "histogram", "line", "density")){
  #       var <- selectedVar2(data = ptable(), "numeric")
  #     }else{
  #       var <- selectedVar(data = ptable()) 
  #     }
  #     
  #     
  #     output$xAxisUi <- renderUI({
  #       req(pltType() != "none")
  #       message(glue::glue("xVar: {var}"))
  #       if(pltType() != "none"){
  #         selectInput(inputId = "xAxis", label = "X-axis", choices = colnames(ptable()), selected = var)
  #       }
  #     })
  #     
  #     #selected variable for y-axis
  #     varC <- ifelse(pltType() == "line", selectedVar2(data = ptable(), check = "numeric", index = 2), selectedVar2(data = ptable(), check = "numeric"))
  #     #y-axis for box
  #     output$yAxisUi <- renderUI({
  #       req(pltType() != "none")
  #       # if(pltType() %in% c("box", "line", "scatter") || (pltType() == "histogram" & req(input$countIdentity) != "count")){
  #       if(pltType() %in% xyRequire || isTRUE(needYAxis())){
  #         selectInput(inputId = "yAxis", label = "Y-axis", choices = colnames(ptable()), selected = varC)
  #       }
  #     })
  #   }
  # })
  #get the selected variables of axes from the data
  xVar <- reactive({
    req(is.data.frame(ptable()), pltType() != "none", input$xAxis)#, cancelOutput = FALSE)
    if(input$xAxis %in% colnames(ptable())){
      ptable() %>% dplyr::select(.data[[input$xAxis]]) 
    }
  })
  
  yVar <- reactive({
    req(refresh_3(), is.data.frame(ptable()),  pltType() != "none", input$yAxis)#pltType() %in% xyRequire || isTRUE(needYAxis()), , cancelOutput = FALSE)
    if(input$yAxis %in% colnames(ptable())){
      ptable() %>% dplyr::select(.data[[input$yAxis]]) 
    }
  })
  # yVar <- reactive({
  #   req(refresh_3(), ptable(), pltType() %in% xyRequire || isTRUE(needYAxis), input$yAxis)#, cancelOutput = FALSE)
  #   if(input$yAxis %in% colnames(ptable())) {
  #     ptable() %>% dplyr::select(.data[[input$yAxis]])
  #     }
  # })
  
  # xVar <- reactive({
  #   req(refresh_3(), ptable(), pltType() != "none", input$xAxis)#, cancelOutput = FALSE)
  #   ptable() %>% dplyr::select(.data[[input$xAxis]])
  #   })
  # yVar <- reactive({
  #   req(refresh_3(), ptable(), pltType() != "none", input$yAxis)#, cancelOutput = FALSE)
  #   ptable() %>% dplyr::select(.data[[input$yAxis]])
  # })
  #data type of the selected axes variable
  xVarType <- reactive({
    req(pltType() != 'none', xVar())
    sapply(xVar(), class)
  })
  yVarType <- reactive({
    req(pltType() != 'none', yVar())
    sapply(yVar(), class)
  })
  
  #labelling and adjusting size of axis
  observe({
    req(is.data.frame(ptable()))
    output$uiTextSize <- renderUI({if( req(input$plotType) != "none" ) sliderInput(inputId = "textSize", label = "Axis text font size", min = 10, max = 30, value = 15)})
    output$uiTitleSize <- renderUI({if( req(input$plotType) != "none" ) sliderInput(inputId = "titleSize", label = "Axis title font size", min = 10, max = 50, value = 15)})
    output$uiYlable <- renderUI({if( req(input$plotType) != "none" )textAreaInput(inputId = "yLable", label = "Enter title for Y-axis", height = "35px")})
    output$uiXlable <- renderUI({if( req(input$plotType) != "none" )textAreaInput(inputId = "xLable", label = "Enter title for X-axis", height = "35px")})
    output$uiBinWidth <- renderUI({
      req(refresh_3(),input$plotType, xVarType())
      # xVar <- ptable() %>% dplyr::select(.data[[input$xAxis]])
      #if(input$plotType == "histogram" & type(xVar[1]) == "double") sliderInput(inputId = "binWidth", label = "Adjust bin width", min = 0.01, max = 100, value = 30)
      if(input$plotType %in% c("histogram", "frequency polygon") & xVarType()[1] %in% c("integer", "numeric", "double")) sliderInput(inputId = "binWidth", label = "Adjust bin width", min = 0.01, max = 100, value = 30)
    })
  })
  #Bar graph settings---------------------
  output$UiStackDodge <- renderUI({
    #Bar plot and histogram will have this option
    #this will be updated when user request for error bar in bar plot, but not for histogram
    req(refresh_3(), pltType(), xVar())
    choices <- list(tags$span("Stack", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
    if(pltType() %in% c("bar", "histogram")){
      radioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Stack", "Dodge"), inline = TRUE)
    }
    # if(pltType() == "bar" && !isTruthy(input$lineErrorBar) && !isTruthy(input$lineGroupVar)){
    #   radioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Stack", "Dodge"), inline = TRUE)
    # }else if(pltType() == "bar" && isTruthy(input$lineErrorBar) && isTruthy(input$lineGroupVar)){
    #   #updating the option for position 
    #   choice <- list(tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
    #   radioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choice, choiceValues = "dodge")
    # }
  })
  
  
  
  #Line graph settings---------------
  # #show option to connect the path within: check below
  # output$UiLineConnectPath <- renderUI({
  #   req(refresh_3(), ptable(), pltType() != "none")
  #   # req(ptable(), pltType() == "line", isTruthy(input$lineErrorBar), input$lineComputeSd)
  #   if(pltType() == "line") selectInput(inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(ptable())), selected = "none")
  # })
  # show option to connect the path within 
  output$UiLineConnectPath <- renderUI({
    req(refresh_3(), ptable(), yVar() )
    # req(ptable(), pltType() == "line", isTruthy(input$lineErrorBar), input$lineComputeSd)
    col <- colnames(ptable())
    varC <- colnames( ptable()[ ,!col %in% colnames(yVar()) ] )
    if(req(pltType()) == "line" && (isTruthy(xVar())|| isTruthy(yVar())) ) selectInput(inputId = "lineConnectPath", label = "Connect the line", choices = c("none", varC), selected = "none")
  })
  
  # coln <- colnames(ToothGrowth)
  # colnames(ToothGrowth[, !coln %in% 'len'])
  
  #add error bar
  output$UiLineErrorBar <- renderUI({
    req(refresh_3(), pltType() != "none")
    if(pltType() %in% c("line", "bar", "scatter") && (isTruthy(xVar())|| isTruthy(yVar())) ) checkboxInput(inputId = "lineErrorBar", label = tags$span("Add error bar", style = "color:#b30000; font-weight:bold; background:#f7f3f3"))
  })
  
  observe({
    req(is.data.frame(ptable()), isTruthy(input$lineErrorBar))
    
    output$UiErrorBarStat <- renderUI({
      if(is.data.frame(ptable()) && pltType() %in% c("line", "bar", "scatter") && isTruthy(input$lineErrorBar)){
        li <- list(`Inferential error bar` = c("Confidence interval (CI)","Standard error (SE)"), `Descriptive error bar` = c("Standard deviation (SD)", ""))
        selectInput(inputId = "errorBarStat", label = "Calculate", choices = li, selected = "Standard error")
      }
    })
    
  })
  #update lineconnectpath when error bar is active and color is set
  # observe({
  #   req(pltType() == "line", isTruthy(input$lineErrorBar), input$colorSet)
  #   
  #   initialVar <- input$lineConnectPath
  #   
  #   if(pltType() == "line" && isTruthy(input$lineErrorBar) && (input$colorSet == "none" || !isTruthy(input$shapeLine)) ){
  #     
  #     if(initialVar != "none" && initialVar %in% colnames(xVar()) ){
  #       sel <- initialVar
  #     }else{
  #       sel <- "none"
  #     }
  #     updateSelectInput( inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(xVar())), selected = sel )
  #   }else if( pltType() == "line" && isTruthy(input$lineErrorBar) && input$colorSet != "none" ){
  #     
  #     if(initialVar != "none" && initialVar %in% c(colnames(xVar()), input$colorSet)){
  #       sel <- initialVar
  #     }else{
  #       sel <- "none"
  #     }
  #     updateSelectInput( inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(ptable()), input$colorSet), selected = sel )
  #   }else if(pltType() == "line" && isTruthy(input$lineErrorBar) && input$colorSet == "none" && isTruthy(input$shapeLine) ){
  #     if(input$shapeLine == "shapeSet"){
  #       if(initialVar != "none" && initialVar %in% c(colnames(xVar()), input$shapeSet)){
  #         sel <- initialVar
  #       }else{
  #         sel <- "none"
  #       }
  #       updateSelectInput( inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(ptable()), input$shapeSet), selected = sel )
  #     }else if(input$shapeLine == "lineSet"){
  #       if(initialVar != "none" && initialVar %in% c(colnames(xVar()), input$lineSet)){
  #         sel <- initialVar
  #       }else{
  #         sel <- "none"
  #       }
  #       updateSelectInput( inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(ptable()), input$lineSet), selected = sel )
  #     }
  #   }
  # })
  
  #Option for the user to used computed sd or to compute sd
  output$UilineComputeSd <- renderUI({
    req(refresh_3(), pltType() != "none", input$errorBarStat)
    if(pltType() %in% c("line", "bar", "scatter") & req(isTruthy(input$lineErrorBar))){
      choic <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
      
      if(input$errorBarStat == "Standard error"){
        radioButtons(inputId = "lineComputeSd", label = "Calculate SE?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
      }else if(input$errorBarStat == 'Standard deviation'){
        radioButtons(inputId = "lineComputeSd", label = "Calculate SD?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
      }else{
        radioButtons(inputId = "lineComputeSd", label = "Calculate CI?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
      }
      
    }
  })
  #display error message for SD
  sdError <- 0
  observe({
    req(input$lineErrorBar, input$lineComputeSd == "yes")
    if(input$lineComputeSd == "yes" && sdError == 1){
      helpText("Require samples with more than one value. Data has zero SD.")
    }
    sdError <<- 0
  })
  
  
  #compute by grouping variables
  output$UiLineGroupVar <- renderUI({
    req(refresh_3())
    req(ptable(), pltType() %in% c("line", "bar", "scatter"), isTruthy(input$lineErrorBar), input$lineComputeSd)
    
    col <- ptable()[colnames(ptable()) != colnames(yVar())]
    if(input$lineComputeSd == "no"){
      #if user want to specify the column for already computed SD
      c("Confidence interval (CI)", "Standard deviation (SD)", "Standard error (SE)")
      if(input$errorBarStat == "Confidence interval (CI)"){
        las <- "Specify the CI column"
      }else if(input$errorBarStat == "Standard deviation (SD)"){
        las <- "Specify the SD column"
      }else{
        las <- "Specify the SE column"
      }
      selectInput(inputId = "lineGroupVar", label = las,
                  choices = colnames(col),  multiple = TRUE) #selected = var2,
    }
  })
  
  #change the variables option for x axis if compute is YES in line and bar graph
  lineComputeSd <- reactive({req(input$lineComputeSd)})
  
  #color option for error bar
  
  output$UiErrorBarColor <- renderUI({
    if(req(pltType() %in% c("line", "bar", "scatter")) && req(isTruthy(input$lineErrorBar)) ){
      selectInput( inputId = "errorBarColor", label = "Error bar color", choices = sort(c("black", "red", "blue", "green")) )
    }
  })
  # addErrorBarTruthy <- reactive({ifelse(isTruthy(input$lineErrorBar), TRUE, FALSE)})
  # lineGroupVar <- reactive({if(isTruthy(input$lineGroupVar)) input$lineGroupVar})
  #can't refresh xVarChoice (given below)
  # lineBar <- reactive({
  #   req(addErrorBarTruthy())
  #   if(pltType() == "line" && isTRUE(addErrorBarTruthy())){
  #     "line"
  #   }else if(pltType() == "bar" && isTRUE(addErrorBarTruthy())){
  #     "bar"
  #   }
  # })
  #variable to update the variable of x-axis
  xVarChoice <- reactive({
    req(refresh_3(), pltType() %in% c("line", "bar"), ptable()) 
    if(isTruthy(input$lineErrorBar) && lineComputeSd() == "no"){
      c("none",colnames(ptable()))
    }else if(isTruthy(input$lineErrorBar) && lineComputeSd() == "yes"){
      if(!isTruthy(input$lineGroupVar)){
        #even if compute sd is selected, but no variables are chosen for computation, than show
        #the original column name
        c("none",colnames(ptable()))
      }else{
        input$lineGroupVar  
      }
    }else{
      #default choice
      c("none", colnames(ptable()))
    }
  })
  
  # #update the option to connect the path within : some issue
  # observeEvent(req(pltType() == "line", lineComputeSd()),{
  #   if(lineComputeSd() == "yes") updateSelectInput(inputId = "lineConnectPath", label = "Connect the line within", choices = xVarChoice(),
  #                                                  #select the second variable if sd is calculated
  #                                                  selected = ifelse(length(colnames(ptable()))+1 == length(xVarChoice()), xVarChoice()[1], xVarChoice()[2]))
  # })
  
  
  #Update the x-axis for line and bar graph if SD is calculated
  # observe({
  #   req(refresh_3())
  #   # if(pltType() == "line" && lineComputeSd() == "yes" && isTruthy(input$lineGroupVar)){
  #   if(pltType() %in% c("line","bar") && isTRUE(addErrorBarTruthy())  && lineComputeSd() == "yes" && isTruthy(lineGroupVar())){
  #     #updating x-axis
  #     var <- input$xAxis #original x variable
  #     xVar <- if(length(xVarChoice()) == 1){
  #               #user has choosen one variable for grouping
  #               xVarChoice()
  #             }else if(length(xVarChoice()) > 1){
  #               if(var %in% xVarChoice()){
  #                 var
  #               }else{
  #                 xVarChoice()[1]
  #               }
  #             }
  #     updateSelectInput(inputId = "xAxis", label = "X-axis", choices = xVarChoice(), selected = xVar) 
  #   }
  # })
  
  observe({
    req(refresh_3(), pltType() %in% c("line","bar"))
    # if(pltType() == "line" && lineComputeSd() == "yes" && isTruthy(input$lineGroupVar)){
    if(isTruthy(input$lineErrorBar) && isTruthy(input$lineGroupVar)){
      #updating x-axis
      var <- input$xAxis #original x variable
      xSel <- if(length(xVarChoice()) == 1){
        #user has choosen one variable for grouping
        xVarChoice()
      }else if(length(xVarChoice()) > 1){
        if(var %in% xVarChoice()){
          var
        }else{
          xVarChoice()[1]
        }
      }
      updateSelectInput(inputId = "xAxis", label = "X-axis", choices = xVarChoice(), selected = xSel) 
    }
    # else{
    #   #return to the original status
    #   #selected variable
    #   updateSelectInput(inputId = "xAxis", label = "X-axis", choices = colnames(ptable()), selected = input$xAxis)
    # }
  })
  
  
  #Update the lineConnectPath for line. 
  # observe({
  #   req(refresh_3(), pltType() %in% c("line"))
  #   #if sd is computed, list of variables for lineConnectPath will be the same as x-axis
  #   if(isTruthy(input$lineErrorBar) && isTruthy(input$lineGroupVar)){
  #     #updating lineConnectPath
  #     lo <- input$lineConnectPath #original variable
  #     lVar <- if(length(xVarChoice()) == 1){
  #       #user has choosen one variable for grouping
  #       xVarChoice()
  #     }else if(length(xVarChoice()) > 1){
  #       if(lo %in% xVarChoice()){
  #         lo
  #       }else{
  #         xVarChoice()[1]
  #       }
  #     }
  #     updateSelectInput(inputId = "lineConnectPath", label = "Connect the line within", choices = xVarChoice(), selected = lVar)
  #   }else{
  #     #return to the original status
  #     # sel <- input$lineConnectPath
  #     updateSelectInput(inputId = "lineConnectPath", label = "Connect the line within", choices = c("none", colnames(ptable())))
  #   }
  #   
  # })
  
  
  # #Option for the user to used computed sd or to compute sd
  # output$UilineComputeSd <- renderUI({
  #   req(refresh_3(), pltType() != "none")
  #   if(pltType() %in% c("line", "bar") & req(isTruthy(input$lineErrorBar))){
  #     selectInput(inputId = "lineComputeSd", label = "Calculate standard deviation (sd)?", choices = c("yes","no"), selected = "no")
  #   }
  # })
  
  #update stackDodge for bar plot
  # Only 'Dodge' option, if
  # case 1: stat is applied.
  # case 2: error bar and aesthetic is applied - only if aesthetic variable is different from x-axis
  observe({
    req(is.data.frame(ptable()), pltType() =="bar", xVar(), input$colorSet, input$stat)
    
    choices <- list(tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
    choices2 <- list(tags$span("Stack", style = "font-weight:bold; color:#0099e6"), 
                     tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
    
    if(    #case 1
      input$stat != 'none'
    ){
      
      updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
      
      
    }else if(   #case 2 : color on
      (isTruthy(input$lineErrorBar) && !input$colorSet %in% c('none', colnames(xVar())))
    ){
      
      updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
      
    }else if(
      #case 2 :shapeLine on
      (isTruthy(input$lineErrorBar) && input$colorSet == 'none' && isTruthy(input$shapeLine))
    ){
      
      if( input$shapeLine == "Shape" && (!req(input$shapeSet) %in% c("none", colnames(xVar()))) ){
        updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
      }else if( input$ShapeLine == "Line type" && ( !req(input$lineSet) %in% c("none", colnames(xVar())) ) ){
        updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
      }else{
        #reset to original condition
        updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
      }
      
      
    }else{
      
      #reset to original condition
      updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
      
    }
    
  })
  
  #   if( #case 1 : color on
  #     (req(isTruthy(input$lineErrorBar)) && !input$colorSet %in% c('none', colnames(xVar())) && !isTruthy(input$shapeLine) )||
  #       #case 2
  #       ( input$stat != 'none' )
  #     ){
  #         
  #     updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
  #   }else if(
  #     #shapeLine on , color off
  #     req(isTruthy(input$lineErrorBar)) && input$colorSet == "none" && isTruthy(input$shapeLine) && input$stat != "none"
  #   ){
  #     
  #     if(req(input$shapeLine) == "Shape"){
  #       #case 2
  #       if(! req(input$shapeSet) %in% c("none", colnames(xVar()))){ 
  #         updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge")) 
  #       }else{
  #         updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
  #       }
  #       
  #     }else if(input$shapeSet == "Line type"){
  #       #case 2
  #       if(!req(input$lineSet) %in% c("none", colnames(xVar()))){
  #         updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge")) 
  #       }else{
  #         updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
  #       }
  #     }
  #     
  #     
  #   }else{
  #     
  #     updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
  #   }
  
  # observe({
  #   
  #   req(pltType() =="bar", xVar(), input$colorSet, input$stat)
  #   
  #   choices <- list(tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
  #   if( pltType() %in% c("bar", "histogram") ){
  #     
  #     if( !req(input$colorSet) %in% c('none', colnames(xVar())) || input$stat %in% statList ){
  #       updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
  #     }else if( req(input$colorSet)  %in% c(colnames(xVar()), 'none') && (isTruthy(input$shapeLine) && req(input$lineSet) != colnames(xVar())) ){
  #       message("entering only dodge")
  #       updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Dodge"))
  #     }else {
  #       
  #       choices2 <- list(tags$span("Stack", style = "font-weight:bold; color:#0099e6"), 
  #                        tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
  #       updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices2, choiceValues = list("Stack","Dodge"), inline = TRUE)
  #     }
  #     
  #   }
  # })
  # 
  
  # observe({
  #   req(pltType() == "bar")
  # 
  #   if(isTruthy(input$lineErrorBar) && isTruthy(input$lineGroupVar)){
  #     #updating the option for position
  #     choice <- list(tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
  #     updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choice, choiceValues = "dodge")
  #     message("updated radio button---------------rb----")
  #   }else{
  #     #change back to earlier status
  #     choices <- list(tags$span("Stack", style = "font-weight:bold; color:#0099e6"),
  #                     tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
  #     updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Stack", "Dodge"), inline = TRUE)
  #   }
  # })
  
  # observe({
  #   req(refresh_3(), isTruthy(input$lineGroupVar), pltType() != "none")
  #   # if(pltType() == "bar" && lineComputeSd() == "yes" && isTRUE(addErrorBarTruthy()) && isTruthy(lineGroupVar())){
  #   message("inside update radiobutton-----")
  #   
  #   if(pltType() == "bar" && req(isTruthy(input$lineErrorBar)) && req(lineComputeSd() == "yes") && req(isTruthy(input$lineGroupVar))){
  #     #updating the option for position 
  #     choice <- list(tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
  #     updateRadioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choice, choiceValues = "dodge")
  #     message("updated radio button---------------rb----")
  #   }
  # })
  
  # observe({
  #   req(pltType() %in% c("line","bar"), input$lineGroupVar)
  #   #refresh_3(),
  #   # var <- selectedVar(data = ptable())
  #   var <- input$xAxis
  #   if(isTRUE(addErrorBarTruthy()) && lineComputeSd() == "yes"){
  #     
  #     if(!isTruthy(input$lineGroupVar)){
  #       updateSelectInput(inputId = "xAxis", label = "X-axis", choices = xVarChoice(), selected = var)
  #     }else{
  #       updateSelectInput(inputId = "xAxis", label = "X-axis", choices = xVarChoice())#, selected = var) 
  #     }
  #   }else{
  #     # var <- selectedVar2(data = ptable(), "numeric")
  #     var <- input$xAxis
  #     updateSelectInput(inputId = "xAxis", label = "X-axis", choices = colnames(ptable()), selected = var)
  #   }
  #   
  #   
  # })
  # #Update variable for connecting line
  # 
  # output$UiLineConnectPath <- renderUI({
  #   req(refresh_3(), ptable())
  #   # req(ptable(), pltType() == "line", isTruthy(input$lineErrorBar), input$lineComputeSd)
  #   selVar <- if(length(colnames(ptable()))+1 == length(xVarChoice())){
  #     #let user choose
  #     "none"
  #   }else if(length(xVarChoice()) == 1){
  #     #user has choosen one variable for grouping
  #   }
  #   if(pltType() == "line") selectInput(inputId = "lineConnectPath", label = "Connect the line within", choices = xVarChoice(),
  #                                       #select the second variable if sd is calculated
  #                                       selected = ifelse(length(colnames(ptable()))+1 == length(xVarChoice()), xVarChoice()[1], xVarChoice()[2])
  #   )
  # })
  
  #setting for adjusting point, line, bar size----------
  observe({
    req(pltType() != "none")
    
    output$UiFreqPolySize <- renderUI({
      req(input$plotType)
      if(pltType() == "scatter"){
        lab <- "Point size"
        min <- 0.1
        max <- 5
        value <- 1
      }else if(pltType() %in% c("density","line", "frequency polygon")){
        lab <- "Line size"
        min <- 0.1
        max <- 10
        value <- 1
      }else if(pltType() %in% c("bar", "box")){
        lab <- ifelse(pltType() == 'bar', 'Bar width', "Box width")
        min <- 0.001
        max <- 1
        value <- 0.90
      }
      if(!pltType() %in% c("none", "histogram", "Violine plot") && (isTruthy(xVar())|| isTruthy(yVar())) ) sliderInput(inputId = "freqPolySize", label = lab,
                                                                                                                       value = value, min = min, max = max)
    })
    # output$UiFreqPolySize <- renderUI({
    #   req(input$plotType)
    #   if(pltType() %in% c("frequency polygon", "line", "scatter") && (isTruthy(xVar())|| isTruthy(yVar())) ) sliderInput(inputId = "freqPolySize", label = ifelse(pltType() %in% c("scatter"), "Point size", "Line size"),
    #                                                                                                                      value = 1, min = 1, max = 25)
    # })
  })
  
  #add mean, median for histogram
  observeEvent(req(pltType() == "histogram"),{
    # req(refresh_2())
    output$UiHistMean <- renderUI({
      req(ptable(), input$xAxis)
      # xVar <- ptable() %>% dplyr::select(.data[[input$xAxis]]) :  #type(xVar()[1]) == "double") 
      if(pltType() == "histogram" & xVarType()[1] %in% c("integer", "numeric", "double")) selectInput(inputId = "histMean", label = "Add mean line", choices = c("none","mean", "group mean", "median"), selected = "none")
    })
  })
  
  observeEvent(req(input$histMean == "group mean"),{
    output$UiHistGroupVar <- renderUI({
      var <- selectedVar(data = ptable())
      if(pltType() == "histogram" & xVarType()[1] %in% c("integer", "numeric", "double") & input$histMean == "group mean") selectInput(inputId = "histGroupVar", label = "Grouping variables",
                                                                                                                                       choices = colnames(ptable()), selected = var)
    })
  })
  
  observe({
    # req(input$histMean)
    output$UiHistMeanLine <- renderUI({
      req(ptable(), input$xAxis, input$histMean)
      if(pltType() == "histogram" & xVarType()[1] %in% c("integer", "numeric", "double") & input$histMean != "none") selectInput(inputId = "histMeanLine", label = "Line type", choices = c("dashed","dotted","solid"))
    })
    output$UiHistMeanColor <- renderUI({
      req(ptable(), input$xAxis, input$histMean)
      # if(pltType() == "histogram" & type(xVar()[1]) == "double" & input$histMean != "none") selectInput(inputId = "histMeanColor", label = "Color", choices = c("black","blue","red"), selected = "red")
      if(pltType() == "histogram" & xVarType()[1] %in% c("integer", "numeric", "double") & input$histMean != "none") {
        if(input$histMean %in% c("mean", "median")){
          selectInput(inputId = "histMeanColor", label = "Color", choices = c("black","blue","red"), selected = "red")
        }else if (input$histMean == "group mean"){
          selectInput(inputId = "histMeanColor", label = "Color", choices = c("default", "black","blue","red"), selected = "default")
        }
      }
    })
    
    output$UiHistMeanSize <- renderUI({
      req(ptable(), input$xAxis, input$histMean)
      # if(pltType() == "histogram" & type(xVar()[1]) == "double" & input$histMean != "none") sliderInput(inputId = "histMeanSize", label = "Line size", min = 1, max = 10, value = 1)
      if(pltType() == "histogram" & xVarType()[1] %in% c("integer", "numeric", "double") & input$histMean != "none") sliderInput(inputId = "histMeanSize", label = "Line size", min = 1, max = 10, value = 1)
    })
    
  })
  
  
  #theme for plot
  output$UiTheme <- renderUI({
    if(isTruthy(input$plotType)){
      selectInput(inputId = "theme", label = "Background theme", choices = c("default", "dark", "white", "white with grid lines","blank"), selected = "default") 
    }
  })
  
  #scatter plot:----------------------------
  #add jitter
  output$UiJitter <- renderUI({
    req(refresh_2(), pltType())
    if(pltType() == "scatter") checkboxInput(inputId = "jitter", label = tags$span("Handle overplotting (jitter)", style = "font-weight:bold; color:#b30000; background:#f7f3f3"))
  })
  #Density-----------------------------------
  kde <- c("gaussian", "epanechnikov", "rectangular", "triangular", "biweight", "cosine", "optcosine")
  output$UiDensityKernel <- renderUI({
    req(refresh_3(), pltType())
    if(pltType() == "density") selectInput(inputId = "densityKernel", label = "Kernel\ndensity", choices = sort(kde), selected = "gaussian")
  })
  
  output$UiDensityStat <- renderUI({
    req(refresh_3(), pltType())
    computes <- c("density", "count", "scaled", "ndensity")
    if(pltType() == "density") selectInput(inputId = "densityStat", label = "Computed\n stat", choices = sort(computes), selected = "density")
  })
  output$UiDensityBandwidth <- renderUI({
    req(refresh_3(), pltType())
    binwd <- c("nrd0","nrd", "ucv","bcv","SJ-ste","SJ-dpi")
    if(pltType() == "density") selectInput(inputId = "densityBandwidth", label = "Bandwidth (bw)", choices = sort(binwd), selected = "nrd0")
  })
  output$UiDensityAdjust <- renderUI({
    req(refresh_3(), pltType())
    if(pltType() == "density") sliderInput(inputId = "densityAdjust", label = "Adjust bw", min = 1, max = 20, value = 1)
  })
  output$UiDensityPosition <- renderUI({
    req(refresh_1(), pltType(), input$colorSet != "none")
    positions<- c("stack", "identity","fill")
    if(pltType() == "density" && input$colorSet != "none") selectInput(inputId = "densityPosition", label = "Position", choices = c("default", sort(positions)), selected = "default")
  })
  output$UiAlpha <- renderUI({
    req(refresh_1(), pltType(), input$colorSet != "none")
    if(pltType() == "density" && input$colorSet != "none") sliderInput(inputId = "alpha", label = "Transparency", min = 0.01, max = 1, value = 1)
  })
  #For more settings----------------------------------
  #reactive input for transform
  transformation <- reactive(ifelse(input$transform == "Yes", TRUE, FALSE))
  action <- reactive(ifelse(isTruthy(input$goAction), TRUE, FALSE))
  
  #function for option to choose variables for applying different aesthetic: color, shape and line
  # displayAes <- function(transform = TRUE, action = FALSE, pltType = "pltType()",#!isTruthy(input$goAction)
  #                        data = ptable(), label = "Variable to fill color", newId = "colorSet", firstChoice = "none", choice = colnames(ptable()), selecteds = "none",...){
  #   if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & pltType == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
  #     selectInput(inputId = newId, label = label, choices = list("none"))
  #   }else{#} if(is.data.frame(data)){
  #     selectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
  #   }
  # }
  displayAes <- function(update= "no", transform = TRUE, action = FALSE, pltType = "pltType()",#!isTruthy(input$goAction)
                         data = ptable(), label = "Variable to fill color", newId = "colorSet", firstChoice = "none", choice = colnames(ptable()), selecteds = "none",...){
    if(tolower(update) =="no"){
      if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & req(pltType) == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
        selectInput(inputId = newId, label = label, choices = list("none"))
      }else{#} if(is.data.frame(data)){
        selectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
      }
    }else if(tolower(update) == "yes"){
      if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & req(pltType) == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
        updateSelectInput(inputId = newId, label = label, choices = list("none"))
      }else{#} if(is.data.frame(data)){
        message("-===========updating selectInput================")
        updateSelectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
      }
      
    }
  }
  
  #color setting-------------------------
  #error still exist when grouping variable changes back to the earlier: the error is in bar plot
  
  #variables to be selected for color
  #This need revision to implement
  # selectedChoice <- reactive({
  #   req(pltType(), xVarType())
  #   if(pltType() == "histogram" && xVarType()[1] == "numeric"){# && input$histMean == "group mean"){
  #     #I want to display the color directly for histogram, if group mean is choosen
  #     if(req(input$histMean) == "group mean"){
  #       input$histGroupVar
  #     }else{"none"}
  #   }else{"none"}
  # })
  # var <- reactive(req(input$lineGroupVar))
  
  lineGrpVar <- reactive(req(input$lineGroupVar))
  # selectedChoice <- reactive({
  #   req(pltType())
  #   
  #   if(pltType() == "bar" && isTruthy(input$lineErrorBar) && input$lineComputeSd == "yes" && lineGrpVar()!= ""){
  #     #This is require for bar plot: to display error bar correctly
  #     if(length(lineGrpVar()) > 1 && lineGrpVar() %in% colnames(xVar())){
  #       #remove variable set in x-axis from the list
  #       lineGrpVar()[!lineGrpVar() %in% colnames(xVar())] 
  #     }else if(length(lineGrpVar()) > 1 && !lineGrpVar() %in% colnames(xVar())){
  #       lineGrpVar()[1] 
  #     }else{
  #       NULL #let the default none be applied if grouping variable is equal with variable of x-axis
  #     }
  #   }else{
  #     #default for other plots i.e. none
  #     NULL
  #   }
  # })
  
  #list of variables to choose by the user
  varColorChoice <- reactive({
    req(refresh_2(), pltType(), xVarType())
    
    allVar <- colnames(ptable())
    if(pltType() == "histogram" && xVarType()[1] %in% c("integer", "numeric", "double")){# && input$histMean == "group mean"){
      #Histogram: if variable for group mean is chosen, then provide only that variable for color, no other variables!
      if(req(input$histMean) == "group mean"){
        input$histGroupVar
      }
    }
    # else if(pltType() %in% c("line", "bar", "scatter") && isTruthy(input$lineErrorBar) && input$lineComputeSd == "no" && isTruthy(input$lineGroupVar)){
    #   var <- input$lineGroupVar
    #   
    #   # if(pltType() == "bar"){
    #   #   if(length(var) > 1){
    #   #     #bar plot: if more than one variables are available, list only the variables not present in x-axis and y-axis
    #   #     var[ !var %in% c(colnames(xVar()), colnames(yVar()) ) ]
    #   #   }else{
    #   #     #Provide the only one variables
    #   #     var
    #   #   }
    #   }
    # else if(pltType() == "line"){
    # #line graph: if compute sd is chosen, then provide only the variables chosen in group
    # input$lineGroupVar
    # }
    
    else{
      #generic
      if(pltType() %in% c("box","Violine plot", "line", "scatter", "bar")){
        req(yVar())
        #remove variable of y-axis from the list
        allVar[allVar != colnames(req(yVar()))]
      }else{
        colnames(ptable())
      }
    }
  })
  
  output$UiColorSet <- renderUI({
    req(refresh_2())
    #This will be updated based on the type of ANOVA, if required
    displayAes(update = "no", transform = transformation(), action = action(), pltType = pltType(),
               data = ptable(), label= "Add color", newId = "colorSet", choice = varColorChoice()) #selecteds = selectedChoice()
    # displayAes(transform = transformation, action = action, pltType = pltType(),
    #            data = ptable(), label= "Add color", newId = "colorSet", choice = varColorChoice())
  })
  #update color if the input feature change
  observe({
    req(input$replicatePresent, input$transform)
    if( isTRUE(dataChanged()) || isTruthy(input$replicateActionButton) || isTruthy(input$goAction) ){
      displayAes(update = "yes", transform = transformation(), action = action(), pltType = pltType(),
                 data = ptable(), label= "Add color", newId = "colorSet", choice = varColorChoice()) 
    }
  })
  
  #option to provide color 
  #provide option to auto fill the color or customize it
  output$uiAutoCustome <- renderUI(
    if(req(input$colorSet) != "none"){
      radioButtons("autoCustome", label = NULL, choices = c("auto filled","customize"), selected = "auto filled")
    })
  #if customize is selected than provide option to add colors
  output$UiColorAdd <- renderUI({
    req(input$autoCustome)
    customize <- reactive(input$autoCustome)
    if(input$colorSet != "none" & customize() == "customize"){
      #get number of variables
      countVar <- ptable() %>%
        #count number of variables 
        distinct(.data[[input$colorSet]], .keep_all = T) %>% nrow()
      
      textAreaInput(inputId = "colorAdd", label = glue::glue("Enter {countVar} colors"),
                    placeholder = "comma or space separated. \nE.g. red, #cc0000, BLUE")
    }
  })#end of renderUI
  
  #color and fill for histogram----------------
  #above option to add color and histogram color setting will be mutually exclusive
  observeEvent(req(pltType() %in% c("histogram"), input$colorSet == "none"),{
    output$UiHistBarColor <- renderUI({
      if(pltType() %in% c("histogram") & input$colorSet == "none") textInput(inputId = "histBarColor", label = "Bar color", placeholder = "red or #ff0000")
    })
    output$UiHistBarFill <- renderUI({
      if(pltType() %in% c("histogram") & input$colorSet == "none") textInput(inputId = "histBarFill", label = "Fill bar", placeholder = "blue or #b3d9ff")
    })
  })
  #shape and line-----------------
  # displayAes <- function(transform = TRUE, action = FALSE, pltType = "pltType()",#!isTruthy(input$goAction)
  #                        data = ptable(), label = "Variable to fill color", newId = "colorSet", firstChoice = "none", choice = colnames(ptable()), selecteds = "none",...){
  #   if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & pltType == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
  #     selectInput(inputId = newId, label = label, choices = list("none"))
  #   }else{#} if(is.data.frame(data)){
  #     selectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
  #   }
  # }
  #shapeExcluded <- c("histogram", "frequency polygon", "line", "scatter")
  shapeLineOption <- reactive({
    if(req(pltType()) %in% c("scatter")){
      # list(tags$span("Shape", style = "font-weight:bold; color:#0099e6"))
      c("Shape")
    }else if(req(pltType()) %in% c("box","Violine plot", "bar", "histogram", "frequency polygon", "line", "density")){
      #remove shape for histogram, frequency polygon, line
      c("Line type")
    }else{
      c("Shape", "Line type")
    }
  })
  
  output$UiShapeLine <- renderUI({
    req(refresh_2(), pltType(), input$stat)
    checkboxGroupInput(inputId = "shapeLine", label = "Add more aesthetic", choices = shapeLineOption(), inline = TRUE)
  })
  #update shapeLine if input parameters for data changed
  observe({
    req(input$replicatePresent, input$transform, pltType())
    if( isTRUE(dataChanged()) || isTruthy(input$replicateActionButton) || isTruthy(input$goAction) ){
      updateCheckboxGroupInput(inputId = "shapeLine", label = "Add more aesthetic", choices = shapeLineOption(), inline = TRUE)
    }
  })
  
  observeEvent(req(input$shapeLine),{
    req(is.data.frame(ptable()))
    #This will be updated later based on ANOVA, if required
    #variables to choose
    var <- selectedVar(data = ptable())
    if(is.data.frame(ptable())){
      allVar <- colnames(ptable())
      choiceVar <- allVar[allVar != colnames(yVar())]
    }else{
      choiceVar <- ""
    }
    #shape
    output$shape_1 <- renderUI({
      req(pltType() != "bar" && input$shapeLine == "Shape", input$stat)
      displayAes(transform = transformation(), action = action(), pltType = pltType(),
                 label = "Variable for shape", newId = "shapeSet", firstChoice = NULL, choice = choiceVar, selected = var) 
      
    })
    #line
    output$line_1 <- renderUI({
      req(input$shapeLine == "Line type")
      if(pltType() == "line" && input$lineConnectPath != "none"){
        displayAes(transform = transformation(), action = action(), pltType = pltType(),
                   label = "Variable for line type", newId = "lineSet", firstChoice = NULL, choice = input$lineConnectPath, selected = input$lineConnectPath)
      }else{
        displayAes(transform = transformation(), action = action(), pltType = pltType(),
                   label = "Variable for line type", newId = "lineSet", firstChoice = NULL, choice = choiceVar, selected = var) 
      }
    })
  })
  
  
  #update aesthetic, if add error bar for line, scatter plot is active, then choice for shapeSet and lineSet
  # case 1: color not choosen. option will remain as it is and calculation will take care 
  # case 2: color choosen and equal with x-axis. shapeSet and lineSet will still remain unchange
  # case 2: color choosen and not equal with x-axis. all other aesthetic must have only two options, variables of x-axis and color
  # * color is given higher precedence over other aesthetics
  
  observe({
    req( pltType() %in% c("scatter", "bar"), isTruthy(input$lineErrorBar) )
    if( isTruthy(input$lineErrorBar) && !input$colorSet %in% c("none", colnames(xVar())) ){
      
      if(pltType() == "scatter"){
        #update shape
        displayAes(update = "yes", transform = transformation(), action = action(), pltType = pltType(),
                   data = ptable(), label = "Variable for shape", newId = "shapeSet", firstChoice = NULL, choice = c(colnames(xVar()), input$colorSet), selected= input$colorSet )
      }else if(pltType() == "bar"){
        #update line
        #for line plot, it will be taken care by connect line path
        message("update lineSet2")
        # updateSelectInput(inputId = "lineSet", label = "Variable for line type2", choices = c(colnames(xVar()), input$colorSet), selected= input$colorSet)
        displayAes(update = "yes", transform = transformation(), action = action(), pltType = pltType(),
                   data = ptable(), label = "Variable for line type", newId = "lineSet", firstChoice = NULL, choice = c(colnames(xVar()), input$colorSet), selected= input$colorSet )
      }
      
    }
    # else{
    #   displayAes(transform = transformation, action = action, pltType = pltType(),
    #              label = "Variable for shape", newId = "shapeSet", firstChoice = NULL, choice = choiceVar, selected = var) 
    # }
  })
  
  # #update for lineSet, similar as above.
  # #for line plot, it will be taken care by connect line path
  # observe({
  #   req(pltType() != "line", isTruthy(input$lineErrorBar))
  #   if( isTruthy(input$lineErrorBar) && input$colorSet != "none" ){
  #     displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
  #                label = "Variable for line type", newId = "lineSet", firstChoice = NULL, choice = c(colnames(xVar()), input$colorSet)) 
  #   }
  #   
  # })
  
  #Figure legend and other theme parameters------------
  observe({
    req(input$plotType, input$xAxis, input$colorSet)
    shl <- reactive({
      ifelse(isTruthy(input$shapeLine), input$shapeLine, "none")
    })
    output$UiLegendPosition <- renderUI({if(input$plotType != "none" && (input$colorSet != "none" | shl() %in% c("Shape", "Line type"))) selectInput(inputId = "legendPosition", label = "Legend position", choices = c("none","bottom","left","right","top"), selected = "right")})
    output$UiLegendDirection <- renderUI({if(input$plotType != "none" && (input$colorSet != "none" | shl() %in% c("Shape", "Line type")) && req(input$legendPosition) != "none") selectInput(inputId = "legendDirection", label = "Legend direction", choices = c("horizontal","vertical"), selected = "vertical")})
    output$UiLegendSize <- renderUI({if(input$plotType != "none" && (input$colorSet != "none" | shl() %in% c("Shape", "Line type")) && req(input$legendPosition) != "none") sliderInput(inputId = "legendSize", label = "Legend size", min = 10, max = 30, value = 15)})
    output$UiLegendTitle <- renderUI({if(input$plotType != "none" && (input$colorSet != "none" | shl() %in% c("Shape", "Line type")) && req(input$legendPosition) != "none") checkboxInput(inputId = "legendTitle", label = span("Remove legend title", style = "font-weight:bold; color:cornflowerblue"))})
  })
  #bracket-----------------
  observe({
    req(is.data.frame(ptable()), pltType() != "none", xVar(), !input$stat %in% c("none", "anova"))
    output$UiRemoveBracket <- renderUI({
      if(!input$stat %in% c("none", "anova", "Kruskal test")) checkboxInput(inputId = "removeBracket", label = span("Remove bracket", style = "font-weight:bold; color:cornflowerblue"))
    })
  })
  
  #Facet strip background
  observe({
    req(refresh_2())
    req(input$plotType, input$xAxis)
    output$UiStripBackground <- renderUI({
      if(input$facet != "none" & (isTruthy(input$varRow) | isTruthy(input$varColumn))){
        checkboxInput(inputId = "stripBackground", label = span("Remove facet strip background", style = "font-weight:bold; color:cornflowerblue")) 
      }
    })
  })
  #statistics-------------------------------------------------------------------
  ## choose facet type
  # output$UiFacet_1 <- renderUI({
  #   req(refresh_2())
  #   selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
  # })
  #check whether x and y axis is available
  # xyAxisReady <- reactive(ifelse(input$countIdentity == "use the data as is" && isTruthy(input$xAxis) && isTruthy(input$yAxis), TRUE, FALSE))
  
  #statistical method
  statMethods <- list(Parametric = c("t.test", "anova"), `Non-parametric`=c("wilcox.test","Kruskal test"))
  statList <- c("t.test", "anova", "wilcox.test","Kruskal test")
  #Choose statistical method
  output$UiStatMethod <- renderUI({
    req(refresh_2(), pltType())
    #to apply statistic, it require both x and y-axis
    #if(pltType() %in% c("none","box") || (pltType() == "histogram" & isTRUE(xyAxisReady()))){
    if(pltType() %in% c("none",plotList)){ 
      selectInput(inputId = "stat", label = "Statistical method", choices = c("none",statMethods), selected = "none") 
    }
    #   if(req(input$facet) %in% c("none", "wrap")){
    #     selectInput(inputId = "stat", label = "Statistical method", choices = c("none",statMethods), selected = "none") 
    #     # }else if(req(input$facet) %in% c("grid", "wrap")){
    #   }else{
    #     selectInput(inputId = "stat", label = "Statistical method", choices = c("none"))
    #   }
    # }else{
    #   selectInput(inputId = "stat", label = "Statistical method", choices = c("none"))
    # }
  })
  
  #alert message for t-test, if more than 2 variables present
  observe({
    req(is.data.frame(ptable()), pltType() != 'none', input$stat %in% c('t.test', 'wilcox.test'))
    output$UiTtestAlert <- renderUI({
      if(input$stat %in% c('t.test', 'wilcox.test')){
        if(req(input$colorSet) == 'none' && !isTruthy(input$shapeLine)){
          #check variable count
          countVar <- ptable() %>% distinct(.data[[input$xAxis]]) %>% nrow()
        }else if(req(input$colorSet) != 'none'){
          countVar <- ptable() %>% distinct(.data[[input$xAxis]], .data[[input$colorSet]]) %>% nrow()
        }
        
        if(countVar > 2){
          helpText("Data has more than 2 variables to compare. ANOVA may be more appropriate or specify variables to compare or add reference group",
                   style= "margin-bottom:20px; border-radius:10px; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")#style = "margin-bottom:20px; color:#EB6305")
        }
      }
    })
  })
  # #update stat method--------------------------------
  #update stat if input parameters for data changed
  observe({
    req(input$replicatePresent, input$transform)
    if( isTRUE(dataChanged()) || isTruthy(input$replicateActionButton) || isTruthy(input$goAction) ){
      if(pltType() %in% c("none",plotList) || isTRUE(needYAxis())){
        selectInput(inputId = "stat", label = "Statistical method", choices = c("none",statMethods), selected = "none") 
      }
    }
  })
  
  #update stat based on anova
  observe({
    req(refresh_2(), ptable(), pltType() != "none", xVar(), input$stat == "anova", input$pairedData == "two", input$twoAovVar)
    # req(input$twoAovVar)
    oldVar <- input$twoAovVar
    if(input$pairedData == "two" && isTruthy(input$twoAovVar) && oldVar == colnames(xVar())){
      updateSelectInput(inputId = "stat", label = "Statistical method", choices = c("none",statMethods), selected = "none")
    }
  })
  
  #t-test method-----------------------
  output$UiTtestMethod <- renderUI({
    req(input$stat == "t.test")
    choices <- list(tags$span("Welch's test", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Student's test", style = "font-weight:bold; color:#0099e6"))
    if(input$stat == "t.test"){
      radioButtons(inputId = "ttestMethod", label = "Test method", choiceNames = choices, choiceValues = c("welch", "student"), inline = FALSE)
    }
    
  })
  
  observe({
    req(is.data.frame(ptable()), input$stat == "t.test", input$ttestMethod)
    output$ttestMethodAlert <- renderUI({
      if(input$ttestMethod == 'welch'){
        helpText("Designed for unequal population variance", style= "margin-bottom:20px; border-radius:10px; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
      }else{
        helpText("Use when population has equal variance", style= "margin-bottom:20px; border-radius:10px; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
      }
    })
  })
  #data (paired or unpaired) and ANOVA type (one-way or two-way)
  unpaired_stopTest <- reactiveVal("no") #no means data is unpaired, but user used as paired. So stop executing the t-test
  observe({
    req( refresh_2(), pltType(), !input$stat %in% c("none", "Kruskal test") )
    
    statMethod <- reactive(input$stat)
    output$UiPairedData <- renderUI({
      
      dataTypeList <- if(statMethod() %in% c("t.test", "wilcox.test")){
        
        list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
             tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
        
      }else{
        
        list(tags$span("One-way", style = "font-weight:bold; color:#0099e6"), 
             tags$span("Two-way", style = "font-weight:bold; color:#0099e6"))
        
        #tags$span("Two-way Repeated Measures", style = "font-weight:bold; color:#0099e6"))
      }
      
      if(statMethod() %in% c("t.test", "wilcox.test")) {
        radioButtons(inputId = "pairedData", label = "Paired data", inline = TRUE,
                     choiceNames = dataTypeList, choiceValues = list("no", "yes"))
      }else if(statMethod() == "anova"){
        radioButtons(inputId = "pairedData", label = "ANOVA type", inline = FALSE,
                     choiceNames = dataTypeList, choiceValues = list("one", "two"))
      }
    })
    
    #alert message if user try to use paired data, when the data is actually an unpaired
    output$UiAlertPairedData <- renderUI({
      req(is.data.frame(ptable()), input$stat, input$pairedData)
      if(input$stat %in% c("t.test", "wilcox.test") && input$pairedData == "yes"){
        
        #count the sample size of each variable
        if(input$colorSet == 'none' || !isTruthy(input$shapeLine)){
          count_df <- ptable() %>% count(.data[[input$xAxis]])
        }else if(input$colorSet != 'none'){
          count_df <- ptable() %>% count(.data[[input$xAxis]], .data[[input$colorSet]])
        }else if(input$colorSet == 'none' && isTruthy(input$shapeLine)){
          if(isTruthy(input$shapeSet)){
            count_df <- ptable() %>% count(.data[[input$xAxis]], .data[[input$shapeSet]])
          }else if(isTruthy(input$lineSet)){
            count_df <- ptable() %>% count(.data[[input$xAxis]], .data[[input$lineSet]])
          }
        }
        
        #check paired or unpaired and provide information to stop executing t-test.
        init <- count_df[1, "n"]
        if(!all(count_df$n == init)){
          #data is unpaired, so stop
          unpaired_stopTest("yes")
        }else{
          unpaired_stopTest('no')
        }
        
        if(unpaired_stopTest() == 'yes'){
          helpText("Please, double-check the data and choose the correct option.", style="color:red; margin-bottom:20px; margin-top:0")
        }
        
      }else{
        unpaired_stopTest('no')
        ""
      }
    })
    
  })
  
  # output$UiPairedData <- renderUI({
  #   req( refresh_2(), input$stat %in% c("none", "Kruskal test") )
  #   statMethod <- reactive(input$stat)
  #   dataTypeList <- if(statMethod() %in% c("t.test", "wilcox.test")){
  #     list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
  #          tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
  #   }else{
  #     list(tags$span("One-way", style = "font-weight:bold; color:#0099e6"), 
  #          tags$span("Two-way", style = "font-weight:bold; color:#0099e6"))
  #          #tags$span("Two-way Repeated Measures", style = "font-weight:bold; color:#0099e6"))
  #   }
  #   if(statMethod() %in% c("t.test", "wilcox.test")) {
  #     radioButtons(inputId = "pairedData", label = "Paired data", inline = TRUE,
  #                                         choiceNames = dataTypeList, choiceValues = list("no", "yes"))
  #   }else if(statMethod() == "anova"){
  #     radioButtons(inputId = "pairedData", label = "ANOVA type", inline = FALSE,
  #                  choiceNames = dataTypeList, choiceValues = list("one", "two"))
  #     }
  # })
  
  #two-way anova: variable list-----------------
  output$UiTwoAovVar <- renderUI({
    req(refresh_2(), ptable(), pltType() != "none", input$stat == "anova", input$pairedData == "two")
    #default variable for computing two-way anova: must not be equal with the variable of x-axis
    varSel <- selectedVar2(data = ptable(), check = "character", index=2)
    
    #get the variable list from the table other than the variables of x- and y-axis
    colList <- ptable()[!colnames(ptable()) %in% c(colnames(yVar()), colnames(xVar()))]
    
    selectInput(inputId = "twoAovVar", label = "Choose the other independent variable", 
                choices = colnames(colList), selected = varSel)
    #Choosing the variable may require to update the aesthetic parameters
    #So, update the aethetic paramters again.
  })
  
  #anova Figure--------------------
  output$UiAnovaFigure <- renderUI({
    req(ptable(), pltType() != "none", input$stat == "anova", input$pairedData == "two")
    varName <- list(`Main effect` = c(colnames(xVar()), input$twoAovVar))
    if(input$anovaModel == "additive"){
      selectInput(inputId = "anovaFigure", label = "Show figure", choices = varName)
    }else if(input$anovaModel == "non-additive"){
      selectInput(inputId = "anovaFigure", label = "Show figure", choices = c("Interaction",varName))
    }
  })
  
  #Anova color----------------------
  # output$UiAnovaColor <- renderUI({
  #   req(ptable(), pltType() != "none", input$stat == "anova", input$pairedData == "two", input$anovaFigure != "Interaction")
  #   if(input$anovaFigure != "Interaction") selectInput(inputId = "anovaColor", label = "Color", choices = input$anovaFigure)
  # })
  
  #option to provide color 
  #provide option to auto fill the color or customize it
  output$UiAnovaAutoCust <- renderUI(
    if(req(input$stat == "anova") && req(input$pairedData == "two") && req(input$anovaFigure) != "Interaction"){
      radioButtons("anovaAutoCust", label = "Color", choices = c("auto filled","customize"), selected = "auto filled")
    })
  #if customize is selected than provide option to add colors
  output$UiAnovaAddColor <- renderUI({
    req(input$anovaAutoCust)
    customize <- reactive(input$anovaAutoCust)
    if(input$anovaFigure != "Interaction" & customize() == "customize"){
      #get number of variables
      countVar <- ptable() %>%
        #count number of variables 
        distinct(.data[[input$anovaFigure]], .keep_all = T) %>% nrow()
      
      textAreaInput(inputId = "anovaAddColor", label = glue::glue("Enter {countVar} colors"),
                    placeholder = "comma or space separated. \nE.g. red, #cc0000, BLUE")
    }
  })#end of renderUI
  
  
  
  #update aesthetic-------------------------
  
  #update the aesthetic (color, shape, line variable) based on the type of ANOVA, if required-------------
  observe({
    req(refresh_2(), ptable(), pltType(), xVar(), input$stat)
    if(input$stat == "anova"){
      req(input$pairedData)
      if(input$pairedData == "one"){
        #for one-way anova, 
        #if aesthetic is choosen, convert the variable given in x-axis and provide 'none' as the other options
        #if aesthetic is not applied, than leave as it is but the option to choose will be the variable of x-axis
        #Shape & line type
        # displayAes(update = 'yes', transform = transformation(), action = action(), pltType = pltType(),
        #            label = "Variable for shape", newId = "shapeSet", firstChoice = NULL, choice = input$xVar)
        updateSelectInput(inputId = "shapeSet", label = "Variable for shape", choices = colnames(xVar()))
        updateSelectInput(inputId = "lineSet", label = "Variable for line type", choices = colnames(xVar()))
        
        #update color
        if(input$colorSet != "none"){
          if(input$colorSet != colnames(xVar())){
            #This is required
            #If user change the variable of x-axis while all other stat paramters are applied, then
            #reset the colorSet to none. 
            updateSelectInput(inputId = "colorSet", label= "Add color", choices = c("none",colnames(xVar())), selected = "none")
          }else{
            updateSelectInput(inputId = "colorSet", label= "Add color", choices = c("none",colnames(xVar())), selected = colnames(xVar()))
          }
          
          # displayAes(transform = transformation, action = action, pltType = pltType(),
          #            data = ptable(), label= "Add color", newId = "colorSet", choice = varColorChoice(), selecteds = selectedChoice())
        }else if(input$colorSet == "none"){
          updateSelectInput(inputId = "colorSet", label= "Add color", choices = c("none",colnames(xVar())), selected = "none")
        }
        #update shape and line
        # if(isTruthy(input$shapeLine)){
        #   if(input$shapeLine == "Shape"){
        #     updateSelectInput(inputId = "shapeSet", label = "Variable for shape", choices = colnames(xVar()))
        #   }else if(input$shapeLine == "Line type"){
        #     updateSelectInput(inputId = "shapeSet", label = "Variable for line type", choices = colnames(xVar()))
        #   }
        # }
      }else if(input$pairedData == "two"){
        req(input$twoAovVar)
        #for two-way anova,
        #If aesthetic is not applied, auto apply the color
        #If more than one aesthetic are applied, all must select similar variable
        #The variable must not be equal with the variables of x- and y-axis
        #Only one variable will be provided for aesthetic
        #The variable must be the variable selected in input$twoAovVar
        #The variable must be character. If required, convert to character/factor. Require for computation and implemented later.
        
        xSel <- input$twoAovVar
        if((input$colorSet != "none"|| input$colorSet == "none") && !isTruthy(input$shapeLine)){
          if(input$colorSet != "none" && all(c(xSel,input$colorSet) %in% colnames(xVar()))){
            #if user has applied all the stat parameters for two-way anova, but change the variable of x-axis, then
            #reset the color to none
            displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                       data = ptable(), label= "Add color", newId = "colorSet", firstChoice = NULL, choice = xSel, selecteds = "none")
          }else{
            displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                       data = ptable(), label= "Add color", newId = "colorSet", firstChoice = NULL, choice = xSel, selecteds = xSel)
            
          }
          
        }else if( (input$colorSet != "none"|| input$colorSet == "none") && isTruthy(input$shapeLine)){
          if(input$shapeLine == "Line type"){
            updateSelectInput(inputId = "lineSet", label = "Variable for line type", choices = xSel, selected = xSel)
          }else if(input$shapeLine == "Shape"){
            updateSelectInput(inputId = "shapeSet", label = "Variable for shape", choices = xSel, selected = xSel)
          }
        }
      }
    }else{
      
      # updateSelectInput(inputId = "colorSet", label = "Add color", choices = c("none", varColorChoice()))
      displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                 data = ptable(), label= "Add color", newId = "colorSet", choice = varColorChoice()) #, selecteds = selectedChoice())
    }
  })
  
  
  #update aesthetic based on parameters of stat method--------------------
  # If user choose to compare or add reference, choosen variable of aesthetic must be equal to the variable
  # of x-axis. If not equal, then all aesthetic of color will be revert back to none.
  # For aesthetic other than color, it will reset to none, irrespective of the status.
  # Updated option available will be none and variable of x-axis. 
  # Resetting the option to none will allow the user to notice the change
  
  observe({
    req(pltType(), xVar(), input$stat %in% c("t.test", "wilcox.test", "Kruskal test"))
    if( input$stat == "Kruskal test" || (input$stat %in% c("t.test", "wilcox.test") && req(input$compareOrReference) != "none") ){# && input$colorSet != "none" && !isTruthy(input$shapeLine)){
      
      #user provide color
      if(input$colorSet %in% c("none", colnames(xVar())) ){
        if(input$colorSet == colnames(xVar())){
          #keep the color as it is, but update the option to only one variable, by default 'none' is included
          displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                     data = ptable(), label= "Add color", newId = "colorSet", choice = colnames(xVar()), selecteds = colnames(xVar()))
        }else{
          displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                     data = ptable(), label= "Add color", newId = "colorSet", choice = colnames(xVar()), selecteds = "none")
        }
        
      }else if( !input$colorSet %in% c("none", colnames(xVar())) ){
        #reset to none so that user knows the changed
        #   and update the option to only none and one variable
        displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
                   data = ptable(), label= "Add color", newId = "colorSet", choice = colnames(xVar()), selecteds = "none")
      }#end of updating only the color
      
      #other aesthetics, if applied, will be reset to none irrespective of the status
      if(isTruthy(input$shapeLine)){
        if(input$shapeLine == "Line type"){
          updateSelectInput(inputId = "lineSet", label = "Variable for line type", choices = c(colnames(xVar())))
        }else if(input$shapeLine == "Shape"){
          updateSelectInput(inputId = "shapeSet", label = "Variable for shape", choices = c(colnames(xVar())))
        }
      }
      
    }
    # else if(input$compareOrReference != "none" && isTruthy(input$shapeLine)){
    #   #user provide both color and other aesthetic
    #   # convert other aesthetic to none and option list be 'none' and x-axis
    #   if(input$shapeLine == "Line type"){
    #     updateSelectInput(inputId = "lineSet", label = "Variable for line type", choices = c('none', colnames(xVar())))
    #   }else if(input$shapeLine == "Shape"){
    #     updateSelectInput(inputId = "shapeSet", label = "Variable for shape", choices = c('none', colnames(xVar())))}}
  })
  
  #update other than color
  
  # 
  # observe({
  #   req(pltType(), pltType(), xVar(), input$stat %in% c("t.test", "wilcox.test"), input$compareOrReference != "none")
  #   if(input$compareOrReference != "none" && input$colorSet != "none" && !isTruthy(input$shapeLine)){
  #     
  #     #user provide only color
  #     if(input$colorSet == colnames(xVar())){
  #       #keep as it is, but update the option to only one variable
  #       displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
  #                  data = ptable(), label= "Add color", newId = "colorSet", choice = colnames(xVar()), selecteds = colnames(xVar()))
  #     }else if(input$colorSet != colnames(xVar())){
  #       #reset to none and update the option to only one variable
  #       displayAes(update = "yes", transform = transformation, action = action, pltType = pltType(),
  #                  data = ptable(), label= "Add color", newId = "colorSet", choice = colnames(xVar()), selecteds = "none")
  #     }
  #     
  #   }
  # })
  
  
  # displayAes <- function(update= "no", transform = TRUE, action = FALSE, pltType = "pltType()",#!isTruthy(input$goAction)
  #                        data = ptable(), label = "Variable to fill color", newId = "colorSet", firstChoice = "none", choice = colnames(ptable()), selecteds = "none",...){
  #   if(update=="no"){
  #     if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & pltType == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
  #       selectInput(inputId = newId, label = label, choices = list("none"))
  #     }else{#} if(is.data.frame(data)){
  #       selectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
  #     }
  #   }else if(update == "yes"){
  #     if(!is.data.frame(data) || (is.data.frame(data) & isFALSE(transform) & pltType == "none") || (is.data.frame(data) & isTRUE(transform) & isFALSE(action))){
  #       updateSelectInput(inputId = newId, label = label, choices = list("none"))
  #     }else{#} if(is.data.frame(data)){
  #       updateSelectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
  #     }
  #     
  #   }
  # }
  #not require:------------------------------------------
  #Compute the stat by grouping the variables or not: yes or no
  #not require: i have implemented during plotting
  # output$UiGroupComputeStat <- renderUI({
  #   req(refresh_2(), input$stat != "none")
  #   choiceList <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"),
  #                      tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
  #   #group_by() will be omitted if user does not use additional aesthetic in the mapping of plot
  #   if((input$colorSet != "none" || isTruthy(input$shapeLine)) && input$stat !="anova"){
  #     #To group or not to group depend upon selection of variable in x-axis and other aesthetic
  #     selectedVar <- if(pltType() == "none" || !is.data.frame(ptable())){
  #       "no"
  #     }else{
  #       if(colnames(xVar()) == input$colorSet ||
  #          (isTruthy(input$shapeSet) && colnames(xVar()) == input$shapeSet) ||
  #          (isTruthy(input$lineSet) && colnames(xVar()) == input$lineSet)){
  #         "no" #don't group
  #       }else{"yes"}
  #     }
  #     radioButtons(inputId = "groupComputeStat", label = "Compute by grouping variable(s)?", #"Group variable(s) to compute",
  #                                                choiceNames = choiceList, choiceValues = c("no","yes"), selected = selectedVar, inline = TRUE)
  #     }
  # })
  
  # output$UiGroupComputeStatOption <- renderUI({
  #   req(refresh_2(), !input$stat %in% c("none", "anova"), input$groupComputeStat == "yes")#, input$independentVar)
  #   if(input$colorSet != "none" || isTruthy(input$shapeLine)){
  #     
  #     if(!is.data.frame(ptable()) || pltType() == "none"){
  #       selectInput(inputId = "groupComputeStatOption", label = NULL, choices = "none")
  #     }else{
  #       #Note: group by can be applied using only the variables supplied in the mapping
  #       allVar <- colnames(ptable()) #all column
  #       xCol <-  colnames(xVar()) #xAxis variable
  #       choseVar <- if(input$colorSet != "none" && isTruthy(input$shapeLine)){
  #                     if(input$shapeLine == "Shape"){
  #                       allVar[allVar %in% c(xCol, input$colorSet, input$shapeSet)]
  #                     }else if(input$shapeLine == "Line type"){
  #                       allVar[allVar %in% c(xCol, input$colorSet, input$lineSet)]
  #                     }else if(identical(input$shapeLine, c("Shape", "Line type"))){
  #                       allVar[allVar %in% c(xCol, input$colorSet,input$shapeSet, input$lineSet)]
  #                     }
  #                   }else if(input$colorSet != "none" && !isTruthy(input$shapeLine)){
  #                       allVar[allVar %in% c(xCol, input$colorSet)]
  #                   }else if(input$colorSet == "none" && isTruthy(input$shapeLine)){
  #                     if(input$shapeLine == "Shape"){
  #                       allVar[allVar %in% c(xCol, input$shapeSet)]
  #                     }else if(input$shapeLine == "Line type"){
  #                       allVar[allVar %in% c(xCol, input$lineSet)]
  #                     }else if(identical(input$shapeLine, c("Shape", "Line type"))){
  #                       allVar[allVar %in% c(xCol, input$shapeSet, input$lineSet)]
  #                     }
  #                   }
  #         
  #       selectInput(inputId = "groupComputeStatOption", label = NULL, choices = choseVar, selected = xCol, multiple = TRUE)
  #     }
  #   }
  # })
  # 
  # #display the formula
  # output$UiFormula <- renderUI({
  #   req(refresh_2())
  #   if(req(input$stat != "none")) textOutput("showFormula")
  # })
  # output$showFormula <- renderText({
  #   req(input$stat != "none")
  #   "* Formula = numeric ~ category"})
  # 
  # #Formula: option for numeric (dependent) variable
  # output$UiDependentVar <- renderUI({
  #   req(refresh_2(), input$stat != "none")
  #   yVar <- if(pltType() != "none" && is.data.frame(ptable())){
  #     yVar()
  #   }else{
  #     ""
  #   }
  #   allVars <- if(pltType() != "none" && is.data.frame(ptable())){
  #     allChar <- allNumCharVar(data = ptable(), checks = "numeric")
  #   }else {
  #     ""
  #   }
  #   if(input$stat != "none") selectInput(inputId = "dependentVar", label = "Numeric \nvariable", choices = allVars, selected = yVar)
  # })
  # #get the categorical variables chosen by the user for grouping and exclude from categorical formula
  # groupVarStat <- reactive({ req(input$groupComputeStatOption)
  #   # req(input$groupComputeStat == "yes")
  #   # if(input$groupComputeStatOption==""){
  #   #   "" #if user does not select anything
  #   # }else{
  #   #   input$groupComputeStatOption
  #   # }
  # })
  # 
  # # reactive({req(input$groupComputeStatOption)})
  # #Formula: option for categorical variable
  # varForIndependent <- reactive({
  #   req(refresh_2(), pltType(), input$stat)
  #   if(pltType() != "none" && is.data.frame(ptable())){
  #     #below condition apply only when the table is a data frame
  #     allCols <- colnames(ptable())
  #     
  #     # if((input$colorSet != "none" || !isTruthy(input$shapeLine)) && input$stat != "none"){
  #     if((input$colorSet == "none" || !isTruthy(input$shapeLine)) && input$stat != "none"){
  #       #when no additonal aesthetic is given in the mapping, provide only the
  #       # variables of x-axis (x-axis is also the default variable) 
  #       allCols <- allCols[allCols %in% c(colnames(xVar()))]
  #       # allCols <- allCols[!allCols %in% c(colnames(yVar()), input$dependentVar)]
  #     }else {
  #       #Only for additional aesthetic parameters given by the user
  #       if(input$stat != "anova" && input$groupComputeStat == "yes"){
  #         req(groupVarStat()) #it is a must for applying group_by
  #         allCols <- allCols[!allCols %in% c(groupVarStat(), colnames(yVar()), input$dependentVar)]
  #         # if(groupVarStat() == ""){
  #         #   #if user does not select any var
  #         #   allCols <- allCols[!allCols %in% c(colnames(yVar()), input$dependentVar)]
  #         # }else{
  #         #   allCols <- allCols[!allCols %in% c(groupVarStat(), colnames(yVar()), input$dependentVar)]
  #         # }
  #       }else{ #if(input$stat != "anova" && input$groupComputeStat == "no"){
  #         allCols <- allCols[!allCols %in% c(colnames(yVar()), input$dependentVar)]
  #       }
  #     }
  #   }else{ #if(pltType() == "none" || !is.data.frame(ptable()) || (pltType() != "none" && !is.data.frame(ptable()))){
  #     ""
  #   }
  # })
  # 
  # #not applied
  # output$UiIndependentVar <- renderUI({
  #   req(refresh_2(), pltType(), input$stat != "none")#, varForIndependent()) #input$groupComputeStat)#,
  #   #for selected:
  #   if(pltType() != "none" && is.data.frame(ptable())){
  #     selectedVar <- colnames(xVar())
  #   }else{ selectedVar <- ""}
  # 
  #   if(!input$stat %in% c("none", "anova") | (input$stat == "anova" && input$pairedData == "one")){ #if anova it is one-way
  #     selectInput(inputId = "independentVar", label = "Categorical \nvariable", choices = varForIndependent(), selected = selectedVar, multiple =FALSE)
  #   }else if(input$stat == "anova" && input$pairedData == "two"){
  #     selectInput(inputId = "independentVar", label = "Categorical \nvariables", choices = varForIndependent(), multiple = T)
  #     # selectInput(inputId = "independentVar", label = ifelse(input$pairedData == "two", "Categorical \nvariables", "Categorical \nvariable(s)"), choices = allVars, multiple = T)
  #   }
  # })
  # #not applied
  # 
  #upto this------------------------------------------------------
  
  #Computed statistic data----------------
  #This will be shown as table in statistic summary
  statDataStore <- reactiveValues(df = data.frame(matrix(nrow = 5, ncol = 6)))
  statDataR <- reactiveValues(df=reactive({
    if(req(input$stat) == "none" && req(input$dependentVar) == "" && req(input$independentVar) == ""){
      NULL
    }else{
      message(statDataStore$df)
      statDataStore$df
    }
  })
  )
  
  #pvalue: p value or p.adjust
  output$UiChooseSignif <- renderUI({
    req(refresh_2(), input$stat != "none")
    if(!input$stat %in% c("anova")){
      checkboxInput(inputId = "choosePFormat", label = tags$span("p.adjust", style = "background:#f7f3f3; font-weight:bold; color:black"),value = TRUE)
    }
  })
  #p.adjust method
  output$UiChooseSignifMethod <- renderUI({
    pMethod <- c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr") 
    if(req(!input$stat %in% c("none", "anova"), isTruthy(input$choosePFormat))){
      selectInput(inputId = "signifMethod", label = NULL, choices = sort(pMethod), selected = "bonferroni")
    }
  })
  
  #label for p value
  output$UiChooseSignifLabel <- renderUI({
    req(refresh_2(), input$stat != "none")
    if(!input$stat %in% c("anova", "Kruskal test")){
      choiceList <- list(tags$span("value", style = "font-weight:bold; color:#0099e6"), tags$span("symbol", style = "font-weight:bold; color:#0099e6"))
      radioButtons(inputId = "choosePLabel", label = "Choose p label format", choiceNames = choiceList, choiceValues = c("p.adj","p.adj.signif"),
                   selected = "p.adj", inline = TRUE)
      # checkboxGroupButtons(inputId = "choosePLabel", label = "Choose p label format", choiceNames = choiceList, choiceValues = c("p.adj","p.adj.signif"),
      #                      selected = "value", size = "sm", status = "primary", individual =TRUE)
      # selectInput(inputId = "chooseLabel", label = "Choose label format", choices = c("symbol","value"))
    }
  })
  
  #pairwise comparison: perform pairwise comparisons only when the users add more aesthetics 
  #like color, fill, shape or line type. Otherwise pairwise comparisons does not make sense.
  #In other words, performed pairwise between variables of x-axis in addition to the comparison
  #computed between variables assign by other aesthetic parameters.
  # output$UiPairwiseComparison <- renderUI({
  #   req(refresh_2(), input$stat != "none")
  #   nameList <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
  #   if((input$colorSet != "none" || isTruthy(input$shapeLine)) && !input$stat %in% c("none", "anova", "Kruskal test")) radioButtons(inputId = "pairwiseComparison", label = "Add pairwise comparison?", 
  #                                         choiceNames = nameList,
  #                                         choiceValues = c("no","yes"), inline = TRUE)
  #                                         # choices = c("No","Yes"), selected = "No", inline = TRUE) 
  # })
  #pairwise method
  output$UiPairSignif <- renderUI({
    req(refresh_2(), pltType(), input$pairwiseComparison == "yes")
    if(pltType() %in% c("none","box") || isTRUE(needYAxis())){
      if(req(input$facet) %in% c("none", "wrap")){
        selectInput(inputId = "pairStat", label = "Pairwise statistical method", choices = c("none","t.test","wilcox.test", "anova","Kruskal.test"), selected = "none") 
        # }else if(req(input$facet) %in% c("grid", "wrap")){
      }else{
        selectInput(inputId = "pairStat", label = "Pairwise statistical method", choices = c("none"))
      }
    }else{
      selectInput(inputId = "pairStat", label = "Pairwise statistical method", choices = c("none"))
    }
  })
  #not yet implemented in the UI
  #pairwise: choose numeric (dependent) and categorical (independent) variable
  output$UiPairDependentVar <- renderUI({
    req(refresh_2())
    # var2 <- selectedVar2(data = ptable(), "numeric") #this should be x axis: check
    allVars <- allNumCharVar(data = ptable(), checks = "numeric")
    if(req(input$stat != "none")) selectInput(inputId = "dependentVar", label = "Numeric \nvariable", choices = allVars, selected = yVar())
  })
  output$UiPairIndependentVar <- renderUI({
    req(refresh_2())
    # var <- selectedVar(data = ptable())
    allVars <- allNumCharVar(data = ptable(), checks = "character")
    if(req(input$stat != "none")) selectInput(inputId = "independentVar", label = "Categorical \nvariable(s)", choices = allVars, selected = xVar())
  })
  
  #t-test parameters----------------------------------------
  #compute t-test by comparisons or reference group 
  observe({
    req(refresh_2(), input$stat != "none")
    
    output$UiCompareOrReference <- renderUI({
      if(input$stat %in% c("t.test", "wilcox.test")){
        selectInput(inputId = "compareOrReference", label = "Compare or add reference", choices = c("none","comparison", "reference group"), selected = "none")
      }
    })
    
  })
  
  #compute stat without comparisons for t test
  output$UiNoCompareTTest <- renderUI({
    req(refresh_2())
    if(req(input$stat == "t.test", input$compareOrReference == "none")) selectInput(inputId = "TtestGroupBy", label = "Group by", choices = c("none",input$xAxis))
  })
  
  #empty list to collect groups from user for comparison: require to preceed the below command
  grpList <- list()
  
  #provide option to add group
  output$UiListGroup <- renderUI({
    req(refresh_2(), ptable(), input$xAxis, !input$stat %in% c("none", "anova", "Kruskal test"), input$compareOrReference != "none")
    
    if(input$compareOrReference != "none"){
      #get the variables to be compare or reference
      # req(ptable(), input$xAxis)
      varCR <-reactive(unique(ptable()[[input$xAxis]]))
      checkList <- reactive({ 
        #emptied the list every time user choose comparison or reference
        grpList <<- list()
        input$compareOrReference
      })
      if(checkList() == "comparison"){
        selectInput(inputId = "listGroup", label = "Choose 2 variables per group", choices = varCR(), multiple = TRUE)
      }else{
        if(input$pairedData == "yes"){
          #for paired data
          selectInput(inputId = "listGroup", label = "Choose 1 variable as reference", choices = c("all",varCR()), multiple = FALSE)
        }else{
          #for unpaired data, 'all' is not applicable
          selectInput(inputId = "listGroup", label = "Choose 1 variable as reference", choices = c(varCR()), multiple = FALSE)
        }
      }
    }
  })
  
  #add group action
  output$UiAddGroupAction <- renderUI({
    # req(input$listGroup, input$compareOrReference != "none")
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcox.test"), input$compareOrReference != "none")
    if(input$stat %in% c("t.test","wilcox.test") && input$compareOrReference != "none") actionButton(inputId = "addGroupAction", label = span("Add", style = "color:white; font-weight:bold"), class = "btn-success", width = '100%')
  })
  #delete group action
  output$UiDeleteGroupAction <- renderUI({
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcox.test"), input$compareOrReference != "none")
    if(input$stat %in% c("t.test","wilcox.test") && input$compareOrReference != "none") actionButton(inputId = "deleteGroupAction", label = span("Delete", style = "color:white; font-weight:bold"), class = "btn-danger", width = '100%')
  })
  #steps to add or delete groups for comparisons
  #get the users provided list
  givenGrp <- reactive(req(input$listGroup))
  
  
  
  #stop here compRef----------------------------------
  #object to collect and save the list of groups provided by the user
  cmpGrpList <- reactiveValues(lists = NULL) #list for comparison
  rfGrpList <- reactiveValues(lists = NULL) #list for reference group
  
  #Whenever user click "add", then save it to the list
  observeEvent(req(input$addGroupAction),{
    message("get group")
    if(input$compareOrReference == "comparison"){
      req(length(givenGrp()) == 2) #the list must be 2 elements
      grpList <<- grpAddDel(lst = grpList, grp = givenGrp(), act = "add")
      cmpGrpList$lists <<- grpList
    }else{
      #no need to append for referencing.
      grpList <<- list(input$listGroup)
      rfGrpList$lists <<- grpList
    }
  })
  
  #delete from the list if user click the delete button
  observeEvent(req(input$deleteGroupAction),{
    if(input$compareOrReference == "comparison"){
      grpList <<- grpAddDel(lst = grpList, grp = givenGrp(), act = "delete")
      cmpGrpList$lists <<- grpList
    }else{
      grpList <<- list()
      rfGrpList$lists <<- grpList
    }
  })
  
  #update the cmpGrpList & rfGrpList: list for comparison or referencing-----------
  #Reset the list to null when user switch between "none", "comparison" and "reference group"
  observe({
    req(!is_empty(cmpGrpList$lists) | !is_empty(rfGrpList$lists))
    message("-------not empty--------------")
    if(!is_empty(cmpGrpList$lists) && input$compareOrReference != "comparison"){
      #Comparison list is not null and user has switch to "none" or "reference group", then
      # reset the list for comparison to null
      cmpGrpList <<- reactiveValues(lists = NULL)
      
    }else if(!is_empty(rfGrpList$lists) && input$compareOrReference != "reference group"){
      #reference group is not null and user switch to "none" or "comparison", then
      # reset the list to null
      rfGrpList <<- reactiveValues(lists = NULL)
    }
  })
  #Check that the list is in a proper format of rstatix
  #   case 1: refernce group - require only 1 element
  #   case 2: comparison - require at least 1 group with 2 elements.
  # observe({
  #   req(!is.null(cmpGrpList$lists))
  #   message("==098==================09=======")
  #   message(glue::glue(glue::glue("cmpGrpList: {isolate(cmpGrpList$lists)}")))
  #   if(input$compareOrReference == "none"){
  #     message("-------------None=============")
  #     #if user choose none, than reset the list to null
  #     cmpGrpList <<- reactiveValues(lists = NULL)
  #   }else if(input$compareOrReference == "comparison"){
  #     message("-------------compare==========")
  # 
  #     #check the cmpGrpList$list. If it has less than or greater than 2 elements in any of the sets, then
  #     #       #case 1: it must have change back from "reference group" to "comparison". clear the cmpGrpList$list
  #     checkForOneVar <- any(lapply(cmpGrpList$lists, length) != 2)
  #     if(isTRUE(checkForOneVar)){
  #       cmpGrpList <<- reactiveValues(lists = NULL)
  #     }
  #   }else if(input$compareOrReference == "reference group"){
  #     message("-------------Ref=============")
  #     #If the length is more than 1 or it has more than 1 elements in the first set, then
  #     #       #case 1: it must have change back from "comparison" to "reference group". clear the cmpGrpList$list
  #     len <- length(cmpGrpList$lists)
  #     checkForTwoVar <- any(lapply(cmpGrpList$lists, length) != 1)#any(length(cmpGrpList$lists[1]) > 1)
  #     message(glue::glue(glue::glue("cmpGrpList: {isolate(cmpGrpList$lists[1])}")))
  #     message(glue::glue(glue::glue("cmpGrpList: {any(lapply(cmpGrpList$lists, length) != 1)}")))
  #     if((len == 1 && isTRUE(checkForTwoVar)) || len != 1){
  #       cmpGrpList <<- reactiveValues(lists = NULL)
  #     }
  # 
  #   }
  #   message(glue::glue("cmpGrpList null?== {is_empty(cmpGrpList$lists)}"))
  # })
  
  #switch to add comparison or reference group(s): its a global list
  switchGrpList <- reactiveValues(switchs = 0)
  observeEvent(req(input$addGroupAction | input$deleteGroupAction),{
    if(is_empty(cmpGrpList$lists)){
      #if all the lists are deleted or provide nothing
      switchGrpList$switchs <<- 0
    }else{
      switchGrpList$switchs <<- 1 
    }
  })
  
  
  
  # observe(req(input$addGroupAction,{
  #   message("get group")
  #   if(input$compareOrReference == "comparison"){
  #     #check the cmpGrpList$list. If it has less than 2 elements in each set, then 
  #       #case 1: it must have change back from "reference group" to "comparison". clear the cmpGrpList$list
  #       
  #     checkForOneVar <- any(lapply(cmpGrpList$lists, length) == 1)
  #     len <- length(cmpGrpList$lists)
  #     
  #     if(isTRUE(checkForOneVar)){
  #       #empty the list
  #       cmpGrpList <- reactiveValues(lists = NULL)
  #       req(length(givenGrp()) == 2)
  #       grpList <<- grpAddDel(lst = grpList, grp = givenGrp(), act = "add")
  #     }else{
  #       req(length(givenGrp()) == 2)
  #       grpList <<- grpAddDel(lst = grpList, grp = givenGrp(), act = "add")
  #     }
  #     # req(length(givenGrp()) == 2) #the list must be 2 elements
  #     
  #   }else if(input$compareOrReference == "reference group"){
  #     #element must be one: if not
  #       #case 1: user must have changed back from "comparison" to "reference group". So, wait for adding one variable
  #     
  #     req(length(givenGrp()) == 1) #the list must be 1 elements
  #     #no need to append for referencing.
  #     grpList <<- list(input$listGroup)
  #   }
  #   cmpGrpList$lists <<- grpList
  # })
  
  #display the groups in above box
  output$UiShowListGroup <- renderUI({
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcox.test"), input$compareOrReference != "none", input$addGroupAction)
    verbatimTextOutput("showListGroup", placeholder = TRUE)
    # textOutput("showListGroup") #not ideal for this case
  })
  
  output$showListGroup <- renderText({
    req(input$stat != "none", input$compareOrReference != "none", input$addGroupAction | input$deleteGroupAction)
    if(input$compareOrReference == "comparison"){
      paste0(grpList,",")
    }else{paste0(grpList)}
  })
  
  # output$UiShowListGroup <- renderUI({
  #   req(input$stat %in% c("t.test","wilcox.test"), input$compareOrReference != "none", input$addGroupAction | input$deleteGroupAction)
  #   if(input$compareOrReference == "comparison"){
  #     helpText( glue::glue("Groups for comparison: \n
  #     {grpList }") )
  #   }else{paste0(grpList)}
  # })
  #if user choose reference group, than user might need to turn off the coloring option
  #facet-------------------------------------------------------------
  #choose facet type
  observe({
    req(refresh_2(), pltType(), input$stat)
    
    output$UiFacet_1 <- renderUI({
      # selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
      
      if(req(input$stat) == 'none'){
        selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
      }else if(input$stat != "anova" || (input$stat == "anova" && req(input$pairedData) == "one")){
        #off facet when user apply statistic, except for anova, else it is difficult to analyse.
        selectInput(inputId = "facet", label = "Facet type", choices = "none")
      }else{
        #for two-way anova, it require more parameters to apply facet
        req(input$pairedData == "two", input$anovaFigure)
        if(input$anovaFigure != "Interaction"){
          #no facet for other figure
          selectInput(inputId = "facet", label = "Facet type", choices = "none")
        }else{
          selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
        }
      }
      
    })
  })
  
  
  # output$UiFacet_1 <- renderUI({
  #   req(refresh_2())
  #   if(input$stat != "anova" || (input$stat == "anova" && req(input$pairedData) == "one")){
  #     selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
  #   }else{
  #     #for two-way anova, it require more parameters to apply facet
  #     req(input$pairedData == "two", input$anovaFigure)
  #     if(input$anovaFigure != "Interaction"){
  #       selectInput(inputId = "facet", label = "Facet type", choices = "wrap")
  #     }else{
  #       selectInput(inputId = "facet", label = "Facet type", choices = c("none","grid","wrap"), selected = "none")
  #     }
  #   }
  #   
  # })
  
  
  col <- eventReactive(
    req(is.data.frame(ptable())),{
      colnames(ptable())
    })
  
  facetType <- reactive(req(input$facet, cancelOutput=TRUE))
  gridWrapInput <- function(id = "varRow", label = list("Facet row","Facet by"),type = facetType(), choice = NULL, selected = NULL){ # nolint
    if(type == "grid"){
      selectInput(inputId = id, label = label[[1]], choices = choice, selected = selected, multiple = FALSE) #multiple was difficult to implement in the function for plotting the facet
    }else if(type == "wrap"){
      selectInput(inputId = id, label = label[[2]], choices = choice, selected = selected, multiple = F)
    }
  }
  
  #implement later------------------------
  # var1 <- reactive({
  #   #option for variables: no interesect between varRow and varColumn
  #   if(!isTruthy(input$varColumn)){
  #     var <- col()
  #   }else if(isTruthy(req(input$varColumn, cancelOutput = TRUE))){
  #     var <- col()[!col() %in% input$varColumn]
  #   }
  # })
  # 
  # var2 <- reactive({
  #   #remove the variable selected in the facet row
  #     if(isTruthy(input$varRow)){
  #       #col2 <- c("none", col())
  #       var <- col()[!col() %in% input$varRow]
  #     }else{
  #       var <- col()
  #     }
  # })
  #----------------------------------------
  
  #Variables for both grid and wrap
  observe({
    req(refresh_2(), ptable(), is.data.frame(ptable()), pltType() != 'none', input$facet != "none")
    
    output$UiVar_1 <- renderUI({
      
      #select variables to be used as selected: only string type
      var <- selectedVar(data = ptable())
      # if(pltType %in% xyRequire){
      #   var2 <- var[ var != colnames(yVar())]
      # }else{
      #   
      # }
      
      if(input$plotType == "none"){
        gridWrapInput(choice = NULL)
      }else{
        gridWrapInput(choice = col(), selected = var)
      }
    })
    
    #input for column facet_grid
    output$UiVar_2 <- renderUI({
      #get next variables to be used as selected for column: only string type
      varC <- selectedVar2(data = ptable(), )
      if(req(input$facet) == "grid"){
        if(input$plotType == "none"){
          gridWrapInput(id = "varColumn", label = list("Facet column"), type = "grid", choice = NULL)
        }else{
          gridWrapInput(id = "varColumn", label = list("Facet column"), type = "grid", choice = col(), selected = varC)
        }
      }
    })
    
  })
  
  # output$UiVar_1 <- renderUI({
  #   req(refresh_2(), input$facet != "none")#, is.data.frame(ptable()))
  #   #select variables to be used as selected: only string type
  #   var <- selectedVar(data = ptable())
  #   if(input$plotType == "none"){
  #     gridWrapInput(choice = NULL)
  #   }else if(input$plotType != "none" && (input$stat != "anova" || (input$stat == "anova" && input$pairedData == "one"))){
  #     gridWrapInput(choice = col(), selected = var)
  #   }else if(input$plotType != "none" && input$stat == "anova" && input$pairedData == "two"){
  #     
  #     req(input$anovaFigure)
  #     #get the var for facet: two-way anova figure for non-interaction
  #     col <- reactive({
  #       if(input$anovaFigure %in% c("Interaction", colnames(xVar()))){
  #       input$twoAovVar
  #       }else{ colnames(xVar()) }
  #     })
  #     gridWrapInput(choice = col())
  #     
  #   }
  # })
  
  
  observe({
    req(refresh_2(), input$facet == "wrap")
    
    #number of row and columns for facet_wrap
    output$UiRowColumn_1 <- renderUI({
      numericInput(inputId = "nRow", label = "Row", value = 0, min = 0, max = 25)
    })
    output$UiRowColumn_2 <- renderUI({
      # req(refresh_2(), input$facet == "wrap")#, input$varRow != "none")
      numericInput(inputId = "nColumn", label = "Column", value = 0, min = 0, max = 25)
    })
    
  })
  
  #scale for facet
  observe({
    req(refresh_2(), input$facet != "none")
    
    output$UiScales <- renderUI({
      optLs <- list(tags$span("Fixed", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Free", style = "font-weight:bold; color:#0099e6"))
      if(input$plotType == "none"| input$facet == "none"){
        radioButtons(inputId = "scales", label = "Choose scale", choiceNames = optLs, choiceValues= c("Fixed","Free"), selected = character(0), inline = TRUE)
      }else if(input$plotType != "none" & input$facet != "none"){
        radioButtons(inputId = "scales", label = "Choose scale", choiceNames = optLs, choiceValues= c("Fixed","Free"), selected = "Fixed", inline = TRUE)
      }
    })
  })
  
  
  
  #Addition of layer to the main geom----------------------------------
  output$UiLayer <- renderUI({
    req(refresh_2(), pltType())
    #it require both x and y-axis
    reqPlot <- c("none","box","line", "scatter", "Violine plot")
    layerChoice <- c("line", "smooth", "point", "jitter")
    # if(pltType() %in% reqPlot || (pltType() == "histogram" & isTRUE(xyAxisReady()))){
    if(pltType() %in% reqPlot || isTRUE(needYAxis())){
      selectInput(inputId = "addLayer", label = "Additional layer", choices = c("none", sort(layerChoice)), selected = "none") 
    }else{# if(isTruthy(input$xAxis) | isTruthy(input$yAxis)){
      selectInput(inputId = "addLayer", label = "Additional layer", choices = c("none")) 
    }
  })
  
  output$UiLayerSize <- renderUI({
    if(req(input$addLayer) != "none") sliderInput(inputId = "layerSize", label = "Adjust size", min = 1, max = 10, value = 1)
  })
  
  
  #summary panel---------------------
  
  # #Ui for data summary
  observe({
    req(is.data.frame(ptable()))
    
    output$summaryDataCaption <- renderUI({
      if(is.data.frame(ptable())){
        helpText("Table 1. summary of the data", style = "margin-top:30px; margin-bottom:0; font-weight:bold; font-size:20px")
      }
    })
    
    output$UiDataSummary <- renderPrint({
      if(is.data.frame(ptable())){
        #convert x-axis to factor and display the summary if x-axis is selected
        if(isTruthy(input$xAxis)){
          req(xVar())
          input_data <- ptable() %>% mutate( across(.data[[colnames( xVar() )]], factor ) )
        }else{
          input_data <- ptable()
        }
        #exclude the column starting with sd
        input_data <- input_data %>% dplyr::select(!starts_with("sd_"))
        # data %>% mutate(across(Species, factor)) %>% head()
        #custome skim
        cust_hist <- skim_with(base = sfl(missing_value = n_missing),
                               character = sfl(whitespace = NULL, min=NULL, max = NULL, empty = NULL ),
                               factor = sfl( ordered = NULL, count =top_counts, top_counts=NULL),
                               numeric = sfl( hist = NULL, p0 = NULL, p25=NULL, p50=NULL, p75=NULL, p100=NULL, min = min, median =median, max= max)
        )
        # summary(ptable())
        cust_hist(input_data)
      }
    })
  })
  
  # #Display normality and homogeneity test for parametric statistic
  observe({
    req(is.data.frame(ptable()), pltType() != "none", input$xAxis, input$yAxis, input$stat %in% c("t.test", "anova"))
    
    #title
    output$UiAssumptionTitle <- renderUI({
      if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
        validate("")
      }
      
      if(input$stat %in% c("t.test", "anova"))
        helpText("Testing assumptions for the parametric test", style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px")
    })
    
    #get input param for liner regression
    num_var <- input$yAxis #dependent variable
    #get independent variable
    if(input$stat == "t.test"){
      #case 1: no aesthetic is provided or aesthetic is equal with the x-axis than apply simple regression
      #case 2: one aesthetic is provided and different from x-axis, then apply regression with only interaction
      #case 3: more than one aesthetics are provided, color will override other.
      if(input$colorSet == "none" || input$colorSet == input$xAxis){
        if(!isTruthy(input$shapeLine)){
          
          #no aesthetic provided or equal with x-axis
          ind_var <- input$xAxis
          
        }else{
          
          #aesthetic for shape or line type is provided
          if(input$shapeLine == "shape"){
            if(req(input$shapeSet) == input$xAxis){
              #equal with x-axis
              ind_var <- input$xAxis
            }else{
              #not equal with x-axis
              ind_var <- paste0(input$xAxis,":",input$shapeSet)
            }
          }else if(input$shapeLine == "Line type"){
            if(req(input$lineSet) == input$xAxis){
              #equal with x-axis
              ind_var <- input$xAxis
            }else{
              #not equal with x-axis
              ind_var <- paste0(input$xAxis,":",input$lineSet)
            }
          }
          
        }
        
      }else if(input$colorSet != 'none' && input$colorSet != input$xAxis){
        #aesthetic provided for color and not equal with x-axis
        # override: no need to check for other aesthetics
        ind_var <- paste0(input$xAxis,":",input$colorSet)
      }
      
      #end of t.test
    }else if(input$stat == "anova"){
      
      req(input$pairedData)
      av <- input$pairedData
      if(av == "one"){
        ind_var <- input$xAxis
      }else{
        req(input$anovaModel, input$twoAovVar)
        if(input$anovaModel == "additive"){
          ind_var <- paste0(input$xAxis,"+", input$twoAovVar)
          #for levene test, it has to be crossed
          lv_var <- paste0(input$xAxis,"*", input$twoAovVar)
        }else{
          ind_var <- paste0(input$xAxis,"*", input$twoAovVar)
        }
      }
    }#end of anova
    
    
    #formula
    message("--------ind_var for regress")
    message(ind_var)
    if(input$stat %in% c("t.test", "anova")){
      forml <- reformulate(response = glue::glue("{num_var}"), termlabels = glue::glue("{ind_var}")) 
      #run linear regression based on user's input.
      tryCatch({
        model <- lm(data = ptable(), formula = forml)  
        #residual
        resl <- resid(model)
      }, error = function(e){
        print(e)
      })
      
    }
    
    #residual plot
    output$UiResidualPlot <- renderPlot({
      if(pltType() != "none" && input$stat %in% c("t.test", "anova")){
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          plot(fitted(model), resl, main= "Figure 1. Residual plot", ylab="residual") %>% abline(0,0, col="red")
        }
      }
      res=350
    })
    
    #density plot
    output$UiNDensityPlot <- renderPlot({
      if(pltType() != "none" && input$stat %in% c("t.test", "anova")){
        
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          plot(density(resl), main="Figure 2. Density plot of residuals")
        }
      }
      res=350
    })
    
    #qqplot
    output$UiQqplot <- renderPlot({
      if(pltType() != "none" && input$stat %in% c("t.test", "anova")){
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          qqnorm(resl, main="Figure 3. Q-Q plot of residuals")
          qqline(resl, col="red") 
        }
      }
      res=350
    })
    
    #normality test
    # case 1. if sample size is between 3 and 5000, use Shaprio-Wilk test
    # case 2: sample size is above 5000, use Kolmogorov-Smirnov test
    output$UiTestCaption <- renderUI({
      
      if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
        validate("")
      }
      
      if(pltType() != "none" && input$stat %in% c("t.test", "anova")){
        
        #levene test
        if(input$stat == "anova" && input$pairedData == 'two' && input$anovaModel == "additive"){
          form_lv <- reformulate(response = glue::glue("{num_var}"), termlabels = glue::glue("{lv_var}")) #used in levene test 
          model_lv <- lm(data = ptable(), formula = form_lv) 
          lvT <- car::leveneTest(model_lv)
        }else{
          lvT <- car::leveneTest(model)
        }
        
        #get sample size
        sampleSize <- nrow(ptable())
        x <- rstandard(model)
        
        if(sampleSize <= 5000){
          
          #shapiro
          message("shaprio length")
          message(length(x))
          message(sampleSize)
          normT <- shapiro.test(x)
          if(normT$p.value <= 0.05 | lvT[1,3] <= 0.05){
            helpText(glue::glue("Levene's test p-value is { format(lvT[1,3], digit=3) } and Shapiro-Wilk's normality test p-value is { format(normT$p.value, digit = 3) }"), style = "color:red; margin-left:10%; margin-right:10%;")
          }else{
            helpText(glue::glue("Levene's test p-value is { format(lvT[1,3], digit=3) } and Shapiro-Wilk's normality test p-value is { format(normT$p.value, digit = 3) }"), style = "color:#3385ff; margin-left:10%; margin-right:10%;")
          }
          
        }else{
          normT <- ks.test(x, "pnorm")
          if(normT$p.value <= 0.05 | lvT[1,3] <= 0.05){
            helpText(glue::glue("Levene's test p-value is { format(lvT[1,3], digit=3) } and Kolmogrov-Smirnov's normality test p-value is { format(normT$p.value, digit = 3) }"), style = "color:red;margin-left:10%; margin-right:10%;")
          }else{
            helpText(glue::glue("Levene's test p-value is { format(lvT[1,3], digit=3) } and Kolmogrov-Smirnov's normality test p-value is { format(normT$p.value, digit = 3) }"), style = "color:red;margin-left:10%; margin-right:10%;")
          }
        }
        
        
      }
      
    })
    
  }) #end of testing assumptions for parametric test
  
  
  #computed data for statistic
  # testTable <- reactiveValues(df=NULL)
  # postHoc_table <- reactiveValues(df = NULL)
  # effectSize <- reactiveValues(df=NULL)
  #display statistic data 
  observe({
    
    req( is.data.frame(ptable()), pltType() != 'none', input$stat != 'none', !is.null(testTable$df), unpaired_stopTest() == 'no' )
    #caption
    output$UiStatSumCaption <- renderUI({
      if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
        validate("")
      }
      #type of stat
      if(input$stat == "t.test"){
        req(input$ttestMethod)
        
        if(input$ttestMethod == "welch"){
          ttype <- "t-test (Welch's test)"
        }else{
          ttype <- "t-test (Student's test)"
        }
        
      }else if(input$stat == "Kruskal test"){
        
        ttype <-  "Kruskal-Wallis test"
        
      }else if(input$stat == 'anova'){
        #for anova
        req(input$pairedData)
        if(input$pairedData == "one"){
          ttype <- "one-way ANOVA"
        }else{
          if(input$anovaModel == "additive"){
            ttype <- "two-way ANOVA (additive model)"
          }else{
            ttype <- "two-way ANOVA (non-additive model)"
          }
        }
        
      }else if(input$stat == "wilcox.test"){
        
        if(input$pairedData == "no"){
          ttype <- "Wilcoxon rank-sum test"
        }else{
          ttype <- "Wilcoxon sign-rank test"
        }
        
      }
      
      helpText(glue::glue("Table 2. Summary for {ttype}."), style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px;")
    })
    
    output$UiStatSubCaption <- renderUI({
      
      if(input$stat %in% c('t.test', 'wilcox.test')){
        if(unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          subCaption <- "'.y.' is the variable used in y-axis; 'group 1 & 2' are the groups compared in the test;
        'n' are the sample counts; 'statistic' is the test used to compute the p-value;
        'p' is the p-value"
        }
        
      }else if(input$stat == "Kruskal test"){
        subCaption <- "'.y.' is the y-axis variable; 'n' is the count of sample; 'statistic' is the test used to compute the p-value; 'df' is the degree of freedom;
        'p' is the p-value"
      }else if(input$stat == "anova"){
        subCaption <- ""
      }
      
      helpText(subCaption, style = "padding: 5px; margin-top:10px; margin-bottom:0;font-size:15px")
    })
    
    
    message(testTable$df)
    message(str(testTable$df))
    #table for stat summary
    output$UiStatSummaryTable <- renderReactable({
      if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
        validate("")
      }else{
        reactable(as.data.frame(testTable$df), sortable = FALSE, pagination = FALSE)
      }
    })
    
    # output$UiStatSummaryTable <- renderPrint({
    #   if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
    #     validate("")
    #   }else{
    #     testTable$df
    #   }
    # })
    
  })
  
  #display effect size. 
  observe({
    
    req( is.data.frame(ptable()), pltType() != 'none', input$stat %in% c(statList), !is.null(effectSize$df) )
    # browser()
    #caption for effect size
    output$UiCapEffectSize <- renderUI({
      if(input$stat != 'none'){
        
        if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          helpText("Table 3. Table of effect size. Measures the strength of relationship between variables.", style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px;")
        }
        
      }
      
    })
    #sub-caption for effect size
    output$UiSubCapEffectSize <- renderUI({
      
      if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
        validate("")
      }
      
      if(input$stat == 't.test'){
        # subCaption <- "Effect size computed using Cohen's d. 'conf.low' and 'conf.high' represents lower and upper bound of the effect size confidence interval (95% confidence level)."
        subCaption <- "Effect size computed using Cohen's d."
      }else if(input$stat == "Kruskal test"){
        # subCaption <- "Eta-squared based on the H-statistic used as the measure of effect size. 'conf.low' and 'conf.high' represents lower and upper bound of the effect size confidence interval (95% confidence level)."
        subCaption <- "Eta-squared based on the H-statistic used as the measure of effect size."
      }else if(input$stat == "wilcox.test"){
        subCaption <- "Effect size is computed using z statistic (of Wilcoxon test) and divided by square root of the sample size."
      }else if(input$stat == "anova"){
        subCaption <- "Eta2 is the Generalized eta squared (Eta2); CI is the confidence interval; CI_low and CI_high are the upper and lower bound."
      }
      
      if(input$stat != 'none'){
        helpText(subCaption, style = "padding: 5px; margin-top:10px; margin-bottom:0;font-size:15px")
      }
    })
    #table for effect size
    output$UiEffectSize <- renderReactable({
      if(input$stat != 'none'){
        
        if(input$stat %in% c('t.test', 'wilcox.test') && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          reactable(as.data.frame(effectSize$df), sortable = FALSE, pagination = FALSE)
        }
      }
    })
  })
  # observeEvent(req(!is.null(statDataR$df())),{
  #   message(statDataR$df())
  #   output$UiStatSummaryTable <- renderReactable({
  #     reactable(statDataR$df(), highlight = TRUE, outlined = TRUE, compact = TRUE,
  #               wrap = FALSE, resizable = TRUE)
  #   })
  # })
  
  #post hoc table 
  
  observe({
    req(is.data.frame(ptable()), pltType() != "none", input$stat %in% c("anova", "Kruskal test"), !is.null(postHoc_table$df))
    
    #caption
    output$UiPostHocCaption <- renderUI({
      # if(input$stat == "anova"){
      #   tabn <- "Table 3."
      # }else{
      #   tabn <- "Table 4."
      # }
      tabn <- "Table 4."
      if(input$stat == "anova"){
        helpText(glue::glue("{tabn} Post-hoc analysis using Tukey's Honest Significant Difference method"), style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px")
      }else{
        helpText(glue::glue("{tabn} Post-hoc analysis using Dunnett's method"), style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px")
      }
      
    })
    #display post-hoc test
    output$UiPostHoc <- renderUI({
      verbatimTextOutput("postHocOut")
    })
    
    output$postHocOut <- renderPrint( postHoc_table$df )
  })
  
  
  #end of summary panel-----------------------
  
  #plotting figure------------------------------
  requirement <- function(){
    #function to add criteria for execution of plot
    #not yet 
    if(input$plotType == "box"){
      req(input$xAxis, cancelOutput = TRUE)
      req(input$yAxis, cancelOutput = TRUE)
    }else{}
  }
  #this function was not applied
  processColor <- function(data="data", varSet = "varSet", colorTxt = "colorTxt"){
    #function to process the customize input color: output will be list of color and length of variables
    #count variables from the input table
    countVar <- data %>% distinct(.data[[varSet]], .keep_all = TRUE) %>% nrow()
    editC <- if(colorTxt == ""){
      "not provided" #if no color is provided
    }else{
      #process the given color input by removing space and comma
      inputC <- strsplit(str_trim(gsub(" |,", " ", colorTxt))," +")[[1]]
    }
    list(editC, countVar, inputC)
  }
  
  #plot----------------------------------
  #save the plot for download
  saveFigure <- reactiveVal(NULL)
  finalPlt <- NULL #this is require to be able to delete after session end
  # ptable <- reactive({
  #   req(input$xAxis, input$normStand)
  #   ptable()
  # })
  observeEvent({
    req(is.data.frame(ptable()),
        input$xAxis,
        input$xAxis %in% colnames(ptable()),
        input$plotType != "none",
        input$normalizeStandardize
    )
  },{
    
    #required parameters
    figType <- reactive(req(input$plotType))
    
    #get x- and y-axis as list
    xyAxis <- reactive({
      
      if(figType() %in% xyRequire){
        
        list(input$xAxis, input$yAxis)
        
      }else if(!figType() %in% xyRequire){
        
        if(input$xAxis %in% colnames(ptable())) list(input$xAxis, NULL)
        
      }
    })
    
    #for color setting
    # autoCust <- reactive(if(varSet() != "none") input$autoCustome)
    autoCust <- reactive(ifelse(varSet() != "none", input$autoCustome, "none"))
    colorTxt <- reactive(ifelse(autoCust() == "customize", input$colorAdd, "noneProvided"))
    #for shape and line
    shapeLine <- reactive(ifelse(isTruthy(input$shapeLine), input$shapeLine, "none"))
    shapeSet <- reactive(if(shapeLine() == "Shape") req(input$shapeSet))
    lineSet <- reactive(if(shapeLine() == "Line type") req(input$lineSet))
    
    #stat method
    methodSt <- reactive(req(input$stat))
    ttestMethod <- reactive(ifelse(methodSt() == "t.test"&& input$ttestMethod == "student", TRUE, FALSE)) #welch = false, student=TRUE
    pairedData <- reactive(ifelse(req(input$pairedData) == "no", FALSE, TRUE)) #either 'no' or 'yes': no means unpaired
    anovaType <- reactive( ifelse(req(input$stat) == "anova", req(input$pairedData), "no anova"))
    model <- reactive(if(anovaType() == "two") input$anovaModel)
    
    #themes and other related paramters
    textSize <- reactive(req(input$textSize))
    titleSize <- reactive(req(input$titleSize))
    themes <- reactive(req(input$theme))
    varSet <- reactive(req(input$colorSet))
    
    #bar graph
    stackDodge <- reactive(if(figType() %in% c("bar", "histogram")) req(input$stackDodge))
    #param for histogram (removed this param from bar)
    # useValueAsIs <- reactive({ifelse(input$countIdentity == "count", FALSE, TRUE)
    #   #TRUE: provide y-axis and use the value as is
    # }) 
    #bin width
    binwd <- reactive(input$binWidth)
    #histogram color
    histBarColor <- reactive({
      if(figType() %in% c("histogram") && varSet() == "none" && isTruthy(input$histBarColor)){
        #get user input
        strsplit(input$histBarColor,  split= "\\s{1,}")[[1]][1]
      }else{ NA } #default color
    })
    histBarFill <- reactive({
      if(figType() %in% c("histogram") && varSet() == "none" && isTruthy(input$histBarFill)){
        strsplit(req(input$histBarFill), split= "\\s{1,}")[[1]][1]
      }else{"#737373"} #default fill
    })
    #frequency polygon settings
    freqPolySize <- reactive(ifelse(figType() != "histogram", req(input$freqPolySize), 1))
    
    #get type of plot: add bin width for histogram and connect line for line graph
    #group for connect the line path
    linC <- reactive({if(figType() == "line") {
      message("ccccccccccccc-------------")
      message(glue::glue("lineConnectPath: {input$lineConnectPath}---------------------------"))
      req(input$lineConnectPath) }})
    connectVar <- reactive({ifelse(figType() == "line" && linC() == "none", 1, linC())})
    
    #scatter plot
    handleOverplot <- reactive({ifelse(isTruthy(input$jitter), "jitter","identity")})
    #density
    trueVarSet <- reactive(ifelse(varSet() != "none", TRUE, FALSE)) #if color var is provided: TRUE ;else FALSE
    kernelDE <- reactive(if(figType() == "density") input$densityKernel)
    densityStat <- reactive(if(figType() == "density") input$densityStat)
    densityBW <- reactive(if(figType() == "density") input$densityBandwidth)
    densityAdj <- reactive(if(figType() == "density") input$densityAdjust)
    densityPos <- reactive(if(figType() == "density" && isTRUE(trueVarSet())) req(input$densityPosition))
    alpha <- reactive(if(figType() == "density" && isTRUE(trueVarSet())) input$alpha)
    
    #xVar <- ptable() %>% dplyr::select(.data[[input$xAxis]])
    geomTypes <- reactive({
      # message(glue::glue("connectVar: {connectVar()}"))
      switch(figType(),
             "box" = geom_boxplot(width = freqPolySize()),
             "Violine plot" = geom_violin(),
             "histogram" = if(xVarType()[1] == "character"){ 
               #Discrete variable
               if(varSet() == "none"){
                 stat_count(color = histBarColor(), fill = histBarFill(), position= stackDodge())#this is default, add color must override
               }else {
                 stat_count(position= stackDodge())
               }
             }else if(xVarType()[1] %in% c("integer", "numeric", "double")){
               #continuous variable
               if(varSet() == "none"){
                 stat_bin(color = histBarColor(), fill = histBarFill(), binwidth = binwd(), position= stackDodge())
               }else {
                 stat_bin(binwidth = binwd(), position= stackDodge())
               }
             },
             "frequency polygon" = if(xVarType()[1] == "character"){
               geom_freqpoly(stat = "count", group = 1, size = freqPolySize(), binwidth = binwd())
             }else if(xVarType()[1] %in% c("integer", "numeric", "double")){
               geom_freqpoly(size = freqPolySize(), binwidth = binwd())
             },
             "line" = if(connectVar() == 1){
               #no need to group for character type
               geom_line(size = freqPolySize())
             }else{
               geom_line(aes(group=.data[[connectVar()]]), size = freqPolySize())
             },
             "scatter" = geom_point(position = handleOverplot(), size = freqPolySize()),
             "density" = if(isTRUE(trueVarSet())){
               #if user provides additional setting
               if(densityPos() == "default"){
                 geom_density(kernel = kernelDE(), aes(y = switch(densityStat(),
                                                                  "count" = ..count..,
                                                                  "density" = ..density..,
                                                                  "scaled" = ..scaled..,
                                                                  "ndensity" = ..ndensity..
                 )), 
                 size = freqPolySize(), bw = densityBW(), adjust= densityAdj(), alpha = alpha())
               }else{
                 geom_density(kernel = kernelDE(), aes(y = switch(densityStat(),
                                                                  "count" = ..count..,
                                                                  "density" = ..density..,
                                                                  "scaled" = ..scaled..,
                                                                  "ndensity" = ..ndensity..
                 )), 
                 size = freqPolySize(), bw = densityBW(), adjust= densityAdj(), position = densityPos(), alpha = alpha())
               }
             }else{
               #no extra settings
               geom_density(kernel = kernelDE(), aes(y = switch(densityStat(),
                                                                "count" = ..count..,
                                                                "density" = ..density..,
                                                                "scaled" = ..scaled..,
                                                                "ndensity" = ..ndensity..
               )), 
               size = freqPolySize(), bw = densityBW(), adjust= densityAdj())
             },
             
             "bar" = geom_bar(stat = "identity", position = stackDodge(), width = freqPolySize() ),
             "none" = NULL
             
      )
    })
    message("---------replace dodge in bar-----------")
    
    #for labs() -labeling the x- and y-axis: list
    xyLable <- reactive({
      if(isTruthy(input$yLable) & isTruthy(input$xLable)){
        list(input$xLable, input$yLable)
      }else if(isTruthy(input$yLable)){
        list(NULL, input$yLable)
      }else if(isTruthy(input$xLable)){
        list(input$xLable, NULL)
      }else if(figType() == "density"){
        #for density, initial label for y has to be provided
        if(!isTruthy(input$yLable) && !isTruthy(input$xLable)){
          list(input$xAxis, densityStat())
        }else{ #users choice of labeling y axis
          list(input$xLable, input$yLable)
        }
      }
    })
    
    #histogram mean line
    histLinetypes <- reactive(if(input$histMean != "none") input$histMeanLine)
    colors <- reactive(if(input$histMean != "none") input$histMeanColor)
    sizes <- reactive(if(input$histMean != "none") input$histMeanSize)
    histGrpVar <- reactive(if(input$histMean == "group mean") input$histGroupVar)
    
    histLine <- reactive({
      if(figType() == "histogram"){
        if(xVarType()[1] %in% c("integer", "numeric", "double")){ #if variable is numeric, than mean or group mean
          message(glue::glue("histMean: {input$histMean}------"))
          if(req(input$histMean) %in% c("mean", "median")){
            geom_vline(aes(xintercept = mean(.data[[xyAxis()[[1]]]])), linetype = histLinetypes(), color = colors(), size = sizes())
          }else if(input$histMean == "group mean"){
            newDf <- ptable() %>% group_by(.data[[histGrpVar()]]) %>% summarise(grpMean = mean(.data[[xyAxis()[[1]] ]]))
            if(colors() == "default"){
              if(varSet() != "none"){
                geom_vline(data = newDf, aes(xintercept = grpMean, color= .data[[varSet()]]), linetype = histLinetypes(), size = sizes())
              }else{
                geom_vline(data = newDf, aes(xintercept = grpMean), linetype = histLinetypes(), size = sizes())
              }
            }else{
              geom_vline(data = newDf, aes(xintercept = grpMean), linetype = histLinetypes(), color = colors(), size = sizes())
            }
            
          }else if(input$histMean == "none"){
            geom_vline(xintercept = NULL)
          }
        }else {
          #x variable other than numeric
          geom_vline(xintercept = NULL)
        }
      }
    })
    
    
    #stop stat parameter-------------------------------------------------
    #parameters for computing statistics
    #dependent variable
    numericVar <- reactive({
      if(figType() %in% c("box","Violine plot", "bar","line", "scatter")){
        if(methodSt() != "none") xyAxis()[2]
      }else if(figType() %in% c("histogram")){
        #for histogram, it will depend upon the data used for ploting
        #1. count
        #2. use data as is
        "count"
      }
    })
    
    twoAovVar <- reactive(if(methodSt() == "anova" && anovaType() == "two" && (varSet() != "none" || shapeLine() != "none")) req(input$twoAovVar))
    ssType <- reactive(ifelse(methodSt() == "anova", input$ssType, "not anova"))
    #independent variable
    "For two-way anova: select x-axis and one more independent variable choosen by the user"
    catVar <- reactive({
      #aesthetic(s) not applied, use the variable of x-axis
      #aesthetic(s) applied
      #1. Variable of x-axis and aesthetic are equal, use variable of x-axis
      #2. variables are different, use the variables of aesthetic as categorical or independent variable in the formula
      if((methodSt() == "anova" && anovaType() == "one") || !methodSt() %in% c("none", "anova")){
        
        if( varSet() == "none" && shapeLine() == "none" ){
          xyAxis()[1]
        }else{
          
          if(varSet() != "none"){
            ifelse(varSet() == xyAxis()[1], xyAxis()[1], varSet())
          }else if(isTruthy(shapeSet())){
            ifelse(shapeSet() == xyAxis()[1], xyAxis()[1], shapeSet())
          }else if(isTruthy(lineSet())){
            ifelse(lineSet() == xyAxis()[1], xyAxis()[1], lineSet())
          }
          
        }
        
      }else if(methodSt() == "anova" && anovaType() == "two"){
        #Two variables for two-way anova
        message(glue::glue("xVar: {colnames(xVar())} == twoAovVar: {twoAovVar()} == color:{varSet()}"))
        c(colnames(xVar()),twoAovVar())
      }
      
    })
    #del-------------------
    #   #formula: numeric ~ category variable
    # numericVar <- reactive(if(methodSt() != "none") xyAxis()[2])
    # catVar <- reactive(if(methodSt() != "none"){
    #   message("independent variable ----------")
    #   message(input$independentVar)
    #   input$independentVar
    # })
    # 
    #del-------------------
    # groupStat <- reactive(if(methodSt() != "none") input$groupComputeStat)
    # groupStat <- reactive({ifelse(methodSt() != "none" && (varSet() != "none" || shapeLine() != "none"), input$groupComputeStat, "don't show")}) #if none: no grouping
    groupStat <- reactive({
      #If independant variable is equal with variable of x-axis, then no grouping: no
      #not equal, then grouped and compute: yes
      #grouping is not required for anova; this method not applied for anova
      if(!methodSt() %in% c("none", "anova", "Kruskal test") && (varSet() != "none" || shapeLine() != "none")){
        ifelse(catVar() %in% xyAxis()[1], "no", "yes")
      }else{
        "do nothing"
      }
    })
    #remove bracket from labeling the stat result in the plot
    removeBracket <- reactive(ifelse(!methodSt() %in% c("none", "anova") && isTruthy(input$removeBracket), TRUE, FALSE))
    
    groupStatVarOption <- reactive({ifelse(groupStat() == "yes", colnames(xVar()), "nothing")}) #I have use xVar(), instead of xyAxis()[1], to avoid error in using across()
    
    pAdjust <- reactive(ifelse(methodSt() != "none" && isTruthy(input$choosePFormat), TRUE, FALSE))
    pAdjustMethod <- reactive(
      if(isTRUE(pAdjust())){
        input$signifMethod
      }else{'none'}
    )
    choosePLabel <- reactive(ifelse(methodSt() != "none" && isTruthy(input$choosePLabel), input$choosePLabel, "value"))
    labelSt <- reactive({ 
      message(glue::glue("choosePLabel: {choosePLabel()}"))
      if(choosePLabel() == "p.adj.signif"){
        ifelse(isTRUE(pAdjust()),"p.adj.signif","p.signif")
      }else if(choosePLabel() == "p.adj"){
        ifelse(isTRUE(pAdjust()),"p.adj","p")
      }
    })#reactive(ifelse(isTruthy(input$choosePLabel), ifelse(isTRUE(pAdjust), "p.adj", "p"), FALSE)) #if false, no need to add add_significance
    
    compareOrReference <- reactive({
      if(methodSt() %in% c("t.test", "wilcox.test")){ req(input$compareOrReference) }
    })
    #inside1--------------------------------------
    # pairwiseComparison <- reactive(if(methodSt() != "none") input$pairwiseComparison)
    #line and bar graph error bar
    #add error bar?
    addErrorBar <- reactive(ifelse(figType() %in% c("line","bar", "scatter") && isTruthy(input$lineErrorBar), TRUE, FALSE)) #TRUE: add error bar
    #compute sd?
    computeSD <- reactive(ifelse(isTRUE(addErrorBar()) && input$lineComputeSd == "yes", TRUE, FALSE)) #TRUE: compute sd
    # countIdentity <- reactive(ifelse(figType() == "bar" && input$countIdentity != "count", TRUE, FALSE)) #TRUE: use the value as is
    
    #This is require for line, bar and scatter plot
    
    #which variable(s) to groupby for sd column?
    #IF no to compute SD than user will specify the computed columns
    lineGroupVarYN <- reactive(ifelse(isTruthy(input$lineGroupVar), TRUE, FALSE)) #TRUE means column is specified
    lineGroupVar <- reactive(if(isTruthy(input$lineGroupVar)) input$lineGroupVar) #get the sd specified by the user
    lineConnectPath <- reactive({ 
      if(figType()  == "line"){ 
        req(input$lineConnectPath)
      }else if(figType() %in% c("scatter", "bar")){
        NULL
      }
    }) #used to shift to basic or error bar
    errorBarColor <- reactive(req(input$errorBarColor))
    lineParam <- reactive({
      #all required parameters for line, bar and scatter graph will be saved as list: 3 elements
      
      #compute mean and sd from data
      if(isTRUE(addErrorBar())){
        
        colnm <- xyAxis()[[2]] #column name for y axis
        if(isTRUE(computeSD())){
          #To compute sd from data
          
          #If anova is applied:
          # case 1: one way anova will have same parameters as other plots for processing.
          # case 2: interaction of two way anova with non-additive wil have same parameters as other plots.
          # case 3: two-way with no interaction (additive and non-additive) will be processed differently.
          
          if(methodSt() != "anova" || (methodSt() == "anova" && req(anovaType()) == "one") || (methodSt() == "anova" && req(anovaType()) == "two" && req(input$anovaFigure) == "Interaction") ){
            
            #if aesthetic is not given or chosen aesthetic is equal with var of x-axis,
            # then compute sd from variable of x-axis.
            if( (varSet() == 'none' && shapeLine() == "none") || 
                ( varSet() == colnames(xVar()) && shapeLine() == "none" ) ||
                ( varSet() == "none" && shapeLine() != "none" &&  ( figType() %in% c("line", "bar") && lineSet() == colnames(xVar()) ) ) ||
                ( varSet() == "none" && shapeLine() != "none" &&  ( figType() == "scatter" && shapeSet() == colnames(xVar()) ) ) 
            ){
              
              message("computing sd")
              #compute SD
              newData <- sdFunc(x = ptable(), oName = colnames(xVar()), yName = colnm, lineGrp = lineConnectPath())
              
              #computing
              message("computed sd--------------")
              
              message(newData)
              message(colnames(newData))
              
              
            }else if( !varSet() %in% c("none", colnames(xVar())) ){
              #if variable for color is present and different from x-axis, no need to check for other aesthetics
              message("hereddss")
              newData <- sdFunc(x = ptable(), oName = c(colnames(xVar()), varSet()), yName = colnm, lineGrp = lineConnectPath() )
              
            }else if( varSet()  %in% c('none', colnames(xVar())) && shapeLine() != "none"){
              message("shapeLine not one")
              if( figType() %in% c("line", "bar") && lineSet() != colnames(xVar()) ){
                message("lineSet")
                newData <- sdFunc(x = ptable(), oName = c(colnames(xVar()), lineSet()), yName = colnm, lineGrp = lineConnectPath() )
              }else if(figType() == "scatter" && shapeSet() != colnames(xVar())){
                newData <- sdFunc(x = ptable(), oName = c(colnames(xVar()), shapeSet()), yName = colnm, lineGrp = lineConnectPath())
              }else{
                message("shapelineSet equal")
                newData <- sdFunc(x = ptable(), oName = c(colnames(xVar())), yName =  colnm, lineGrp = lineConnectPath() )
              }
            }
            #end of non anova
          }else {
            
            #for two way anova: require information of figure and grouping will be done based
            # on the variable chosen for the figure
            anovaFigure <- reactive(req(input$anovaFigure))
            
            message("two-anova")
            message(input$anovaFigure)
            #by default aesthetic will have only one option for two-way anova.
            newData <- sdFunc(x = ptable(), oName = anovaFigure(), yName = colnm, lineGrp = lineConnectPath())
            message("tow-done2")
            message(colnames(newData))
            message(newData)
          }#end of two-way anova
          
          
          
          #save the computed data as global for stat summary
          barData <<- newData
          #check users choice for error bar
          errorBarStat <- reactive(input$errorBarStat)
          if(errorBarStat() == "Standard deviation (SD)"){
            ebs <- "sd"
          }else if(errorBarStat() == "Standard error (SE)"){
            ebs <- "se"
          }else{
            ebs <- "ci"
          }
          #geom_errorbar
          geom_erbar <- switch(figType(),
                               "line" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                      width = 0.2, position = position_dodge(0.03), size = freqPolySize(), color = errorBarColor()),
                               "bar" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                     width = 0.2, position = position_dodge(width = 0.9), color = errorBarColor()),
                               "scatter" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                         width = 0.2, position = position_dodge(width = 0.9), size = freqPolySize(), color = errorBarColor())
          )
          
          # geom_erbar <- geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - sd, ymax = .data[[colnm]] + sd), 
          # 
          
          # width = 0.1, position = position_dodge(0.03), size = freqPolySize())
          
          #end of compute sd
        }else{
          newData <- ptable()
          if(isTRUE(lineGroupVarYN())){
            #if SD computed and specified the sd column
            # #convert the lineGroupVar to factor
            # newData <- newData %>% mutate(across(lineGroupVar(), factor))
            #geom_errorbar
            geom_erbar <- switch(figType(),
                                 "line" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                            ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  width = 0.1,
                                                        position = position_dodge(0.03), size = freqPolySize(), color = errorBarColor()),
                                 "bar" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                           ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  width = 0.2,
                                                       position = position_dodge(width = 0.9), color = errorBarColor()), #position will always be dodge for error_bar
                                 "scatter" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - sd, ymax = .data[[colnm]] + sd), 
                                                           width = 0.2, position = position_dodge(width = 0.9), size = freqPolySize(), color = errorBarColor())
            )
          }else{
            geom_erbar <- NULL
          }
          
        } #end of sd specified column
      }else if(isFALSE(addErrorBar())){
        #show the basic plot
        newData <- ptable()
        geom_erbar <- NULL
      }
      
      #param list: 3 elements
      list(
        #Add error bar: true or false
        addErrorBar(),
        #data for line
        newData,
        #geom_errorbar
        geom_erbar
      )
    })
    
    #legend parameters
    legendPosition <- reactive(input$legendPosition)
    legendDirection <- reactive(input$legendDirection)
    legendSize <- reactive(input$legendSize)
    legendTitle <- reactive(input$legendTitle)
    removeLegend <- reactive(input$removeLegend)
    #facet parameters
    #facet <- reactive(ifelse(input$plotType == "none"| input$facet == "none", FALSE, TRUE))
    facet <- reactive({
      #if(input$plotType == "none" | input$facet == "none"){
      if(figType() == "none" | input$facet == "none"){
        FALSE
      }else{
        if(isTruthy(input$varRow)| isTruthy(input$varColumn)){
          #even if user selected the facet type, but no other paramters are provided
          TRUE
        }else{
          FALSE
        }
      }
    })
    faceType <- reactive({
      input$facet})
    
    varRow <- reactive({
      if(isTRUE(facet())){
        if(isTruthy(input$varRow)){
          input$varRow
        }else{NULL}
      }else{
        NULL
      }
      
    })
    
    varColumn <- reactive({
      if(isTRUE(facet())){
        if(isTruthy(input$varColumn)){
          input$varColumn
        }else{NULL}
      }else{NULL}
    })
    
    nRow <- reactive({
      if(input$nRow == 0 | !isTruthy(input$varRow)){
        NULL
      }else{input$nRow}
    })
    nColumn <- reactive({
      if(input$nColumn == 0 | !isTruthy(input$varColumn)){
        NULL
      }else{input$nColumn}
    })
    scales <- reactive(input$scales)
    
    stripBackground <- reactive(ifelse(isTruthy(input$stripBackground), TRUE, FALSE))
    #additional layer
    layer <- reactive(input$addLayer)
    #layer size
    layerSize <- reactive({
      if(layer() != "none"){
        input$layerSize
      }else{1}
    })
    #get the computed data for annotating in plot
    
    #stop here-------------------------------------
    # if(methodSt() != "none"){
    #   # if(is_empty(catVar())) stop(message("fixed catVar"))
    #   statData <- reactive({
    #     generateStatData(data = ptable(), groupStat = groupStat(), groupVar = groupStatVarOption(), method = methodSt(), numericVar = numericVar(),
    #                      catVar = catVar(), compRef = compareOrReference(), paired = pairedData(), pAdjust = pAdjust(),
    #                      pAdjustMethod = pAdjustMethod(), labelSignif = labelSt(), cmpGrpList = cmpGrpList$lists, switchGrpList = switchGrpList$switchs,
    #                      xVar = xyAxis()[[1]], anovaType = anovaType(), ssType = ssType())
    #   })
    #   statDataStore$df <<- isolate(statData()[[1]])
    # }
    
    
    
    #display the plot
    output$figurePlot <- renderPlot({
      #resolution for the plot
      res=400
      
      message("catVarbelow2----")
      # message(glue::glue("catVar:{catVar()}"))
      #check condition-----------------------
      req(is.data.frame(ptable()))
      #check for x and y-axis
      if(pltType() %in% xyRequire){
        #must have both x- and y-axis
        req(all(lapply(xyAxis(), length) == 1))
      }
      
      #chosen variable must be in the data
      # If user change the data, the cached variables may not be available in the data.
      colms <- colnames(ptable())
      if(pltType() != "none"){
        req(unlist(xyAxis()[1]) %in% colms)
      }else if(varSet() != "none"){
        req(varSet() %in% colms)
      }else if(shapeLine() != "none"){
        if(isTruthy(shapeSet())){
          req(shapeSet() %in% colms)
        }else if(isTruthy(lineSet())){
          req(lineSet() %in% colms)
        }else if(isTruthy(shapeSet()) && isTruthy(lineSet())){
          req(all(c(shapeSet(), lineSet()) %in% colms))
        }
      }else if(methodSt() == "anova" && pairedData() == "two"){
        req(twoAovVar() %in% colms, twoAovVar() == varSet())
      }
      
      #second check
      if(figType() != "none" && !is.null(unlist(xyAxis()[2]))){
        validate(need(unlist(xyAxis()[1]) != unlist(xyAxis()[2]), "Provide different variable for x- and y-axis."))
      }
      #check 3 for density plot
      if(methodSt() != "none"){
        validate(need(!figType() %in% c("density", "frequency polygon", "histogram"), glue::glue("Unable to apply statistical method for {figType()} plot")))
      }
      #check 4: for t.test and wilcox.test
      # case 1: check for paired and unpaired data
      if(methodSt() %in% c('t.test', 'wilcox.test')){
        validate(
          need( unpaired_stopTest() == 'no', "Data appears to be unpaired!")
        )
      }
      #check for anova
      if(methodSt() == "anova" && anovaType() == "two"){
        validate(need(ncol(ptable()) >= 3, "Two-way anova require more variables (with different levels) to compare"))
      }
      #check end--------------------------------------
      
      # message(glue::glue("figurePlot parameter list: {varSet()}, {methodSt()}, {geomTypes()}"))
      tryCatch({
        if(figType() != "none" && methodSt() != "none"){
          message(glue::glue("method2: {methodSt()}"))
          message(catVar())
          message("input$compareOrReference")
          message(input$compareOrReference)
          message("againssssss")
          message(compareOrReference())
          #stat not applicable
          
          #compute statistic only when requested
          statData <- reactive({
            statData <- generateStatData(data = ptable(), groupStat = groupStat(), groupVar = groupStatVarOption(), method = methodSt(), numericVar = numericVar(),
                                         catVar = catVar(), compRef = compareOrReference(),
                                         ttestMethod = ttestMethod(), paired = pairedData(), 
                                         model = model(), pAdjust = pAdjust(),
                                         pAdjustMethod = pAdjustMethod(), labelSignif = labelSt(), cmpGrpList = cmpGrpList$lists, rfGrpList = rfGrpList$lists,# switchGrpList = switchGrpList$switchs,
                                         xVar = xyAxis()[[1]], anovaType = anovaType(), ssType = ssType())
            message("stat data in plain")
            message(statData) #8 and #9 #wil: 7 and 8
            message(str(statData))
            #adjust the decimal display of p value
            if(methodSt() %in% c("t.test", "wilcox.test")){
              
              # stsignif(statData[,c(8,9)], 1)
              message(str(statData[[1]]))
              if(isTRUE(pAdjust())){
                list(
                  statData[[1]] %>% mutate(p = round(p, 3), p.adj = round(p.adj, 3)),
                  statData[[2]]
                )
              }else{
                list(
                  statData[[1]] %>% mutate(p = round(p, 3)),
                  statData[[2]]
                )
              }
              
              # }else if(methodSt == "wilcox.test"){
              #   signif(statData[,c(7,8)], 3)
            }else{ statData }
            statData
          })
          
          statDataStore$df <<- isolate(statData()[[1]])
        }
      }, error = function(e){
        print(e)
        # validate("Cannot compute! \n Statistic method may not be appropriate for the data or choose different variables to conduct the statistic")
      })
      
      
      #convert the color variable to factor
      if(varSet() != "none"){
        data1 <- ptable() %>% mutate(across(.data[[varSet()]], factor)) 
      }
      
      
      
      tryCatch({ 
        
        if(methodSt() != "anova" || (methodSt() == "anova" && anovaType() == "one")){
          message("one and other ====================way=======")
          #not for anova-----------------------------
          if(varSet() == "none" && methodSt() == "none"){
            
            #Draw basic plot: dis = FALSE
            finalPlt <<- setFig(data = ptable(), dis = FALSE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
                                textSize = textSize(), titleSize = titleSize(),themes = themes(),
                                legendPosition = legendPosition(), legendDirection = legendDirection(),
                                legendTitle = legendTitle(), legendSize = legendSize(),
                                shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(),
                                nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                layer = layer(), layerSize = layerSize())
            # finalPlt
            
          }else if(varSet() != "none" && methodSt() == "none"){
            #disable parameters for statistic
            #based on plot type use color or fill
            if(!figType() %in% c("frequency polygon", "line", "scatter")){
              
              finalPlt <<- setFig(data = data1, dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  #methodSt = methodSt(), statData = statData(), anovaType=anovaType(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(), layerSize = layerSize(),
                                  fill = .data[[varSet()]]) #fill the color
              # finalPlt
            }else{
              #freqpoly, line will use varSet for color, not fill
              finalPlt <<- setFig(data = data1, dis = TRUE, geomType = geomTypes(),barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(),lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  #methodSt = methodSt(), statData = statData(), anovaType=anovaType(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(),layerSize = layerSize(),
                                  color = .data[[varSet()]]) #color the line
              # finalPlt
            }
          }else if(varSet() == "none" && methodSt() != "none"){
            #disable parameters for color/fill
            finalPlt <<- setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
                                textSize = textSize(), titleSize = titleSize(),
                                legendPosition = legendPosition(), legendDirection = legendDirection(),
                                legendTitle = legendTitle(), legendSize = legendSize(),themes = themes(), 
                                # varSet = varSet(), autoCust = autoCust(),colorTxt = colorTxt(), 
                                shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                methodSt = methodSt(), statData = statData(), anovaType=anovaType(), removeBracket=removeBracket(),
                                facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                layer = layer(), layerSize = layerSize())
            # finalPlt
          }else if(varSet() != "none" && methodSt() != "none"){
            #enable parameters for both the color and statistics
            #based on plot type use color or fill
            if(!figType() %in% c("frequency polygon", "line", "scatter")){
              
              finalPlt <<- setFig(data = data1, dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData(), anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(), layerSize = layerSize(),
                                  fill = .data[[varSet()]]) #fill the color
              # finalPlt
            }else{
              #freqpoly, line will use varSet for color, not fill
              finalPlt <<- setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(),lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData(), anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(),layerSize = layerSize(),
                                  color = .data[[varSet()]]) #color the line
              # finalPlt
            }
            
          } #end of varSet() != "none" && methodSt() != "none"
          
        }else if(methodSt() == "anova" && anovaType() == "two"){
          req(model, twoAovVar(), input$anovaFigure)
          #only for two-way anova----------------------------------
          #For two-way anova: 
          #1. anovaFigure() requested by user is not interaction, then 
          #     1. generate new color. It will be different from varSet()
          #     2. Facet will be auto selected: update the facet
          #     3. variable for x-axis will be change for figure of non-interaction
          
          message("two====================way=======")
          anovaFigure <- reactive(req(input$anovaFigure))
          
          #based on the figure, not on the model, process the figure separately
          if(anovaFigure() == "Interaction"){
            if(!figType() %in% c("frequency polygon", "line", "scatter")){
              
              finalPlt <<- setFig(data = data1, dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData(), anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(), layerSize = layerSize(),
                                  fill = .data[[varSet()]]) #fill the color
              # finalPlt
            }else{
              #freqpoly, line will use varSet for color, not fill
              finalPlt <<- setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), xyLable = xyLable(),lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), varSet = varSet(), autoCust = autoCust(),
                                  colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData(), anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(),layerSize = layerSize(),
                                  color = .data[[varSet()]]) #color the line
              # finalPlt
            }
            
            #end of interaction
          }else if(anovaFigure() != "Interaction"){
            #Figure for non-interaction
            message("stop1")
            #This is to put a condition to avoid processing the below codes
            # if(anovaFigure() == twoAovVar()){
            #   req(faceType(), varRow() != twoAovVar())
            # }else{
            #   req(faceType(), varRow() == twoAovVar())
            # }
            # 
            #generate data for two-way anova: additive and non-additive
            #data for additive
            if(model() == "additive"){
              message("stop2")
              if(anovaFigure() == twoAovVar()){
                #get the global output computed for the anova
                statData <- list(meanLabPos_a2, NULL)
              }else{
                req(colnames(xVar()) %in% colnames(ptable()))
                statData <- list(meanLabPos_a, NULL)
              }
              
              #data for non-additive
            }else{
              message("stop3")
              if(anovaFigure() == twoAovVar()){
                statData <- list(meanLabPos_a2, NULL)
              }else{
                req(colnames(xVar()) %in% colnames(ptable()))
                statData <- list(meanLabPos_a, NULL)
              }
              
            }
            #get x- and y-axis if figure is for non-interaction and not present in x-axis
            # 1. it will be a list of two elements
            message(glue::glue("stop333 anovafigure: {anovaFigure()}, {twoAovVar()}"))
            if(anovaFigure() == twoAovVar()){
              xyAxis <- reactive(list(twoAovVar(), colnames(yVar())))
            }
            # xyAxis <- reactive({
            #   if(anovaFigure() == twoAovVar()){
            #     # list(twoAovVar(), colnames(yVar()))
            #     list(twoAovVar(), input$yAxis)
            #   }
            # })
            message("stop3334")
            message(glue::glue("xyoutsied: {xyAxis()}"))
            
            anovaAutoCust <- reactive(ifelse(anovaFigure() != "Interaction", input$anovaAutoCust, "none"))
            anovaColor <- reactive(if(anovaFigure() != "Interaction" && anovaFigure() %in% colnames(ptable())) input$anovaFigure)
            # data1 <- ptable() %>% mutate(across(.data[[anovaColor()]], factor)) 
            message(glue::glue("anova:"))#{anovaColor()}"))
            anovaAddColor <- reactive(ifelse(anovaFigure() != "Interaction" && anovaAutoCust() == "customize", input$anovaAddColor, "noneProvided"))
            aovX <-if(anovaFigure() == colnames(xVar())){
              "group1"
            }else{
              anovaFigure()
            }
            
            if(!figType() %in% c("frequency polygon", "line", "scatter")){
              
              finalPlt <<- setFig(data = data1, dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), aovX=aovX,
                                  
                                  xyLable = xyLable(), lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), 
                                  
                                  varSet = anovaColor(), autoCust = anovaAutoCust(), colorTxt = anovaAddColor(),
                                  
                                  shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData, anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(), layerSize = layerSize(),
                                  fill = .data[[anovaColor()]]) #fill the color
              # finalPlt
            }else{
              #freqpoly, line will use varSet for color, not fill
              finalPlt <<- setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), barSize = freqPolySize(), histLine = histLine(), figType = figType(),
                                  xy = xyAxis(), aovX=aovX,
                                  
                                  xyLable = xyLable(),lineParam = lineParam(), 
                                  textSize = textSize(), titleSize = titleSize(),
                                  legendPosition = legendPosition(), legendDirection = legendDirection(),
                                  legendTitle = legendTitle(), legendSize = legendSize(),
                                  themes = themes(), 
                                  
                                  varSet = anovaColor(), autoCust = anovaAutoCust(), colorTxt = anovaAddColor(), 
                                  
                                  shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
                                  methodSt = methodSt(), statData = statData, anovaType=anovaType(), removeBracket=removeBracket(),
                                  facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
                                  nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
                                  layer = layer(),layerSize = layerSize(),
                                  color = .data[[anovaColor()]]) #color the line
              # finalPlt
            }
          }  #end of non interaction
          
          
        }#end of two way anova
        
        saveFigure(finalPlt) #save it
        finalPlt #final plot
        
      }, error = function(e){
        print(e)
      })
      
      
      
      
      
      # {
      #   if(varSet() != "none" && methodSt() == "none"){}
      #   #more aesthetic
      #   tryCatch({
      #     
      #     statData <- reactive({
      #       generateStatData(data = ptable(), groupStat = groupStat(), groupVar = groupStatVarOption(), method = methodSt(), numericVar = numericVar(),
      #                        catVar = catVar(), compRef = compareOrReference(), paired = pairedData(), pAdjust = pAdjust(),
      #                        pAdjustMethod = pAdjustMethod(), labelSignif = labelSt(), cmpGrpList = cmpGrpList$lists, switchGrpList = switchGrpList$switchs,
      #                        xVar = xyAxis()[[1]], anovaType = anovaType(), ssType = ssType())
      #     })
      #     statDataStore$df <<- isolate(statData()[[1]])
      #     
      #     if(varSet() != "none" ){ 
      #       #based on plot type use color or fill
      #       if(!figType() %in% c("frequency polygon", "line", "scatter")){
      #         #convert the variable to factor
      #         data1 <- ptable() %>% mutate(across(.data[[varSet()]], factor))
      #         setFig(data = data1, dis = TRUE, geomType = geomTypes(), histLine = histLine(), figType = figType(),
      #                    xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
      #                    textSize = textSize(), titleSize = titleSize(),
      #                    legendPosition = legendPosition(), legendDirection = legendDirection(),
      #                    legendTitle = legendTitle(), legendSize = legendSize(),
      #                    themes = themes(), varSet = varSet(), autoCust = autoCust(),
      #                    colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
      #                    methodSt = methodSt(), statData = statData(), anovaType=anovaType(),
      #                    facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
      #                    nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
      #                    layer = layer(), layerSize = layerSize(),
      #                    fill = .data[[varSet()]]) #fill the color
      #       }else{
      #         #freqpoly, line will use varSet for color, not fill
      #         setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), histLine = histLine(), figType = figType(),
      #              xy = xyAxis(), xyLable = xyLable(),lineParam = lineParam(), 
      #              textSize = textSize(), titleSize = titleSize(),
      #              legendPosition = legendPosition(), legendDirection = legendDirection(),
      #              legendTitle = legendTitle(), legendSize = legendSize(),
      #              themes = themes(), varSet = varSet(), autoCust = autoCust(),
      #              colorTxt = colorTxt(), shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
      #              methodSt = methodSt(), statData = statData(), anovaType=anovaType(),
      #              facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
      #              nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
      #              layer = layer(),layerSize = layerSize(),
      #              color = .data[[varSet()]]) #color the line
      #       }
      #     }else{
      #       #setting for no color
      #       message("no color")
      #       setFig(data = ptable(), dis = TRUE, geomType = geomTypes(), histLine = histLine(), figType = figType(),
      #              xy = xyAxis(), xyLable = xyLable(), lineParam = lineParam(), 
      #              textSize = textSize(), titleSize = titleSize(),
      #              legendPosition = legendPosition(), legendDirection = legendDirection(),
      #              legendTitle = legendTitle(), legendSize = legendSize(),
      #              shapeLine = shapeLine(), shapeSet = shapeSet(), lineSet = lineSet(),
      #              themes = themes(), varSet = varSet(), 
      #              methodSt = methodSt(), statData = statData(), anovaType=anovaType(),
      #              facet = facet(), faceType = facetType(), varRow = varRow(), varColumn = varColumn(), 
      #              nRow = nRow(), nColumn = nColumn(), scales = scales(), stripBackground = stripBackground(),
      #              layer = layer(), layerSize = layerSize())
      #     }#end of if else
      #   }, error = function(e){print(e)})#end of tryCatch
      # }
    })
    
  })#end of advance plot
  #end plot figures--------------------------------
  
  #download option------------------------
  #organized table
  observe({
    req(is.data.frame(ptable()))
    output$organizedDownload <- downloadHandler(
      filename = "plotS_table.csv",
      content = function(file){
        write_csv(ptable(), file)
      }
    )
  })
  
  #figure
  observe({
    req(input$figDownloadFormat)
    output$figDownload <- downloadHandler(
      filename = glue::glue("plotS_figure.{tolower(input$figDownloadFormat)}"),
      content = function(file){
        pDev <- switch(input$figDownloadFormat,
                       "EPS" = 'eps',
                       "PDF" ="pdf",
                       "PNG" = "png",
                       "SVG" = "svg",
                       "TIFF" = "tiff")
        heights <- ifelse(isTruthy(input$figHeight) && !str_detect(input$figHeight, "[:alpha:]"), as.numeric(input$figHeight), NA)
        widths <- ifelse(isTruthy(input$figWidth) && !str_detect(input$figWidth, "[:alpha:]"), as.numeric(input$figWidth), NA)
        plt <- if(!is.null(saveFigure())){
          saveFigure()
        }else{ NULL}
        ggsave(file, plot = plt, device = pDev, height = heights, width = widths, dpi = 400, units = "in")
      }
    )
  })
  
  # #report
  # observe({
  #   req(input$statSummaryDownloadOptions)
  #   output$downloadStatSummary <- downloadHandler(
  #     #users choice
  #     filename = switch(tolower(input$statSummaryDownloadOptions),
  #                       "report" = "plotS_report.pdf",
  #                       "table 1" = "plotS_table1.csv",
  #                       "table 2" = "plotS_table2.csv",
  #                       ),
  #     content = function(file){
  #       #File to temporary directory
  #       tempReport <- file.path(tempdir(), "plotS_report.rmd")
  #       file.copy("plotS_report.pdf", tempReport, overwrite = TRUE)
  # 
  #       #pass the parameter to the .rmd
  #       saveParams <- if(tolower(input$statSummaryDownloadOptions) == "report"){
  #         if(input$stat %in% c("t.test")){
  #           plot1 <- input$residualPlot
  #           plot2 <- input$NDensityPlot
  #         }
  #         #end of report param
  #       }else if(){}
  #     }
  #   )#end of download handler
  # 
  # })
  
  
  
}

# Run the application-----------------------
shinyApp(ui, server, onStart = function(){
  message("started session")
  rm(list=ls(), envir = .GlobalEnv)
  #clear all after session end--------------------
  onStop(function(){ 
    message("ended session and will clear all")
    rm(list = ls(), envir = .GlobalEnv)
  })
}
)