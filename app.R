
source("global.R", local = TRUE)
#link: https://plots-application.shinyapps.io/plots/
ui <- fluidPage(
  #link to CSS----------------
  includeCSS("www/uiStyle.css"),
  
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
                    
                      <p>
                      <b>PlotS</b> is a web-based application for data analysis and visualization. It is free and simple to use. 
                      You can analyze your data in an engaging way by running statistical tests while plotting the graphs. We hope that it will be a useful tool for performing quick analysis.
                      </p>
                      
                      <br></br>
                      
                      <p> 
                      Go to <strong>Analyze & visualize</strong> section for data analysis. There are three sub-sections - <strong>Data</strong>, <strong>Graph</strong> and <strong>Summary</strong>. The <strong>Data</strong> section allows you to upload data, manage replicates or header, reshape and apply transformation. The <strong>Graph</strong> section is for plotting and statistical analysis. All statistical results will be displayed in the <strong>Summary</strong>, and you will be able to download them as a report or as individual tables and figures.
                      </p>
                      
                      <p>
                      Data can be either all numerical or a combination of numerical and categorical variables. For comparisons between variables, it is recommended that data be in a long format rather than a wide format. If it doesn\'t, use the reshape options to reshape it. More information can be found in the <strong>Help</strong> section.
                      </p>
                      
                      <p>
                      The list of graphs currently available for plotting:
                      <ul>
                        <li>Bar plot</li>
                        <li>Box plot</li>
                        <li>Density plot</li>
                        <li>Frequency polygon</li>
                        <li>Histogram</li>
                        <li>Line plot</li>
                        <li>Scatter plot</li>
                        <li>Violin plot</li>
                      </ul>
                      </p>
                      
                      <p>
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
                      
                      <br></br>
                      
                      <p>
                      This application is developed using <a href="https://www.r-project.org/">R  programming language</a>. Refer the Help section for R packages used in the application.
                      </p>
                    </div>'
          )#end HTML
            
            
          ) %>% tagAppendAttributes(class="instructionPanel"),#end instruction tab
          
          #Analyze & visualize-------------------
          tabPanel(
            #This panel will be shown as interactive when the figure is ready
            title = "Analyze & visualize", value = "chart", icon = icon("area-chart"),
            
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
                      #input option
                      div({
                        inptOpt <- list(tags$span("Example", style = "font-weight:bold; color:#0099e6"), 
                                       tags$span("Upload", style = "font-weight:bold; color:#0099e6"))
                        radioButtons(inputId = "pInput", label = "Input data", choiceNames = inptOpt, choiceValues = list("example","upload data"), inline = TRUE) 
                      }),
                      
                      # selectInput(inputId = "pInput", label = "Input data", choices = list("example","upload data"), selected = ""),
                      #ui for uploading the data, 
                      uiOutput(outputId = "pUpload"),
                      
                      #ui for na 
                      conditionalPanel(condition = "input.pInput == 'upload data'",
                                       div(
                                         style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px; margin-right:0; text-align:center;
                                                      background-image:linear-gradient(rgba(206,247,250, 0.3), rgba(254, 254, 254, 0), rgba(206,247,250, 0.5))",
                                         class = "NAdiv",
                                         h4("Manage missing values", align = "center", style = "color:green; margin-bottom:20px"),
                                         uiOutput("UiSelectNA"),
                                         helpText("You can specify more than one missing values. If no value is specified, 'NA' and empty cell are treated as missing values by default.", style = "margin-top:0;"),#, style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;"),
                                         uiOutput("UiRemRepNA")
                                       )
                                       ),
                     
                      #ui explanation for example
                      uiOutput("UiExampleDes"),
                      # conditionalPanel(condition = "input.pFile == 'example'",
                      #                  helpText("Data for 'long' and 'wide' formats are the same. Wide format data need to be reshaped to compare between variables - ctrl, tr1, tr2.",
                      #                           style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
                      # ),
                      
                      #ui for alerting invalid file type
                      uiOutput(outputId = "UiUploadInvalid"),
                      #ui for present or absent of replicates
                      uiOutput(outputId = "UiReplicatePresent"),
                      
                      conditionalPanel(condition = "input.replicatePresent == 'yes'",
                                       helpText("Manage the replicates. Data must have at least one header.", style = "margin-top:5px; margin-bottom: 10px;"),
                                       div(
                                         style = "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:10px; padding:5px 0 5px 0; text-align:center",
                                         #Ui for number of header in the table
                                         # helpText("Provide correct number of header!", style = "margin-top:10px; margin-bottom:0;color:#F49F3A"), 
                                         helpText("Provide number of header row and group/variables of replicates.", style = "margin-top:20px; margin-bottom:7px;font-weight:bold; color:#F4763A"), 
                                         fluidRow(
                                           column(6,uiOutput("UiHeaderNumber")),
                                           #let user specify number of variables:
                                           # It is easier to process
                                           column(6, uiOutput("UiDataVariables"))
                                         ),
                                         textOutput("UiVarList"),
                                         uiOutput("UiReplicateNumber"),
                                         helpText("Provide variable's name and index number of the replicate columns", style = "margin-top:15px; margin-bottom:7px;font-weight:bold;color:#F4763A; text-align:center"), #3ABFF4
                                         #Ui for adding variable name and replicates column
                                         uiOutput("UiVarNameRepCol"),
                                         # #Ui for replicate statistic
                                         uiOutput("UiReplicateStat"),
                                         #message on when to use mean and median
                                         conditionalPanel(condition = "input.replicateStat != 'none'",
                                                          helpText("'Mean' is appropriate for parametric statistical method and 'Median' for non-parametric method.", 
                                                                   style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
                                                          #style= "margin-bottom:15px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)"), #Compute 'mean' to apply parametric statistic method, 'median' for non-parametric.
                                         ),
                                         uiOutput("UireplicateStatGroup"),
                                         uiOutput("UiReplicateStatGroupMsg"), #warning message
                                         uiOutput("UiReplicateStatGroupHelp"), #general message
                                         # conditionalPanel(condition = "input.replicateStat != 'none'",
                                         #                  uiOutput("UiReplicateStatGroupHelp")
                                         #                  
                                         # ),
                                         #action button for running replicates parameter
                                         uiOutput("UiReplicateActionButton"),
                                         uiOutput("UiAfterReplicate"),
                                         #show error message
                                         uiOutput("UiReplicateError")
                                       )
                      ),
                      
                      #reshape input data: though the ID says tranform [would be confusing]
                      div({
                        trsOpt <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                                       tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
                        radioButtons(inputId = "transform", label = "Reshape the data", choiceNames = trsOpt, choiceValues = c("No", "Yes"), inline = TRUE) 
                      }),
                      # selectInput(inputId = "transform", label = "Reshape the data", choi, selected = "No"),
                      conditionalPanel(condition = "input.transform == 'Yes'",
                                       helpText(list(tags$p("Reshape will transpose column to row (long formate)."), tags$p("It facilitate comparison between variables.")), style= "color:black; margin-top:0; background-color:#D6F4F7; border-radius:5%; text-align:center;")),
                      #ui output for choosing columns to transform the data
                      #for names 
                      uiOutput(outputId = "trName"),
                      # conditionalPanel(condition = "input.transform == 'Yes'",
                      #                  helpText("Choose the multiple variables to transpose and compare", style= "color:black; margin-top:0; background-color:#D6F4F7; border-radius:5%; text-align:center;")),
                      #for value
                      uiOutput(outputId = "trValue"),
                      #error message for reshape
                      conditionalPanel(condition = "input.transform == 'Yes' & input.enterName == 'value'",
                                       helpText("Provide a different name, not 'value'.",
                                                style = "color:red; margin-bottom: 10px; font-weight:bold; font-size:12; text-align:center")
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
                               conditionalPanel(condition = "input.plotType == 'bar plot'",
                                                helpText(list(tags$p("Use bar graph for categorical or count data!!"), tags$p("Users are encouraged to use other graph that show data distribution.")), style= "margin-bottom:10px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
                               ),
                               #additional param for histogram
                               uiOutput(outputId = "UiHistParam"),
                               #ui output to specify axis
                               fluidRow(
                                 column(6, uiOutput("xAxisUi")),
                                 column(6, uiOutput("yAxisUi"))
                               ),
                               #message for choosing x and y axis
                               conditionalPanel(condition = "input.plotType != 'none'",
                                                helpText("Variable for Y-axis must be numeric", style = "text-align:center")
                                                ),
                               #add filter as drop down menu
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
                               #line size for frequency polygon and line
                               uiOutput("UiFreqPolySize"),
                               #control transparency of scatter plot
                               conditionalPanel(condition = "input.plotType == 'scatter plot'",
                                            sliderInput(inputId = "scatterAlpha", label = "Transparency", min = 0.1, max = 1, value = 1)
                                            ),
                               #Ui to select variable to connect the path
                               uiOutput("UiLineConnectPath"),
                               #Ui for scatter plot, jitter the points
                               uiOutput("UiJitter"),
                               #Ui to add error bar for line type
                               uiOutput("UiLineErrorBar"),
                               #parameters for error bar
                               conditionalPanel(condition = "input.lineErrorBar",
                                                div(
                                                  style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px; margin-right:0; 
                                                      background-image:linear-gradient(rgba(206,247,250, 0.3), rgba(254, 254, 254, 0), rgba(206,247,250, 0.5))",
                                                  
                                                  #ui to compute for error bar
                                                  uiOutput("UiErrorBarStat"),
                                                  #ui message for confidence interval
                                                  uiOutput("UiCIMsg"),
                                                  #ui to display error for sd
                                                  uiOutput("UiSdError"),
                                                  #Ui to compute or specify the computed sd
                                                  uiOutput("UilineComputeSd"),
                                                  #Ui to group by for computing standard deviation 
                                                  uiOutput("UiLineGroupVar"),
                                                  #ui for error bar size
                                                  uiOutput("UiErrorBarSize"),
                                                  #Ui to add color for error bar
                                                  uiOutput("UiErrorBarColor")
                                                )
                               ),
                               
                               #line size for error bar
                               uiOutput("UiErrorBarLineSize"), 
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
                                 helpText(
                                   list(tags$p("Aesthetic options", style = "text-align:center; margin-top: 5px; margin-bottom: 0; font-weight:bold;"),
                                        tags$p("Customize color, shape, line type and compare between variables", style = "margin-top:0; text-align:center"))
                                 ),
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
                                                  conditionalPanel(condition = "input.stat == 'kruskal-wallis'",
                                                                   helpText("Dunn's test used for post-hoc analysis", style ="margin-top:10px; font-weight:bold;")
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
                                                                   helpText("Tukey's HSD test used for post-hoc analysis", style ="font-weight:bold;")
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
                                                  #ui for anova error alert
                                                  uiOutput("UiAnovaErrorAlert"),
                                                  # #sum of square type for anova
                                                  # conditionalPanel(condition = "input.stat == 'anova' && input.pairedData == 'one'",
                                                  #                  {er_lst <- list(tags$span("I", style = "font-weight:bold; color:#0099e6"), 
                                                  #                                  tags$span("II", style = "font-weight:bold; color:#0099e6"),
                                                  #                                  tags$span("III", style = "font-weight:bold; color:#0099e6"))
                                                  #                  # selectInput(inputId = "ssType", label = "Error type",
                                                  #                  #              choice = c(1,2,3), selected = 2)
                                                  #                  radioButtons(inputId = "ssType", label = "Type of sum of squares", inline = TRUE,
                                                  #                               choiceNames = er_lst, choiceValues = list(1, 2, 3), selected = 2)
                                                  #                  }),
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
                                                )#end of div for statistic test-----------------------
                               ), #end of conditional panel for stat
                               #ui for facet-------
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
                          
                          column(6,
                                 fluidRow(
                                   column(4, textInput(inputId = "figHeight", label = NULL, placeholder = "Height(in)")), #in inch 3.3 default for 1 coulmn wide (https://www.elsevier.com/__data/promis_misc/JBCDigitalArtGuidelines.pdf),
                                   column(4, textInput(inputId = "figWidth", label = NULL, placeholder = "Width (in)")),
                                   column(4, downloadButton("figDownload", label = NULL, class = "btn-info btn-l")),
                                 ) %>% tagAppendAttributes(class="figHWDFluidRow")
                          )
                        ),
                        helpText("Image resolution is 300 dpi. Default dimension is 4 * 4 inches.", style = "font-style:italic; text-align:center; margin:0;")
                      )%>% tagAppendAttributes(class="figDownloadDiv"),
                      #display figure
                      div(
                        width = 12,
                        # style= "position:fixed;width:inherit",
                        height = '400px',
                        
                        # column(6,
                        #        fluidRow(
                        #          column(8, 
                        #                 fluidRow(
                        #                   tags$div(
                        #                     tags$label(class= "col-sm-4 control-label", `for`="figHeight", br(), "Height"),
                        #                     column(5, textInput(inputId = "figHeight", label = NULL))), #in inch 3.3 default for 1 coulmn wide (https://www.elsevier.com/__data/promis_misc/JBCDigitalArtGuidelines.pdf),
                        #                   tags$div(
                        #                     tags$label(class ="col-sm-4 control-label", `for`="figWidth", "Width"),
                        #                     column(5, textInput(inputId = "figWidth", label = NULL)))
                        #                 )
                        #          ),
                        #          column(4, downloadButton("figDownload")),
                        #        )
                        # ),
                        # column(6, 
                        #        fluidRow(
                        #          column(5, textInput(inputId = "figHeight", label = "Height")) in inch 3.3 default for 1 coulmn wide (https://www.elsevier.com/__data/promis_misc/JBCDigitalArtGuidelines.pdf),
                        #          column(5, textInput(inputId = "figWidth", label = "Width")),
                        #          column(2, downloadButton("figDownload")),
                        #        )
                        #        )
                        
                        plotOutput(outputId = "figurePlot")
                      ) %>% tagAppendAttributes(class = "figurePlotBox"),
                      #box for figure settings:theme  
                      box(
                        #title = span("Additional settings:", style="font-weight:bold"),
                        # style="overflow-y:auto; position:fixed; width:inherit",
                        width = 12,
                        
                        #text label for x-axis
                        uiOutput("uiXAxisTextLabel"),
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
                          #Miscellaneous setting for graph
                          conditionalPanel(condition = "input.plotType != 'none'",
                                           dropdownButton(
                                             inputId = "miscGraphSet",
                                             label = "Misc setting",
                                             icon = icon("sliders"),
                                             size="sm",
                                             up=TRUE,
                                             margin = '5px',
                                             status = "primary",
                                             circle = FALSE,
                                             tooltip = tooltipOptions(title = "Click"),
                                             div(
                                               class = "miscDiv",
                                               {lch <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                                                            tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
                                               
                                               radioButtons(inputId = "Ylimit", label = "Set lower limit of y-axis to 0?",
                                                            choiceNames = lch, choiceValues = c("no", "yes"), inline = TRUE)},
                                               
                                               uiOutput("UiRemoveBracket"),
                                               uiOutput("UiStripBackground")
                                             )
                                           )
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
                  div(
                    class = "statSummaryDownload",
                    fluidRow(
                      column(7,
                             #Ui for download format
                             # report: pdf and doc
                             # table: csv
                             # figure: pdf, png, eps, tiff
                             uiOutput("UiStatSumDownFormat")
                      ),
                      column(2,
                             #download options : report, table or graph
                             
                             selectInput(inputId = "statSumDownList", label = NULL, choices = list(Report = c("Report", ""), Table = c("Table",""), Figure = c("Figure","")), selected = "Report", width = "100px")
                             
                             # #download options : report, table or graph
                             # output$UiStatSumDownList <- renderUI({
                             #   
                             #   optList <- list(Report = c("Report", ""), Table = c("Table",""), Figure = c("Figure",""))
                             #   
                             #   selectInput(inputId = "statSumDownList", label = NULL, choices = optList, selected = "Report", width = "100px")
                             # })
                      ),
                      column(2,
                             downloadButton(outputId = "downloadStatSummary", class = "btn-info btn-l")
                      )
                    )
                    
                    # statSummaryDownloadOptions downloadStatSummary
                  ),
                  #display the summary table of statistical computation
                  h3("Summary of data and statistical analysis", style = "text-align:center; font-weight:bold;"),
                  h4("Note: For transparency and credibility of your data analysis, always report the statistical method and a description of its appropriateness for the data. Record the result in accepted scientific standard, not just p-value. Report effect size in addition to p-value.", style = "text-align:center; font-style:italic;"),
                  #caption for data summary
                  helpText("Table 1. summary of the input data", style = "margin-top:30px; margin-bottom:0; font-weight:bold; font-size:20px"),
                  #Ui for data summary
                  verbatimTextOutput("UiDataSummary"), #show summary of all the data
                  # textOutput("statSummaryText"),
                  #ui for descriptive statistics
                  uiOutput("UiDescriptiveTableCaption"),
                  reactableOutput("UiDescriptiveTable"),
                  #Ui for parametric test
                  #Display normality and homogeneity test for parametric statistic
                  conditionalPanel(condition = "input.stat == 't.test' | input.stat == 'anova'",
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
                                   reactableOutput("UiStatSummaryTable")
                                   # verbatimTextOutput("UiStatSummaryTable")
                                   
                  ),
                  
                  #ui for effect size
                  conditionalPanel(condition = "input.stat != 'none'",
                                   
                                   #Ui caption
                                   uiOutput("UiCapEffectSize"),
                                   #ui effect size method and bootstrap
                                   #effect size method for t.test and anova
                                   #bootstrap for wilcox and kruskal
                                   
                                   div(
                                     class="effectSizeMethodDiv",
                                     uiOutput("UiEffectSizeMethod")
                                     # uiOutput("UiBootstrapWarn")
                                   ),
                                   
                                   # uiOutput("UiEffectSizeMethod"),
                                   #subcaption
                                   uiOutput("UiSubCapEffectSize"),
                                   #ui for effect size
                                   reactableOutput("UiEffectSize") #, width = '80%'
                                   
                  ),
                  #ui for post hoc test
                  conditionalPanel(condition = "input.stat== 'kruskal-wallis' | input.stat=='anova'",
                                   uiOutput("UiPostHocCaption"),
                                   uiOutput("UiPostHoc")
                  )
                  
                ) %>% tagAppendAttributes(class= "summaryPanel")#end of summary tab panel
              )
              
            ) %>% tagAppendAttributes(class="analyzeTabBox") #end of tabBox
            
          ) %>% tagAppendAttributes(class="chartPanel"), #end Analyze & visualize
          
          #help panel----------------
          tabPanel(
            title = "Help", icon = icon("book-open"),
            includeHTML("www/plotS_help.html")
          ) %>% tagAppendAttributes(class="helpPanel")#end of help section-----------------
        )
        
    ),
    div(class = "column column3")
    
  ),
  
  #add footer note
  tags$footer(
    HTML('<p>  </p>'), 
    align = "center",
    style = "
  height: 100px; 
  background-color: #ffffff"#f2f2f2;" #d9d9d9
    #bottom: 10%;padding = 10px;
  )#end of footer
  
)# end of fluidPage for UI


#server------------------------
server <- function(input, output){
  
  #plot figures:-----------------
  #refresh/trigger button for different parameters to none-------------
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
  #manage missing values and then upload
  observe({
    req(input$pInput)
    
    
    output$UiSelectNA <- renderUI({
      if(input$pInput == "upload data"){
        textInput(inputId = "selectNA", label = "Specify missing values", placeholder = "comma separated only!!")
      }
    })
    
    output$UiRemRepNA <- renderUI({
      if(input$pInput == "upload data"){
        naOpt <- list(tags$span("Remove NA", style = "font-weight:bold; color:#0099e6"), 
                      tags$span("Replace with 0", style = "font-weight:bold; color:#0099e6"))
        radioButtons(inputId = "remRepNa", label = NULL, choiceNames = naOpt, choiceValues = c("remove", "replace"), inline = TRUE) 
      }
    })
    
    output$pUpload <- renderUI(
      if(input$pInput == "upload data"){
        # req(input$remRepNa)
        fileInput(inputId = "pFile", label = "Upload", placeholder = "csv/tsv/xlsx/rds/txt", accept = c(".csv",".tsv", ".txt",".xlsx",".rds"))
      }else if(input$pInput == "example"){
        # selectInput(inputId = "pFile", label = "Select", choices = list(`Long format` = c("long format", ""), `Wide format` = c("iris", "")))
        selectInput(inputId = "pFile", label = "Choose example", choices = list("long format", "wide format", "replicate"))
      }
    )
    
  })
  
  #description of example
  observe({
    req(input$pInput, input$pFile)
    output$UiExampleDes <- renderUI({
      if(input$pInput == "example" && input$pFile %in% c("long format", "wide format")){
        helpText("Data for 'long' and 'wide' formats are the same. Wide format data need reshape to compare between variables - ctrl, tr1, tr2.",
                 style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
      }else if(input$pInput == "example" && input$pFile == "replicate"){
        helpText("It has two header rows and two replicates (R1 and R2) each for two groups/variables - control and treatment.",
                 style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
      }
    })
    
  })
  #Get the input data for the plot
  #user's file path: reactive value so that user can change the file
  upPath <- reactive({
    if(req(input$pInput) == "upload data" && req(!input$pFile %in% c("replicate", "long format", "wide format"))) req(input$pFile)
  })
  
  #First point to collect the data based on user's input--------------------------
  #I've use reactiveValues, just in case if required to convert the data to Null
  # This will be updated to manage replicates in the data
  
  # #ui for na 
  # div(
  #   style= "border-top:dotted 1px; border-bottom:dotted 1px; margin-bottom:20px; margin-right:0; text-align:center;
  #                                                     background-image:linear-gradient(rgba(206,247,250, 0.3), rgba(254, 254, 254, 0), rgba(206,247,250, 0.5))",
  #   class = "NAdiv",
  #   h4("Manage missing values", align = "center", style = "color:green; margin-bottom:20px"),
  #   textInput(inputId = "selectNA", label = "Specify missing values", placeholder = "space or comma separated"),
  #   helpText("'NA' and empty cell are considered as missing values. You can specify more than one missing values."),#, style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;"),
  #   {
  #     naOpt <- list(tags$span("Remove NA", style = "font-weight:bold; color:#0099e6"),
  #                   tags$span("Replace with 0", style = "font-weight:bold; color:#0099e6"))
  #     radioButtons(inputId = "remRepNa", label = NULL, choiceNames = naOpt, choiceValues = c("remove", "replace"), inline = TRUE)
  #   }
  # ),
  # 
  # uploadError <- 0 #for alerting error
  # 
  pInputTable_orig <- reactiveVal(PlantGrowth)
  
  observe({
    req(input$pInput, input$pFile)
    
    #get data based on users input
    if(req(input$pInput) == "upload data"){
      
      #get the extension of the file
      ext <- tools::file_ext(req(upPath()$datapath))
      
      #alert and validate the file type
      output$UiUploadInvalid <- renderUI({
        if(!ext %in% c("csv","tsv","xlsx", "xls","rds", "txt") ){
          helpText(list(tags$p("Invalid file!!"), tags$p("Please upload a valid file: csv/tsv/txt/xlsx/xls/rds")), style= "color:red; text-align:center")
        }
      })
      shiny::validate(
        need(ext %in% c("csv","tsv","xlsx", "xls","rds", "txt"), "Please upload a valid file: csv/tsv/txt/xlsx/xls/rds")
      )
      
      
      # req(input$remRepNA)
      # #manage missing values
      if(!isTruthy(input$selectNA)){
        naList <- c("", " ", "NA", "na")
      }else if(isTruthy(input$selectNA)){
        #process the given list
        naList <- strsplit(gsub(",", "_", input$selectNA),"_") %>% unlist()#strsplit(str_trim(gsub(",", " ", input$selectNA))," +") %>% unlist()
      }
      tryCatch({
        #read the data
        up_df <- switch(ext,
                        "csv" = vroom::vroom(upPath()$datapath, na = naList) %>% as.data.frame(), #, na = naList
                        "tsv" = vroom::vroom(upPath()$datapaht, na = naList) %>% as.data.frame(),
                        "txt" = vroom::vroom(upPath()$datapaht, na = naList) %>% as.data.frame(),
                        "xlsx" = read_xlsx(upPath()$datapath, na = naList),
                        "xls" = read_xls(upPath()$datapath, na = naList),
                        "rds" = readRDS(upPath()$datapath, na = naList))
        uploadError <<- 0
        
        #remove or replace na 
        if(input$remRepNa == "remove"){
          pData <- na.omit(up_df)
        }else if(input$remRepNa == "replace"){
          pData <- up_df %>% mutate_if(is.numeric, ~ replace(., is.na(.), 0)) %>% as.data.frame()
        }
        pData
      }, error = function(e){
        uploadError <<- 1
        # uploadErrorMessage <<- e
        print(e)
        validate(
          "Unable to load the file!"
        )
      })
      
      
    }else if(input$pInput == "example"){
      req(input$pFile %in% c("long format", "wid format", "replicate"))
      if(req(input$pFile) == "long format"){
        pData <- PlantGrowth
      }else if(req(input$pFile) == "wide format"){
        # df <- PlantGrowth
        # dput(df)
        # df$new <- rep(1:10, 3) 
        # df2 <- df %>% pivot_wider(names_from = group, values_from = weight) %>% select(-new)
        # dput(df2)
        pData <- structure(list(ctrl = c(4.17, 5.58, 5.18, 6.11, 4.5, 4.61, 5.17,4.53, 5.33, 5.14), 
                       trt1 = c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83,6.03, 4.89, 4.32, 4.69), 
                       trt2 = c(6.31, 5.12, 5.54, 5.5, 5.37,5.29, 4.92, 6.15, 5.8, 5.26)), 
                  row.names = c(NA, -10L), class = c("data.frame"))
        
        
      }else if (req(input$pFile) == "replicate"){
        # x <- read_excel("~/Desktop/temp/replicates_ex.xlsx")
        # dput(x)
        pData <- structure(list(...1 = c("variable", "ob1", "ob2", "ob3", "ob4", "ob5", "ob6", "ob7"), 
                       control = c("R1","23", "41", "24", "5", "23", "56", "23"), 
                       ...3 = c("R2","23", "54", "65", "32", "57", "73", "42"), 
                       treatment = c("R1", "2", "3", "4", "67", "2", "45", "24"), 
                       ...5 = c("R2", "1", "4", "6", "32", "1", "35", "23")), class = c("data.frame"), row.names = c(NA, -7L))
        
      }
    }
    
    message(str(pData))
    pInputTable_orig(pData) 
  })
  
  
  #signal the change of data-----------------
  oldData <- reactiveValues(df = NULL)
  oldPath <- reactiveValues(df = NULL)
  
  dataChanged <- eventReactive( req(input$pInput == "upload data") ,{
    
    if(input$pInput == "upload data"){
      "
    Initial value will be null.
    If user change the data, than it will be TRUE, else FALSE.
    "
      req(oldData$df, pInputTable_orig())
      if(is_empty(oldData$df)){
        
        #No data: start of program
        oldData$df <- pInputTable_orig()
        oldPath$df <- upPath()$datapath 
        NULL
      }else{
        
        if(nrow(pInputTable_orig()) == nrow(oldData$df) &&
           ncol(pInputTable_orig()) == ncol(oldData$df) &&
           colnames(pInputTable_orig()) == colnames(oldData$df) #&& oldPath$df == upPath()$dataPath
        ){
          
          #data remain unchanged
          FALSE
        }else{
          
          #Data has changed
          oldData$df <<- pInputTable_orig()
          oldPath$df <<- upPath()$datapath
          
          #reset all other data
          replicateData <<- reactiveValues(df=NULL)
          tidy_tb <<- reactiveValues(df = NULL)
          reshapeError <<- reactive(0)
          organizedSwitch(0)
          TRUE
        }
      }
    }else{
      NULL
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
    req(pInputTable_orig(), input$replicatePresent == "yes")
    output$UiHeaderNumber <- renderUI({
      if(isTruthy(input$pInput) &&  input$replicatePresent == "yes"){
        selectInput(inputId = "headerNumber", label = "Header row", choices = 1:5, selected = 1)
        #Number of table's header
      }
    })
    
    
    output$UiDataVariables <- renderUI({
      # req(input$headerNumber)
      # browser()
      if(input$replicatePresent == "yes" && req(as.numeric(input$headerNumber)) != 0){
        
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
      
      
      if(input$replicatePresent == "yes"){
        
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
  output$UiReplicateStat <- renderUI({
    if(input$replicatePresent == "yes"){
      lst <- list(tags$span("None", style = "font-weight:bold; color:#0099e6"),
                  tags$span("Mean", style = "font-weight:bold; color:#0099e6"),
                  tags$span("Median", style = "font-weight:bold; color:#0099e6"))
      radioButtons(inputId = "replicateStat", label = "Compute (for the replicates)", choiceNames = lst, choiceValues = c("none", "mean", "median"), inline = TRUE) 
    }
  })
  
  #action button to run the replicate parameters
  output$UiReplicateActionButton <- renderUI({
    #Button will be available only when all the parameters are filled
    req(pInputTable$data, input$headerNumber, input$dataVariables, input$replicateStat)
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
    
    if(isTRUE(gName) && isTRUE(rCol)){
      actionButton(inputId = "replicateActionButton", label = span("Apply", style="color:white; font-weight:bold"), width = '100%', class = "btn-primary")
    }
    
  })
  
  #variables to group by for determining mean or median of replicates
  observe({
    # req(pInputTable$data, input$headerNumber, input$dataVariables, input$replicateStat)
    req(is.data.frame(pInputTable$data), pInputTable$data, input$dataVariables, input$replicateStat != "none", eval( str2expression(paste0("input$Variable",1:input$dataVariables,"R")) ) )
    output$UireplicateStatGroup <- renderUI({
      if(input$replicateStat != "none"){
        #provide option for the column index
        #make sure that no index overlapped with replicates index
        df_col <- 1:ncol(pInputTable$data)
        replicateIndx <- lapply( 1:as.numeric(input$dataVariables), function(x) as.numeric(eval( str2expression(paste0("input$Variable",x,"R")) )) ) %>% unlist()
        
        #get the index not present in the replicates
        gr_col <- df_col[!df_col %in% replicateIndx]
        selectInput(inputId = "replicateStatGroup", label = "Specify column(s) to group by", choices = c("none", gr_col), multiple = TRUE, selected = "none")
        #below code: use it for data base (ibdc), but not for plotS
        #get the column name from the table
        # gr_col_name <- pInputTable$data[, gr_col, drop = FALSE] %>% colnames()
        # selectInput(inputId = "replicateStatGroup", label = "Specify column(s) to group by", choices = c("none", gr_col_name), multiple = TRUE)
      }
    })
  })
  
  # add alert message to select at least one variable
  observe({
    # req(isTruthy(input$replicateActionButton))
    output$UiReplicateStatGroupMsg <- renderUI({
      if(req(input$replicateStat) != "none" && !isTruthy(input$replicateStatGroup)){
        helpText("Provide at least one variable to group by!", style = "color:red; font-weight:bold; background-color:white; margin-top:0")
      }
    })
  })
  #instructions and alert message to users for group_by usage in managing replicates
  observe({
    req(is.data.frame(pInputTable$data), pInputTable$data, input$dataVariables, input$replicateStat)
    # req(input$replicateStat, input$replicateStatGroup)
    output$UiReplicateStatGroupHelp <- renderUI({
      
      if(input$replicateStat != "none" && !isTruthy(input$replicateStatGroup)){
        helpText( list(tags$p("Specify one or more column index to group by and determine mean or median"),
                       tags$p("Note: only replicate mean and, if applied, variables used for grouping will be retained.")), 
                  style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
                  # style= "margin-bottom:20px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
        
      }else if(input$replicateStat != "none" && isTruthy(input$replicateStatGroup)){
        if(length(req(input$replicateStatGroup)) > 1  && any("none" %in% req(input$replicateStatGroup))){
          helpText("Remove 'none' from the selection", style = "margin-bottom:20px; border-radius:10%; color:red; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
        }else if(length(req(input$replicateStatGroup)) == 1){
          helpText( list(tags$p("Specify one or more column index to group by and determine mean or median"),
                         tags$p("Note: only replicate mean and, if applied, variables used for grouping will be retained.")), 
                    style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")#style= "margin-bottom:20px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
        }
      }
      
    })
    
  })
  # helpText( list(tags$p("Specify one or more column index to group by and determine mean or median"),
  #                tags$p("Note: only replicate mean and, if applied, variables used for grouping will be remained.")), style= "margin-bottom:20px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
  
  #notify the user to reshape the data after managing replicates
  observe({
    req(input$replicatePresent == "yes", isTruthy(input$replicateActionButton))
    
    output$UiAfterReplicate <- renderUI({
      if(input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)){
        helpText("Apply reshape after managing replicates (Recommended)", 
                 style= "margin-bottom:15px; margin-top:0; color:black; background-color:#D6F4F7; border-radius:5%; text-align:center;")
                 # style = "margin-top:7px; margin-bottom:10px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")
      }
      
    })
  })
  #error setting-------------------------------------------
  #Message to display for various type of errors
  #message to display for calculating replicates mean and median
  # value = 0, no error
  # value = 1, error occured, mostly unable to convert to numeric data type
  # replicateError <- eventReactive( req(input$replicatePresent) == "no", { 0 }) #use this to provide error message
  replicateError <- reactiveVal( 0 ) #use this to provide error message while processing replicates
  reshapeError <- eventReactive( req(input$transform) == "No", { 0 }) #user must not combine numeric and character column
  
  observe({
    req(pltType(), input$stat, input$anovaModel)
    #computeFuncError() is created in global.R
    # need to keep updating based on the model used for anova
    computeFuncError(0)
    computeFuncErrorMsg(NULL)
  })
  #end of error setting------------------------------------
  
  
  #get the tidied data of replicates for each group------
  replicateData <- reactiveValues(df=NULL)
  unequalReplicateError <- reactiveVal(0)
  #execute the below code every time user press action button
  observeEvent( req(isTruthy(input$replicateActionButton)), {
    
    req(input$replicatePresent == "yes", input$dataVariables)
    
    #check that user do not mixed with none and other options in multiple selection
    if(input$replicateStat != "none"){
      req(input$replicateStatGroup)
      
      message(input$replicateStatGroup)
      #for future
      if(length(input$replicateStatGroup) > 1){
        validate(
          need( !any("none" %in% req(input$replicateStatGroup)), "Remove 'none' from the selection")
        )
      }
    }
    
    #number of header
    headerNo <- reactive(as.numeric(input$headerNumber))
    
    #main data: process the data based on the header
    data <- pInputTable$data %>% as.data.frame()
    
    #keep the columns selected for group by in the beginning
    
    if(req(input$replicateStat) != "none"){
      #if user want mean or median
      
      if( !any("none" %in% req(input$replicateStatGroup)) ){
        #For mean and median, if user specified group by, then, keep the variable in the first column of the table
        data <- data %>% select(colnames(data[, as.numeric(input$replicateStatGroup), drop=FALSE]), everything())
        #below code: use it for data base (ibdc), but not for plotS
        # data <- data %>% select(!!!rlang::syms(input$replicateStatGroup), everything())
      }
    }
    
    
    #variables id 
    varId <- reactive(paste0("Variable", seq_len(input$dataVariables)))
    
    #get replicates detail from the user's input as list
    repDetails <- lapply(1:input$dataVariables, function(x) eval(str2expression(paste0("input$Variable",x,"R"))))
    
    #count the replicates for each group
    repCount <- lapply(repDetails, length)
    
    
    #check error and alert the user:
    # case 1: must have equal replicates for all the group
    # case 2: must not select the same replicate column more than once
    if( any(repCount != repCount[[1]]) & length(unlist(repDetails)) == length(unique(unlist(repDetails))) ){
      #case 1
      unequalReplicateError(1)
    }else if( all(repCount == repCount[[1]]) & length(unlist(repDetails)) != length(unique(unlist(repDetails))) ){
      #case 2
      unequalReplicateError(2)
    }else if( any(repCount != repCount[[1]]) & length(unlist(repDetails)) != length(unique(unlist(repDetails))) ){
      #case 1 and 2
      unequalReplicateError(3)
    }else{
      #no error
      unequalReplicateError(0)
    }
    #stop processing
    validate(
      need(#case 1
        all(repCount == repCount[[1]]) && length(unlist(repDetails)) == length(unique(unlist(repDetails))), "Error: select the appropriate replicate column for variables"
      )
    )
    
    #unlist and convert to numeric (it's a list of index number for columns)
    repCol <- repDetails %>% unlist() %>% as.numeric()
    
    #separate data to replicate and non-replicate [if any (not all data will have variables other than replicates)]
    
    #non-replicate data: 
    # case 1: not need of mean or median, than proceed as usual i.e. deselect the replicate column 
    # case 2: with mean or median,
    #       case i: group by column is specified, than add length(input$replicateStatGroup) 
    #               to repCol, since the group by variables is being placed in the start column
    #       case ii: group by not specified, than proceed as case 1.
    
    if(req(input$replicateStat) != "none"){
      if(req(input$replicateStatGroup) != "none"){
        noRep_df <- data[, -(repCol + length(input$replicateStatGroup)), drop=FALSE] 
      }else{
        noRep_df <- data[, -repCol, drop=FALSE] 
      }
    }else{
      noRep_df <- data[, -repCol, drop=FALSE] 
    }
    
    #dummy data frame to collect the replicates data after iteration and processing for each variable.
    mergeData <- data.frame()
    #stopwatch for processing columns other than replicates (inside the function: tidyReplicate())
    stp <- 0 # 0 to 1: 1 is to stop
    
    tryCatch({
      #for loop to tidy up the replicate for each group [[change code later]]
      for(i in seq_along(varId())){
        
        #name of variable given by the user
        colName <- eval(str2expression(paste0("input$Variable",i)))
        
        #replicates column for the given variable
        no <- eval(str2expression(paste0("input$Variable",i,"R")))
        #convert to numeric: replicate columns
        colNo <- as.numeric(no)
        #use trycatch()
        # tryCatch({
          #run the tidy function
          rstat <- tidyReplicate(x=data, y = noRep_df, headerNo = 1:headerNo(),
                                 colName= colName, colNo = colNo, stp=stp)
          stp <- 1
          
          message("000000000000000000000000helo")
          
        
        #tidy the computed data.: output will have all the columns and computed stat
        #remove column not necessary 
        rstat2 <- rstat %>% select(!starts_with("Replicate_"))
        
        if(is_empty(mergeData)){
          mergeData <- rstat2
        }else{
          #select only the necessary column and append to the data frame
          newDf <- rstat2 %>% select_if(is.numeric)
          mergeData <- cbind(mergeData, newDf)
        }
        
      }
      
      #Compute Mean or median:
      if(input$replicateStat != "none"){
        
        #non-replicate colnames: require for grouping
        if( !any("none" %in% req(input$replicateStatGroup)) ){
          gb_col <- colnames(mergeData[, 1:length(req(input$replicateStatGroup)), drop = FALSE])
        }else{
          #no group_by
          gb_col <- NULL
        }
        # browser()
        #get the name of the columns for which to determine mean or median
        other_col <- colnames( mergeData[, 1:which(colnames(mergeData) == "replicates")-1] )
        #check that the col must be numeric
        
        numericCheck_df <- mergeData %>% select(-all_of(other_col), -replicates)
        # message(lapply(numericCheck_df, str))
        # message(colnames(numericCheck_df))
        # message(head(numericCheck_df))
        # validate(
        #   need(all(isTRUE(lapply(numericCheck_df, is.numeric))) || all(isTRUE(lapply(numericCheck_df, is.double))), "Must be numeric variables")
        # )
        
        
        #get only the names of the necessary columns to process futher
        mm_col <- mergeData %>% select(-all_of(other_col), -replicates) %>% colnames()
        
        #arrange the varNum for the arguments of getMeanMedian
        # more than one hheader row need to be consider while proceeding
        if(headerNo() > 1){
          forVarNum <- nrow(pInputTable_orig()) - (headerNo() - 1)
          #for 0 and 1, no need to worry
        }else{
          forVarNum <- nrow(pInputTable_orig())
        }
        message(forVarNum)
        #determine mean or median for each variables
        mm_list <- lapply(mm_col, getMeanMedian, df = mergeData, stat = req(input$replicateStat), grp = all_of(gb_col), varNum = forVarNum, repNum = length(req(input$Variable1R)))
        #convert to data frame
        mm_df <- mm_list %>% as.data.frame.list()
        if(!is_empty(gb_col)){
          #keep variables used in group by
          nR_df <- mergeData %>% select(gb_col) 
          # keep only the unique
          nr_df_uniq <- nR_df %>% distinct(!!!rlang::syms(colnames(nR_df))) %>% as.data.frame()
          #append
          message(nr_df_uniq)
          message(mm_df)
          message(str(nr_df_uniq))
          message(str(mm_df))
          mergeData <- cbind(nr_df_uniq, mm_df)
        }else{
          
          mergeData <- mm_df
        }
      }#computation completed
      
      #save the final data for display
      replicateData$df <<- mergeData
      
      #update error message
      replicateError <<- reactive(0)
      replicateProcessingErrorMsg(NULL)
    }, error = function(e){ 
      
      replicateError <<- reactive(1)
      replicateProcessingErrorMsg(e)
      print(e)
      # validate(
      #   need(replicateError() == 0, "Error: cannot process the data!! Make sure that the table is in porper format (check Help section)")
      # )
    })
    
  })
  
  #replicateData must be reset to null 
  # case 1. if user choose no to 'Data with replicates/multiple headers'
  # case 2. if there is error in computation for the replicates
  observe({
    req(input$replicateData, unequalReplicateError())
    if(input$replicateData == "no" || unequalReplicateError() != 0){
      replicateData$df <- NULL
    }
  })
  
  
  replicateProcessingErrorMsg <- reactiveVal("Error: cannot convert to numeric. Provide correct header or replicate columns!!")
  #provide error message to the user
  observe({
    req(replicateError())
    output$UiReplicateError <- renderUI({
      message("replicaterrororrrrr")
      message(replicateProcessingErrorMsg())
      if(isTruthy(input$replicateActionButton) && replicateError() == 1) helpText(paste0("Error:",replicateProcessingErrorMsg()), style = "margin-top: 10px; font-size = 12; color:red; font-weight:bold")
    })
  })
  
  #Alert message for unequal replicates:may not be required
  # observe({
  #   req(unequalReplicateError())
  #   # #reset the data to null if there is error
  #   # replicateData$df <<- NULL
  # 
  #   #check error:
  #   # case 1: must have equal replicates for all the group
  #   # case 2: must not select the same replicate column more than once
  #   output$UiReplicateError <- renderUI({
  # 
  #     if( unequalReplicateError() == 1 ){
  #       #case 1
  #       helpText("Error: variables have unequal replicates", style="color:red; ")
  #       validate("Variables have unequal replicates")
  #     }else if( unequalReplicateError() == 2 ){
  #       #case 2
  #       helpText("Error: replicate column is duplicated", style="color:red; ")
  #       validate("Replicate column is duplicated")
  #     }else if( unequalReplicateError() == 3 ){
  #       #case 1 and 2
  #       helpText("Error: variables have unequal replicates and replicate column is duplicated", style="color:red; ")
  #       validate("Variables have unequal replicates and replicate column is duplicated")
  #     }
  #   })
  # 
  # })
  
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
      if(input$transform == "Yes") varSelectInput(inputId = "variables", label = "Specify the columns to reshape", data = pInputTable$data, multiple = TRUE)
    }else if(req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)){
      if(input$transform == "Yes") varSelectInput(inputId = "variables", label = "Specify the columns to reshape", data = replicateData$df, multiple = TRUE)
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
  observe({
    #input$pInput,
    # req(pInputTable$data, input$transform, input$variables, isTruthy(input$enterName))
    req(pInputTable$data, input$transform, input$variables, input$enterName)
    # browser()
    #check the presence of the input in the choosen data and proceed
    validate(
      need(input$variables %in% colnames(pInputTable$data), "")
    )
    output$trAction <- renderUI({
      if(input$transform == "Yes" && !is_empty(input$variables) && isTruthy(input$enterName)) actionButton(inputId = "goAction", label = span("Reshape", style="color:white"), class = "btn-primary", width = "100%")
    })
  })
  
  #table for reshape
  tidy_tb <- reactiveValues(df=NULL)
  #reshape error message:not in use
  reshapeErrorMsg <- reactiveVal(NULL)
  #reshape the data-----------------
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
      reshapeErrorMsg(NULL)
    }, error = function(e){
      # browser()
      #assign the original table to tidy_tb so that failure will still provide the original data for plotting
      if( input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df) ){
        #data has replicates
        tidy_tb$df <- req(replicateData$df)
      }else{
        #without replicates
        tidy_tb$df <<- req(pInputTable$data)
      }
      message("wrong reshape")
      # message(e)
      reshapeError <<- reactive(1) #error message to  be displayed to the user
      reshapeErrorMsg(glue::glue("Failed to reshape the column. {e}!"))
      print(e)
    }) #end of trycatch
    
  })
  
  #error message for reshape.
  # Mostly, when user try to combine numeric and character column
  observe({
    req(reshapeError())
    # browser()
    output$UiReshapeError <- renderUI({
      
      if(input$transform == "Yes" && isTruthy(input$goAction) && req(reshapeError()) == 1 ){
        # browser()
        # message(reshapeErrorMsg())
        # helpText(reshapeErrorMsg(), style = "color:red; margin-bottom: 10px; font-weight:bold; font-size:12")
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
  
  
  #data before transformation------------------
  bf_ptable <- reactive({
   
    req(refresh_1(), input$normalizeStandardize)
    # browser()
    message("ptable")
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
    }else if( (req(input$replicatePresent) == "yes" && isTruthy(input$replicateActionButton)) && !is.null(replicateData$df) ){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
      replicateData$df #replicate table not requested for re-arrangement
    }else{
      #show the input table, if nothin apply
      message("no other available for ptable")
      pInputTable$data
    }
  })
  
  #update data transformation: normalization and standardization
  observe({
    # need(unequalReplicateError() == 0 && replicateError() == 0 && reshapeError() == 0, "wait")
    req(input$replicatePresent, replicateError(), input$transform, reshapeError())
    # browser()
    if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && replicateError() == 1) | (input$transform == "Yes" && isTruthy(input$goAction) && reshapeError() == 1) ){
      updateSelectInput(inputId = "normalizeStandardize", label = "Transform", choices = "none")
    }else{
      updateSelectInput(inputId = "normalizeStandardize", label = "Transform", choices = c('none', NS_methods), selected = 'none')
    }
  })

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
  
  
  #transform the data: normalize or standardize
  # step 1: transform y-axis
  # step 2: update ptable() by adding the transformed column, saved the 
  #         original data as well so that it can revert back to the original.
  # step 3: update variable of y-axis.
  
  ns_input <- reactive(input$normalizeStandardize)
  transformationError <- reactiveVal(0)
  ns_ptable <- eventReactive(req(isTruthy(input$nsActionButton)), {
    # browser()
    #browser()
    if(ns_input() != 'none'){
      
      #get variables for transformation
      if(ns_input() == 'box-cox'){
        req(input$nsCatVar, input$nsNumVar2)
        #check that the selected variable has at least 2 levels
        selCol <- bf_ptable() %>% select(.data[[input$nsCatVar]]) %>% distinct() %>% nrow()
        validate(
          need(selCol >= 2, "Error: selected categorical variable must have 2 or more levels")
        )
        cVar <- input$nsCatVar
        nVar <- input$nsNumVar2
      }else{
        req(input$nsNumVar)
        cVar <- NULL
        nVar <- input$nsNumVar
      }
      
      #transformed given numeric variable
      message("inside ns and table")
      tryCatch({
        
        ns_df <- ns_func(data = bf_ptable(), ns_method = ns_input(), x = cVar, y = nVar)
        message(ns_df)
        transformationError(0)
      }, error = function(e){
        transformationError(1)
        # transformationErrorMsg(e)
        validate(
          need(transformationError() == 0, glue::glue("{e}"))
        )
      })
      
      message("transofrm done]]]]]]]]]]]]]]]]]")
      ns_df
    }
  })
  
  #Final data:---------------------
  # Includes all data before and/or after transformation
  # To be used for all further analysis: graph and statistics
  # Must pass all errorless condition
  ptable <- reactive({
    # browser()#
    message(replicateError())
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
    req(pInputTable_orig(), input$replicatePresent == "yes" )
    
    if(input$replicatePresent == "yes" && req(input$headerNumber) > 0){
      df_nproper <- pInputTable_orig() %>% as.data.frame()
      
      #data has header
      #get all the header and add as row dataset
      #header name: vector
      message("greater than 0")
      realColN <- colnames(df_nproper) #header name
      
      if(as.numeric(input$headerNumber) > 1){
        #if user specified more than 1 header, than require more steps to process
        #get the data for the header from the row
        userColN <- df_nproper[1:as.numeric(input$headerNumber), ,drop=FALSE] #not require
        
        #create one duplicate rows and append real colnames to it
        add_df <- df_nproper[1, ,drop=FALSE]
        
        df_nproper2 <- rbind(add_df, df_nproper)
        
        #start appending
        df_nproper2[1,] <- realColN
        
        
      }else if(as.numeric(input$headerNumber) == 1){
        #for just one header: add the column name as header
        df_nproper2 <- rbind(df_nproper[1,], df_nproper) %>% as.data.frame()
        df_nproper2[1, ] <- realColN
      }
      
      #Note:R will add header if needed (not always) [when using fread(), instead of vroom()]
      # check for addition of header by R: V1, V2, .....Vn
      # removed the header if present. 
      
      if( all( str_detect(df_nproper2[1,], regex("^V[:digit:]")) ) ){
        df_nproper2 <- df_nproper2[-1, ]
      }
      
      #update the oiginal input table
      updated_df(df_nproper2)
    }else{
      updated_df(pInputTable_orig())
    }
    
  })
  
  #Table to be used for input display and further analysis for replicates or reshape or transformation
  pInputTable <- reactiveValues(data = NULL)
  observe({
    req(pInputTable_orig(), input$replicatePresent, input$transform)
    # browser()
    if(input$replicatePresent == "yes" && !is.null(updated_df())){
      
      pInputTable$data <- updated_df()
    }else{
      #original input table
      pInputTable$data <- pInputTable_orig()
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
      
      #show the new table
      output$pShowTable <- renderDataTable({
        
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
        ) 
      })
      
    }
  })
  
  #display the tidied or transformed table
  
  observe({ 
    req(ptable(), input$replicatePresent, input$transform, unequalReplicateError(), replicateError(), reshapeError(), input$normalizeStandardize) #must not have error while calculating mean and median of replicates
    
    validate(
      need(unequalReplicateError() == 0 && replicateError() == 0 && reshapeError() == 0, "wait")
    )
    
    #for caption
    if( input$normalizeStandardize == 'none' || (input$normalizeStandardize != 'none' && !isTruthy(input$nsActionButton)) ){
      addCaption <- "."
    }else if(input$normalizeStandardize != 'none' && isTruthy(input$nsActionButton)){
      addCaption <- paste0(". Applied ", input$normalizeStandardize," transformation.")
    }
    
    #add caption to the table
    if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton) && !is_empty(replicateData$df)) && (input$transform == "Yes" && isTruthy(input$goAction) && !is_empty(tidy_tb$df)) ){
      
      captions <- glue::glue("Table 2. Reshaped table{addCaption}")
      
    }else if(input$transform == "Yes" && isTruthy(input$goAction) && (is_empty(replicateData$df) || !isTruthy(input$replicateActionButton)) ){
      captions <- glue::glue("Table 2. Reshaped table{addCaption}")
    }else if( (input$replicatePresent == "yes" && isTruthy(input$replicateActionButton)) && !is_empty(replicateData$df)){#&& (is_empty(tidy_tb$df) || !isTruthy(input$goAction))
      #general table for replicate only
      df_display <- replicateData$df
      #get table caption
      captions <- glue::glue("Table 2. Re-arranged table for replicates")
      
      #end of only replicate 
    }else if(input$normalizeStandardize != "none" && isTruthy(input$nsActionButton)){
      #for normalization and standardization
      captions <- glue::glue("Table 2. {input$normalizeStandardize} transformed table.")
    }else{
      captions <- NULL
    }
    
    
    message("enter pshowtra")
    
    #display the table
    output$pShowTransform <- renderDataTable({
      if(!is.null(captions)){
        datatable(ptable(), selection = "single", options = list(searching = FALSE),
                  caption = captions) #%>%formatRound(columns = 1:ncol(df_display))
      }
    })
    
  })
  
  
  #plot choice for different--------------------------
  planPlotList <- c("none",   "box plot","bar plot", "histogram", "scatter plot",
                    "density plot", "heatmap", "line", "frequency polygon",
                    "violin","jitter","area", "pie chart", "venn", "upset", "tile")
  plotList <- c(  "box plot","violin plot", "density", "frequency polygon", "histogram","line", "scatter plot", "bar plot")
  
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
  
  #reactive plot type
  pltType <- reactive({
    req(refresh_1())
    input$plotType
  })
 
  #set x- and/or y-axis-----------------------
  #plot that require x and y-axis
  # xyRequire <- c(  "box plot", "violin plot", "bar plot", "line", "scatter plot") 
  
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
    if(pltType() %in% c("scatter plot", "line")){
      var <- selectedVar2(data = ptable(), "integer")
    }else{
      var <- selectedVar(data = ptable()) 
    }
    message("x ptable value")
    output$xAxisUi <- renderUI({
      
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
        
        selectInput(inputId = "yAxis", label = "Y-axis", choices = colnames(ptable()), selected = varC)
      }
    })
  })
  
  

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
  
  #data type of the selected axes variable
  xVarType <- reactive({
    req(pltType() != 'none', input$xAxis, xVar())
    sapply(xVar(), class)
  })
  yVarType <- reactive({
    req(pltType() != 'none', yVar(), input$yAxis)
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
      if(input$plotType %in% c("histogram", "frequency polygon") & xVarType()[1] %in% c("integer", "numeric", "double")) sliderInput(inputId = "binWidth", label = "Adjust bin width", min = 0.01, max = 100, value = 30)
    })
    
  })
  
  #changing variable names for the x-axis
  observe({
    req(is.data.frame(ptable()), pltType() != "none")
    #condition to check: prevent crashing when data change.
    validate(
      need(input$xAxis %in% colnames(ptable()), "Wait!")
    )
    #get number of variables in x-axis
    x <- req(input$xAxis)
    nVar <- ptable() %>% distinct(.data[[x]]) %>% nrow()
    
    output$uiXAxisTextLabel <- renderUI({
      if( req(input$plotType) != "none" ){
        textAreaInput(inputId = "xTextLabel", label = glue::glue("Change variable name of x-axis (enter {nVar} names):"), placeholder = "Comma or space separated",  height = "35px", width = "650px")
      }
    })
  })
  #get the input name and passed it to the figure function 
  xTextLabel <- reactive({
    if(isTruthy(input$xTextLabel)){
      
      #get name of variables in x-axis
      varName <- unique(ptable()[,input$xAxis]) %>% as.vector()
      #get number of variables in x-axis
      nVar <- ptable() %>% distinct(.data[[input$xAxis]]) %>% nrow()
      #user given name
      givenName <- strsplit(str_trim(gsub(" |,", " ", input$xTextLabel))," +") %>% unlist()
      
      
      #Use the name based on the user's input
      # case 1: given name is less than the variables available in x-axis:
      #         use given name + remaining original name
      #case 2: given name is equal to the variables available in x-axis:
      #         use the given name.
      #case3: given name is longer - remove the extra name
      
      if(length(givenName) < nVar){
        #case 1:
        c(givenName, varName[-c(1:length(givenName))])
      }else{
        if(length(givenName) == nVar){
          givenName
        }else if(length(givenName) > nVar){
          givenName[1:nVar]
        }
      }
      
    }else{
      unique(req(ptable()[,input$xAxis])) %>% as.vector()
    }
  })
  
  
  # nVar <- c("white", "red", "blue", "gree", "purple", "black")
  # givenName <- c("smith", "cooper", "leonard")
  #Bar graph settings---------------------
  output$UiStackDodge <- renderUI({
    #Bar plot and histogram will have this option
    #this will be updated when user request for error bar in bar plot, but not for histogram
    req(refresh_3(), pltType(), xVar())
    choices <- list(tags$span("Stack", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Dodge", style = "font-weight:bold; color:#0099e6"))
    if(pltType() %in% c("bar plot", "histogram")){
      radioButtons(inputId = "stackDodge", label = "Bar position", choiceNames = choices, choiceValues = list("Stack", "Dodge"), inline = TRUE)
    }
  })
  
  
  
  #Line graph settings---------------
  # #show option to connect the path within: check below
  # show option to connect the path within 
  output$UiLineConnectPath <- renderUI({
    req(refresh_3(), ptable(), yVar() )
    # req(ptable(), pltType() == "line", isTruthy(input$lineErrorBar), input$lineComputeSd)
    col <- colnames(ptable())
    varC <- colnames( ptable()[ ,!col %in% colnames(yVar()) ] )
    if(req(pltType()) == "line" && (isTruthy(xVar())|| isTruthy(yVar())) ) selectInput(inputId = "lineConnectPath", label = "Connect the line", choices = c("none", varC), selected = "none")
  })
  
  #add error bar
  output$UiLineErrorBar <- renderUI({
    req(refresh_3(), pltType() != "none")
    if(pltType() %in% c("line", "bar plot", "scatter plot", "violin plot") && (isTruthy(xVar())|| isTruthy(yVar())) ) checkboxInput(inputId = "lineErrorBar", label = tags$span("Add error bar", style = "color:#b30000; font-weight:bold; background:#f7f3f3"))
  })
  
  observe({
    req(is.data.frame(ptable()), isTruthy(input$lineErrorBar))
    
    output$UiErrorBarStat <- renderUI({
      if(is.data.frame(ptable()) && pltType() %in% c("line", "bar plot", "scatter plot", "violin plot") && isTruthy(input$lineErrorBar)){
        li <- list(`Inferential error bar` = c("Confidence interval (CI)","Standard error (SE)"), `Descriptive error bar` = c("Standard deviation (SD)", ""))
        selectInput(inputId = "errorBarStat", label = "Error bar type", choices = li, selected = "Standard error")
      }
    })
    
  })
  #display message for confidence interval
  observe({
    req(input$errorBarStat)
    output$UiCIMsg <- renderUI({
      if(isTruthy(input$lineErrorBar) && pltType() %in% c("line", "bar plot", "scatter plot", "violin plot") && input$errorBarStat == "Confidence interval (CI)"){
        helpText("At 95% confidence level", style = "text-align:center; margin-top:0;")
      }
    })
  })
  
  
  
  #Option for the user to used computed sd or to compute sd
  output$UilineComputeSd <- renderUI({
    req(refresh_3(), pltType() != "none", input$errorBarStat)
    if(pltType() %in% c("line", "bar plot", "scatter plot", "violin plot") & req(isTruthy(input$lineErrorBar))){
      choic <- list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
                    tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
      
      if(input$errorBarStat == "Standard error"){
        radioButtons(inputId = "lineComputeSd", label = "Auto compute SE?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
      }else if(input$errorBarStat == 'Standard deviation'){
        radioButtons(inputId = "lineComputeSd", label = "Auto compute SD?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
      }else{
        radioButtons(inputId = "lineComputeSd", label = "Auto compute CI?", choiceNames = choic, choiceValues = c("no","yes"), selected = "no", inline = TRUE)
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
    req(ptable(), pltType() %in% c("line", "bar plot", "scatter plot", "violin plot"), isTruthy(input$lineErrorBar), input$lineComputeSd)
    
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
    if(req(pltType() %in% c("line", "bar plot", "scatter plot", "violin plot")) && req(isTruthy(input$lineErrorBar)) ){
      selectInput( inputId = "errorBarColor", label = "Error bar color", choices = c("default", sort(c("black", "red", "blue", "green"))), selected = "default")
    }
  })
  #error bar size
  observe({
    req(isTruthy(input$lineErrorBar))
    output$UiErrorBarSize <- renderUI({
      if(isTruthy(input$lineErrorBar) && pltType() %in% c("line", "bar plot", "scatter plot", "violin plot")){
        sliderInput(inputId = "errorBarSize", label = "Error bar size", min = 0.1, max = 5, value = 1)
      }
    })
    
  })

  #variable to update the variable of x-axis
  xVarChoice <- reactive({
    req(refresh_3(), pltType() %in% c("line", "bar plot"), ptable()) 
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
  
  # #update the option to connect the path within
  
  observe({
    req(refresh_3(), pltType() %in% c("line","bar plot"))
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
    
  })
  
  
  #update stackDodge for bar plot
  # Only 'Dodge' option, if
  # case 1: stat is applied.
  # case 2: error bar and aesthetic is applied - only if aesthetic variable is different from x-axis
  observe({
    req(is.data.frame(ptable()), pltType() =="bar plot", xVar(), input$colorSet, input$stat)
    
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
  
  #setting for adjusting point, line, bar size----------
  observe({
    req(pltType() != "none")
    
    output$UiFreqPolySize <- renderUI({
      req(input$plotType)
      if(pltType() == "scatter plot"){
        lab <- "Point size"
        min <- 0.1
        max <- 5
        value <- 1
      }else if(pltType() %in% c("density","line", "frequency polygon")){
        lab <- "Line size"
        min <- 0.1
        max <- 10
        value <- 1
      }else if(pltType() %in% c("bar plot",   "box plot", "violin plot")){
        lab <- ifelse(pltType() == 'bar plot', 'Bar width', "Box width")
        min <- 0.001
        max <- 2
        value <- 0.90
      }
      if(!pltType() %in% c("none", "histogram") && (isTruthy(xVar())|| isTruthy(yVar())) ) sliderInput(inputId = "freqPolySize", label = lab,
                                                                                                                       value = value, min = min, max = max)
    })
    
  })
  
  #add mean, median for histogram
  observeEvent(req(pltType() == "histogram"),{
    # req(refresh_2())
    output$UiHistMean <- renderUI({
      req(ptable(), input$xAxis, xVarType())
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
    if(pltType() == "scatter plot") checkboxInput(inputId = "jitter", label = tags$span("Handle overplotting (jitter)", style = "font-weight:bold; color:#b30000; background:#f7f3f3"))
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
  
  lineGrpVar <- reactive(req(input$lineGroupVar))
  
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
    
    else{
      #generic
      if(pltType() %in% c("box plot","violin plot", "line", "scatter plot", "bar plot")){
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
  #shapeExcluded <- c("histogram", "frequency polygon", "line", "scatter plot")
  shapeLineOption <- reactive({
    if(req(pltType()) %in% c("scatter plot")){
      # list(tags$span("Shape", style = "font-weight:bold; color:#0099e6"))
      c("Shape")
    }else if(req(pltType()) %in% c(  "box plot","violin plot", "bar plot", "histogram", "frequency polygon", "line", "density")){
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
      req(pltType() != "bar plot" && input$shapeLine == "Shape", input$stat)
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
    req( pltType() %in% c("scatter plot", "bar plot"), isTruthy(input$lineErrorBar), xVar() )
    if( isTruthy(input$lineErrorBar) && !input$colorSet %in% c("none", colnames(xVar())) ){
      
      if(pltType() == "scatter plot"){
        #update shape
        displayAes(update = "yes", transform = transformation(), action = action(), pltType = pltType(),
                   data = ptable(), label = "Variable for shape", newId = "shapeSet", firstChoice = NULL, choice = c(colnames(xVar()), input$colorSet), selected= input$colorSet )
      }else if(pltType() == "bar plot"){
        #update line
        #for line plot, it will be taken care by connect line path
        message("update lineSet2")
        # updateSelectInput(inputId = "lineSet", label = "Variable for line type2", choices = c(colnames(xVar()), input$colorSet), selected= input$colorSet)
        displayAes(update = "yes", transform = transformation(), action = action(), pltType = pltType(),
                   data = ptable(), label = "Variable for line type", newId = "lineSet", firstChoice = NULL, choice = c(colnames(xVar()), input$colorSet), selected= input$colorSet )
      }
      
    }
   
  })
  
  
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
      if(!input$stat %in% c("none", "anova", "kruskal-wallis")) checkboxInput(inputId = "removeBracket", label = span("Remove bracket (p label)", style = "font-weight:bold; color:cornflowerblue"))
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
  #statistical method
  statMethods <- list(Parametric = c("t.test", "anova"), `Non-parametric`=c("wilcoxon.test","kruskal-wallis"))
  statList <- c("t.test", "anova", "wilcoxon.test","kruskal-wallis")
  #Choose statistical method
  output$UiStatMethod <- renderUI({
    req(refresh_2(), pltType())
    #to apply statistic, it require both x and y-axis
    if(pltType() %in% c("none",plotList)){ 
      selectInput(inputId = "stat", label = "Statistical method", choices = c("none",statMethods), selected = "none") 
    }
    
  })
  
  #alert message for t-test, if more than 2 variables present
  observe({
    req(is.data.frame(ptable()), pltType() != 'none', input$stat %in% c('t.test', "wilcoxon.test"), input$compareOrReference)
    output$UiTtestAlert <- renderUI({
      if(input$stat %in% c('t.test', "wilcoxon.test")){
        if(req(input$colorSet) == 'none' && !isTruthy(input$shapeLine)){
          #check variable count
          countVar <- ptable() %>% distinct(.data[[input$xAxis]]) %>% nrow()
        }else if(req(input$colorSet) != 'none'){
          countVar <- ptable() %>% distinct(.data[[input$xAxis]], .data[[input$colorSet]]) %>% nrow()
        }
        
        if(countVar > 2 && input$compareOrReference == "none"){
          if(input$stat == "t.test"){
            helpText("Data has more than 2 variables to compare. Consider using ANOVA or apply comparions or add reference group (options below)",
                     style= "margin-bottom:20px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")#style = "margin-bottom:20px; color:#EB6305")
          }else if(input$stat == "wilcoxon.test"){
            helpText("Data has more than 2 variables to compare. Consider using kruskal-wallis test or apply comparions or add reference group (options below)",
                     style= "margin-bottom:20px; border-radius:10%; color:#921802; text-align:center; padding:auto; background-color:rgba(252, 198, 116, 0.2)")#style = "margin-bottom:20px; color:#EB6305")
          }
          
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
  #data (paired or unpaired) and ANOVA type (one-way or two-way)
  unpaired_stopTest <- reactiveVal("no") #no means data is unpaired, but user used as paired. So stop executing the t-test
  observe({
    req( refresh_2(), pltType(), !input$stat %in% c("none", "kruskal-wallis") )
    
    statMethod <- reactive(input$stat)
    output$UiPairedData <- renderUI({
      
      dataTypeList <- if(statMethod() %in% c("t.test", "wilcoxon.test")){
        
        list(tags$span("No", style = "font-weight:bold; color:#0099e6"), 
             tags$span("Yes", style = "font-weight:bold; color:#0099e6"))
        
      }else{
        
        list(tags$span("One-way", style = "font-weight:bold; color:#0099e6"), 
             tags$span("Two-way", style = "font-weight:bold; color:#0099e6"))
        
        #tags$span("Two-way Repeated Measures", style = "font-weight:bold; color:#0099e6"))
      }
      
      if(statMethod() %in% c("t.test", "wilcoxon.test")) {
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
      if(input$stat %in% c("t.test", "wilcoxon.test") && input$pairedData == "yes"){
        
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
      selectInput(inputId = "anovaFigure", label = tags$span("Choose ANOVA figure", style= "color:#BD1403"), choices = varName)
      # radioButtons(inputId = "anovaFigure", label = "Show figure", choices = varName)
    }else if(input$anovaModel == "non-additive"){
      selectInput(inputId = "anovaFigure", label = tags$span("Choose ANOVA figure", style= "color:#BD1403"), choices = c("Interaction",varName))
    }
  })
  
  #Anova color----------------------
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
    req(pltType(), xVar(), input$stat %in% c("t.test", "wilcoxon.test", "kruskal-wallis"))
    if( input$stat == "kruskal-wallis" || (input$stat %in% c("t.test", "wilcoxon.test") && req(input$compareOrReference) != "none") ){# && input$colorSet != "none" && !isTruthy(input$shapeLine)){
      
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
  })
  
  #Computed statistic data----------------
  #This will be shown as table in statistic summary
  statDataStore <- reactiveValues(df = data.frame(matrix(nrow = 5, ncol = 6)))
  statDataR <- reactiveValues(df=reactive({
    if(req(input$stat) == "none" && req(input$dependentVar) == "" && req(input$independentVar) == ""){
      NULL
    }else{
      
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
    if(!input$stat %in% c("anova", "kruskal-wallis")){
      choiceList <- list(tags$span("value", style = "font-weight:bold; color:#0099e6"), tags$span("symbol", style = "font-weight:bold; color:#0099e6"))
      radioButtons(inputId = "choosePLabel", label = "Choose p label format", choiceNames = choiceList, choiceValues = c("p.adj","p.adj.signif"),
                   selected = "p.adj", inline = TRUE)
    }
  })
  
  #t-test parameters----------------------------------------
  #compute t-test by comparisons or reference group 
  observe({
    req(input$stat %in% c("t.test", "wilcoxon.test"))
    output$UiCompareOrReference <- renderUI({
      if(input$stat %in% c("t.test", "wilcoxon.test")){
        selectInput(inputId = "compareOrReference", label = "Compare or add reference", choices = c("none","comparison", "reference group"), selected = "none")
      }
    })
    
  })
  
  #empty list to collect groups from user for comparison: require to preceed the below command
  grpList <- list()
  
  #provide option to add group
  output$UiListGroup <- renderUI({
    req(refresh_2(), ptable(), input$xAxis, !input$stat %in% c("none", "anova", "kruskal-wallis"), input$compareOrReference != "none")
    
    if(input$compareOrReference != "none"){
      #get the variables to be compare or reference
      varCR <-reactive(as.vector(unique(ptable()[[input$xAxis]])))
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
          selectInput(inputId = "listGroup", label = "Choose 1 variable as reference", choices = varCR(), multiple = FALSE)
        }else{
          #for unpaired data
          #count var
          varC <- ptable() %>% count(.data[[input$xAxis]])
          
          if( any(varC$n != varC$n[1]) ){
            varCh <- varCR()
          }else if( all(varC$n == varC$n[1]) ){
            varCh <- c("all", varCR())
          }
          
          selectInput(inputId = "listGroup", label = "Choose 1 variable as reference", choices = varCh, multiple = FALSE)
        }
      }
    }
  })
  
  #add group action
  output$UiAddGroupAction <- renderUI({
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcoxon.test"), input$compareOrReference != "none")
    if(input$stat %in% c("t.test","wilcoxon.test") && input$compareOrReference != "none") actionButton(inputId = "addGroupAction", label = span("Add", style = "color:white; font-weight:bold"), class = "btn-success", width = '100%')
  })
  #delete group action
  output$UiDeleteGroupAction <- renderUI({
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcoxon.test"), input$compareOrReference != "none")
    if(input$stat %in% c("t.test","wilcoxon.test") && input$compareOrReference != "none") actionButton(inputId = "deleteGroupAction", label = span("Delete", style = "color:white; font-weight:bold"), class = "btn-danger", width = '100%')
  })
  #steps to add or delete groups for comparisons
  #get the users provided list
  givenGrp <- reactive(req(input$listGroup))
  
  
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
  
  
  #display the groups in above box
  output$UiShowListGroup <- renderUI({
    req(refresh_2(), ptable(), input$stat %in% c("t.test","wilcoxon.test"), input$compareOrReference != "none", input$addGroupAction)
    verbatimTextOutput("showListGroup", placeholder = TRUE)
  })
  
  output$showListGroup <- renderText({
    req(input$stat != "none", input$compareOrReference != "none", input$addGroupAction | input$deleteGroupAction)
    if(input$compareOrReference == "comparison"){
      paste0(grpList,",")
    }else{paste0(grpList)}
  })
  
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
  
  
  #Variables for both grid and wrap
  observe({
    req(refresh_2(), ptable(), is.data.frame(ptable()), pltType() != 'none', input$facet != "none")
    
    output$UiVar_1 <- renderUI({
      
      #select variables to be used as selected: only string type
      var <- selectedVar(data = ptable())
      
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
    reqPlot <- c("none",  "box plot","line", "scatter plot", "violin plot")
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
  #stat summary table
  table1 <- reactiveVal(NULL)
  table2 <- reactiveVal(NULL)
  table3 <- reactiveVal(NULL)
  table4 <- reactiveVal(NULL)
  table5 <- reactiveVal(NULL)
  #stat summary figure
  # figure1 <- figure2 <- figure3 <- reactiveVal(NULL)
  figure1 <- reactiveVal(NULL)
  figure2 <- reactiveVal(NULL)
  figure3 <- reactiveVal(NULL)
  #convert to null whenever data change
  observe({
    req(is.data.frame(ptable()))
    #stat summary figure
    # figure1 <- figure2 <- figure3 <- reactiveVal(NULL)
    figure1 <- reactiveVal(NULL)
    figure2 <- reactiveVal(NULL)
    figure3 <- reactiveVal(NULL)
    #stat summary table
    table1 <- reactiveVal(NULL)
    table2 <- reactiveVal(NULL)
    table3 <- reactiveVal(NULL)
    table4 <- reactiveVal(NULL)
    table5 <- reactiveVal(NULL)
  })
  
  #update the statSumDownList
  observe({
    req(is.data.frame(ptable()), pltType(), input$stat)
    # req(is.data.frame(ptable()), pltType(), input$xAxis, input$stat)
    #options for download:
    # case 1: download as report - 3 types of report (implement in download option)
    #         case i: only summary - no graph applied 
    #         case ii: only descriptive - only graph applied (x-axis given)
    #         case iii: all - applied graph and stat
    # case 2: download tables:
    #         case i: only summary - no graph applied (implemented above)
    #         case ii: only descriptive - only graph applied (x-axis given) 
    #         case iii: t-test and wilcoxon test - only 1-4 tables
    #         case iv: anova and kruskal wallis tests - upto 1-5 tables
    # case 3: download figures:
    #         case i: t-test and anova - figures 1 to 3.
    
    # output$UiStatSumDownList <- renderUI({
    if(pltType() != "none" && input$stat == "none"){
      #case 1 & 2: case ii 
      optList <- list(Table = c("Table 1", "Table 2"))
    }else if(pltType() != "none" && input$stat != "none"){
      #case 1 & 2: case iii
      if(input$stat == "t.test"){
        #included case 3:
        optList <- list(Report = "Report", Table = c(paste0(rep("Table ", 4), 1:4)), Figure = c( paste0(rep("Figure ",3), 1:3) ))
      }else if(input$stat == "wilcoxon.test"){
        optList <- list( Report = "Report", Table = c( paste0(rep("Table ", 4), 1:4) ) )
      }else if(input$stat == "anova"){
        #included case 3:
        if(twoAnovaError() == 0){
          optList <- list(Report = "Report", Table = c(paste0(rep("Table ", 5), 1:5)), Figure = c( paste0(rep("Figure ",3), 1:3) ))
        }else if(twoAnovaError() != 0){
          optList <- list(Table = c("Table 1", "Table 2"))
        }
        
      }else if(input$stat == "kruskal-wallis"){
        optList <- list( Report = "Report", Table = c( paste0(rep("Table ", 5), 1:5) ) )
      }
    }else{
      #reset to original
      optList <- list(Table= c("Table 1", ""))
    }
    
    updateSelectInput(inputId = "statSumDownList", label = NULL, choices = optList)
  })
  #download format:
  # case 1: report - pdf or docx
  # case 2: table - csv (default and only option)
  # case 3: figure - pdf, png, eps, tiff
  # #Ui for data summary
  observe({
    req(input$statSumDownList)
    
    output$UiStatSumDownFormat <- renderUI({
      # browser()
      if(input$statSumDownList == "Report"){
        radioButtons(inputId = "statSumDownFormat", label = NULL, choices = c("PDF", "DOCX"), selected = "PDF", inline = TRUE)
      }else if(str_detect(input$statSumDownList, regex("^Figure"))){
        radioButtons(inputId = "statSumDownFormat", label = NULL, choices = c("BMP", "PDF", "PNG", "TIFF"), selected = "PNG", inline = TRUE)
      }
    })
  })
  

  observe({
    req(is.data.frame(ptable()))
    
    output$UiDataSummary <- renderPrint({
      
      if(is.data.frame(ptable())){
        #convert x-axis to factor and display the summary if x-axis is selected
        if(pltType() != "none" && isTruthy(input$xAxis) && input$xAxis %in% colnames(ptable())){
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
        tab1 <- cust_hist(input_data)
        table1(tab1)
        
        return(tab1)
      }
    })
  })
  
  
  #ui for descriptive statistics
  observe({
    req(is.data.frame(ptable()), pltType() %in% xyRequire, input$xAxis, input$yAxis, input$colorSet)
    data <- ptable()
    #validate before proceeding
    validate(
      need( all(c(input$xAxis, input$yAxis) %in% colnames(data)), "Wait! data has changed!" )
    )
    
    #show title if x-axis is given
    output$UiDescriptiveTableCaption <- renderUI({
      if(pltType() != "none" && is.numeric(yVar()[[1]])){
        helpText("Table 2. Descriptive statistics", style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px")
      }
    })
    
    
    #display the table
    output$UiDescriptiveTable <- renderReactable({
      
      if(pltType() != "none" && is.numeric(yVar()[[1]])){
        
        #require y-axis (skip for histogram, density and frequency polygon)
        #determine descriptive statistis
        # case 1: no aesthetic were provided
        # case 2: aesthetic provided
        #       case i: all aesthetic equal with x-axis
        #       case ii: only color applied - may or may not be equal with x-axis
        #       case iii: only shapeLine applied - may or may not be equal with x-axis
        #       case iv: both applied - may or may not be equal with x-axis.
        #case 1:
        tryCatch({
          
          if(input$colorSet == "none" && !isTruthy(input$shapeLine)){
            xA_grp <- input$xAxis
            #end of case 1
          }else{
            #case 2:
            if(input$colorSet != "none" && !isTruthy(input$shapeLine)){
              #case ii:
              xA_grp <- if(input$colorSet == input$xAxis){
                input$xAxis
              }else c(input$xAxis, input$colorSet)
              
            }else if(input$colorSet == "none" && isTruthy(input$shapeLine)){
              #case iii:
              if(isTruthy(input$shapeSet) && !isTruthy(input$lineSet)){
                xA_grp <- if(input$shapeSet == input$xAxis){
                  input$xAxis 
                }else c(input$xAxis, input$shapeSet) 
                
              }else if(!isTruthy(input$shapeSet) && isTruthy(input$lineSet)){
                
                xA_grp <- if(input$lineSet == input$xAxis){
                  input$xAxis
                }else c(input$xAxis, input$lineSet)
              }
              
            }else if(input$colorSet != "none" && isTruthy(input$shapeLine)){
              
              if(isTruthy(input$shapeSet)){
                
                if( all(input$xAxis == c(input$colorSet, input$shapeSet)) ){
                  #case i:
                  xA_grp <- input$xAxis
                }else if( any(input$xAxis == c(input$colorSet, input$shapeSet)) ){
                  #case iV:
                  xA_grp <- c(input$colorSet, input$shapeSet)
                }else{
                  #case iV:
                  xA_grp <- c(input$xAxis, input$colorSet, input$shapeSet)
                }
                
              }else if(isTruthy(input$lineSet)){
                
                if( all(input$xAxis == c(input$colorSet, input$lineSet)) ){
                  #case i:
                  xA_grp <- input$xAxis
                }else if( any(input$xAxis == c(input$colorSet, input$lineSet)) ){
                  #case iV:
                  xA_grp <- c(input$colorSet, input$lineSet)
                }else{
                  #case iV:
                  xA_grp <- c(input$xAxis, input$colorSet, input$lineSet)
                }
              }
              
            }#end of all aesthetic provided
          } #end of case 2
          
          stopAll(0)
          
        }, error = function(e){
          stopAll(1)
          validate(
            need(stopAll() == 0, "Error: unable to process the data. Please check the data")
          )
        })
        
        #table for display in the summary
        dspTable <- descriptiveStatFunc(df = data, xA = xA_grp, yA = input$yAxis)
        table2(dspTable)
        
        reactable(dspTable, sortable = FALSE, outlined = TRUE)
        
      }
    })
    
  })
  
  
  #statment of assumption test: to be use in report
  statment1 <- reactiveVal(NULL)
  statment2 <- reactiveVal(NULL)
  #check whether anova can be computed or not
  twoAnovaError <- reactiveVal(0)
  #anova error alert
  observe({
    req(input$stat)
    # browser()
    output$UiAnovaErrorAlert <- renderUI({
      if(req(input$stat) == "anova"){
        if(req(input$pairedData) == "two"){
          ifelse(is_empty(input$twoAovVar) || input$twoAovVar == "", twoAnovaError(1), twoAnovaError(0))
        }else twoAnovaError(0)
      }else twoAnovaError(0)
      
      if(twoAnovaError() == 1){
        helpText("Provide at least 1 independent variable", style = "color:red; margin-top:0; text-align:center")
      }
    })
  })
  
  
  # #Display normality and homogeneity test for parametric statistic
  observe({
    req(is.data.frame(ptable()), pltType() != "none", input$xAxis, input$yAxis, input$stat %in% c("t.test", "anova"), computeFuncError(), twoAnovaError())
    
    data <- ptable()
    
    #title
    output$UiAssumptionTitle <- renderUI({
      if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
        validate("")
      }
      
      #anova check
      validate(
        need(twoAnovaError() == 0, "")
      )
      
      if(input$stat %in% c("t.test", "anova"))
        helpText("Testing assumptions for the parametric test", style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px")
    })
    
    #get input param for liner regression
    num_var <- input$yAxis #dependent variable
    
    #validate the presence of x axis before proceeding: It will take care of change in data by the user
    validate(
      need(input$xAxis %in% colnames(data), "Require column not available. Wait!")
    )
    
    #convert x-axis to factor
    data <- data %>% mutate(across(.data[[input$xAxis]], factor))
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
              data <- data %>% mutate(across(.data[[input$shapeSet]], factor))
              ind_var <- paste0(input$xAxis,":",input$shapeSet)
            }
          }else if(input$shapeLine == "Line type"){
            if(req(input$lineSet) == input$xAxis){
              #equal with x-axis
              ind_var <- input$xAxis
            }else{
              #not equal with x-axis
              data <- data %>% mutate(across(.data[[input$lineSet]], factor))
              ind_var <- paste0(input$xAxis,":",input$lineSet)
            }
          }
          
        }
        
      }else if(input$colorSet != 'none' && input$colorSet != input$xAxis){
        #aesthetic provided for color and not equal with x-axis
        # override: no need to check for other aesthetics
        data <- data %>% mutate(across(.data[[input$colorSet]], factor))
        ind_var <- paste0(input$xAxis,":",input$colorSet)
      }
      
      #end of t.test
    }else if(input$stat == "anova" ){
      
      req(input$pairedData)
      av <- input$pairedData
      if(av == "one"){
        ind_var <- input$xAxis
      }else{
        req(input$anovaModel, input$twoAovVar)
        #anova check
        validate(
          need(twoAnovaError() == 0, " ")
        )
        
        data <- data %>% mutate(across(.data[[input$twoAovVar]], factor))
        if(input$anovaModel == "additive" ){
          ind_var <- paste0(input$xAxis,"+", input$twoAovVar)
          #for levene test, it has to be crossed
          lv_var <- paste0(input$xAxis,"*", input$twoAovVar)
        }else if(input$anovaModel == "non-additive"){
          ind_var <- paste0(input$xAxis,"*", input$twoAovVar)
        }
      }
    }#end of anova
    
    
    #formula
    message("--------ind_var for regress")
    message(ind_var)
    if(input$stat %in% c("t.test", "anova")){
      #anova check
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      forml <- reformulate(response = glue::glue("{num_var}"), termlabels = glue::glue("{ind_var}")) 
      #run linear regression based on user's input.
      tryCatch({
        model <- lm(data = data, formula = forml)  
        #residual
        resl <- resid(model)
      }, error = function(e){
        print(e)
      })
      
    }
    
    #residual plot
    output$UiResidualPlot <- renderPlot({
      
      #anova check
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if( pltType() != "none" && input$stat %in% c("t.test","anova") ){
        
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          plot(fitted(model), resl, main= "Figure 1. Residual plot", ylab="residual") %>% abline(0,0, col="red")
          rec <- recordPlot()
          figure1(rec)
          rec
        }
      }
      res=350
    })
    
    #density plot
    output$UiNDensityPlot <- renderPlot({
      
      #anova check
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if( pltType() != "none" && input$stat %in% c("t.test", "anova") ){
        
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          plot(density(resl), main="Figure 2. Density plot of residuals")
          rec <- recordPlot()
          figure2(rec)
          rec
        }
      }
      res=350
    })
    
    #qqplot
    output$UiQqplot <- renderPlot({
      
      #anova check
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if( pltType() != "none" && input$stat %in% c("t.test", "anova") ){
        
        if(input$stat == 't.test' && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          qqnorm(resl, main="Figure 3. Q-Q plot of residuals")
          qqline(resl, col="red") 
          rec <- recordPlot()
          figure3(rec)
          rec
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
      
      #anova check
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if( pltType() != "none" && ( input$stat == "t.test" || (input$stat == "anova" && computeFuncError() == 0) ) ){
        
        #levene test
        if(input$stat == "anova" && input$pairedData == 'two' && input$anovaModel == "additive"){
          form_lv <- reformulate(response = glue::glue("{num_var}"), termlabels = glue::glue("{lv_var}")) #used in levene test 
          model_lv <- lm(data = data, formula = form_lv) 
          lvT <- car::leveneTest(model_lv)
        }else{
          lvT <- car::leveneTest(model)
        }
        
        #get sample size
        sampleSize <- nrow(data)
        x <- rstandard(model)
        
        if(sampleSize <= 5000){
          
          #shapiro
          message("shaprio length")
          
          normT <- shapiro.test(x)
          if(normT$p.value <= 0.05 | lvT[1,3] <= 0.05){
            statment1(round(lvT[1,3], digit=3))
            statment2(round(normT$p.value, digit = 3))
            
            helpText( list( tags$p(glue::glue("The p-value (rounded to 3 decimal places) for Levene's homoscedasticity test is { statment1() }, and Shapiro-Wilk's normality test is { statment2() }."),style = "color:red; margin-left:10%; margin-right:10%;font-weight:bolder"),
                            tags$p("Note: Higher the p-value (generally greater than 0.05), the more likely it satisfy the parametric assumptions.", style = "color:black; margin-left:10%; margin-right:10%; font-weight:bold")
            )
            )
            
          }else{
            statment1(round(lvT[1,3], digit=3))
            statment2(round(normT$p.value, digit = 3))
            
            helpText( list( tags$p(glue::glue("The p-value (rounded to 3 decimal places) for Levene's homoscedasticity test is { statment1() }, and Shapiro-Wilk's normality test is { statment2() }."), style = "color:#3385ff; margin-left:10%; margin-right:10%;font-weight:bolder"),
                            tags$p("Note: Higher the p-value (generally greater than 0.05), the more likely it satisfy the parametric assumptions.", style = "color:black; margin-left:10%; margin-right:10%; font-weight:bold")
            )
            )
          }
          
        }else{
          normT <- ks.test(x, "pnorm", mean = mean(x), sd = sd(x))
          if(normT$p.value <= 0.05 | lvT[1,3] <= 0.05){
            statment1(round(lvT[1,3], digit=3))
            statment2(round(normT$p.value, digit = 3))
            helpText( list( tags$p(glue::glue("The p-value (rounded to 3 decimal places) for Levene's homoscedasticity test is { statment1() }, and Kolmogrov-Smirnov's normality test is { statment2() }."),style = "color:red; margin-left:10%; margin-right:10%;font-weight:bolder"),
                            tags$p("Note: Higher the p-value (generally greater than 0.05), the more likely it satisfy the parametric assumptions.", style = "color:black; margin-left:10%; margin-right:10%; font-weight:bold")
            )
            )
            
          }else{
            statment1(round(lvT[1,3], digit=3))
            statment2(round(normT$p.value, digit = 3))
           
            helpText( list( tags$p(glue::glue("The p-value (rounded to 3 decimal places) for Levene's homoscedasticity test is { statment1() }, and Kolmogrov-Smirnov's normality test is { statment2() }."),style = "color:#3385ff; margin-left:10%; margin-right:10%;font-weight:bolder"),
                            tags$p("Note: Higher the p-value (generally greater than 0.05), the more likely it satisfy the parametric assumptions.", style = "color:black; margin-left:10%; margin-right:10%; font-weight:bold")
            )
            )
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
    
    req( is.data.frame(ptable()), pltType() != 'none', input$stat != 'none', !is.null(testTable$df), unpaired_stopTest() == 'no', computeFuncError(), twoAnovaError())
    
    #caption
    output$UiStatSumCaption <- renderUI({
      if(input$stat %in% c('t.test', "wilcoxon.test") && unpaired_stopTest() == 'yes'){
        validate("")
      }
      
      #check whether anova can be computed or not
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      
      #type of stat
      if(input$stat == "t.test"){
        req(input$ttestMethod)
        
        if(input$ttestMethod == "welch"){
          ttype <- "t-test (Welch's test)"
        }else{
          ttype <- "t-test (Student's test)"
        }
        
      }else if(input$stat == "kruskal-wallis"){
        
        ttype <-  "Kruskal-Wallis test"
        
      }else if(input$stat == 'anova'){
        #for anova
        req(input$pairedData)
        if(input$pairedData == "one"){
          ttype <- "one-way ANOVA"
        }else if(input$pairedData == "two"){
          if(input$anovaModel == "additive"){
            ttype <- "two-way ANOVA (additive model)"
          }else{
            ttype <- "two-way ANOVA (non-additive model)"
          }
        }
        
      }else if(input$stat == "wilcoxon.test"){
        
        if(input$pairedData == "no"){
          ttype <- "Wilcoxon rank-sum test"
        }else{
          ttype <- "Wilcoxon sign-rank test"
        }
        
      }
      
      helpText(glue::glue("Table 3. Summary for {ttype}."), style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px;")
    })
    
    output$UiStatSubCaption <- renderUI({
      
      #check whether anova can be computed or not
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if(input$stat %in% c('t.test', "wilcoxon.test")){
        if(unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          subCaption <- "'.y.' is the variable used in y-axis; 'group 1 & 2' are the groups compared in the test;
        'n' are the sample counts; 'statistic' is the test used to compute the p-value;
        'p' is the p-value"
        }
        
      }else if(input$stat == "kruskal-wallis"){
        subCaption <- "'.y.' is the y-axis variable; 'n' is the count of sample; 'statistic' is the test used to compute the p-value; 'df' is the degree of freedom;
        'p' is the p-value"
      }else if(input$stat == "anova"){
        subCaption <- ""
      }
      
      helpText(subCaption, style = "padding: 5px; margin-top:10px; margin-bottom:0;font-size:15px")
    })
    
    
    
    #table for stat summary
    output$UiStatSummaryTable <- renderReactable({
      if(input$stat %in% c('t.test', "wilcoxon.test") && unpaired_stopTest() == 'yes'){
        validate("")
      }else{
        if(input$stat == "anova" && input$pairedData == "two"){
          
          #check whether anova can be computed or not
          validate(
            need(twoAnovaError() == 0, " ")
          )
          
          validate(
            need(computeFuncError() == 0, "Error: cannot compute! Please, check the data")
          )
        }
        table3(testTable$df)
        reactable(as.data.frame(testTable$df), sortable = FALSE, pagination = FALSE, outlined = TRUE)
        
      }
    })
    
    
  })
  
  
  #effect size------------------
  observe({
    req(ptable(), pltType(), input$xAxis, input$yAxis, input$stat != "none", computeFuncError(), twoAnovaError())
    validate(
      need(computeFuncError() == 0 & twoAnovaError() == 0, "stop")
    )
    output$UiEffectSizeMethod <- renderUI({
      if(input$stat == "t.test"){
        selectInput(inputId = "effectSizeMethod", list(icon("wrench"),tags$span("Method", style="color:#E11604")), 
                    choices = c("Cohen's d", "Hedge's g", "Glass delta"), selected = "Hedge's g")
      }else if(input$stat == "anova"){
        req(input$pairedData)
        if(input$pairedData == "one"){
          selectInput(inputId = "effectSizeMethod", list(icon("wrench"),tags$span("Method", style="color:#E11604")), 
                      choices = c("Eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"))
        }else{
          selectInput(inputId = "effectSizeMethod", list(icon("wrench"),tags$span("Method", style="color:#E11604")), 
                      choices = c("Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"), selected = "Partial eta-squared")
        }
        
      }else if(input$stat %in% c("wilcoxon.test", "kruskal-wallis")){
        req(input$stat %in% c("wilcoxon.test", "kruskal-wallis"))
        dropdownButton(
          inputId = "dbBootStrap",
          label = "Bootstrap setting",
          icon = icon("sliders"),
          circle = FALSE,
          up = TRUE,
          margin = '5px',
          status = "primary",
          tooltip = tooltipOptions(title = "Click to adjust"),
          div(
            class= "dbBootStrapDiv",
            sliderTextInput(inputId = "effectSizeMethod",
                            label = "Number of replicates for bootstrap",
                            choices = c(10, 100, 500, 1000, 1500, 2000, 2500, 3000), grid = TRUE),
            helpText("Computation will be slower with more replicates!", style = "color:red; font-weight:normal")
          )
        )
        
      }
    })
  })
  
  #error msg
  efsErrorMsg <- reactiveVal(NULL)
  #determine effect size
  observe({
    req(ptable(), input$stat != "none", input$yAxis, input$xAxis, input$effectSizeMethod,
        computeFuncError(), twoAnovaError())
    
    validate(
      need(computeFuncError() == 0 & twoAnovaError() == 0, "stop")
    )
    validate(
      need( all( c(input$yAxis, input$xAxis) %in% colnames(ptable()) ), "" )
    )
    
    message(input$stat)
    #checks to avoid crash
    if(input$stat == "t.test"){
      req(input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta"))
    }else if(input$stat == "anova"){
      req(input$effectSizeMethod %in% c("Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"))
    }else if(input$stat == "wilcoxon.test"){
      req(!input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta", "Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"), input$compareOrReference)
    }else if(input$stat == "kruskal-wallis"){
      req(!input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta", "Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"))
    }
    
    #categorical independent variable
    indpVar <- reactive({
      #case 1: aesthetic(s) not applied, use the variable of x-axis
      #case 2: aesthetic(s) applied
      #     i. Variable of x-axis and aesthetic are equal, use variable of x-axis
      #     ii. variables are different, use the variables of aesthetic as categorical or independent variable in the formula
      if((input$stat == "anova" && req(input$pairedData) == "one") || !input$stat %in% c("none", "anova")){
        
        if( req(input$colorSet) == "none" && !isTruthy(input$shapeLine) ){
          #case 1
          input$xAxis
        }else{
          # case 2
          if(req(input$colorSet) != "none"){
            #case 2 i & ii
            ifelse(input$colorSet == input$xAxis, input$xAxis, input$colorSet)
          }else if(isTruthy(input$shapeLine) && req(input$shapeLine) == "Shape"){
            #case 2 i & ii
            ifelse(input$shapeSet == input$xAxis, input$xAxis, input$shapeSet)
          }else if(isTruthy(input$shapeLine) && req(input$shapeLine) == "Line type"){
            #case 2 i & ii
            ifelse(input$lineSet == input$xAxis, input$xAxis, input$lineSet)
          }
          
        }
        
      }else if(input$stat == "anova" && req(input$pairedData) == "two"){
        # For two-way anova: select x-axis and one more independent variable choosen by the user
        c(colnames(input$xAxis), req(input$twoAovVar))
      }
      
    })
    
    
    #get the list for comparison and reference group: applicable only for t test and wilcoxon
    if(input$stat %in% c("t.test", "wilcoxon.test")){
      #get compare and reference group
      compRef <- reactive(req(input$compareOrReference))
      ref <- if(compRef() == "reference group"){
        if(is_empty(rfGrpList$lists)){ NULL }else { rfGrpList$lists}
      }else { NULL }
      
      cmp <- if(compRef() == "comparison"){
        if(!is_empty(cmpGrpList$lists)){ cmpGrpList$lists }else{ NULL }
      }else { NULL }
    }
    
    #compute effect size
    tryCatch({
      if(input$stat == "t.test"){
        message("preparing compareOrReference list")
        #get the formula
        forml <- reformulate(response = glue::glue("{input$yAxis}"), termlabels = glue::glue("{indpVar()}")) 
        #get all possible combinations of variables
        if(!is.null(ref)){
          req(indpVar() %in% colnames(ptable()))
          uniqVar <- unique(ptable()[ ptable()[indpVar()] != ref, indpVar()])
          cbn <- lapply(as.vector(uniqVar), function(x) c(ref, x))
          
        }else if(!is.null(cmp)){
          req(all(c(input$xAxis, input$yAxis) %in% c(colnames(ptable()))))
          browser()
          message(cmp)
          cbn <- cmp
        }else {
          message(indpVar())
          req(indpVar() %in% colnames(ptable()))
          cbn <- combn(unique(ptable()[,indpVar(),drop=T]), 2, simplify = FALSE)
        }
        
        #run the function to determine effect size
        message(cbn)
        efs_list <- lapply(cbn, efS, dt = ptable(), v = indpVar(), y = input$yAxis, method = req(input$effectSizeMethod), 
                           stat = input$stat, welchs = ifelse(req(input$ttestMethod) == "welch", TRUE, FALSE), fa = forml, paired = ifelse(input$pairedData == "no", FALSE, TRUE))
        #convert the list to data frame
        efs_df <- data.frame(matrix(nrow = 1, ncol = 8))
        for (i in seq_along(efs_list)) {
          col <- colnames(efs_list[[i]])
          names(efs_df) <- col
          efs_df[ i, ] <- efs_list[[i]]
        }
        
        
      }else if(input$stat == "anova"){
        
        
        if(req(input$pairedData) == "one"){
          #get the formula
          avIndVar <- aovInFunc(indpVar())
          forml <- reformulate(response = input$yAxis, termlabels = avIndVar)
          efs_df <- efS(dt = ptable(), y = input$yAxis, method = input$effectSizeMethod, 
                        stat = input$stat, fa = forml, x = NULL, v = NULL)
        }else{
          req(input$anovaModel)
          message(input$anovaModel)
          #get the formula
          avIndVar <- aovInFunc(indpVar(), model = input$anovaModel)
          forml <- reformulate(response = input$yAxis, termlabels = avIndVar)
          efs_df <- efS(dt = ptable(), y = input$yAxis, method = input$effectSizeMethod, 
                        stat = input$stat, fa = forml, x = NULL, v = NULL)
        }
        
      }else if(input$stat == "wilcoxon.test"){
        
        #formula
        forml <- reformulate(response = glue::glue("{input$yAxis}"), termlabels = glue::glue("{indpVar()}"))
        
        if(isTruthy(req(input$choosePFormat))){
          efs_df <- rstatix::wilcox_effsize(data = ptable(), formula = forml,
                                            ref.group = unlist(ref), 
                                            comparisons = cmp, 
                                            paired = ifelse(req(input$pairedData) == "no", FALSE, TRUE),
                                            p.adjust.method = req(input$signifMethod),
                                            ci = TRUE,
                                            conf.level = 0.95,
                                            nboot = as.numeric(input$effectSizeMethod)
          )
        }else if(!isTruthy(req(input$choosePFormat))){
          efs_df <- rstatix::wilcox_effsize(data = ptable(), formula = forml,
                                            ref.group = unlist(ref), 
                                            comparisons = cmp, 
                                            paired = ifelse(req(input$pairedData) == "no", FALSE, TRUE),
                                            p.adjust.method = "none",
                                            ci = TRUE,
                                            conf.level = 0.95,
                                            nboot = as.numeric(input$effectSizeMethod)
          )
        }
        
      }else if(input$stat == "kruskal-wallis"){
        #wait for the message for bootstrap and then proceed
        # req(repNo() > 0)
        #get the formula
        forml <- reformulate(response = glue::glue("{input$yAxis}"), termlabels = glue::glue("{indpVar()}"))
        efs_df <- rstatix::kruskal_effsize(data=ptable(), formula = forml,
                                           ci = TRUE,
                                           conf.level = 0.95,
                                           nboot = as.numeric(input$effectSizeMethod))
      }
      
      
      effectSize$df <<- efs_df
    }, error = function(e){
      efsErrorMsg(glue::glue("{e}")) #not implemented yet
      print(e)
    })
    
  })
  
  #caption for report
  reportSubCaption <- reactiveVal(NULL)
  #display effect size. 
  observe({
    
    req( is.data.frame(ptable()), pltType() != "none", input$stat %in% statList, !is.null(effectSize$df), input$effectSizeMethod, computeFuncError(), twoAnovaError() )
    # req( is.data.frame(ptable()), pltType() != "none", input$stat %in% statList, effectSize$df, input$effectSizeMethod, computeFuncError(), twoAnovaError() )
    
    
    validate(
      need(computeFuncError() == 0 & twoAnovaError() == 0, "stop")
    )
    #checks to avoid crash
    if(input$stat == "t.test"){
      req(input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta"))
    }else if(input$stat == "anova"){
      req(input$effectSizeMethod %in% c("Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"))
    }else if(input$stat == "wilcoxon.test"){
      req(!input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta", "Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"), input$compareOrReference)
    }else if(input$stat == "kruskal-wallis"){
      req(!input$effectSizeMethod %in% c("Cohen's d", "Hedge's g", "Glass delta", "Eta-squared", "Partial eta-squared", "Generalized partial eta-squared", "Omega-squared", "Epsilon-squared", "Cohen's f"))
    }
    
    #caption for effect size
    output$UiCapEffectSize <- renderUI({
      if(input$stat != 'none'){
        
        #check whether anova can be computed or not
        validate(
          need(twoAnovaError() == 0, " ")
        )
        
        
        if(input$stat %in% c('t.test', "wilcoxon.test") && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          helpText("Table 4. Table of effect size. Measures the strength of relationship between variables.", style = "margin-top:40px; margin-bottom:0; font-weight:bold; font-size:20px;")
        }
        
      }
      
    })
    #sub-caption for effect size
    output$UiSubCapEffectSize <- renderUI({
      
      if(input$stat %in% c('t.test', "wilcoxon.test") && unpaired_stopTest() == 'yes'){
        validate("")
      }
      #check whether anova can be computed or not
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      if(input$stat == 't.test'){
        # subCaption <- "Effect size computed using Cohen's d. 'conf.low' and 'conf.high' represents lower and upper bound of the effect size confidence interval (95% confidence level)."
        subCaption <- glue::glue("Effect size computed using {input$effectSizeMethod}. CI is the confidence interval level; CI_low and CI_high are the upper and lower bound.")
      }else if(input$stat == "kruskal-wallis"){
        # subCaption <- "Eta-squared based on the H-statistic used as the measure of effect size. 'conf.low' and 'conf.high' represents lower and upper bound of the effect size confidence interval (95% confidence level)."
        subCaption <- glue::glue("Eta-squared based on the H-statistic (of Kruskal-Wallis test) used as the measure of effect size. Formula: Eta2[H] = (H - k + 1)/(n - k); Where k is the number of groups; n is the total number of observations.
        The number of replicates use for bootstrap is {input$effectSizeMethod}. Measured at 95% confidence level: conf.low and
        conf.high are the upper and lower bound.")
      }else if(input$stat == "wilcoxon.test"){
        subCaption <- glue::glue("Effect size is computed using z statistic (of Wilcoxon test) and divided by square root of the sample size. The number of replicates use for bootstrap is {input$effectSizeMethod}. Measured at 95% confidence interval level: conf.low and
        conf.high are the upper and lower bound.")
      }else if(input$stat == "anova"){
        subCaption <- glue::glue("Effect size measured using {input$effectSizeMethod}. CI is the confidence interval level; CI_low and CI_high are the upper and lower bound.")
      }
      
      reportSubCaption(subCaption) #require for report
      
      if(input$stat != 'none'){
        helpText(subCaption, style = "padding: 5px; margin-top:10px; margin-bottom:0;font-size:15px")
      }
    })
    
    
    #table for effect size
    output$UiEffectSize <- renderReactable({
      if(input$stat != 'none'){
        message(twoAnovaError())
        #check whether anova can be computed or not
        validate(
          need(twoAnovaError() == 0, " ")
        )
        
        if(input$stat %in% c('t.test', "wilcoxon.test") && unpaired_stopTest() == 'yes'){
          validate("")
        }else{
          if(input$stat == "anova" && input$pairedData == "two"){
            message(computeFuncError())
            validate(
              need(computeFuncError() == 0, efsErrorMsg())
            )
          }
          table4(effectSize$df)
          reactable(as.data.frame(effectSize$df), sortable = FALSE, pagination = FALSE, outlined = TRUE)
        }
      }
    })
  })
  
  
  #post hoc---------------------
  observe({
    req(is.data.frame(ptable()), pltType() != "none", input$stat %in% c("anova", "kruskal-wallis"), !is.null(postHoc_table$df), computeFuncError(), twoAnovaError())
    
    #caption
    output$UiPostHocCaption <- renderUI({
      #check whether anova can be computed or not
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      tabn <- "Table 5."
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
    
    output$postHocOut <- renderPrint({
      
      #check whether anova can be computed or not
      validate(
        need(twoAnovaError() == 0, " ")
      )
      
      table5(postHoc_table$df)
      postHoc_table$df
    })
  })
  
  
  #end of summary panel-----------------------
  
  
  
  #plotting figure------------------------------
  requirement <- function(){
    #function to add criteria for execution of plot
    #not yet 
    if(input$plotType ==   "box plot"){
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
  observeEvent({
    req(is.data.frame(ptable()),
        input$xAxis,
        input$xAxis %in% colnames(ptable()),
        input$plotType != "none",
        input$normalizeStandardize,
        computeFuncError() #this is require for anova: it will reset between non-additive and additive.
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
    
    #ylim
    ylimit <- reactive(ifelse(input$Ylimit == "yes", TRUE, FALSE))
    #for color setting
    autoCust <- reactive(ifelse(varSet() != "none", input$autoCustome, "none"))
    colorTxt <- reactive(ifelse(autoCust() == "customize", input$colorAdd, "noneProvided"))
    #for shape and line
    shapeLine <- reactive(ifelse(isTruthy(input$shapeLine), input$shapeLine, "none"))
    shapeSet <- reactive(if(shapeLine() == "Shape") req(input$shapeSet))
    lineSet <- reactive(if(shapeLine() == "Line type") req(input$lineSet))
    
    #stat method
    methodSt <- reactive(req(input$stat))
    ttestMethod <- reactive(ifelse(methodSt() == "t.test"&& req(input$ttestMethod) == "student", TRUE, FALSE)) #welch = false, student=TRUE
    pairedData <- reactive(ifelse(req(input$pairedData) == "no", FALSE, TRUE)) #either 'no' or 'yes': no means unpaired
    anovaType <- reactive( ifelse(req(input$stat) == "anova", req(input$pairedData), "no anova"))
    model <- reactive(if(anovaType() == "two") input$anovaModel)
    
    #themes and other related paramters
    textSize <- reactive(req(input$textSize))
    titleSize <- reactive(req(input$titleSize))
    themes <- reactive(req(input$theme))
    varSet <- reactive(req(input$colorSet))
    xTextLabels <- reactive({
      req(figType() != 'none', input$xAxis %in% colnames(ptable()))
      xTextLabel()
    })
    #bar graph
    stackDodge <- reactive(if(figType() %in% c("bar plot", "histogram")) req(input$stackDodge))
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
      
      switch(figType(),
             "box plot" = geom_boxplot(width = freqPolySize()),
             "violin plot" = geom_violin(width = freqPolySize()),
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
             "scatter plot" = geom_point(position = handleOverplot(), size = freqPolySize(), alpha = req(input$scatterAlpha)),
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
             
             "bar plot" = geom_bar(stat = "identity", position = stackDodge(), width = freqPolySize() ),
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
    
    
    #parameters for computing statistics
    #dependent variable
    numericVar <- reactive({
      if(figType() %in% c(  "box plot","violin plot", "bar plot","line", "scatter plot")){
        if(methodSt() != "none") xyAxis()[2]
      }else if(figType() %in% c("histogram")){
        #for histogram, it will depend upon the data used for ploting
        #1. count
        #2. use data as is
        "count"
      }
    })
    
    twoAovVar <- reactive(if(methodSt() == "anova" && anovaType() == "two" && (varSet() != "none" || shapeLine() != "none")) req(input$twoAovVar))
    # ssType <- reactive(ifelse(methodSt() == "anova", input$ssType, "not anova"))
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
        c(colnames(xVar()),twoAovVar())
      }
      
    })
   
    groupStat <- reactive({
      #If independant variable is equal with variable of x-axis, then no grouping: no
      #not equal, then grouped and compute: yes
      #grouping is not required for anova; this method not applied for anova
      if(!methodSt() %in% c("none", "anova", "kruskal-wallis") && (varSet() != "none" || shapeLine() != "none")){
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
      
      if(choosePLabel() == "p.adj.signif"){
        ifelse(isTRUE(pAdjust()),"p.adj.signif","p.signif")
      }else if(choosePLabel() == "p.adj"){
        ifelse(isTRUE(pAdjust()),"p.adj","p")
      }
    })#reactive(ifelse(isTruthy(input$choosePLabel), ifelse(isTRUE(pAdjust), "p.adj", "p"), FALSE)) #if false, no need to add add_significance
    
    compareOrReference <- reactive({
      
      if(methodSt() %in% c("t.test", "wilcoxon.test")){ req(input$compareOrReference) }
    })
  
    #line and bar graph error bar
    #add error bar?
    addErrorBar <- reactive(ifelse(figType() %in% c("line","bar plot", "scatter plot", "violin plot") && isTruthy(input$lineErrorBar), TRUE, FALSE)) #TRUE: add error bar
    #compute sd?
    computeSD <- reactive(ifelse(isTRUE(addErrorBar()) && input$lineComputeSd == "yes", TRUE, FALSE)) #TRUE: compute sd
    
    #This is require for line, bar and scatter plot
    
    #which variable(s) to groupby for sd column?
    #IF no to compute SD than user will specify the computed columns
    lineGroupVarYN <- reactive(ifelse(isTruthy(input$lineGroupVar), TRUE, FALSE)) #TRUE means column is specified
    lineGroupVar <- reactive(if(isTruthy(input$lineGroupVar)) input$lineGroupVar) #get the sd specified by the user
    lineConnectPath <- reactive({ 
      if(figType()  == "line"){ 
        req(input$lineConnectPath)
      }else if(figType() %in% c("scatter plot", "bar plot")){
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
                ( varSet() == "none" && shapeLine() != "none" &&  ( figType() %in% c("line", "bar plot") && lineSet() == colnames(xVar()) ) ) ||
                ( varSet() == "none" && shapeLine() != "none" &&  ( figType() == "scatter plot" && shapeSet() == colnames(xVar()) ) ) 
            ){
              
              message("computing sd")
              #compute SD
              newData <- sdFunc(x = ptable(), oName = colnames(xVar()), yName = colnm, lineGrp = lineConnectPath())
              
              #computing
              message("computed sd--------------")
              
              
            }else if( !varSet() %in% c("none", colnames(xVar())) ){
              #if variable for color is present and different from x-axis, no need to check for other aesthetics
              message("hereddss")
              newData <- sdFunc(x = ptable(), oName = c(colnames(xVar()), varSet()), yName = colnm, lineGrp = lineConnectPath() )
              
            }else if( varSet()  %in% c('none', colnames(xVar())) && shapeLine() != "none"){
              message("shapeLine not one")
              if( figType() %in% c("line", "bar plot", "violin plot") && lineSet() != colnames(xVar()) ){
                message("lineSet")
                newData <- sdFunc(x = ptable(), oName = c(colnames(xVar()), lineSet()), yName = colnm, lineGrp = lineConnectPath() )
              }else if(figType() == "scatter plot" && shapeSet() != colnames(xVar())){
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
            
            #by default aesthetic will have only one option for two-way anova.
            newData <- sdFunc(x = ptable(), oName = anovaFigure(), yName = colnm, lineGrp = lineConnectPath())
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
          if(errorBarColor() == "default"){
            #default color is appropriate when user provide color aesthetics
            geom_erbar <- switch(figType(),
                                 "line" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                        width = 0.1, position = position_dodge(0.03), size = freqPolySize()),
                                 "bar plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                            width = 0.1, position = position_dodge(width = 0.9)),
                                 "scatter plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                width = 0.1, position = position_dodge(width = 0.9), size = req(input$errorBarSize)),
                                 "violin plot" = geom_pointrange(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                 position = position_dodge(width = 0.9), size = req(input$errorBarSize))
            )
          }else{
            #not default
            geom_erbar <- switch(figType(),
                                 "line" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                        width = 0.1, position = position_dodge(0.03), size = freqPolySize(), color = errorBarColor()),
                                 "bar plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                            width = 0.1, position = position_dodge(width = 0.9), color = errorBarColor()),
                                 "scatter plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                width = 0.1, position = position_dodge(width = 0.9), size = req(input$errorBarSize), color = errorBarColor()),
                                 "violin plot" = geom_pointrange(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                 position = position_dodge(width = 0.9), size = req(input$errorBarSize), color = errorBarColor())
            )
          }
          
          #end of compute sd
        }else{
          newData <- ptable()
          if(isTRUE(lineGroupVarYN())){
            #if SD computed and specified the sd column
            # #convert the lineGroupVar to factor
            # newData <- newData %>% mutate(across(lineGroupVar(), factor))
            #geom_errorbar
            if(errorBarColor() == "default"){
              geom_erbar <- switch(figType(),
                                   "line" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                              ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  
                                                          width = 0.1, position = position_dodge(0.03), size = freqPolySize()),
                                   "bar plot" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                                  ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  
                                                              width = 0.1, position = position_dodge(width = 0.9)), #position will always be dodge for error_bar
                                   "scatter plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - sd, ymax = .data[[colnm]] + sd), 
                                                                  width = 0.1, position = position_dodge(width = 0.9), size = req(input$errorBarSize)),
                                   "violin plot" = geom_pointrange(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                   position = position_dodge(width = 0.9), size = req(input$errorBarSize))
              )
            }else{
              geom_erbar <- switch(figType(),
                                   "line" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                              ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  width = 0.1,
                                                          position = position_dodge(0.03), size = freqPolySize(), color = errorBarColor()),
                                   "bar plot" = geom_errorbar(data = newData, aes(ymin = .data[[ colnm ]] - .data[[ lineGroupVar() ]],
                                                                                  ymax = .data[[ colnm ]] + .data[[ lineGroupVar() ]]),  width = 0.1,
                                                              position = position_dodge(width = 0.9), color = errorBarColor()), #position will always be dodge for error_bar
                                   "scatter plot" = geom_errorbar(data = newData, aes(ymin= .data[[colnm]] - sd, ymax = .data[[colnm]] + sd), 
                                                                  width = 0.1, position = position_dodge(width = 0.9), size = req(input$errorBarSize), color = errorBarColor()),
                                   "violin plot" = geom_pointrange(data = newData, aes(ymin= .data[[colnm]] - .data[[ebs]], ymax = .data[[colnm]] + .data[[ebs]]), 
                                                                   position = position_dodge(width = 0.9), size = req(input$errorBarSize), color = errorBarColor())
              )
            }
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
    facet <- reactive({
      
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
    
    #display the plot
    output$figurePlot <- renderPlot({
      #resolution for the plot
      res=400
      
      message("catVarbelow2----")
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
      }else if(methodSt() == "anova" && anovaType() == "two"){
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
      if(methodSt() %in% c('t.test', "wilcoxon.test")){
        validate(
          need( unpaired_stopTest() == 'no', "Data appears to be unpaired!")
        )
      }
      #check for anova
      if(methodSt() == "anova" && anovaType() == "two"){
        validate(need(twoAnovaError() == 0, "Two-way anova require more variables to compare"))
      }
      #check end--------------------------------------
      
      tryCatch({
        if(figType() != "none" && methodSt() != "none"){
          
          #necessary for t.test and wilcoxon test: ..??
          message(compareOrReference())
          # message(input$compareOrReference) 
          
          
          #compute statistic only when requested
          statData <- reactive({
            
            #show notification
            computeMsg <- showNotification("Computing.. Please wait.....", duration = NULL, closeButton = FALSE,
                                           type ="message", id = "computeMsg")
            on.exit(removeNotification(computeMsg), add = TRUE)
            
            # cacheGSD <- memoise::memoise(generateStatData)
            # cacheGSD() #kruskal-wallis is not working for this
            statData <- generateStatData(data = ptable(), groupStat = groupStat(), groupVar = groupStatVarOption(), 
                                         method = methodSt(), numericVar = numericVar(),
                                         catVar = catVar(), compRef = compareOrReference(),
                                         ttestMethod = ttestMethod(), paired = pairedData(), 
                                         model = model(), pAdjust = pAdjust(),
                                         pAdjustMethod = pAdjustMethod(), labelSignif = labelSt(), cmpGrpList = cmpGrpList$lists, rfGrpList = rfGrpList$lists,# switchGrpList = switchGrpList$switchs,
                                         xVar = xyAxis()[[1]], anovaType = anovaType())#, ssType = ssType())
          })
          
          statDataStore$df <<- isolate(statData()[[1]])
        }
        
        computeFuncError(0)
        
      }, error = function(e){
        
        computeFuncError(1)
        computeFuncErrorMsg(glue::glue("{e}"))
        print(e)
        # validate(glue::glue(computeFuncErrorMsg()))
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
                                layer = layer(), layerSize = layerSize(), xTextLabel = xTextLabels(), ylim=ylimit())
            # finalPlt
            
          }else if(varSet() != "none" && methodSt() == "none"){
            #disable parameters for statistic
            #based on plot type use color or fill
            if(!figType() %in% c("frequency polygon", "line", "scatter plot")){
              
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
                                  fill = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #fill the color
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
                                  color = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #color the line
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
                                layer = layer(), layerSize = layerSize(), xTextLabel=xTextLabels(), ylim=ylimit())
            # finalPlt
          }else if(varSet() != "none" && methodSt() != "none"){
            #enable parameters for both the color and statistics
            #based on plot type use color or fill
            if(!figType() %in% c("frequency polygon", "line", "scatter plot")){
              
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
                                  fill = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #fill the color
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
                                  color = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #color the line
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
            if(!figType() %in% c("frequency polygon", "line", "scatter plot")){
              
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
                                  fill = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #fill the color
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
                                  color = .data[[varSet()]], xTextLabel=xTextLabels(), ylim=ylimit()) #color the line
              # finalPlt
            }
            
            #end of interaction
          }else if(anovaFigure() != "Interaction"){
            #Figure for non-interaction
            message("stop1")
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
            
            if(anovaFigure() == twoAovVar()){
              xyAxis <- reactive(list(twoAovVar(), colnames(yVar())))
            }
            
            anovaAutoCust <- reactive(ifelse(anovaFigure() != "Interaction", input$anovaAutoCust, "none"))
            anovaColor <- reactive(if(anovaFigure() != "Interaction" && anovaFigure() %in% colnames(ptable())) input$anovaFigure)
            anovaAddColor <- reactive(ifelse(anovaFigure() != "Interaction" && anovaAutoCust() == "customize", input$anovaAddColor, "noneProvided"))
            aovX <-if(anovaFigure() == colnames(xVar())){
              "group1"
            }else{
              anovaFigure()
            }
            
            if(!figType() %in% c("frequency polygon", "line", "scatter plot")){
              
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
                                  fill = .data[[anovaColor()]], xTextLabel=xTextLabels(), ylim=ylimit()) #fill the color
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
                                  color = .data[[anovaColor()]], xTextLabel=xTextLabels(), ylim=ylimit()) #color the line
              # finalPlt
            }
          }  #end of non interaction
          
          
        }#end of two way anova
        
        saveFigure(finalPlt) #save it
        finalPlt #final plot
        
      }, error = function(e){
        print(e)
      })
      
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
        heights <- ifelse(isTruthy(input$figHeight) && !str_detect(input$figHeight, "[:alpha:]"), as.numeric(input$figHeight), 4)
        widths <- ifelse(isTruthy(input$figWidth) && !str_detect(input$figWidth, "[:alpha:]"), as.numeric(input$figWidth), 4)
        plt <- if(!is.null(saveFigure())){
          saveFigure()
        }else{ NULL}
        ggsave(file, plot = plt, device = pDev, height = heights, width = widths, dpi = 300, units = "in")
      }
    )
  })
  
  observe({
    req(input$statSumDownList)
    output$downloadStatSummary <- downloadHandler(
      
      filename = function() {
        dlChoice <- req(input$statSumDownList)
        if(tolower(dlChoice) == "report"){
          ifelse(req(input$statSumDownFormat) == "PDF", "plotS_report.pdf", "plotS_report.docx")
        }else if(str_detect(dlChoice, regex("^Table \\d$"))){
          # str_detect("Table 1", regex("^Table \\d$"))
          if(str_detect(dlChoice, regex("^Table 5$"))){
            paste0("plotS_",dlChoice,".xlsx")
          }else{
            paste0("plotS_",dlChoice,".csv")
          }
          
        }else if(str_detect(dlChoice, regex("^Figure \\d$"))){
          
          dlFormat <- req(input$statSumDownFormat)
          #pdf, png, eps, tiff
          if(tolower(dlFormat) == "pdf"){
            paste0("plotS_",dlChoice,".pdf")
          }else if(tolower(dlFormat) == "png"){
            paste0("plotS_",dlChoice,".png")
          }else if(tolower(dlFormat) == "bmp"){
            paste0("plotS_",dlChoice,".bmp")
          }else{
            paste0("plotS_",dlChoice,".tiff")
          }
        }
        
      },
      content = function(file){
        
        dlChoice <- req(input$statSumDownList)
        if(dlChoice == "Table 1"){
          write_csv(table1(), file)
        }else if(dlChoice == "Table 2"){
          write_csv(table2(), file)
        }else if(dlChoice == "Table 3"){
          write_csv(table3(), file)
        }else if(dlChoice == "Table 4"){
          write_csv(table4(), file)
        }else if(dlChoice == "Table 5"){
          
          #save as worksheet: openxlsx
          #create a workbook
          wb <- openxlsx::createWorkbook()
          #add sheet name and write the data
          if(is.data.frame(table5())){
            addWorksheet(wb, sheetName = "table 5")
            writeData(wb, table5()[], sheet = "table 5")
          }else if(!is.data.frame(table5())){
            for(i in 1:length(table5())){
              #prepare the sheet name of the table: ':' not allow
              colName <- names(table5()[i])
              sheetnames <- ifelse( str_detect(colName, ":"), sub(":",".", colName), colName )
              #add proper column name in the final output
              x_df <- as.data.frame(table5()[i])
              x_df[, sheetnames] <- rownames(as.data.frame(table5()[i]))
              x_df <- x_df %>% select(.data[[sheetnames]], everything())
              # rownames(x_df) <- NULL
              
              addWorksheet(wb, sheetName = sheetnames)
              # str_detect("red:blue", ":")
              # sub(":","*","red:blue")
              
              writeData(wb, x_df, sheet = sheetnames)
            }
          }
          
          #save the sheet
          saveWorkbook(wb, file = file, overwrite = TRUE)
          
        }else if(dlChoice == "Figure 1"){
          
          figureDowFunc(fig = figure1(), filename = file, format = tolower(req(input$statSumDownFormat)))
          
        }else if(dlChoice == "Figure 2"){
          figureDowFunc(fig = figure2(), filename = file, format = tolower(req(input$statSumDownFormat)))
        }else if(dlChoice == "Figure 3"){
          figureDowFunc(fig = figure3(), filename = file, format = tolower(req(input$statSumDownFormat)))
        }else if(dlChoice == "Report"){
          
          # Set up parameters to pass to Rmd document: depend on the type of plot and stat
          if(pltType() != "none" && input$stat != "none"){
            if(input$stat == "t.test"){
              param <- list(table1 = table1(), table2 = table2(), table3=table3(), table4 = table4(),
                            figure1 = figure1(), figure2 = figure2(), figure3 = figure3(),
                            caption = input$ttestMethod, statment1 = statment1(), statment2 = statment2(),
                            subcaption = reportSubCaption()
              )
            }else if(input$stat == "wilcoxon.test"){
              param <- list(table1 = table1(), table2 = table2(), table3=table3(), table4 = table4(), subcaption = reportSubCaption())
            }else if(input$stat == "anova"){
              if(input$pairedData == "one"){
                param <- list(table1 = table1(), table2 = table2(), table3=table3(), table4 = table4(), table5 = table5(),
                              figure1 = figure1(), figure2 = figure2(), figure3 = figure3(),
                              anovaType = input$pairedData, statment1 = statment1(), statment2 = statment2(),
                              subcaption = reportSubCaption()
                )
              }else if(input$pairedData == "two"){
                param <- list(table1 = table1(), table2 = table2(), table3=table3(), table4 = table4(), table5 = table5(),
                              figure1 = figure1(), figure2 = figure2(), figure3 = figure3(),
                              anovaType = input$pairedData, model = input$anovaModel, 
                              statment1 = statment1(), statment2 = statment2(), subcaption = reportSubCaption()
                )
              }
              
            }else if(input$stat == "kruskal-wallis"){
              param <- list(table1 = table1(), table2 = table2(), table3=table3(), table4 = table4(), table5 = table5(), subcaption = reportSubCaption())
            }
            
            dlFormat <- tolower(req(input$statSumDownFormat))
            
            #File to temporary directory
            if(input$stat == "t.test"){
              if(dlFormat == "pdf"){
                tempReport <- file.path(tempdir(), "plotS_report_t_pdf.Rmd")
                file.copy("www/plotS_report_t_pdf.Rmd", tempReport, overwrite = TRUE)
              }else if(dlFormat == "docx"){
                tempReport <- file.path(tempdir(), "plotS_report_t_docx.Rmd")
                file.copy("www/plotS_report_t_docx.Rmd", tempReport, overwrite = TRUE)
              }
            }else if(input$stat == "anova"){
              if(dlFormat == "pdf"){
                tempReport <- file.path(tempdir(), "plotS_report_anova_pdf.Rmd")
                file.copy("www/plotS_report_anova_pdf.Rmd", tempReport, overwrite = TRUE)
              }else if(dlFormat == "docx"){
                tempReport <- file.path(tempdir(), "plotS_report_anova_docx.Rmd")
                file.copy("www/plotS_report_anova_docx.Rmd", tempReport, overwrite = TRUE)
              }
            }else if(input$stat == "kruskal-wallis"){
              if(dlFormat == "pdf"){
                tempReport <- file.path(tempdir(), "plotS_report_kruskal_pdf.Rmd")
                file.copy("www/plotS_report_kruskal_pdf.Rmd", tempReport, overwrite = TRUE)
              }else if(dlFormat == "docx"){
                tempReport <- file.path(tempdir(), "plotS_report_kruskal_docx.Rmd")
                file.copy("www/plotS_report_kruskal_docx.Rmd", tempReport, overwrite = TRUE)
              }
            }else if(input$stat == "wilcoxon.test"){
              if(dlFormat == "pdf"){
                tempReport <- file.path(tempdir(), "plotS_report_wilcox_pdf.Rmd")
                file.copy("www/plotS_report_wilcox_pdf.Rmd", tempReport, overwrite = TRUE)
              }else if(dlFormat == "docx"){
                tempReport <- file.path(tempdir(), "plotS_report_wilcox_docx.Rmd")
                file.copy("www/plotS_report_wilcox_docx.Rmd", tempReport, overwrite = TRUE)
              }
            }
            
            # Knit the document, passing in the `params` list, and eval it in a
            # child of the global environment
            rmarkdown::render(tempReport, output_file = file,
                              params = param,
                              envir = new.env(parent = globalenv()))
          }
          
        }
       
      }#end of content
    )#end of download handler
    
  })
  
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