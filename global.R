
options(shiny.maxRequestSize = 50*1024^2) # too large: use 50
#library--------------------------------
#can't use this method for loading library: shinyapps.io
# libraries <- c("flextable", "openxlsx", "svglite",
#                "MASS", "skimr", "coin", "DT", "data.table", 
#                "readxl", "markdown", "shinydashboard","ggpubr","multcompView",
#                "rstatix", "shiny", "tidyverse", "reactable")
# lapply(libraries, library, character.only = TRUE)
# 
library(ggpp)
library(ggforce)
library(shinyBS)
library(memoise)
library(effectsize)
library(vroom)
library(car)
library(glue)
library(flextable)
library(openxlsx)
library(svglite)
library(MASS)
library(skimr)
library(coin)
library(DT)
library(data.table)
library(readxl)
library(markdown)
library(shinydashboard)
require(ggpubr)
require(multcompView)
library(rstatix)
library(shiny)
library(tidyverse)
library(reactable)
library(shinyWidgets)
#May use later
# library(GenomicRanges)
# library(bslib)
# library(shinyWidgets) #useful
# library(shinyjs)
# library(shinyFeedback)
# library(shinyvalidate)
# library(shinyauthr)

#Objects necessary to create---------------
#example dataset
long_df <- PlantGrowth
wide_df <- structure(list(ctrl = c(4.17, 5.58, 5.18, 6.11, 4.5, 4.61, 5.17,4.53, 5.33, 5.14), 
                          trt1 = c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83,6.03, 4.89, 4.32, 4.69), 
                          trt2 = c(6.31, 5.12, 5.54, 5.5, 5.37,5.29, 4.92, 6.15, 5.8, 5.26)), 
                     row.names = c(NA, -10L), class = c("data.frame"))
replicate_df <- structure(list(...1 = c("variable", "ob1", "ob2", "ob3", "ob4", "ob5", "ob6", "ob7"), 
                               control = c("R1","23", "41", "24", "5", "23", "56", "23"), 
                               ...3 = c("R2","23", "54", "65", "32", "57", "73", "42"), 
                               treatment = c("R1", "2", "3", "4", "67", "2", "45", "24"), 
                               ...5 = c("R2", "1", "4", "6", "32", "1", "35", "23")), class = c("data.frame"), row.names = c(NA, -7L))

#list of graph
planPlotList <- c("none", "box plot","bar plot", "histogram", "scatter plot",
                  "density plot", "heatmap", "line", "frequency polygon",
                  "violin","jitter","area", "pie chart", "venn", "upset", "tile")
plotList <- c("box plot","violin plot", "density", "frequency polygon", "histogram","line", "scatter plot", "bar plot")
#list of graph allow for inset
insetList <- c( "box plot","violin plot", "line", "scatter plot", "bar plot")

#plot that require x and y-axis
xyRequire <- c(  "box plot", "bar plot", "line", "scatter plot", "violin plot") 
NS_methods <- list(Normalization= c("log2", "log10", "square-root", "box-cox"), Standardization = c("scale","") )

#statistical method----------
statMethods <- list(Parametric = c("t.test", "anova"), `Non-parametric`=c("wilcoxon.test","kruskal-wallis"))
statList <- c("t.test", "anova", "wilcoxon.test","kruskal-wallis")

#stat object
aovClt <- NULL #anova compact leter
aovMeanLabPos <- NULL #anova mean and label position
aovMeanLabPos1 <- NULL
aovMeanLabPos2 <- NULL
meanLabPos_a <- NULL
meanLabPos_a2 <- NULL
newPlt <- NULL #plot collector used inside function
reshapedDone <- NULL #used in table caption for reshaped
barData <- NULL # bar data for stat summary: may not have implemented
sdError <- NULL
#function for notification-------------
waitNotify <- function(msg = "Computing... Please wait..", id = NULL, type = "message"){
  showNotification(msg, id = id, duration = NULL, closeButton = FALSE, type = type)
}
#function for inset text label and color-------
#reactive objects for inset
insetXTextLabels <- reactiveVal(NULL)
insetColor <- reactiveVal(NULL)

"
  arguments:
  inDf = data frame. data for inset
  oriDf = data frame. original data 
  orix = character. original variable of x axis
  oriTextLabel =  character. vector of variable names for labeling x-axis (original graph)
  finalPlt = ggplot object. to get the color use in the graph
  color = character. variable for which to apply color
  shapeLine = character. to apply shape or line or none
  shape = character. variable for shape. default null
  line = character. variable for line. default null
  
  Note: the function will return empty value. necessary output will be saved in the reactive objects
"

insetParamFunc <- function(inDf, oriDf, orix, oriTextLabel, finalPlt, color = "none", shape=NULL, line=NULL){
  # for name: depend only only on x-axis
  #get original variables of x-axis from the original data
  xVarName <- unique(as.data.frame(oriDf)[,orix]) %>% as.vector() %>% sort()
  #get variable name of the inset
  insetXVarName <- unique(as.data.frame(inDf)[,orix]) %>% as.vector() %>% sort()
  #filter only the variables  present in inset data and saved as reactive object
  insetXTextLabels( oriTextLabel[which(xVarName %in% insetXVarName)] )
  
  
  #for color: depend on aesthetic
  if(color != "none"){# && (is.null(shape) && is.null(line))){
    #get original variables of x-axis from the original data
    xVarName <- unique(as.data.frame(oriDf)[,color]) %>% as.vector() %>% sort()
    #get variable name of the inset
    insetXVarName <- unique(as.data.frame(inDf)[,color]) %>% as.vector() %>% sort()
  }else if(color == "none" && !is.null(shape)){
    #get original variables of x-axis from the original data
    xVarName <- unique(as.data.frame(oriDf)[,shape]) %>% as.vector() %>% sort()
    #get variable name of the inset
    insetXVarName <- unique(as.data.frame(inDf)[,shape]) %>% as.vector() %>% sort()
    
  }else if(color == "none" && !is.null(line)){
    #get original variables of x-axis from the original data
    xVarName <- unique(as.data.frame(oriDf)[,line]) %>% as.vector() %>% sort()
    #get variable name of the inset
    insetXVarName <- unique(as.data.frame(inDf)[,line]) %>% as.vector() %>% sort() 
  }
  
  #get color from the original graph (variables of x axis)
  origColor <- unique(ggplot_build(finalPlt)$data[[1]][,1]) %>% as.vector()
  #filter only the color for the inset variables and save as reactive object
  insetColor(origColor[which(xVarName %in% insetXVarName)])
  #return empty
  return("")
}
#function to create input and update options: mainly for color options
"date: 2/3/23
arguments
update = logical. TRUE to update the selectinput and false to reset.
pltType = character. type of graph
data = data frame. 
label = character.
newId = character. ID for the selectinput
firchoice = character. 'none' as default first choice
choice = list of character. 
selecteds = character. must be present in the choice list"
selectInputParam <- function(update= TRUE, pltType = "none",
                       data, label = "Add color", newId = "colorSet", 
                       firstChoice = "none", choice = "", selecteds = "none",...){
  if(!isTRUE(update)){
    if(!is.data.frame(data) || (is.data.frame(data) && pltType == "none")){
      selectInput(inputId = newId, label = label, choices = list("none"))
    }else{#} if(is.data.frame(data)){
      selectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
    }
  }else if(isTRUE(update)){
    if(!is.data.frame(data) ||  (is.data.frame(data) && pltType == "none")){
      updateSelectInput(inputId = newId, label = label, choices = list("none"))
    }else{#} if(is.data.frame(data)){
      message("-===========updating selectInput================")
      updateSelectInput(inputId = newId, label = label, choices = c(firstChoice, choice), selected = selecteds)
    }
    
  }
}

#remove the below later: when color option is being optimized
displayAes <- function(update= "no", transform = TRUE, action = FALSE, pltType = "pltType()",#!isTruthy(input$goAction)
                       data, label = "Variable to fill color", newId = "colorSet", firstChoice = "none", choice = colnames(ptable()), selecteds = "none",...){
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

#function to get all variables: numeric and characters----------------------------------
#get all numeric or character variables
"
Function to determine the names of either numeric or character variables present in the data
checks = character. 'integer' as default for numeric variable.
data = dataframe.
"
#if data.table (fread), it will be integer, instead of numeric
allNumCharVar <- function(checks = "integer", data = "ptable()"){
  
  #get the data types of the column in the data frame
  varClass <- sapply(data, class)
  #filter the df based on the provided data type
  if(checks %in% c("integer", "numeric", "double")){
    var <- data[ varClass %in% c("integer", "numeric", "double") ]
  }else{
    var <- data[varClass %in% c("character", "factor")]
  }
  
  colnames(var)
}
#variable selector function for in selectInput--------------------
#selection for first variable
selectedVar <- function(data = "ptable()", check = "character"){
  var <- allNumCharVar(checks = check, data = data)
  #select the first column
  var[1]
}
#for second variable: use in y-axis and facet_grid-varColumn
"
function to choose variables name from the table
data = dataframe. data to apply
check = character. accept either 'character' or 'factor' or 'numeric'
index = numeric. from 1 to 2. Index of the vectors of variables of the data.
"
selectedVar2 <- function(data = "ptable()", check = "character", index = 1){ #index must not be greater than 2
  var <- allNumCharVar(checks = check, data = data) #return column names only, not data column
  if( tolower(check) %in% c("character", "factor") ){
    #choose the column different from x-axis
    ifelse(length(var) >= 2, var[2], var[1])
  }else if( tolower(check) %in% c("numeric", "integer") ){
    #generally require double for y axis
    ifelse(length(var) >= 2, var[index], var[1])
  }
}

#function for filtering data----------------
"function for filtering the data
date: 30/01/23
arguments:
  df = data frame.
  col = character. Column name to apply the filter
  filterType = character. Type of filter to apply - 'contain', 'equal', 'greater than', etc
  val = character. apply filterType on this given value
"

filterData <- function(df, col, filterType, val){
  # User's input for filterType is -
  #   case 1. case sensitive
  #         i. Character variable -  contain or not contain : each value must be comma separated and bound by double quotes if comma needs to be included
  #         ii. Character variable - equal or not equal : option will be in vector, so apply filter directly.
  #   case 2. Numeric variable - 
  #         i. not between - must be of length 1 and must be able to convert to numeric
  #         ii. between - must be able to convert to numeric and must be colon separated. E.g., 1:10 or 20:40
  # browser()
  # message(filterType)
  #dummy data frame 
  filtr_df <- NULL
  #detect error: not in use
  erorDetected <- 0
  
  if(filterType %in% c("contain", "not contain")){
    
    #case 1. i.
    inputVal <- str_split(val, ',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)') %>% unlist()
    
    if(filterType == "contain"){
      filtr_df <- df[ str_detect(df[,col], inputVal, negate = FALSE), , drop = FALSE]
    }else if(filterType == "not contain"){
      filtr_df <- df[ str_detect(df[,col], inputVal, negate = TRUE), , drop=FALSE]
      #Stop if no data is left
      validate(
        need(nrow(filtr_df) >= 1, "Zero rows. Require at least 1 row")
      )
    }
    
    #end of contain
  }else if(filterType %in% c("equal to", "not equal to")){
    #case 1. ii.
    inputVal <- str_split(val, ',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)') %>% unlist()
    if(filterType == "equal to"){
      filtr_df <- df %>% filter( .data[[col]] %in% inputVal )
    }else{
      filtr_df <- df %>% filter( !.data[[col]] %in% inputVal )
    }
    #end of equal to ...
    
    #End of case 1: character variable
  }else{
    #start case 2: numeric variable
    if(filterType != "between"){
      #case 2. i.
      
      #input must be able to convert to numeric
      validate({
        erorDetected <- 1
        #convert to numeric
        need(numValue <- as.numeric(val), "Error: cannot convert to numeric! provide one numeric value")
      })
      if(filterType == "not equal"){
        filtr_df <- df %>% filter( .data[[col]] != numValue)
      }else if(filterType == "equal"){
        filtr_df <- df %>% filter( .data[[col]] == numValue)
      }else if(filterType == "equal to or greater"){
        filtr_df <- df %>% filter( .data[[col]] >= numValue)
      }else if(filterType == "equal to or less"){
        filtr_df <- df %>% filter( .data[[col]] <= numValue)
      }else if(filterType == "greater than"){
        filtr_df <- df %>% filter( .data[[col]] > numValue)
      }else if(filterType == "less than"){
        filtr_df <- df %>% filter( .data[[col]] < numValue)
      }
      
    }else if(filterType == "between"){
      validate({
        erorDetected <- 1
        need(numRange <- eval(str2expression(val)), "Error: cannot convert to numeric!")
      })
      filtr_df <- df %>% filter( .data[[col]] >= min(numRange), .data[[col]] <= max(numRange))
    }
  }
  
  if(is.null(filtr_df)){
    #for no data found for the filter: provide null data and proper column
    filtr_df <- as.data.frame(matrix(nrow = 1, ncol = ncol(df)))
    names(filtr_df) <- colnames(df)
  }
  #for factor variable, filter data has issue while performing t_test
  # so, convert to character
  #check class
  cl <- lapply(filtr_df, class) %>% unlist()
  if(any(cl == "factor")){
    indx <- which(cl == "factor")
    filtr_df[,indx] <- as.character(filtr_df[,indx]) 
  }
  
  return(filtr_df)
}
#function for downloading figure-------------------
"arguments:
fig = object. output plot object.
filename = character. output file path.
format = character. output format.
"
figureDowFunc <- function(fig, filename, format){
  # browser()
  if(format == "pdf"){
    pdf(file = filename, width = 7, height = 7)
    print(fig)
    dev.off()
  }else if(format == "png"){
    png(filename, width = 4, height = 4, units = "in", res = 300)
    print(fig)
    dev.off()
  }else if(format == "tiff"){
    tiff(filename, width = 4, height = 4, units = "in", res = 300)
    print(fig)
    dev.off()
  }else if(format == "bmp"){
    bmp(filename, width = 4, height = 4, units = "in", res = 300)
    print(fig)
    dev.off()
  }
}
#function for descriptive statistics----------------
#alert message for error, if require
stopAll <- reactiveVal(0)
"
arguments:
df = data frame.
xA = character. Variables selected for group by. It can be single or vector of character.
yA = character. variables selected for y-axis. It is numeric variables in the data.
Output will be dataframe.
"
descriptiveStatFunc <- function(df, xA, yA){
  #unique variables present in x-axis
  uqVarLen <- df %>% distinct(!!!rlang::syms(xA)) %>% nrow()
  
  #check whether sd and se can be determine or not
  # case 1: cannot determine sd and se - unbalanced data and some variables have only one data point
  # case 2: can determine sd and se - variables have more than one data point.
  ct <-  df %>% count(!!!rlang::syms(xA)) #count of each variable data point
  if(uqVarLen == nrow(df) || any(ct$n == 1)){
    #case 1:
    #SD and SE cannot be determine
    ds_df <- df %>% group_by(!!!rlang::syms(xA)) %>% summarise(
      #count
      count = n(),
      #min, Q1, mean, median, Q3, max, sd
      min = min(.data[[yA]]), Q1 = quantile(.data[[yA]], probs = 0.25), mean = round(mean(.data[[yA]]),3), median = median(.data[[yA]]), 
      Q3 = quantile(.data[[yA]], probs = 0.75), max = max(.data[[yA]])
    )
  }else if(uqVarLen != nrow(df) && all(ct$n > 1)){
    #include se
    ds_df <- df %>% group_by(!!!rlang::syms(xA)) %>% summarise(
      #count
      count = n(),
      #min, Q1, mean, median, Q3, max
      min = min(.data[[yA]]), Q1 = quantile(.data[[yA]], probs = 0.25), mean = round(mean(.data[[yA]]), 3), median = median(.data[[yA]]), 
      Q3 = quantile(.data[[yA]], probs = 0.75), max = max(.data[[yA]]), IQR = IQR(.data[[yA]]),
      #sd
      standard_deviation = round(sd(.data[[yA]]),3)
    ) %>% mutate(standard_error = round(standard_deviation/sqrt(count),3)) 
    
  }else{
    stopAll(1)
    ds_df <- data.frame(NULL)
    # "stop proceeding all the program! Important!!!!!!!!!!!!!!!"
  }
  
  return(ds_df)
}
#function for normalization and standardization of data------------------
"
function for normalization and standardization
arguments:
data = data frame.
ns_method = character. method of transformation
x = character. variable of x-axis. Require only for box-cox. 
y = chharacter. variable of y-axis.
"
ns_func <- function(data, ns_method, x=NULL, y){
  #remove na: this was supposed to have been taken care in the beginning, if not ,removed it 
  data <- na.omit(data)
  #if data has 0 than add +1
  if(any(data[, y] == 0)){
    data[, y] <- data[y]+1
  }
  
  
  if(ns_method == "log2"){ 
  
    new_df <- data %>% mutate( log2 = log2(.data[[y]]) )
    
  }else if(ns_method == "log10"){
  
    new_df <- data %>% mutate( log10 = log10(.data[[y]]) ) #log10(y)
    
  }else if(ns_method == "square-root"){
  
    new_df <- data %>% mutate( sqrt = sqrt(.data[[y]]) )#sqrt(y)
    
  }else if(ns_method == "box-cox"){
    #determine model
    bc <- with(data, car::boxCox(eval(parse(text = y)) ~ eval(parse(text = x)), plotit = FALSE))
  
    #optimal lambda value
    opt_lba <- bc$x[which.max(bc$y)]
    message("transformed")
    #transform
    new_df <- data %>% mutate( box_cox = ((.data[[y]]^opt_lba-1)/opt_lba) )
    
  }else{
    
    #scale
    new_df <- data %>% mutate( scale = scale(.data[[y]]) )#scale(y)
    
  }
  
  #rename the column
  new_df[, y] <- new_df[, ncol(new_df)]
  new_df <- new_df[, -ncol(new_df)] #remove the duplicate transform column
  return(new_df)
}
#standard deviation-------------------
"function to compute standard deviation (sd), standard error (se) and confidence interval (ci)
            arguments:
            x = a data frame
            oName = character or vector of characters to be used in group_by(). If single character, variable names of x-axis, 
                    else vector of variable names of x-axis and variable of aesthetic
            yName = character. variable names of y-axis to be used in summarise.
            lineGrp = character. variable use to connect line path.
                    null for scatter plot. It will be use in gorup_by if value is other than 'none' or null
            "
sdFunc <- function(x, oName, yName, lineGrp = NULL){
  
  #convert the x-axis and other aesthetic to factor
  message("entering factro3")
  nDf <- x %>% mutate(across(c(!!!rlang::syms( oName )), factor))
  message("factor done2")
  #computed sd
  if(lineGrp != "none" || is.null(lineGrp)){
    
    if( lineGrp %in% oName || is.null(lineGrp) ){
      nDf <- nDf %>% group_by( !!!rlang::syms( oName ) ) %>% 
        #calculate sd, mean and count
        summarise(sd = sd(.data[[yName]], na.rm = TRUE), newCol = mean(.data[[yName]], na.rm=TRUE), count = n())%>%
        #compute se
        mutate(se = sd/sqrt(count)) %>%
        #ci at 95% confidence level
        mutate(ci = se * qt(0.975, count-1))
    }else{
      nDf <- nDf %>% group_by( !!!rlang::syms( oName ), .data[[lineGrp]] ) %>% 
        summarise(sd = sd(.data[[yName]], na.rm = TRUE), newCol = mean(.data[[yName]], na.rm=TRUE), count=n()) %>%
        #compute se
        mutate(se = sd/sqrt(count)) %>%
        #ci at 95% confidence level
        mutate(ci = se * qt(0.975, count-1))
    }
    
    
  }else if( lineGrp == "none" ){
    
    nDf <- nDf %>% group_by( !!!rlang::syms( oName ) ) %>% 
      summarise(sd = sd(.data[[yName]], na.rm = TRUE), newCol = mean(.data[[yName]], na.rm=TRUE), count=n()) %>%
      #compute se
      mutate(se = sd/sqrt(count)) %>%
      #ci at 95% confidence level
      mutate(ci = se * qt(0.975, count-1))
  }
  
  #If sd cannot be calculated, display message that sd cannot be calculated for the data
  if(is.na(nDf$sd) || is.na(nDf$se) || is.na(nDf$ci)){
    sdError <<- 1
  }else{
    sdError <<- 0
  }
  
  #rename the column
  names(nDf)[ncol(nDf)-3]<- yName #same name as y-axis
  message(glue::glue("ndf heres: colnames(nDf)"))
  return(nDf)
}

#replicate related function--------------------
"
Function to re-arrange replicates of each group/variable provided by the user.
It will processed the replicates only for one group at a time, not multiple groups.

arguments:
x = dataframe. data with both non-replicate and replicate column i.e. whole data.
y = dataframe. data with only non-replicate column. 
colName = character. Column name. To be used for the  tidied data
headerNo = numeric. row index of header used in the table. numeric sequence.
colNo = numeric. column index for the replicates of each group. It can be vector or range
stp = numeric. range from 0 to 1. 0 to process and 1 to stop processing 
      non-replicate columns
"

tidyReplicate <- function(x, y, headerNo = 1:2, colName= "column_name", colNo = c(2,3), stp=0){
  #First process the data for non replicate column and then for replicate column
  #non-replicate column: May not always be in character column when in proper format
  # later some column may have to be converted to numeric
  # and tidied data will be appended to this data
  
  
  #check for addition of header by R: V1, V2, .....Vn
  # removed the header if present. R will add header only if need (not always)
  if(all( str_detect(x[1,], regex("^V[:digit:]")) )){
    x <- x[-1, ]
    y <- y[-1, ] 
  }
  
  if(stp == 0){
    
    #get column name from the header 
    if(!is_empty(y)){
      
      #get the header
      headr <- y[headerNo, ,drop=FALSE] %>% as.data.frame()
      #removed the header
      y_headRe <- y[-headerNo, ,drop=FALSE] %>% as.data.frame()
      
      message("if statment")
      #arrange proper header name for the non-replicate columns
      if(all(is.na(headr))){
        message("inside if")
        #if all is na i.e. no header name in the table,
        # generate new column name
        col_n <- ncol(y_headRe)
        
        colnames(y_headRe) <- paste0("variable",1:col_n)
        
      }else{
        message("header present")
        #if header is included in the table, use the name and re-format in proper order
        #run for loop for each columns and check na
        getName <- as.character() #column name collector
        
        for(i in seq_along(headr)){
          
          if(length(headerNo) == 1){
            #one header
            if(is.na(headr[,i])){
              #give new name
              getName[i] <- paste0("Var",i)
            }else{
              getName[i] <- headr[,i]
            }
            
          }else{
            
            #multiple header
            if( all(is.na(headr[,i])) ){
              getName[i] <- paste0("Var",i)
            }else if( any(is.na(headr[,i])) ){
              
              #check whether there is any row with name for all the columns
              # if so, use that row as column  name
              noNaRow <- as.character()
              for(i in headerNo){
                if(all(!is.na(headr[i,]))){
                  
                  #check for one more condition: skip row that starts with ..number in more 
                  # than one column (this are default header added while uploading data)
                  if( any( isTRUE(str_detect(headr[i,], regex("^\\.+[:digit:]"))) ) ){
                    next
                  }else{
                    noNaRow <- headr[i,]
                  }
                  message("noNaRow")
                }
              }
              
              if(!is_empty(noNaRow)){
                
                getName <- noNaRow
              }else{
                #remove na and get the first element
                vec <- headr[,i]
                naRemovedHdr <- vec[!is.na(vec)]
                getName[i] <- naRemovedHdr[1]
              }
              
            }else{
              #no na;  
              # check for condition
              #   skip row that starts with ..number  
              #   than one column (this are default header added while uploading data)
              for(n in headerNo){
                if(any( isTRUE(str_detect(headr[n,i], regex("^\\.+[:digit:]"))) ) ){
                  next
                }else{
                  #get the first name
                  getName[i] <- headr[n,i] 
                  break #get out of the nested loop
                }
              }
              
            }
          }
          
        }#end of for loop
        
        colnames(y_headRe) <- getName
        
      }
      
      #check wether data needs to be converted back to numeric as it should be in the original data provided
      # by the user
      for(i in seq_len(ncol(y_headRe))){
        if( any( !str_detect( y_headRe[,i],regex('[:alpha:]')) ) ){
          y_headRe[,i] <- as.numeric(y_headRe[, i])
          
        }#end of if digit detected
      }#end of for loop
    }
  }#end of stp==0
  
  
  #process the replicates
  #replicate data: for now, every elements in the data are in character
  # it will execute irrespective of stp
  
  #select only the specified columns
  x2 <- x[, colNo, drop = FALSE] 
  #remove the header 
  message(headerNo)
  message(head(x2))
  message(str(x2))
  x2 <- x2[-c(headerNo),] %>% as.data.frame() 
  
  message("replicate selection")
  # convert to numeric
  onlyNumeric <- x2 %>% as.data.frame() %>% mutate_if(is.character, as.numeric)  #%>% as_tibble()
  #validate whether the replicate data is in numeric, if not, than the column
  # cannot be used as replicates. It is a categorical variable(s).
  message(str(onlyNumeric)) 
  validate(
    need(
        #must not contain any alphabets in the column: added here just to avoid repeated writing (not recommended)
        all( unlist( lapply(x2, function(x) !str_detect(x, regex("[:alpha:]"))) ) ) &&
        #must have been converted to numeric
        all( unlist( lapply(onlyNumeric, is.numeric) ) ), "Specified replicate column(s) must be numeric!"
        )
  )
  
  message("converted to numeric")
  #generate and add column names
  nn <- ncol(onlyNumeric)
  colnames(onlyNumeric) <- paste0("Replicate_",1:nn)
  message("merge")
  #merge the noNumeric (character column) and onlyNumeric (replicate column)
  if(!is_empty(y) && stp == 0){
    newDf <- cbind(y_headRe, onlyNumeric) %>% as.data.frame()
  }else{
    newDf <- onlyNumeric %>% as.data.frame() 
  }
  
  message("merge done3")
  message(str(newDf))
  
  #Reshape the data: keep replicate row-wise i.e. longer format (pivot_longer())
  newDf2 <- pivot_longer(newDf, cols = colnames(onlyNumeric), names_to = "replicates", values_to = colName)
  message("reshape done inside replicate func")
  rownames(newDf2) <- NULL
  
  return(newDf2)
  
}


#function to determine mean or median from replicates
"
arguments:
x = Single character. Column names to get the mean or median.
df = data frame. Data frame that has all the columns that need to be process.
stat = character. Specify 'mean' or 'median'.
grp = character. Specify column name to use for grouping to determine mean or median.
varNum = numeric. Number of rows [confuse! 1st version: number of variables]
repNum = numeric. Number of replicates for each variables.
return one column data frame
"
getMeanMedian <- function(x, df, stat='none', grp = NULL, varNum = NULL, repNum = NULL){
  
  #get the columns for which mean and median are to be determine
  df2 <- df[, c(x), drop = FALSE]
  final <- NULL
  
  if(is.null(grp)){
    #user provide no column to group by
    message(varNum)
    #add unique id to each sample to be used in group by
    df2$newId <- rep(1:varNum, each = repNum)
    message(df2)
    message(str(df2))
    #group by based on the ID
    if(stat == "mean"){
      gb_df <- df2 %>% group_by(newId) %>% summarise(mean= mean(.data[[x]])) %>% as.data.frame() 
      
      #proper name to calculated stat
      gb_df[, paste0(x,"_mean")] <- gb_df$mean
      final <- gb_df[, paste0(x,"_mean"), drop=FALSE]
    }else if(stat == "median"){
      gb_df <- df2 %>% group_by(newId) %>% summarise(mean= median(.data[[x]])) %>% as.data.frame()
      #proper name for calculated stat
      gb_df[, paste0(x,"_median")] <- gb_df$mean
      final <- gb_df[, paste0(x,"_median"), drop=FALSE]
    }
    
  }else if(!is.null(grp)){
    #user provide column to group by
    
    #group by based on the specified column
    if(stat == "mean"){
      gb_df <- df %>% group_by( !!!rlang::syms(grp) ) %>% summarise(mean= mean(.data[[x]])) %>% as.data.frame() 
      #proper name for calculated stat
      gb_df[, paste0(x,"_mean")] <- gb_df$mean
      final <- gb_df[, paste0(x,"_mean"), drop=FALSE]
    }else if(stat == "median"){
      gb_df <- df %>% group_by( !!!rlang::syms(grp) ) %>% summarise(mean= median(.data[[x]])) %>% as.data.frame()
      #proper name for calculated stat
      gb_df[, paste0(x,"_median")] <- gb_df$mean
      final <- gb_df[, paste0(x,"_median"), drop=FALSE]
    }
    
  }
  
  
  return(final)
}


"Function to add or delete variable for comparison in t_test and wilcoxon.test
  arguments for the function
  lst = list of characters provided by the user to compare or reference.
  grp = character. it is the group(s) choosen by the user. Length must be of 1 for reference group or 2 for comparisons
  act = character. Users choice to add or delete. Action button for add and delete will be provided to the user.
  "
grpAddDel <- function(lst = "list()", grp = "givenGrp: the lists", act = "addOrDelete"){
  index <- length(lst)
  if(act == "add"){
    #add the group to the list
    if(is_empty(lst)){
      lst[1] <- list(grp)
    }else{
      #check whether the group has been added
      if(list(grp) %in% lst){
        #no need to add, if group is present
        lst
      }else if(!list(grp) %in% lst){
        #add the group if not present
        lst[index+1] <- list(grp)
      }
    }
    
  }else if(act == "delete"){
    #delete the group from the list
    lst <- lst[-index] #remove from the last index
  }
  return(lst)
}


#function to get the number of variables from the table that has replicates
"
arguments
x= data frame provided by the user
nh = numeric. number of header provided by the user
re = numeric. 1 for number of variable and table for variable [name and number]
"

getDataVariable <- function(x, nh = 1, re = 1){
  # browser()
  nh <- 1:nh #range
  #keep only the header: this will be a table
  headr_df <- x[nh,] # %>% as.data.frame()
  col_n <- ncol(headr_df) #number of column
  #transpose the df
  headr_df <- t(headr_df)
  #generate and add column name
  colnames(headr_df) <- paste0("h",nh)
  
  headr_df <- headr_df %>% as.data.frame()
  rownames(headr_df) <- NULL
  
  #dummy table, variable number and name
  getTable <- data.frame(name="empty", number=0)
  getNumber <- 0 #start from zero
  getVar <- "name"
  
  #run for loop for each header
  for(i in nh){
    h <- headr_df[i]
    len <- length(unique(h[,1]))
    var <- unique(h[,1])
    var <- var[!is.na(var)]
    
    if(any(is.na(h[,1]))){
      #if na is present, then reduce the number of 
      # variable by 1
      len <- len - 1
    }
    
    #add to the dummy table
    getTable[i,1] <- paste(var, collapse=", ")
    getTable[i,2] <- len
    
    #Lower number of variable in the header will be the 
    # actual number of variable for the data
    if(getNumber == 0){
      getNumber <- len
      getVar <- var
    }else if(getNumber > len){
      getNumber <- len
      getVar <- var
    }
  }
  
  if(re == 1){
    return(getNumber)
  }else{
    return(getTable)
  }
  
}

#function to arrange the input for formula of ANOVA: later it will be converted to expression
"argument
  x: categorical or independant variable(s).
  model: model of the anova - additive or non-additive
    If one-way anova: only 1 variable
    two-way: 2 variables"
aovInFunc <- function(x = "categoricalVar", model){
  if(length(x) < 2){
    #for one-way anova: provide the variables as it is
    x
  }else{
    #for two-way anova: pre-arrange the input variables as per the formula (additive model, no interactive effect)
    #
    var = NULL
    for(i in x){
      if(is_empty(var)){
        #var is Null
        var <- glue::glue("{i}")
      }else{
        #var is not empty
        if(model == "additive"){
          var <- paste(var,glue::glue("+{i}"))
        }else if(model == "non-additive"){
          var <- paste(var,glue::glue("*{i}"))
        }
      }
    }
    var
  }
}
#objects------------------------
#require table for summary
testTable <- reactiveValues(df=NULL) #statistic table
postHoc_table <- reactiveValues(df = NULL) #post-hoc analysis table
effectSize <- reactiveValues(df=NULL) #effect size table

#statistical computation function:
# compute error message
computeFuncError <- reactiveVal(0)
computeFuncErrorMsg <- reactiveVal(NULL)
"arguments:
  data = a data frame
  method = character. chosen statistic method
  numericVar = character. dependant variable for the statistic
  catVar = character. It can be single or vector. independant variable
  compRef = character. variable for comparing or a reference group
  pairedD = logical. whether data is paired or unpaired
  anovaType = character. type of anova: one-way (one) or two-way (two)
  ttestMethod = character. welch or student's test

"

computFunc <- function(data = "data", method = "none", numericVar = "numericVar()",
                       catVar = "catVar()", compRef = "none",
                       pairedD = "pairedData", anovaType = "anovaType()", 
                       ttestMethod = FALSE, ssType="I", 
                       model = "model", cmpGrpList = NULL, rfGrpList=NULL,
                       pAdjust = TRUE, pAdjustMethod='none'){ #switchGrpList = 0,
  
  message("entering computFunc()------------")
  message("catVar---------")
  message(catVar)
  message("for formula")
  #formula: dependent (numeric) ~ independent (factor)
  #need to use reformulate() from stats package to use in formula
  if(method == "anova"){
    indepVar <- aovInFunc(catVar, model)
    forml <- reformulate(response = glue::glue("{numericVar}"), termlabels = glue::glue("{indepVar}"))
  }else{
    message("formula-deriving")
    message(numericVar)
    forml <- reformulate(response = glue::glue("{numericVar}"), termlabels = glue::glue("{catVar}")) 
  }
  
  #get the list for comparison and reference group
  if(method %in% c("t.test", "wilcoxon.test")){
    
    message("312wreference")
    message(glue::glue("referencegr3: {compRef}"))
    ref <- if(compRef == "reference group"){
      
      if(is_empty(rfGrpList)){
        message("empty ref\\")
        NULL
      }else {
        message("reference stage++")
        rfGrpList
      }
    }else { NULL }
    
    cmp <- if(compRef == "comparison"){
      if(!is_empty(cmpGrpList)){
        message("comparing stage--")
        cmpGrpList
      }else{
        message("empty compRef;;")
        NULL
      }
    }else { NULL }
    
    message("after compRef=================")
    message(glue::glue("compRef: {cmp}, {ref}"))
  }
  #hard coded: revise
  if(method == "t.test"){
    message("forml=-=--")
    message("ttestMethod complete33")
    # browser()
    # message(str(data))
    # print(data)
    # message(forml)
    # message(ttestMethod)
    
    test <- rstatix::t_test(data, formula = forml,
           ref.group = unlist(ref), 
           comparisons = cmp, p.adjust.method = pAdjustMethod,
           paired = pairedD, var.equal = ttestMethod #welch's =FALSE, or student's test = TRUE
    )
    
    message("ttest done2 ")
    #global
    testTable$df <<- test %>% as.data.frame()
    
    return(test)
    
  }else if(method == "wilcoxon.test"){
    message("formlw=-=--")
    message('start')
    test <- rstatix::wilcox_test(data = data, formula = forml,
                ref.group = unlist(ref), #if(compRef == "none"){NULL}else{if(switchGrpList == 0) NULL else .data[[cmpGrpList]]},
                comparisons = cmp, #if(compRef == "none"){NULL}else if(compRef == "comparions"){if(switchGrpList == 0) NULL else cmpGrpList},
                paired = pairedD,
                p.adjust.method = pAdjustMethod)
    message("done------")
    #global
    testTable$df <<- test %>% as.data.frame()
    return(test)
    
  }else if(method == "anova"){
    
    #Conduct ANOVA
    #formula for one-way and two-way is prepared by aovInFunc and reformulate
    message(glue::glue("running anova--=-="))
    if(anovaType == "one"){
      anova <- aov(data=data, formula=forml)
      # anova <- car::Anova(av, type = ssType) #Default sum of square type = 2
    }else{
      anova <- aov(data=data, formula=forml)
    }
    
    anovaTable <- parameters::model_parameters(anova) %>% as.data.frame() 
    
    #rename the column. Global data
    message(glue::glue("renaming anova table------"))
    #This will be used as summary data and for further analysis
    # testTable$df <<- rename(anovaTable,"DFn" = "Df", "DFd" = "Df_residual") 
    testTable$df <<- anovaTable
    
    message(glue::glue("------catVar: {catVar}-------"))
    
    #conduct post-hoc analysis for one-way and two-way ANOVA
    #one-way anova----------------------------
    if(anovaType == "one"){
      
      message(glue::glue("post hoc test----"))
      #post-hoc test: Tukey HSD test
      tukey_df <- tukey_hsd(data, forml)
      postHoc_table$df <<- tukey_df %>% as.data.frame() #global data to show in stat summary
      message(glue::glue("post hoc test finished: "))
      
      #process further to get multcompletter
      new_tk <- tukey_df %>% mutate(name= paste(tukey_df$group1, tukey_df$group2, sep = "-"))
      message(glue::glue("multcompletter finished-----==="))
      
      #Determine the mean and position for labeling
      meanLabPos <- data %>% group_by(!!!rlang::syms(catVar)) %>% 
        summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE))
      
      #add mean to the new_tk and sort it based on the mean: #####not for aov this is require so that letter is in the order of mean (ascending)
      new_tk_join <- left_join(new_tk, meanLabPos, by = c("group1" = unlist(catVar))) #%>% arrange(mean)
      pval <- new_tk_join$p.adj
      names(pval) <- new_tk_join$name
      
      #get multcompletter
      mcl <- multcompLetters(pval)
      mcl2 <- as.data.frame.list(mcl)
      
      #convert rowName to variable 
      col <- unlist(catVar)
      mcl2[col] <- rownames(mcl2)
      
      #left_join with the computed data for mean and labeling positions
      meanLabPos <- left_join(meanLabPos, mcl2, by = c(col))
      geomTextLabel <- meanLabPos %>% as.data.frame()#use in geom_text
      return(geomTextLabel)
      
    }else if(anovaType == "two"){
      
      #two anova here----------------------------
      #post-hoc analysis
      if(model == "non-additive"){
        
        #non-additive----------
        message("entering non-aditive2))))))")
        #using base aov
        av <- aov(data=data, formula=forml) 
        
        #compare the mean: using base TukeyHSD()
        tukey_df <- TukeyHSD(av) 
        #get compact letter
        # check for error: any error in name arguments will occur here (Estimated effects may be unbalanced)
        tryCatch({
          clt <- multcompLetters4(av, tukey_df)
          computeFuncError(0)
        }, error= function(e){ 
          computeFuncError(1)
          computeFuncErrorMsg(e)
          validate(
            need(isolate(computeFuncError()) == 0, glue::glue(e))
          )
          
        })
        
        #Determine the mean and position for labeling: interaction, group1 and group2
        #interaction
        meanLabPos <- data %>% group_by(!!!rlang::syms(catVar)) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar), everything())
        
        #group1
        meanLabPos1 <- data %>% group_by(!!!rlang::syms(catVar[1])) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar[1]), everything())
        
        #group2
        meanLabPos2 <- data %>% group_by(!!!rlang::syms(catVar[2])) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar[2]), everything())
         
        
        #global save for additive figure for different groups
        # aovFigure_1_2 <<- av #anova
        postHoc_table$df <<- tukey_df#gloabal: save and display as summary
        aovMeanLabPos <<- meanLabPos #mean table
        aovClt <<- clt #compact letter
        
        #get the compact letter 
        clt_n1 <- as.data.frame.list(clt[[1]]) #group1
        clt_n1$lab <- rownames(clt_n1)
        clt_n2 <- as.data.frame.list(clt[[2]]) #group2
        clt_n2$lab <- rownames(clt_n2)
        clt_n3 <- as.data.frame.list(clt[[3]]) #interaction
        clt_n3$lab <- rownames(clt_n3)
        
        message("unlist")
        #add compact letter to the mean table
        #group1
        x <- catVar[1]
        colJ1 <- "lab"
        names(colJ1) <- x
        
        meanLabPos_a <- left_join(meanLabPos1, clt_n1, by=colJ1) %>% select(1:5)
        meanLabPos_a <<- dplyr::rename(meanLabPos_a, tk1=Letters)
        
        #group2
        x <- unlist(catVar[2])
        colJ2 <- "lab"
        names(colJ2) <- x
        meanLabPos_a2 <- left_join(meanLabPos2, clt_n2, by = colJ2) %>% select(1:5)
        meanLabPos_a2 <<- dplyr::rename(meanLabPos_a2, tk2=Letters)
        
        message("non- group2 complete")
        
        #interaction
        meanLabPos_i <- meanLabPos
        meanLabPos_i$tkint <- clt_n3$Letters
        geomTextLabel <- meanLabPos_i %>% as.data.frame()
        
        return(geomTextLabel)
        
      }else if(model == "additive"){
        #additive model---------------------
        message("enter aditive))))))")
        #using base aov
        av <- aov(data=data, formula=forml) 
        
        #Determine the mean and position for labeling
        #group1
        
        meanLabPos1 <- data %>% group_by(!!!rlang::syms(catVar[1])) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar[1]), everything())
        
        #group2
        meanLabPos2 <- data %>% group_by(!!!rlang::syms(catVar[2])) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar[2]), everything())
        
        
        #compare the mean: using base TukeyHSD()
        tukey_df <- TukeyHSD(av) #gloabal: save and display as summary
        
        #get compact letter
        clt <- multcompLetters4(av, tukey_df)
        
        #global save for additive figure for different groups
        # aovFigure_1_2 <<- av #anova
        postHoc_table$df <<- tukey_df #tukey test
        aovMeanLabPos1 <<- meanLabPos1 #mean table
        aovMeanLabPos2 <<- meanLabPos2
        aovClt <<- clt #compact letter
        
        #get all the required data for anova figure: interaction, group1, group2
        #add compact letter to the mean table
        clt_n1 <- as.data.frame.list(clt[[1]]) #group1
        clt_n1$lab <- rownames(clt_n1)
        clt_n2 <- as.data.frame.list(clt[[2]]) #group2
        clt_n2$lab <- rownames(clt_n2)
        
        message("unlist")
        #group1: to be used in join
        x <- catVar[1]
        colJ1 <- "lab"
        names(colJ1) <- x
        meanLabPos_a <- left_join(meanLabPos1, clt_n1, by=colJ1) %>% select(1:4)
        meanLabPos_a <<- dplyr::rename(meanLabPos_a, tk1=Letters)
        
        #group2: to be used in join
        x <- catVar[2]
        colJ2 <- "lab"
        names(colJ2) <- x
        meanLabPos_a2 <- left_join(meanLabPos2, clt_n2, by = colJ2) %>% select(1:4)
        meanLabPos_a2 <<- dplyr::rename(meanLabPos_a2, tk2=Letters)
        
        #two table will be generated
        # This can be confusing:
        # different tables will be used based on user's input for figure
        # tables will be directly access from global, not from the return object of this
        # function. This will save additional computation.
        meanLabPos_a #group1
        meanLabPos_a2 #group2
      }
      
    }
    
    
  }else if (method == "kruskal-wallis"){
    
    #Kruskal test------------------
    message("Kruskal test on2")
    allMean <- data %>% group_by(!!!rlang::syms(catVar)) %>% 
      summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) 
    #do the test
    kstat <- rstatix::kruskal_test(data=data, formula = forml)
    message("entering post hoc kruskal")
    #post hoc test
    #global
    
    posthoc <- dunn_test(data=data, formula = forml, p.adjust.method = pAdjustMethod, detailed=FALSE)
    #get compact letter
    if(isTRUE(pAdjust)){
      pval <- posthoc$p.adj
    }else{
      pval <- posthoc$p
    }
    
    #global
    testTable$df <<- kstat %>% as.data.frame()
    postHoc_table$df <<- posthoc %>% as.data.frame()
    
    message("kruskal post hooooooooooooooooooooooooooooooooooooooooooooooccc")
    #get compLetter
    names(pval) <- paste(posthoc$group1, posthoc$group2, sep="-")
    mcp <- multcompLetters(pval) %>% as.data.frame.list()
    
    #make the name of column equal with the variable used for grouping
    colName <- catVar[1]
    toJoin <- "group"
    names(toJoin) <- colName
    
    mcp$group <- rownames(mcp) #give the column name as "group" (similar name with value of toJoin)
    df_final <- left_join(allMean, mcp, by = toJoin) %>% dplyr::select(1:4)
    return(df_final)
    
  }
  
}

message("End of computFunc()------------")
#function to calculate effect size
"arguments:
dt = data frame.
x = vector of 2 variable names to compare the means. It will be used to subset data from data frame (dt). Require only for t.test
v = single or multiple character. column name used in right-hand side of a model formula. Require only for t.test.
y = single character. column name to be used in left-hand side of a model formula
method = character. method name for estimating effect size. eg. cohen
stat = character. Statistical method - 't.test' or 'anova'
welchs = logical. TRUE for welch and FALSE for student. require only for t.test. 
fa = formula. lm formula - eg. len ~ supp
... = additional arguments. can be used to specify paired or unpaired data in t.test
"

efS <- function(x = c("OJ", "VC"), v = "supp", y = "len", dt = ToothGrowth, method = "cohen/hedge/glass/eta..", stat = "t.test/anova", welchs = FALSE, partial = TRUE, fa, ...){
  
  if(stat == "t.test"){
    
    dt2 <- dt %>% filter(.data[[v]] %in%  x) %>% as.data.frame()
    message(dt2)
    message(colnames(dt2)) 
  }
  # fs <- reformulate(response = y, termlabels = v) #replace fs with proper format
  # 
  if(stat == "t.test"){
    
    if(isTRUE(welchs)){
      #hedge will be the default
      efs <- switch(tolower(method),
                    "cohen's d" = effectsize::cohens_d(data = dt2, x = fa, pooled_sd = FALSE, ...) %>% as.data.frame(),
                    "hedge's g" = effectsize::hedges_g(data = dt2, x = fa, pooled_sd = FALSE, ...) %>% as.data.frame(),
                    "glass delta" = effectsize::glass_delta(data = dt2, x = fa) %>% as.data.frame()
      )
    }else{
      efs <- switch(tolower(method),
                    "cohen's d" = effectsize::cohens_d(data = dt2, x = fa, pooled_sd = TRUE, ...) %>% as.data.frame(),
                    "hedge's g" = effectsize::hedges_g(data = dt2, x = fa, pooled_sd = TRUE, ...) %>% as.data.frame(),
                    "glass delta" = effectsize::glass_delta(data = dt2, x = fa) %>% as.data.frame()
      )
    }
    
    #properly arrange the column: mimic rstatix output
    efs$y_variable <- as.character(y)
    efs$group1 <- as.vector(x[1])
    efs$group2 <- as.vector(x[2])
    message(str(efs))
    efs2 <- efs %>% dplyr::select(y_variable, group1, group2, everything())
    #determine magnitude
    if(abs(efs2[4]) < 0.2){
      efs2$magnitude <- "negligible"
    }else if(abs(efs2[4]) >= 0.2 & abs(efs2[4]) < 0.5){
      efs2$magnitude <- "small"
    }else if(abs(efs2[4]) >= 0.5 & abs(efs2[4]) < 0.8){
      efs2$magnitude <- "medium"
    }else if(abs(efs2[4]) >= 0.8){
      efs2$magnitude <- "large"
    }
    
    final_df <- efs2
    #end of t.test
  }else if(stat =="anova"){
    
    av <- aov(data = dt, formula = fa) #replace fs with proper format
    anov <- car::Anova(av, type = 3)
    pav <- parameters::model_parameters(anov) 
    
    if(method == "Eta-squared"){
      final_df <- effectsize::eta_squared(pav, partial = FALSE) %>% as.data.frame()
      final_df["magnitude"] <- effectsize::interpret_eta_squared(final_df$Eta2) %>% as.data.frame()
    }else if(method == "Partial eta-squared"){
      final_df <- effectsize::eta_squared(pav, partial = TRUE) %>% as.data.frame()
      print(final_df)
      print(colnames(final_df))
      final_df["magnitude"] <- effectsize::interpret_eta_squared(final_df$Eta2_partial) %>% as.data.frame()
    }else if(method == "Generalized partial eta-squared"){
      final_df <- effectsize::eta_squared(pav, partial = TRUE, generalized = TRUE) %>% as.data.frame()
      final_df["magnitude"] <- effectsize::interpret_eta_squared(final_df$Eta2_generalized) %>% as.data.frame()
    }else if(method == "Epsilon-squared"){
      final_df <- effectsize::epsilon_squared(pav, partial = FALSE) %>% as.data.frame()
      final_df["magnitude"] <- effectsize::interpret_epsilon_squared(final_df$Epsilon2) %>% as.data.frame()
    }else if(method == "Omega-squared"){
      final_df <- effectsize::omega_squared(pav, partial = FALSE) %>% as.data.frame()
      final_df["magnitude"] <- effectsize::interpret_omega_squared(final_df$Omega2) %>% as.data.frame()
    }else if(method == "Cohen's f"){
      coh <- effectsize::cohens_f(pav, partial = FALSE) %>% as.data.frame()
      if(abs(coh$Cohens_f) < 0.10){
        coh$magnitude <- "negligible"
      }else if(abs(coh$Cohens_f) >= 0.10 & abs(coh$Cohens_f) < 0.25){
        coh$magnitude <- "small"
      }else if(abs(coh$Cohens_f) >= 0.25 & abs(coh$Cohens_f) < 0.40){
        coh$magnitude <- "medium"
      }else if(abs(coh$Cohens_f) >= 0.40){
        coh$magnitude <- "large"
      }
      final_df <- coh
    }#end of cohens_f
    
  }#end of anova
  
  return(final_df)
}

#function to generate data for stat
#anova need more setting
generateStatData <- function(data = "ptable()", groupStat = "groupStat()", groupVar = "groupStatVarOption()",
                             method = "none", numericVar = "numericVar()",
                             catVar = "catVar()", compRef = "none",
                             pairedD = "pairedData", pAdjust = TRUE, 
                             ttestMethod=FALSE, #welch or student's test
                             model = "model", #model of anova
                             pAdjustMethod = NULL, labelSignif = "labelSt()",
                             cmpGrpList = NULL, rfGrpList = NULL, #switchGrpList = 0, #for ref.group and comparison: global list
                             xVar = "xyAxis()[[1]]", anovaType = "anovaType", ssType ="I"){
  #convert the x-axis or group_by variable to factor.  
  #converting to factor is necessary for further processing
  message("entering generateStatData()-------------------")
  #for anova, every independent variable has to be a factor
  #for other tests, it will depend on the type of computation
  if(method %in% c("anova", "kruskal-wallis")){
    message(glue::glue("anova is converted to factor::======"))
    # message(glue::glue("catVar: {unlist(catVar)}"))
    data <- data %>% mutate(across(unlist(catVar), factor))
  }else{
    
    if(groupStat == "no"){
      #no nee to convert to factor
      data
    }else if(groupStat == "yes"){
      if(groupVar == xVar){
        data <- data %>% mutate(across(groupVar, factor))
      }else{
        data <- data %>% mutate(across(c(groupVar,xVar), factor))
      }
    }
    
  }
  
  message("converted to factor------------------------------")
  #apply stat and get the final data
  tryCatch({
    sData1 <- if(groupStat %in% c("no", "do nothing")){
      message(glue::glue("start sData1:--"))
      data %>% 
        #choose stat methods and apply
        #formula: independent (numeric) ~ dependent (factor)
        computFunc(data = ., method = method, numericVar = numericVar, catVar = catVar, compRef = compRef, 
                   paired = pairedD, ttestMethod = ttestMethod,
                   model = model, anovaType = anovaType, #ssType = ssType, 
                   cmpGrpList = cmpGrpList, rfGrpList = rfGrpList, pAdjust = pAdjust, pAdjustMethod= pAdjustMethod) #switchGrpList = switchGrpList,
      
    }else if(groupStat == "yes"){
      message("running groupby----------")
      data %>% group_by(!!!rlang::syms(groupVar)) %>%
        #choose stat methods and apply
        computFunc(data = ., method = method, numericVar = numericVar, catVar = catVar, compRef = compRef, 
                   paired = pairedD, ttestMethod = ttestMethod, anovaType = anovaType, pAdjustMethod = pAdjustMethod)
    }
  }, error = function(e){print(e)})
  
  
  
  if(!method %in% c("anova", "kruskal-wallis")){
    
    #add p adjusted value column to the data frame: by default, but user can omit
    pAdj <- if(isTRUE(pAdjust)){
      pAdjustMethod
    }else{"none"}
      
    sData2 <- sData1 %>%
        #add p adjusted value column 
        adjust_pvalue(method = pAdj) %>%
        #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
        add_significance(p.col = "p.adj") %>%
        #determine and add x and y position for labeling significance
        add_xy_position(x = xVar, dodge = 0.8)
    
    sData2$p.adj <- round(sData2$p.adj, 3)
    
  }#end of stat data for plots other than anova and krukal test
  
  #provide the output as list of computed data and user's choice for label
  if(method %in% c("anova", "kruskal-wallis")){
    list(sData1, NULL)
  }else{
    list(sData2, labelSignif)
  }
  
}


#Plot figure function--------------------------
"Function to plot graph. All basic graph + aesthetic will be included in this function.
Date: 17/01/23
arguments:
data = data frame. 
types = character. sepcify the type of plots to draw - 'box plot'. It can be 'none'.
geom_type = object. object from ggplot2 to plot the graph specified in the types.
histLine = object. require for histogram.
lineParam = list of objects. require for certain plots - scatter, line, violin, bar.
facet = logical. TRUE to facet and FALSE not to facet.
facetType = character. 'grid' or 'wrap'
nRow, nColumn = numeric. Require for facet.
varRow, varColumn = character. require for facet.
scales = character. 'fixed' or 'free' for facet.
layer = character. type of layer - 'point', 'line'...
layerSize = numeric. size for the layer.
barSize = numeric. size for graph.
xTextLabels = character. Label name for the variable of x-axis. 
xl, yl, fills, colr, shape, linetype, size = aesthetic options.
autoCust = character. either the color should be auto filled or customize.
colorTxt = character. color name specified for the variables.
varSet = character. same as fills or colr.
"

plotFig <- function(data, types = "reactive(input$plotType)", geom_type = "geom_",
                    xl = NULL, yl = NULL, fills = NULL,
                    colr = NULL, shapes = NULL, linetypes = NULL, sizes = NULL,
                    histLine = "meanLine", lineParam = "lineParam",
                    facet = FALSE, facetType = 'grid_wrap', varRow = NULL, varColumn = NULL, nRow = NULL, nColumn = NULL, scales = "fixed",  
                    layer = "none", layerSize = "layerSize", layerAlpha = NULL, barSize = 0.2, 
                    xTextLabels = "label",
                    #color aesthetic
                    autoCust, colorTxt, varSet = "none"
                    #, ...
){ #if y axis is required specifically mention in function parameter
  
  # browser()
  if(types == "none"){
    break
  }else if(!types %in% c("frequency polygon", "histogram")){
    #aesthetics will be filled based on requirement
    gp <- ggplot(data = data, 
                 
                 aes_string(
                   x = xl, y = if(!is.null(yl)){ yl }else{ NULL },
                   fill = if(!is.null(fills) && fills != "none"){ fills }else{ NULL },
                   shape = if(!is.null(shapes)){ shapes }else{ NULL},
                   linetype = if(!is.null(linetypes)){ linetypes }else{ NULL },
                   size = if(!is.null(sizes)){ sizes }else{ NULL },
                   color = if(!is.null(colr) && colr != "none"){ colr }else{ NULL }
                 )
    )
  }else{
    gp <- ggplot(data = data, 
                 aes_string(
                   x = xl,
                   fill = if(!is.null(fills) && fills != "none"){ fills }else{ NULL },
                   shape = if(!is.null(shapes)){ shapes }else{ NULL},
                   linetype = if(!is.null(linetypes)){ linetypes }else{ NULL },
                   size = if(!is.null(sizes)){ sizes }else{ NULL },
                   color = if(!is.null(colr) && colr != "none"){ colr }else{ NULL }
                 )
    )
  }
  
  
  if(types == "box plot"){
    #only for plot that require errorbar
    plt <- gp + 
      stat_boxplot(geom = "errorbar", width = barSize) +
      geom_type
    
  }else if(types == "histogram"){
    # plt <- gp + geom_type + histLine
    plt <- gp + geom_type + histLine
  }else{
    #other plot
    if(isFALSE(lineParam[[1]])){
      plt <- gp +geom_type 
      
    }else{
      #if TRUE, than it is for line, bar graph, etc, which require sd computed data
      plt <- gp + geom_type +
        #adding geom_errorbar
        lineParam[[3]]
    }
  }
  
  
  #add layer
  if(layer != "none"){
    cal <- ifelse(types %in% c("box plot", "violin plot"), "median", "mean")
    plt <- switch(layer,
                  "line" = plt + stat_summary(fun = cal, geom = 'line', aes(group = 1), size = layerSize),
                  "smooth" = plt + geom_smooth(size = layerSize),
                  "point" = plt + geom_point(size = layerSize, alpha = layerAlpha),
                  "jitter" = plt + geom_jitter(size = layerSize, alpha = layerAlpha)
    )
  }
  #facet
  if(isTRUE(facet)){
    if(facetType == "grid"){
      #I've used .data[[]] here, may not require.
      if(is.null(varRow)){
        plt <- plt+facet_grid(rows = vars(NULL), cols = vars(.data[[varColumn]]), scale = tolower(scales))
      }else if(is.null(varColumn)){
        plt <- plt+facet_grid(rows = vars(.data[[varRow]]), cols = vars(NULL), scale = tolower(scales))
      }else{
        plt <- plt+facet_grid(rows = vars(.data[[varRow]]), cols = vars(.data[[varColumn]]), scale = tolower(scales))
      }
    }else if(facetType == "wrap"){
      if(is.null(varRow)){
        plt <- plt + facet_wrap(facets = vars(NULL), nrow = nRow, ncol = nColumn, scale = tolower(scales))
      }else{
        plt <- plt + facet_wrap(facets = vars(.data[[varRow]]), nrow = nRow, ncol = nColumn, scale = tolower(scales))
      }
    }else{plt}
  }
  
  #add color here: so that anova (interaction) can be added
  if( varSet != "none" ){
    message("color provided")
    #User choice to auto fill or customize the color
    if(autoCust == "auto filled"){
      newPlt <<- plt #Make it global, to be used just before customization
      #coloring will be implemented while using the function
      plt
    }else if(autoCust == "customize"){
      #this will execute only if the customize option is selected
      message(glue::glue("colorTxt : {colorTxt}"))
      #get number of variables
      countVar <- length(unique(data[[varSet]]))
      
      editC <- if(colorTxt == "noneProvided"){
        "not provided" #if no color is provided
      }else{
        
        #process the given color input by removing space and comma
        message("Processing color")
        inputC <- strsplit(str_trim(gsub(" |,", " ", colorTxt))," +")[[1]]
        #Select only the required number of colors if user provide more than 
        #the required number.
        message(glue::glue("end of processing color: {inputC}"))
        message(glue::glue("length of inputC: {length(inputC)}"))
        message(glue::glue("countVar: {countVar}"))
        
        if(length(inputC) > countVar){
          inputC[1:countVar]
        }else{ inputC }
      }
      
      message(glue::glue("edit length: {length(editC)}"))
      if(editC != "not provided" && length(editC) < countVar){
        #display the color of the global plot
        message(glue::glue("editC less number : {editC}"))
        message(glue::glue("edit length: {length(editC)}"))
        newPlt
      }else if(length(editC) == countVar){
        message(glue::glue("editC final color: {editC}"))
        #add color to the plot
        if(types %in% c("line", "frequency polygon", "scatter plot")){
          plt <- plt + scale_color_manual(values = tolower(editC))
        }else{
          plt <- plt + scale_fill_manual(values = tolower(editC))
        }
        newPlt <<- plt #save global
      }
    }#end of customizing color
  }#end for color setting
  
  message(xTextLabels)
  #change variable name of x-axis
  plt <<- plt
  plt + scale_x_discrete(labels = xTextLabels ) 
}#end


#theme function---------------------
themeF <- function(thme = "user preferred theme"){
  switch(thme,
         "default" = theme(),
         "white" = theme_classic(),
         "white with grid lines" = theme_bw(),
         "dark" = theme_dark(),
         "blank" = theme_void(),
         "theme5" = theme_bw(10))
}

#Axis labeling Function-------------
axisLabs <- function(x =xyLable[[1]], y = xyLable[[2]]){
  if(!is.null(x) & !is.null(y)){
    labs(x = x, y = y)
  }else if(is.null(x) & !is.null(y)){
    labs(x = NULL, y = y)
  }else if(!is.null(x) & is.null(y)){
    labs(x = x, y = NULL)
  }else{
    #use default
    labs()
  }
}

#advance graph function: adding statistic info to the graph-----------
"
date: 17/01/23
  Function to add more advance settings:
  arguments:
    plt = object of ggplot2. It will be derived from plotFig. 
    methodSt = character. statistical method.
    removeBracket = logical. remove bracket for annotating statistical significance
    statData = Data frame. To be used for annotating statistical significane
    anovaType = character. The type of anova: one-way or two-way anova
    aovX = variable used in x-axis. This is required to display figure for two-way anova.
    plabelSize = numeric. adjust size for labeling p value or symbol.
  "
advancePlot <- function(data, plt,
                        #argument for stat data
                        methodSt = "none",
                        removeBracket=FALSE,
                        statData,
                        anovaType,
                        aovX=aovX,
                        plabelSize = 7
){
  # browser() 
  message(str(statData))
  # advance settings
  message("display advance")
  
  #statistics annotation: computed data will be provided as arguments
  if(methodSt != "none"){
    
    if(!methodSt %in% c("anova", "kruskal-wallis")){
      
      message("not anova------")
      plt <- plt + stat_pvalue_manual(statData[[1]], label = statData[[2]], tip.length = 0.01, remove.bracket = removeBracket, bracket.size = 0.4, step.increase = 0.1, bracket.nudge.y = 0.01, inherit.aes=FALSE, fontface = "bold", size = plabelSize)
      
    }else if(methodSt == "anova"){
      message("Anova stat method 2====")
      #get the details for labeling the plot
      textData <- statData[[1]] %>% as.data.frame()
      message("textData===")
      message(colnames(textData))
      col <- colnames(textData)
      message(glue::glue("inner function col: {col}"))
      
      x_name <- col[1]
      if(anovaType == "one"){
        y_name <- col[3]
        letr <- col[4]
        plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                                                label = eval(str2expression(letr))), size = plabelSize, vjust=-0.5, na.rm = TRUE)
      }else{
        
        message(glue::glue("aovX:{str(aovX)}, {is.null(aovX)}"))
        #get the position from the table
        if(aovX == "Interaction"){
          y_name <- col[4]
          letr <- col[5]
        }else if(aovX == "group1"){
          y_name <- col[3]
          message(y_name)
          letr <- col[4]
        }else{
          x_name <- aovX
          y_name <- col[3]
          message(aovX)
          message(y_name)
          letr <- col[4]
        }
        # browser(). 
        plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                                                label = eval(str2expression(letr))), position= position_dodge2(0.9), size = plabelSize, vjust=-0.25, na.rm = TRUE)
      }#end of two-way anova
      #end of anova
    }else if(methodSt == "kruskal-wallis"){
      
      message("entering Kruskal test=00000000")
      textData <- statData[[1]] %>% as.data.frame()
      col <- colnames(textData)
      
      x_name <- col[1]
      y_name <- col[3]
      letr <- col[4]
      message(glue::glue("inner function x_name: {x_name}"))
      #plot krukal test
      plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                                              label = eval(str2expression(letr))), position= position_dodge2(0.9), size = plabelSize, vjust=-0.25, na.rm = TRUE)
    }#end of Kruskal test
    
  }#end of statistics
  
  message("after condition:inner")
  
  plt 
  
}#end of inner function


