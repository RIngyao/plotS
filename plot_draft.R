#This script has the details code for each plots
library(tidyverse)
library(rstatix)
library(ggpubr)
library(datasets)
library(rstatix)
library(multcompView)
library("rcompanion")
#
#changing tab color------------
"reference: https://stackoverflow.com/questions/35025145/background-color-of-tabs-in-shiny-tabpanel"
# margin-left-right:7%;10%;
# figure
# margin:0 5% 5% 5%;
.figurePlotBox, .figureTheme{
  max-width: 600px;
  margin-left: 25%;
  margin-right:25%;
  margin-bottom: 5%;
  padding:0;
}
#data-----------------
data <- PlantGrowth
data <- ToothGrowth
data <- read_csv("~/Desktop/bar_data.csv")
data <- read_csv("~/Desktop/temp/bar_data.csv")
data <- read.csv("~/Desktop/temp/chickwts.csv")
data <- read_xlsx("~/Desktop/temp/replicates_ex.xlsx")
data <- read_csv("~/Desktop/temp/df_good.csv")
#count variable--------------
head(data)
data %>% distinct(cultivar, treatment) %>% nrow()
#
x <- data
x[1,]  <- c(1,"a", 3)
x <- data.frame(x=c("a","b"), y = c("ks", "ps"))
x[1,] <- x[1,]
x[1, ] <- colnames(x)
x
#rework on error bar------------------------
#provide option for 
# Descriptive error bar: SD
# Inferential error bar: SE and CI
data <- iris
head(data)
#sd
data2 <- data %>% group_by(Species) %>% summarise(count = n(), mean=mean(Sepal.Length), sd=sd(Sepal.Length))

#check condition for n > 3 (at least) for se and CI
data2 <- data %>% group_by(Species) %>% summarise(count = n(), mean=mean(Sepal.Length), sd=sd(Sepal.Length)) %>%
  mutate(se = sd/sqrt(count)) %>%
  #need to mention the qt part
  mutate(ci = se * qt(0.975, count-1)) #mutate(ci = se * qt((1-0.05)/2 + 0.5, count-1))
names(data2)[3] <- "Sepal.Length"
ggplot(data, aes(x=Species, y =Sepal.Length))+
  geom_point()+
  geom_errorbar(data=data2, aes(ymin= Sepal.Length-sd, ymax=Sepal.Length-sd))

ggplot(data, aes(x=Species, y =Sepal.Length))+
  geom_point()+
  geom_errorbar(data=data2, aes(ymin= Sepal.Length-se, ymax=Sepal.Length-se))

ggplot(data, aes(x=Species, y =Sepal.Length))+
  geom_point()+
  geom_errorbar(data=data2, aes(ymin= Sepal.Length-ci, ymax=Sepal.Length-ci))


sdFunc <- function(x, oName, yName, lineGrp){}
sdFunc(x= data, oName = "Species", yName = "Sepal.Length", lineGrp = NULL)

ggplot(data, aes(x=Species, y =Sepal.Length))+
  geom_point()+
  geom_errorbar(data=data2, aes(ymin= mean-se, ymax=mean-se))
library(shiny)
x <- "sd"
ggplot(data, aes(x=Species, y =Sepal.Length))+
  geom_point()+
  geom_errorbar(data=data2, aes(ymin= Sepal.Length-.data[[x]], ymax=Sepal.Length-.data[[x]]))

ggplot(data, aes(x=supp, y =len))+
  stat_boxplot(geom='errorbar')+ geom_boxplot()
#SE
ggplot(data, aes(x=supp, y =len))+
  stat_boxplot(geom='errorbar')+ geom_boxplot()+
  stat_summary(fun.data = mean_se, geom="errorbar")

ggplot(PlantGrowth, aes(group, weight))+
  stat_boxplot( aes(group, weight), 
                geom='errorbar', linetype=1, width=0.2)+  #whiskers
  geom_boxplot( aes(group, weight),outlier.shape=1) +    
  stat_summary(fun.y=mean, geom="point", size=2) + 
  stat_summary(fun.data = mean_se, geom = "errorbar", width=0.1)

ggplot(data, aes(x=supp, y =len))+geom_violin()


#datatable------------
data <- data.frame(x = c(0.143, 4.1132, 6.5231, 5.123), y = c(432, 65, 76, 09))
data %>% datatable() %>% formatRound(columns = 1:ncol(data))
head(data)
?formatRound
#normalization and standardization: 2nd edition----------
"
function for normalization and standardization
arguments:
data = data frame.
ns_method = character. method of transformation
x = character. Require only for box-cox. categorical variable to be used in the formula of lm(). 
y = chharacter. numerical variable to transform
"
ns_func <- function(data, ns_method, x=NULL, y){
  if(ns_method == "log2"){ 
    nw <- "log2"
    new_df <- data %>% mutate( log2 = log2(!!!rlang::syms(y)) )
    
  }else if(ns_method == "log10"){
    nw <- "log10"
    new_df <- data %>% mutate( log10 = log10(!!!rlang::syms(y)) ) #log10(y)
    
  }else if(ns_method == "square-root"){
    nw <- "sqrt"
    new_df <- data %>% mutate( sqrt = sqrt(!!!rlang::syms(y)) )#sqrt(y)
    
  }else if(ns_method == "box-cox"){
    #determine model
    # I have considered only the variable of x-axis while using the model
    # and ignored other independent variables provided in aesthetics.
    # Reason: so that I can display both the original and the transformed data 
    # in the organized table panel.
    
    nw <- "boxcox"
    # forml <- reformulate(response = glue::glue("{y}"), termlabels = glue::glue("{x}"))
    # forml <- reformulate(response = glue::glue("{numericVar}"), termlabels = glue::glue("{indepVar}"))
    # model <- lm(formula=forml, data = data)
    model <- lm(formula = formula(eval(str2expression(y)) ~ eval(str2expression(x))), data = data)
    
    #run boxcox
    bc <- boxcox(model, plotit = FALSE)
    #optimal lambda value
    opt_lba <- bc$x[which.max(bc$y)]
    #transform
    new_df <- data %>% mutate( box_cox = ((.data[[y]]^opt_lba-1)/opt_lba) )
    
  }else{
    
    nw <- "scale"
    #scale
    new_df <- data %>% mutate( scale = scale(!!!rlang::syms(y)) )#scale(y)
    
  }
  
  #rename the column
  # new_df[, paste0(nw, "_", y)] <- new_df[, ncol(new_df)]
  new_df[, y] <- new_df[, ncol(new_df)]
  # new_df[, - (ncol(new_df))]
  new_df <- new_df[, -ncol(new_df)] #remove the duplicate transform column
  return(new_df)
}

#normalization and standardization: 1st edition----------
scale(data$len)
x <- data %>% mutate(across(len, scale))
x %>% head()
data[which()]
which(names(data) == "len")

x <- 5
y <- 1
x <- if( y > 3){
  3
}else{
  x
}
x
#box-cox
"
function for normalization and standardization
arguments:
data = data frame.
ns_method = character. method of transformation
x = character. variable of x-axis. Require only for box-cox. 
y = chharacter. variable of y-axis.
"
ns_func <- function(data, ns_method, x=NULL, y){
  if(ns_method == "log2"){ 
    nw <- "log2"
    new_df <- data %>% mutate( log2 = log2(.data[[y]]) )
    
  }else if(ns_method == "log10"){
    nw <- "log10"
    new_df <- data %>% mutate( log10 = log10(.data[[y]]) ) #log10(y)
    
  }else if(ns_method == "square-root"){
    nw <- "sqrt"
    new_df <- data %>% mutate( sqrt = sqrt(.data[[y]]) )#sqrt(y)
    
  }else if(ns_method == "box-cox"){
    #determine model
    # I have considered only the variable of x-axis while using the model
    # and ignored other independent variables provided in aesthetics.
    # Reason: so that I can display both the original and the transformed data 
    # in the organized table panel.
    
    nw <- "boxcox"
    # forml <- reformulate(response = glue::glue("{y}"), termlabels = glue::glue("{x}"))
    # forml <- reformulate(response = glue::glue("{numericVar}"), termlabels = glue::glue("{indepVar}"))
    # model <- lm(formula=forml, data = data)
    model <- lm(formula = formula(eval(str2expression(y)) ~ eval(str2expression(x))), data = data)
    
    #run boxcox
    bc <- boxcox(model, plotit = FALSE)
    #optimal lambda value
    opt_lba <- bc$x[which.max(bc$y)]
    #transform
    new_df <- data %>% mutate( box_cox = ((.data[[y]]^opt_lba-1)/opt_lba) )
    
  }else{
    
    nw <- "scale"
    #scale
    new_df <- data %>% mutate( scale = scale(.data[[y]]) )#scale(y)
    
  }
  
  #rename the column
  # new_df[, paste0(nw, "_", y)] <- new_df[, ncol(new_df)]
  new_df[, y] <- new_df[, ncol(new_df)]
  # new_df[, - (ncol(new_df))]
  new_df <- new_df[, -ncol(new_df)] #remove the duplicate transform column
  return(new_df)
}
data <- ToothGrowth
y <- c("dose","len")
x <- "supp"
y <- "len"
library(MASS)
ns_func(data = data, y =y, ns_method = "box-cox", x= x) 
ns_func(data = data, y="len", ns_method = "log2")
head(df)
head(data)
log10(df$log10_len)
colnames(df[, ncol(df), drop=F])
data <- ToothGrowth
model <- lm(data = data, formula = formula(eval(str2expression(y)) ~ eval(str2expression(x)) ))

forml <- stats::reformulate(response = glue::glue("{y}"), termlabels = glue::glue("{x}"))
model <- lm(formula=forml, data = data)
bc <- boxcox(model)

opt_lba <- bc$x[which.max(bc$y)]
data2 <- data
data %>% mutate( box_cox = ((.data[["len"]]^opt_lba-1)/opt_lba) )
#median absolute deviation---------
mad(c(12,76,76))
median(c(12,76,76))
mad(1:5)
sd(c(12,76,76))
#parametric test------------------------
data %>% group_by(species) %>% lm(formula = value ~ sub)
lm(formula = value ~ species, data = data)
model <- lm(data = data, formula = value ~ species)
# model <- lm(data = data, formula = value ~ species:sub) #for t_test with aesthetic
summary(model)
res <- resid(model)
plot(fitted(model), res, ylab = "residual") %>% abline(0,0, col="red")
ylab("residual")
data %>% group_by(sub) %>% t_test(value ~ species) %>% as.data.frame()
p <- plot(fitted(model), res) %>% abline(0,0)
plot(density(res), main="Figure 2. Density plot")

qqnorm(res, main="Figure 3. Q-Q plot for residuals")
qqline(res, col="red")
#shapiro wilk test
shapiro.test()
?shapiro_test()
?rstandard
x <- rstandard(model)
ks.test(x, "pnorm")
t <- ks.test(x, "pnorm")
summary(t)
t$p.value

leveneTest(x)
lv <- leveneTest(model) #%>% as.data.frame()
format(lv[1,3], digits = 3)
lv$`Pr(>F)`
str(lv$`Pr(>F)`)
library(car)

car::leveneTest(value ~ species : sub, data=data)

data <- ToothGrowth
model2 <- lm(data = data, len ~ supp)
res <- resid(model2)
x2 <- rstandard(model2)
t2 <- shapiro.test(x2)
t2$p.value
format(2.2e-16, scientific=F)
options(digit=5)
?option
#data summary-----------------------
data <- read_csv("~/Desktop/temp/bar_data.csv")
# data$new <- as.factor(data$dose)
summary(data)
?summary
library(skimr)
cust_hist <- skim_with(base = sfl(missing_value = n_missing),
                     factor = sfl(ordered = NULL, count =top_counts, top_counts=NULL),
                     numeric = sfl( hist = NULL, p0 = NULL, p25=NULL, p50=NULL, p75=NULL, p100=NULL, min = min, median =median, max= max)
                     )
cust_hist <- skim_with(base = sfl( missing_value = n_missing),
                       character = sfl(whitespace = NULL, min=NULL, max = NULL, empty = NULL ),
                       factor = sfl( ordered = NULL, count =top_counts, top_counts=NULL),
                       numeric = sfl(hist = NULL, p0 = NULL, p25=NULL, p50=NULL, p75=NULL, p100=NULL, min = min, median =median, max= max)
)
head(data)
cust_hist(data)
summary(data)
skimr::skim(data)  %>% partition()
quantile(data$len)
#get the name
str_replace("/head/document/new.txt", "$")

#replicates mutually exclusive----------
lapply(c("x","y"),  function(x) x<-NULL)
n <- function(x, col_n, varNum){
  map(varNum, function(x) x <- NULL)
  if(x == "var1R"){
    
  }
  return(x)
}
ui <- fluidPage(
  uiOutput("xy")
)

if(1 == 1 && 4 <5){
  print("yes")
}else "no"

if(1 > 1 && 4 <5){
  print("yes")
}else "no"

if(1 == 1 && 5 <5){
  print("yes")
}else "no"


if(1 > 1 & 4 <5){
  print("yes")
}else "no"

server <- function(input, output, session) {
  output$xy <- renderUI({
    varNum <- paste0("var", seq_len(3))
    map(varNum, ~ fluidRow(
      column(5, textInput(inputId = .x, label = "Name")),
      column(7, selectInput(inputId = paste0(.x,"R"), label = "Replicates column", choices = 1:4, multiple = TRUE))
    ))
  })
}
shinyApp(ui, server)
#end mutually exclusive----

switch("4",
       "1" = "one",
       "2" = "two",
       "blank")
#preparing table for replicates-----------
data <- read_csv("~/Desktop/temp/replicates_csv.csv")
head(data)
library(tidyverse)
library(readxl)
data <- read_excel("~/Desktop/delete/example_gt.xlsx") %>% as.data.frame()
data <- rbind(data[1,], data)
head(data)
data[1, ]<- colnames(data)
tidyReplicate(x = data, y = data[,1:3], colName = "new", headerNo = 1:3, colNo = c(3:5), stp=0)

data <- read_xlsx("~/Desktop/temp/replicates_ex.xlsx")
"
For data with replicates and non-parametric test, used median.
"
data <- ToothGrowth
apply(headerRemoved3, 1, median) 
head(headerRemoved3)
headerRemoved3 %>% rowwise() %>% arrange() %>% mutate(median = median(c(R1, R2,R3)), median2= median(c(R21,R22,R23)))
library(readxl)
xh <- read_excel("~/Desktop/delete/example_gt.xlsx")
csv <- read.csv("~/Desktop/delete/gt_csv.csv")
saveRDS(csv, "www/gt_csv.csv")
xh
headr <- xh[1:2,1] %>% as.data.frame()
is.na(hdr[which(!is.na(hdr)), ])
colnames(hdr) <- hdr[which(!is.na(hdr)), ]
noNumeric <- xh %>% select(matches("[a-zA-Z]"))
#create gt table----------
library(gt)
xh1 <- xh %>% gt()
gt_preview(csv)
csv1 <- csv %>% gt()
csv2 <- gt(csv,rowname_col = "x")

gt_preview(xh1)
gt::gt_preview(csv1)
head(xh)
x <- xh 
names(x) <- NULL
x
x2 <- ToothGrowth
names(x2)<- NULL
x2
colnames(ToothGrowth)
colnames(x)
gt_preview(xh)
#try to get the number of variables in the table
# write a function
getDataVariable <- function(x= "data", nh = 1){
  
  nh <- 1:nh #range
  #keep only the header: this will be in table format
  headr_df <- x[nh,] %>% as.data.frame()
  col_n <- ncol(headr_df) #number of column
  #transpose the df
  headr_df <- t(headr_df)
  #generate and add column name
  colnames(headr_df) <- paste0("h",nh)
  
  headr_df <- headr_df %>% as.data.frame()
  rownames(headr_df) <- NULL
  
  #dummy variable number and name
  getNumber <- 0 #it has to be zero
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
  
  return(list(getNumber, getVar))
}

cc <- getDataVariable(x=xh, nh=2, re=2)

n <- NULL
for(i in seq_along(cc)){
  print(cc[i])
  if(is.null(n)){
    n <- paste0("Variables name: ",cc[i])
    print(n)
  }else{
    n <- paste0(n,", ",cc[i])
  }
}


glue::glue("{cc}")
paste0("hs", cc)
sprintf("ksk %s",cc)
y <- unique(hdr[,1])
y[!is.na(y)]

nh <- 1:2
headrAll <- xh[nh,] %>% as.data.frame()
col_n <- ncol(headrAll)
headrAll2 <- t(headrAll)
colnames(headrAll2) <- paste0("h",nh)
hdr <- headrAll2 %>% as.data.frame()
rownames(hdr) <- NULL
getNumber <- 0

for(i in nh){
  print(i)
  h <- hdr[i]
  len <- length(unique(h[,1]))
  print(h)
  if(any(is.na(h[,1]))){
    print(len)
    len <- len - 1
    print(len)
  }
  if(getNumber == 0){
    getNumber <- len
  }else if(getNumber > len){
    getNumber <- len
  }
}

#User need to specify the number of header and variables for the table
#If user click the replicate, than remove the header from the table
# it will be easier for user to choose the number of header from the 
# original table

# If the table is not in proper format, than header cannot be remove easily.
df_nproper <- xh %>% as.data.frame()
colnames(df_nproper)
#get number of columns 
col_n <- ncol(df_nproper)
#create new header name
colnames(df_nproper) <- paste0("H",1:col_n)
names(df_nproper)  <- NULL
df_nproper

"
Function to re-arrange replicates of each group/variable provided by the user.
It will processed the replicates only for one group at a time, not multiple groups.

arguments:
x = dataframe. data to apply the function
colName = character. Column name. To be used for the  tidied data
headerNo = numeric. row index of header used in the table.
colNo = numeric. column index for the replicates of each group. It can be range or vector
"
tidiedReplicate <- function(x=data, headerNo = 1:2, colName= "column_name", colNo=2:4){
  
  #For now, every elements in the data are in character
  #remove the header
  message("inside func3")
  headerRemoved <- x[-c(headerNo),] %>% as.data.frame() # all columns will be present
  message("headerRemoved")
  message(glue::glue("headerRemoved: {head(headerRemoved)}"))
  
  #non-replicate column: It will be a character column when in proper format
  # later tidied data will be appended to this data
  message("nonnumeric")
  #empty data frame to catch the character column
  noNumeric <- data.frame()
  colIndx <- 0 #empty index to get the header name later
  
  #Check whether the character columns should be a character or numeric
  # and keep only the column that has to be character.
  for(i in seq_len(ncol(headerRemoved))){
    if( any(str_detect( headerRemoved[,i],regex('[a-zA-Z]') ) ) ){
      if(length(colIndx) == 1 && colIndx == 0){
        colIndx <- i
      }else{
        colIndx <- c(colIndx, i)
      }
      
      if(is_empty(noNumeric)){
        noNumeric <- headerRemoved[,i, drop=FALSE]  
      }else{
        col_n <- colnames(headerRemoved[,i, drop =FALSE])
        noNumeric[, col_n] <- headerRemoved[,i]
      }
      
    }
  }
  
  message(head(noNumeric))
  #get column name from the header 
  if(!is_empty(noNumeric)){
    
    #get the header
    headr <- x[headerNo, c(colIndx)] %>% as.data.frame()
    message("if statment")
    if(all(is.na(headr))){
      
      #if all is na i.e. no header name was given in the table.
      #generate new column name
      col_n <- ncol(noNumeric)
      message("inside if")
      colnames(noNumeric) <- paste0("variable",1:col_n)
      message(head(noNumeric))
      
    }else{
      message("header present")
      #if header is included in the table, use the name and re-format in proper order
      getName <- headr[!is.na(headr)]
      colnames(noNumeric) <- getName[1]
      
    }
    
  }
  
  message("replicate selection")
  #select only the column specified as replicates: colNo
  df <- headerRemoved[, c(colNo)]
  message(colnames(df))
  # convert to numeric
  message("converting to numeric")
  onlyNumeric <- df %>% mutate_if(is.character, as.numeric)  #%>% as_tibble()
  
  message("converted to numeric")
  message(head(onlyNumeric))
  message(str(onlyNumeric))
  # browser()
  #generate and add column names
  nn <- ncol(onlyNumeric)
  colnames(onlyNumeric) <- paste0("Replicate_",1:nn)
  
  #merge the noNumeric (character column) and onlyNumeric (replicate column)
  newDf <- cbind(noNumeric, onlyNumeric)
  
  #Reshape the data: keep replicate row-wise i.e. longer format (pivot_longer())
  newDf2 <- pivot_longer(newDf, cols = !colnames(noNumeric), names_to = "replicates", values_to = colName)
  message("reshape done inside replicate func")
  message(head(newDf2))
  rownames(newDf2) <- NULL
  
  return(newDf2)
  
}


nrow(data)
data
#once user has specified the number of header, select only the value below the header and
"
Function to determine mean and median of replicates of each group/variable provided by the user.
Mean and median will be determined row-wise.
It will processed the replicates only for one group at a time, not multiple groups.

arguments:
x = dataframe. data to apply the function
y = dataframe of x, excluding all the replicates of all the groups or variables.
colName = character. Column name for the  tidied data
headerNo = numeric. row index of header used in the table.
colNo = numeric. column index for the replicates of each group.
stat = character. mean or median
"

replicateMeanMedian_perGroup <- function(x=data, y = data2, headerNo = 1:2, colName= "column_name", colNo=1:4, stat = "mean"){
  #remove the header
  # all columns will be present
  headerRemoved <- x[-c(headerNo),] %>% as.data.frame()
  
  #For now, every elements in the data are in character
  
  #get the column other than numeric: 
  # later tidied data will be appended to this data
  # noNumeric <- headerRemoved %>% select(matches("[a-zA-Z]"))
  noNumeric <- y[-c(headerNo), ] %>% as.data.frame()
  #get column name of non-replicates from the header
  headr <- y[1:2,] %>% as.data.frame()
  
  if(all(is.na(headr))){
    
    #if all is na i.e. no header name was given in the table.
    #generate new column name
    col_n <- ncol(noNumeric)
    colnames(noNumeric) <- paste0("variable",1:col_n)
    
  }else{
    
    #if header is included in the table, use the name and re-format in proper order
    getName <- headr[!is.na(headr)]
    colnames(noNumeric) <- getName[1]
    
  }
  
  #select only the column specified for replicates: colNo
  df <- headerRemoved[, colNo]
  # convert to numeric
  onlyNumeric <- df %>% mutate_if(is.character, as.numeric)  %>% as_tibble()
  
  #genreate and add column names
  nn <- ncol(onlyNumeric)
  colnames(onlyNumeric) <- paste0("R",1:nn)
  
  #determine mean or median
  if(tolower(stat) == "mean"){
    
    group_mean <- onlyNumeric %>% rowMeans()
    m_stat <- data.frame(mean = group_mean)
    colnames(m_stat) <- colName
    
  }else{
    
    #sort the replicates row-wise
    group_sort <- t(apply(onlyNumeric,1,sort))
    colnames(group_sort) <- colnames(onlyNumeric)
    #determine median
    group_median <- apply(group_sort, 1, median)
    m_stat <- data.frame(median=group_median)
    colnames(m_stat) <- colName
    
  }
  
  #append the mean or median value back to the original data
  final <- cbind(noNumeric, onlyNumeric, m_stat) 
  row.names(final) <- NULL
  
  return(final)
  
}




xh <- as.data.frame(xh)
xx <- replicateMeanMedian_perGroup(x=xh, y = xh[,1, drop=FALSE], headerNo = 1:2, colName = "control", colNo = 2:4, stat = "mean")
xx

# use gt to display in proper format, if user has replicates
"
Function to display the user's data in proper format. Only require for displaying the table.
This will apply only when data has replicate.
Use  gt() table.

"
x <- "Table 1"
headerRemoved[, headerRemoved[[x]]]
y <- headerRemoved
z <- y[,1, drop=FALSE]
y %>% mutate(new = all_of())
y$new  <- headerRemoved %>% select(.data[[x]])
y$ss <- z
y
#sort
group2 <- t(apply(group1,1,sort))
colnames(group2) <- colnames(group1)
group_median <- apply(group2, 1, median)
df_median <- data.frame(median=group_median)
# group2 <- 
  group2 %>% as_tibble() %>% rowwise() %>% mutate_at(median1= median(acro))
?mutate_at
  apply(group2, 1, median)
ls <- c(paste0("R",1:3))
ls
as.vector(ls[[1]])
# -------------------------------------------------------------------------


#add column names: generic
colnames(headerRemoved3) <- c("R1", "R2", "R3", "R21", "R22", "R23")
x <-headerRemoved2[, 1:3]
n<-  3 #number of columns for the replicate
colnames(x) <- paste0("R", 1:n)

#get the column other than numeric: save this for  the original data
noNumeric <- headerRemoved %>% select(matches("[a-zA-Z]"))
#get the column with numeric
onlyNumeric <- headerRemoved %>% select(!matches("[a-zA-Z]"))
#convert to numeric
headerRemoved3 <- onlyNumeric %>% mutate_if(is.character, as.numeric) %>% as_tibble()

# convert to numeric
headerRemoved <- xh[-c(1,2),] %>% as.data.frame()
head(headerRemoved)
#convert  to numberic

rownames(headerRemoved) <- headerRemoved$`Table 1`
headerRemoved2 <-  headerRemoved[, -1] #remove the column that has been converted to rowname
str(headerRemoved2)
headerRemoved3 <- headerRemoved2 %>% mutate_if(is.character, as.numeric)
str(headerRemoved3)


#add column names: generic
colnames(headerRemoved3) <- c("R1", "R2", "R3", "R21", "R22", "R23")
headerRemoved3
#ask user to specify column number of the replicates for each group and a new name for column (mean and median).
#get the row mean and median of the replicates: keep both in the table
#group1-mean

# -------------------------------------------------------------------------
group1 <- headerRemoved3[,1:3] 
group1_mean <- group1 %>% rowMeans()
group1_mean <- data.frame(mean1=replicate_mean)
#group1-median:
#sort
group2 <- t(apply(group1,1,sort))
colnames(group2) <- colnames(group1)
group2 <- group2 %>% as_tibble() %>% rowwise() %>% mutate(median1= median(c(R1,R2,R3)))#mutate(median1 = median(c_across(where(is.numeric)), na.rm=TRUE))#mutate(median1 = median(c_across(where(is.numeric)), na.rm = TRUE))
# col <-  c(colnames(group1))
# group1 %>% rowwise() %>% mutate(me=median(eval(str2expression(!!!rlang::syms(col)))))
# eval(str2expression(!!!rlang::syms(col)))
group_mean_median <- cbind(group2, group1_mean) %>% select(mean1, median1)
group_mean_median
#add mean and median to the orginal data
headerRemoved4 <- cbind(headerRemoved3, group_mean_median)

#replicate2
replicate_mean <- headerRemoved3[,4:6] %>% rowMeans()
newData <- data.frame(stress=replicate_mean)

head(newData)
head(replicate_mean)
#for stat summary------------------
"
t.test:
  1. result of t_test
  2. effect size:
  3. normality test (shapiro wilk test)
  4. homogeneity test (levene test)
"
#Data--------------
data <- chickwts
data <- read_csv("~/Desktop/bar_data.csv")


x <- list(data) 
x <- x[[1]] 
head(x)
colnames(x[1])
#data["dose"] <- as.factor(data["dose"]) #wrong
#x-axis as factors
head(data)
data$dose <- as.factor(data$dose)
str(data)
"For t-test and anova show normality test"
#kruskal test----------------
data <- read_csv("~/Desktop/temp/chickwts.csv")
data <- PlantGrowth
head(data)
# allMean <- data %>% group_by(group) %>% summarise(mean = mean(weight), quantl = quantile(weight, probs = 1, na.rm =TRUE))
allMean <- data %>% group_by(feed) %>% summarise(mean = mean(weight), quantl = quantile(weight, probs = 1, na.rm =TRUE))
allMean %>% arrange(desc(mean))
# kstat <- kruskal_test(data=data, weight ~ group)
# posthoc <- dunn_test(data=data, formula = weight ~ group, p.adjust.method = "holm", detailed=FALSE)
kstat <- kruskal_test(data=data, weight ~ feed)

posthoc <- dunn_test(data=data, formula = weight ~ feed, p.adjust.method = "holm", detailed=FALSE)

#multcomp
pval <- posthoc$p.adj
pval
names(pval) <- paste(posthoc$group1, posthoc$group2, sep="-")
pval
mcp <- multcompLetters(pval) %>% as.data.frame.list()
#make the name of column equal with the variable used for grouping
mcp$feed <- rownames(mcp)
df_final <- left_join(allMean, mcp, by = "feed") %>% select(1:4)
as.data.frame(df_final)

#library rcompanion: not require
pos2 <- posthoc
pos2$comparison <- paste(pos2$group1, pos2$group2, sep="-")
cpl <- cldList(data=pos2, formula = p.adj ~ comparison)
posthoc_final <- left_join(allMean, cpl, by = c("group"="Group")) %>% select(-MonoLetter)
posthoc_final


#pairwise_ttest-----------------
data <- ToothGrowth
gp <- ggplot(data, aes(x=dose, y = len, fill=supp)) + geom_boxplot()

stat.test <- data %>% pairwise_t_test(len ~ supp, paired = FALSE) %>% adjust_pvalue(method = "bonferroni") %>%
  add_significance(p.col = "p.adj") %>% add_xy_position(x = "dose", dodge = 0.8)

stat.test
gp + stat_pvalue_manual(
  stat.test,  label = "p.adj.signif",  tip.length = 0.01, bracket.size = 1,
  inherit.aes = FALSE
) 

#wilcoxon test----------------
"Wilcoxon rank-sum test is used to compare two independent samples. It is also known as Mann-Whitney test [http://www.sthda.com/english/wiki/unpaired-two-samples-wilcoxon-test-in-r]. 
while Wilcoxon signed-rank test is used to compare two related samples (paired). 
Method to employ for the stat:
1. Wilcoxon rank-sum test - unpaired
2. wilcoxon sign-rank test - paired
"
#reference: 
# 1. https://www.datanovia.com/en/lessons/wilcoxon-test-in-r/
"It needs to report both the test and the effect size."
data <- ToothGrowth
#wilcoxon rank-sum test
gp <- ggplot(data, aes(x=dose, y = len, linetype=supp)) + geom_boxplot()
data %>% rstatix::wilcox_test(len ~ dose, paired = FALSE) 


stat.test <- data %>% wilcox_test(len ~ dose, paired = FALSE) %>% adjust_pvalue(method = "bonferroni") %>%
  add_significance(p.col = "p.adj") %>% add_xy_position(x = "dose", dodge = 0.8)
stat.test
library(coin)
efSize <- wilcox_effsize(data, len ~ dose)
efSize

#wilcoxon sign-rank test
gp <- ggplot(data, aes(x=dose, y = len, linetype=supp)) + geom_boxplot()
stat.test <- data %>% wilcox_test(len ~ dose, paired = TRUE) %>% adjust_pvalue(method = "bonferroni") %>%
  add_significance(p.col = "p.adj") %>% add_xy_position(x = "dose", dodge = 0.8)
stat.test
library(coin)
efSize <- wilcox_effsize(data, len ~ dose, paired = TRUE)
efSize
#t_test-------------------
"Reference:
1. https://www.datanovia.com/en/lessons/t-test-in-r/

Test methods:
  1. Student t-test
  2. Welch t-test
This will be control by var.equal
"
data <- ToothGrowth
data$dose <- as.factor(data$dose)
#normality test: p > 0.05 = normality
data %>% shapiro_test(len) #with  no aesthetic
#with aesthetic
head(data)
data %>% group_by(dose, supp) %>% shapiro_test(len)
identify_outliers(data, len)
library(ggpubr)
ggqqplot(data, "len", color = "dose", combine = FALSE)
ggqqplot(data, "len", color = "dose", combine = TRUE)
ggqqplot(data, "len", color = "dose")
?ggqqplot

#using replicate arrange
head(data)
ne <- tidiedReplicate(x = data, headerNo = 1:2, colName = "control", colNo = c(2,3))
ne2 <- tidiedReplicate(x = data, headerNo = 1:2, colName = "control", colNo = c(4,5))

head(ne2)
ne$stress <- ne2$control
head(ne)
sa <- pivot_longer(ne, cols = c(control, stress), names_to = 'new')
head(sa)
sa$variables <- sa$variable
t_test(data = sa, value ~ var) %>% 
  adjust_pvalue(method = "bonferroni") %>% 
  add_significance(p.col = "p.adj") %>%
  add_xy_position(x ="variables" , dodge = 0.8) 

head(tes)
vr <- "variable"
if(any(colnames(sa) == 'variable')){
  bfp <- dplyr::rename(sa, variables = variable)
}else{
  bfp <- sa
}


head(bfp)
sa[vr]
t_test(data = sa, value ~ replicates) %>% 
  adjust_pvalue(method = "bonferroni") %>% 
  add_significance(p.col = "p.adj") %>%
  add_xy_position(x = "replicates", dodge = 0.8) 
?unnest
#t_test
gp <- ggplot(data, aes(x=dose, y = len)) + geom_violin()#geom_boxplot()
t<- TRUE
data %>%t_test(len ~ dose, paired = FALSE, ref.group = NULL, p.adjust.method = 'none')
data %>%t_test(len ~ dose, paired = FALSE, ref.group = NULL)
stat.test <- data %>%#group_by(dose)%>%
  t_test(len ~ dose, paired = FALSE, ref.group = NULL, p.adjust.method = NULL)%>%#, comparisons = list(c("0.5","2"), c("1","2"))) %>% #x axis default:
  adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
  add_xy_position(x = "dose", dodge = 0.8) 
stat.test
gp + stat_pvalue_manual(
  stat.test,  label = "p.adj.signif",  tip.length = 0.01, bracket.size = 1,
  inherit.aes = FALSE
) 

#if aes selected, it will auto group.
gp <- ggplot(data, aes(x=dose, y = len, fill = dose)) + geom_boxplot()
stat.test <- data %>%#group_by(dose)%>%
  t_test(len ~ dose, comparisons = list(c("0.5","2"), c("1","2"), c("0.5","1"))) %>% #x axis default:
  adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
  add_xy_position(x = "dose", dodge = 0.8) 
gp + stat_pvalue_manual(
  stat.test,  label = "p.adj.signif",  remove.bracket = FALSE, tip.length = 0.01, bracket.size = 1,
  inherit.aes = FALSE
) 

#reference group
gp <- ggplot(data, aes(x=dose, y = len, linetype=supp)) + geom_boxplot()
lst <- list("0.5")
stat.test <- data %>%
  t_test(len ~ dose, ref.group = unlist(lst))%>%#, comparisons = list(c("0.5","2"), c("1","2"))) %>% #x axis default:
  adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
  add_xy_position(x = "dose", dodge = 0.8) 
gp + stat_pvalue_manual(
  stat.test,  label = "p.adj.signif",  tip.length = 0.01, bracket.size = 1,
  inherit.aes = FALSE
) 

ls <- list(c("a","c"), c("c", "b"), c("a", "b"), c("a", "c"))
list(c("a","c")) %in% ls
data <- read_csv("~/Desktop/temp/df_good.csv") %>% as.data.frame()
head(data)
data$cultivar <- as.factor(data$cultivar)
data$treatment <- as.factor(data$treatment)
relevel(data$cultivar, ref="ir")
data %>% rstatix::t_test(formula =value ~ treatment, ref.group = "all")
# relevel(warpbreaks$tension, ref = "all")
warpbreaks %>% rstatix::t_test(formula =breaks ~ tension, ref.group = 'all')
head(warpbreaks)
head(data)
str(warpbreaks)
str(data)
class(warpbreaks)
class(data)
data2 <- ToothGrowth
data %>% rstatix::t_test(formula = len ~ dose, ref.group = "all")
data %>% count(treatment)
# gp <- ggplot(data, aes(x=dose, y = len, fill = supp, linetype=dose)) + geom_boxplot()
# stat.test <- data %>%group_by(dose)%>%
#   t_test(len ~ supp)%>%#, comparisons = list(c("0.5","2"), c("1","2"))) %>% #x axis default:
#   adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
#   add_xy_position(x = "dose", dodge = 0.8) 
# gp + stat_pvalue_manual(
#   stat.test,  label = "p.adj.signif",  tip.length = 0.01, bracket.size = 1,
#   inherit.aes = FALSE
# ) 
#Anova-----------------------
"
Reference:
1. https://www.datanovia.com/en/lessons/anova-in-r/
2. https://www.scribbr.com/statistics/two-way-anova/#:~:text=A%20two%2Dway%20ANOVA%20is,combination%2C%20affect%20a%20dependent%20variable.
"
#one-way ANOVA: use base and rstatix package
data <- chickwts
summary(data)
data
# anova <- aov(weight ~ feed, data = data) 
av <- anova_test(data = data, weight ~ feed, type = 2)
av
tukey_df <- tukey_hsd(weight ~ feed, x = data) #This data need to be saved as global data to show in stat summary
tukey_df
#use inside function
rf <- reformulate(response = glue::glue("weight"), termlabels = glue::glue("feed"))
avrf <- anova_test(data = data, rf, type = 2) 
avrf
tukey_hsd(data, rf)
#process further to get multcompletter
#compact letter for display of significance
new_tk <- tukey_df %>% mutate(name= paste(tukey_df$group1, tukey_df$group2, sep = "-"))
head(new_tk$name)
#Determine the mean and position for labeling
meanLabPos <- data %>% group_by(feed) %>% 
  summarise(mean = mean(weight), quantl = quantile(weight, probs =1, na.rm=TRUE))

#add mean to the new_tk and sort it based on the mean: this is require so that letter is in the order of mean (ascending)
new_tk_join <- left_join(new_tk, meanLabPos, by = c("group1" = "feed")) %>% arrange(mean)
pval <- new_tk_join$p.adj
names(pval) <- new_tk_join$name
mcl <- multcompLetters(pval)
mcl2 <- as.data.frame.list(mcl)
mcl2$new <- rownames(mcl2)
meanLabPos2 <- left_join(meanLabPos, mcl2, by=c("feed"="new")) #%>% select
meanLabPos2

#plot
?coord_cartesian
library(ggplot2)
ggplot(data, aes(feed, weight)) + 
  geom_boxplot() +
  coord_cartesian(clip="off")+
  geom_text(data=meanLabPos2, aes(x = feed, y = quantl, label = Letters), size = 10, vjust=-1)+
  theme(
    axis.title.y = element_text(size = 5)
  )

#two-way anova-----------------------------------------
data <- read_csv("~/Desktop/temp/GTL.csv")
head(data)
data$temp_factor <- as.factor(data$Temp)

#non-additive model: base aov()--------------------
# av <- anova_test(data= data, Light ~ Glass * temp_factor, type=2)
av_n <- aov(data= data, Light ~ Glass * temp_factor)
get_anova_table(anova_test(data= data, Light ~ Glass * temp_factor)) %>% as.data.frame()
av_n
summary(av_n)
# aov <- aov(data = data, value ~ species + sub)
# summary(aov)

#Determine the mean and position for labeling: use the two groups
#for interaction
meanLabPos_n <- data %>% group_by(Glass,temp_factor) %>% 
  summarise(mean = mean(Light), quantl = quantile(Light, probs =1, na.rm=TRUE)) %>% 
  arrange(desc(mean))
#for group1
meanLabPos_n1 <- data %>% group_by(Glass) %>% 
  summarise(mean = mean(Light), quantl = quantile(Light, probs =1, na.rm=TRUE)) %>% 
  arrange(desc(mean))
meanLabPos_n1 %>% as.data.frame()
#for group2
meanLabPos_n2 <- data %>% group_by(temp_factor) %>% 
  summarise(mean = mean(Light), quantl = quantile(Light, probs =1, na.rm=TRUE)) %>% 
  arrange(desc(mean))

meanLabPos_n2 %>% as.data.frame()

#compare the mean
# tukey_df <- tukey_hsd(x=data, Light ~ Glass * temp_factor)
tukey_df_n <- TukeyHSD(av_n)
tukey_df_n
#get compact letter
clt_n <- multcompLetters4(av_n, tukey_df_n)
clt_n

#add compact letter to the mean table
clt_n1 <- as.data.frame.list(clt_n[[1]])
clt_n1$lab <- rownames(clt_n1)
clt_n2 <- as.data.frame.list(clt_n[[2]])
clt_n2$lab <- rownames(clt_n2)
clt_n3 <- as.data.frame.list(clt_n[[3]])
clt_n3$lab <- rownames(clt_n3)
clt_n1
clt_n2
clt_n3

meanLabPos_n$tkint <- clt_n3$Letters
meanLabPos_n1 <- left_join(meanLabPos_n1, clt_n1, by=c("Glass"="lab")) %>% select(1:7)
meanLabPos_n1 <- dplyr::rename(meanLabPos_n1, tk1=Letters)
meanLabPos_n2 <- left_join(meanLabPos_n2, clt_n2, by = c("temp_factor"="lab")) %>% select(1:8)
meanLabPos_n2 <- dplyr::rename(meanLabPos_n2, tk2=Letters)

x <- "Glass"
j <- "lab"
names(j) <- x

left_join(meanLabPos_n, clt_n1, by=j)
#plot: user has to choose the suitable plot
#bar
  #summary will be taken care when plotting: it will be similar with the meanLabPos
#interaction
ggplot(data, aes(Glass, Light, fill=temp_factor)) + 
  geom_boxplot()+ 
  # facet_wrap(temp_factor~.)+#optional
geom_text(data=meanLabPos_n, aes(x = Glass, y = quantl, label = tkint), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )
#group1
ggplot(data, aes(Glass, Light, fill=Glass)) + 
  geom_boxplot()+
  # facet_wrap(temp_factor ~.)+
  geom_text(data=meanLabPos_n1, aes(x = Glass, y = quantl, label = tk1), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )
#group2
ggplot(data, aes(temp_factor, Light, fill=temp_factor)) + 
  geom_boxplot()+
  # facet_wrap(Glass ~.)+
  geom_text(data=meanLabPos_n2, aes(x = temp_factor, y = quantl, label = tk2), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )
meanLabPos_n2
#bar
ggplot(meanLabPos_n2, aes(x=Glass, y= mean, fill= temp_factor)) +
  geom_bar(stat = "identity", position = "dodge")+
  geom_text(aes(label=tkint),position = position_dodge(0.90), size = 10, vjust=-1)+
  theme(
    axis.title.y = element_text(size = 5)
  )



#additive model: base aov()---------------------------------
# av <- anova_test(data= data, Light ~ Glass * temp_factor, type=2)
av <- aov(data= data, Light ~ Glass + temp_factor)
get_anova_table(anova_test(data= data, Light ~ Glass + temp_factor)) %>% as.data.frame()
av
summary(av)
summary(av_n)
# aov <- aov(data = data, value ~ species + sub)
# summary(aov)

#Determine the mean and position for labeling: use the two groups
meanLabPos1 <- data %>% group_by(Glass) %>% 
  summarise(mean = mean(Light), quantl = quantile(Light, probs =1, na.rm=TRUE)) %>% arrange(desc(mean))
meanLabPos1 %>% as.data.frame()
meanLabPos2 <- data %>% group_by(temp_factor) %>% 
  summarise(mean = mean(Light), quantl = quantile(Light, probs =1, na.rm=TRUE)) %>% arrange(desc(mean))
meanLabPos2 %>% as.data.frame()
#compare the mean
# tukey_df <- tukey_hsd(x=data, Light ~ Glass * temp_factor)
tukey_df <- TukeyHSD(av)
tukey_df
tukey_df_n
#get compact letter
clt <- multcompLetters4(av, tukey_df)
clt
clt_n

"Everything will be from the generateStat
1. av
2. meanLabPos
3. tukey_df
4. compact leter
Color will be separately derived
"
#add compact letter to the mean table
g1 <- as.data.frame.list(clt[[1]])
g2 <- as.data.frame.list(clt[[2]])
#convert rowname to column
g1$lab1 <- rownames(g1)
g2$lab2 <- rownames(g2)
#join
meanLabPos1 <- left_join(meanLabPos1, g1, by=c("Glass" = "lab1")) %>% select(1:6)
meanLabPos1 <- dplyr::rename(meanLabPos1, tk1 = Letters)

meanLabPos2 <- left_join(meanLabPos2, g2, by = c("temp_factor"="lab2")) %>% select(1:7)
meanLabPos2 <- dplyr::rename(meanLabPos2, tk2 = Letters)
#filter data
#use the original data
"1. group1 plot"
ggplot(data, aes(x=Glass, y=Light, fill=Glass))+
  geom_boxplot()+
  #change
  facet_wrap(temp_factor~.)+
  #change the label
  geom_text(data=meanLabPos1, aes(x = Glass, y=quantl, label=tk1), size = 10, vjust=-1)
"2. group2 plot"
#change x-axis
ggplot(data, aes(x=temp_factor, y=Light, fill=temp_factor))+
  geom_boxplot()+
  #change
  facet_wrap(Glass~.)+
  #change the x-axis and label
  geom_text(data=meanLabPos2, aes(x = temp_factor, y=quantl, label=tk2), size = 10, vjust=-1)


#plot: user has to choose the suitable plot
#bar
# #summary will be taken care when plotting: it will be similar with the meanLabPos
# data2 <- data %>% group_by(Glass, temp_factor) %>% summarise(mean = mean(Light), sd= sd(Light))
# data2
# meanLabPos
# ggplot(meanLabPos, aes(x=Glass, y= mean, fill= temp_factor)) +
#   geom_bar(stat = "identity", position = "dodge")+
#   geom_text(aes(label= Tukey),position = position_dodge(0.90), size = 10, vjust=-1)+
#   theme(
#     axis.title.y = element_text(size = 5)
#   )
# #boxplot not and ideal
# ggplot(data, aes(Glass, Light, fill=temp_factor)) + 
#   geom_boxplot()+
#   geom_text(data=meanLabPos, aes(x = Glass, y = quantl, label = Tukey), position = position_dodge(0.9), size = 10, vjust=-0.5)+
#   theme(
#     axis.title.y = element_text(size = 5)
#   )




#histogram---------------
data <- read_csv("~/Desktop/temp/bar_data.csv")
#count
#discrete data
ggplot(data, aes(x= species)) + stat_count()
ggplot(data, aes(x= species)) + geom_density(size = 0.2)
ggplot(data, aes(x= species)) + stat_count(position = 'dodge') #wouldn't change
ggplot(data, aes(x= species, fill=sub)) + stat_count(position = "dodge")
#continuous data
ggplot(data, aes(x= value, fill=sub)) + stat_bin(position = "dodge")
#use data as is
ggplot(data, aes(x= species, y=value)) + geom_col(position = "dodge")
ggplot(data, aes(x= species, y=value, fill=sub)) + geom_col(position = "dodge")

#stat_count(fill = "white")

#data---------------
# data <- read_csv("~/Desktop/bar_data.csv")
set.seed(50)
species <- rep(LETTERS[15:19], each = 2000, replace = TRUE)
rep(LETTERS[15:20], each = 5)
sub <- sample(letters[1:4], 10000, replace = TRUE)
# value <- sample(1:1000, 10000, replace = TRUE, prob = sample(c(0.25, 0.10, 0.50), 1000, replace = TRUE))
value1 <- sample(1:200, 2000, replace = TRUE, prob = sample(c(0.25, 0.10, 0.50), 200, replace = TRUE))
value2 <- sample(101:200, 2000, replace = TRUE, prob = sample(c(0.25, 0.10, 0.50), 100, replace = TRUE))
value3 <- sample(101:300, 2000, replace = TRUE, prob = sample(c(0.5, 0.15, 0.50), 200, replace = TRUE))
value4 <- sample(101:200, 2000, replace = TRUE, prob = sample(c(0.50, 0.15, 0.1), 100, replace = TRUE))
value5 <- sample(301:700, 2000, replace = TRUE, prob = sample(c(0.10, 0.05, 0.50), 400, replace = TRUE))
value <- c(value1, value2, value3, value4, value5)
data <- data.frame(species, sub, value)
# write.csv(data, "~/Desktop/bar_data.csv")
# anova: annotating to the plot -------------------------------------------------------------------
#base aov()
#One way anova
av_df <- aov(data = data, value ~ species)
summary(av_df)
tk <- TukeyHSD(av_df)
tk
ltr <- multcompLetters4(object = av_df, comp = tk)
ltr

newData <- data %>% group_by(species) %>% summarise(mean = mean(value, na.rm = TRUE), qtl = quantile(value, probs = 0.75)) %>%
  arrange(desc(mean))
ltr_df <- as.data.frame.list(ltr$species)
newData$yLabel <- ltr_df$Letters
newData
#two way anova
av_df <- aov(data = data, value ~ species*sub)
summary(av_df)
tk <- TukeyHSD(av_df)
tk
ltr <- multcompLetters4(object = av_df, comp = tk)

newData <- data %>% group_by(species, sub) %>% summarise(mean = mean(value, na.rm = TRUE), qtl = quantile(value, probs = 0.75)) %>%
  arrange(desc(mean))
newData
#bar plot--------------------------------
head(data)
#basic plot
bp <- ggplot(data, aes(x= sub)) + geom_bar(width = 0.1)
# ggplot(data, aes(x= species, y = value)) + geom_bar(stat="identity")
ggplot(data, aes(x= sub)) + geom_bar()
ggplot(data, aes(x= species)) + geom_bar()
# ggplot(data, aes(x= sub)) + geom_histogram(stat = "count")
ggplot(data, aes(x= sub, y = value)) + geom_bar(stat = "identity", position = "stack")
ggplot(data, aes(x= species, y = value)) + geom_bar(stat = "identity")

#to add error bar: first compute sd and use the data

erdata <- data %>% group_by(species, sub) %>% summarise(count = n(), sd = sd(value, na.rm = TRUE), newCol = mean(value, na.rm=TRUE))
erdata %>% as.data.frame()
#SD: geom_bar(stat=identity)
bp <- ggplot(erdata, aes(x= species, y = newCol, fill=sub)) + geom_bar(stat = "identity", position = "dodge")
 bp + geom_errorbar(width = 0.1, aes(ymin= newCol-sd, ymax = newCol+sd), position = position_dodge(width=0.9))
 
 summary_func <- function(x, col){
   c(mean = mean(x[[col]], na.rm=TRUE),
     sd = sd(x[[col]], na.rm=TRUE))
 }
 data_sum<-plyr::ddply(data, c(species,sub), .fun=summary_func,
                 value)
 
 data %>% count(sub)
head(ToothGrowth)
 
 erdata <- ToothGrowth %>% group_by(supp, as.factor(dose)) %>% summarise(count = n(), sd = sd(len, na.rm = TRUE), len = mean(len, na.rm=TRUE))
 erdata %>% as.data.frame()
 #SD: geom_bar(stat=identity)
 bp <- ggplot(erdata, aes(x=`as.factor(dose)`, y = len, fill = supp)) + geom_bar(stat = "identity", position = "dodge")
 bp + geom_errorbar(aes(ymin= len-sd, ymax = len+sd), width=.1, position = position_dodge(.9))
 
 #aes: fill
    #1. without sd: use dodge or stack 
    #2. with sd: use dodge
  #without sd
ggplot(data, aes(x= species, fill = sub)) + geom_bar(position = "dodge")
ggplot(data, aes(x= species, fill = sub)) + geom_bar(position = "stack")

  #with sd 
erdata <- data %>% group_by(species, sub) %>% summarise(count = n(), sd = sd(value, na.rm = TRUE), newCol = mean(value, na.rm=TRUE))
bp <- ggplot(erdata, aes(x= species, y = newCol, fill = sub)) + geom_bar(stat = "identity", position = "dodge")
 
 bp + geom_errorbar(aes(ymin= newCol-sd, ymax = newCol+sd), position = "dodge")
 

 

#stat
#low number of var, so need to combine both var
stat.test <- data %>% group_by(species, sub) %>% summarise(count = n(), sd = sd(value, na.rm = TRUE), newCol = mean(value, na.rm=TRUE)) %>%
  as.data.frame() %>% 
  t_test(count ~ sub) %>%
  adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>% add_xy_position(x = "sub")
stat.test

bp + stat_pvalue_manual(
  stat.test, label = "p.adj.signif", tip.length = 0.01, bracket.size = 1
)
stat.test <- data %>% group_by(species, sub) %>% summarise(count = n(), sd = sd(value, na.rm = TRUE), newCol = mean(value, na.rm=TRUE))
stat.test %>% as.data.frame() %>% t_test(count ~ sub)
stat.test %>% as.data.frame() %>% t_test(count ~ species)
?t_test
ggplot(data, aes(x= supp, y = len)) + geom_bar(stat = "prop")

?geom_bar
#box plot---------------------------------
data <- ToothGrowth
# gp2 <- ggplot(data, aes(x=as.factor(dose), y = len)) + geom_boxplot()
# gp <- ggplot(data, aes(x=dose, y = len, color = supp)) + geom_boxplot()
data$dose <- as.factor(data$dose)
ggplot(data, aes(x=dose, y = len)) + stat_boxplot(geom= 'errorbar', width = 0.5) + geom_boxplot(width=0.1)
gp <- ggplot(data, aes(x=dose, y = len)) + geom_boxplot()
  "Addition of other parameters will be taken care by plotFig() and setFig()"
  #stat for simple plot with no additional aesthetic
  stat.test <- data %>%
    #choose stat methods
    #formula: dependent (numeric) ~ independent (factor)
    #independent or categorical variables can be x-axis
    t_test(len ~ dose) %>% #group has to be x axis: specify: paired
    #add p adjusted value olumn to the data frame: by default, but user can omit
    adjust_pvalue(method = "bonferroni") %>%
    #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
    add_significance(p.col = "p.adj") %>%
  #determine and x and y position for labeling significance
    add_xy_position(x = "dose", dodge =0.08) #x = groupby variables or x-axis
  stat.test
  #add p value on the box plot
  gp + stat_pvalue_manual(
    stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1 #bracket size may require user inputs
  ) 
  data %>% t_test(len~dose)
 st<- data %>% t_test(len~dose, p.adjust.method = "fdr")

    #add p adjusted value column 
    st %>% adjust_pvalue(method = "bonferroni") %>%
    #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
    add_significance(p.col = .data[["p.adj"]]) %>%
    #determine and x and y position for labeling significance
    add_xy_position(x = "dose")
  

  
head(data)
  
  gp <- ggplot(data, aes(x=dose, y = len, fill = supp)) + geom_boxplot()
  #stat with additional aesthetic
  stat.test <- data %>%
    t_test(len ~ dose) %>% #x axis default:
    adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
    add_xy_position(x = "dose", dodge = 0.8) 
  stat.test
  gp + stat_pvalue_manual(
    stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1,
    inherit.aes = FALSE
  ) 
  #
  gp <- ggplot(data, aes(x=dose, y = len, fill = supp, linetype=dose)) + geom_boxplot()
  stat.test <- data %>%group_by(dose)%>%
   t_test(len ~ supp)%>%#, comparisons = list(c("0.5","2"), c("1","2"))) %>% #x axis default:
    adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
    add_xy_position(x = "dose", dodge = 0.8) 
  gp + stat_pvalue_manual(
    stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1,
    inherit.aes = FALSE
  ) 
  
  
  #group_by
  #applying statistics for the box plot
  #1. generate data for statistics
  #This is where additional parameters for statistic will be provided by the user
  stat.test <- data %>%
    #whether to group the variables: usually variable on x-axis 
    group_by(dose) %>% #if group by != None, than the chosen variable cannot be  provided in stat method
    #choose stat methods
    #formula: dependent (numeric) ~ independent (factor)
      #independent or categorical variables can be x-axis
    t_test(len ~ supp, ref.group = "OJ") %>% #specify: paired, ref.group, comparisons
    # t_test(len ~ supp, comparisons = list(c("OJ","VC"))) %>%
    #add p adjusted value olumn to the data frame: by default, but user can omit
    adjust_pvalue(method = "bonferroni") %>%
    #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
    add_significance(p.col = "p.adj")

as.data.frame(stat.test)
  #determine and x and y position for labeling significance
  stat.test <- stat.test %>%
    add_xy_position(x = "dose", dodge = 0.8) #x = groupby variables or x-axis
#add p value on the box plot
  firstPlot <- gp + stat_pvalue_manual(
    stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1 #bracket size may require user inputs
  ) 
  firstPlot
  firstPlot <- gp2 + stat_pvalue_manual(
    stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1 #bracket size may require user inputs
  ) 
  
  #pairwise comparisons: This should be user's choice
  #for pairwise comparisons: compute statistic again
  stat.test2 <- data %>% 
    #method: method will remain unchanged from the first computation
    # t_test(len ~ dose,ref.group = "0.5", p.adjust.method = "bonferroni")
    #numeric variable will remain unchange, but factor will be user's input or it should be x-axis
      #check: if it accept only x-axis than no need to provide option for formula
    t_test(len ~ dose, p.adjust.method = "bonferroni") 
  #determine x and y position for labeling significance
  stat.test2 <- stat.test2 %>% add_xy_position(x = "dose")
  #label the computed stat on the box plot
  firstPlot + stat_pvalue_manual(
    stat.test2, label = "p.adj.signif", tip.length = 0.01,  step.increase = 0.02
  ) 
  unique(data$dose)
  #for anova
 stat.aov <- data1 %>% #group_by(dose) %>%
   aov(data=., len ~ supp) %>% tukey_hsd()
   aov(data=., len ~ supp+dose) %>% tukey_hsd()
    anova_test(data=., len ~ supp+dose) %>% #tukey_hsd() %>% add_xy_position(x="dose")
   add_significance("p.adj")
 gp + stat_pvalue_manual(
   stat.aov,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1 #bracket size may require user inputs
 ) 

 
 #rough---------
 gp <- ggplot(data, aes(x=supp, y = len)) + geom_boxplot()
 stat.test <- data %>% t_test(len ~ supp) %>% adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
   add_xy_position(x = "supp", dodge =0.08) 
 
 stat.test
 gp + stat_pvalue_manual(
   stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1, bracket.nudge.y = 1 #bracket size may require user inputs
 ) 
 
 data %>% t_test(len ~ supp) %>% adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
   add_xy_position(x = "supp", dodge =0.08) 
 data %>% t_test(len ~ supp) %>% add_significance(p.col = "p") %>%
   add_xy_position(x = "supp", dodge =0.08) 
 
 gp <- ggplot(data, aes(x=dose, y = len)) + geom_boxplot()
 stat.test <- data %>% t_test(len ~ dose) %>% adjust_pvalue(method = "bonferroni") %>% add_significance(p.col = "p.adj") %>%
   add_xy_position(x = "dose", dodge =0.08) 
 stat.test
 gp + stat_pvalue_manual(
   stat.test,  label = "p.adj.signif", tip.length = 0.01, bracket.size = 1, bracket.nudge.y = 2 #bracket size may require user inputs
 ) 
 
 gp + stat_pvalue_manual(
   stat.test,  label = FALSE, tip.length = 0.01, bracket.size = 1 #bracket size may require user inputs
 ) 
 x <- data %>% t_test(len ~ supp)%>% 
   adjust_pvalue(method = "bonferroni") %>% add_significance(p.col="p.adj") %>%
   add_xy_position(x = "p.adf")
 as.data.frame(x)
 
  meth <- "t_test"
  x <- "supp"
  y <- "len"
  data %>%
    t_test(len ~ dose)
    #whether to group the variables: usually variable on x-axis 
    group_by(dose) %>% #if group by != None, than the chosen variable cannot be  provided in stat method
    #choose stat methods
    #formula: independent (numeric) ~ dependent (factor)
    #dependent can be x-axis
    # t_test(len ~ supp)
    t_test(formula = .data[[str2lang(y)]] ~ supp)
  
  data %>% select(.data[[str2lang(y)]])
  formula
  n  <- str2lang(y)
  ?t_test
    t_test(eval(str2expression(y)) ~ eval(str2expression(x)))
  ?str2lang
    t_test(y ~ x)
    t_test(eval(str2expression(y)) ~ eval(str2expression(x)))
  
    t_test(eval(str2expression(y)) ~ supp)
  n <- eval(str2expression(x))
    
  data %>% select(.data[[y]])
  data %>% select("len")
  head(data)
  data[,.data[[eval(str2expression(y))]]]
    
    
    js(data = .)
  
    js <- function(data= "data"){
      if(meth == "t_test"){
        t_test(data,len ~ supp, ref.group = "OJ")
      }else{
        anova_test(data,len ~ supp)
      }
      
    }
    
    
    x <- case_when(
      meth=="t_test" ~ t_test(data2,len ~ supp, ref.group = "OJ"),
      meth=="anova_test" ~ anova_test(data2,len ~ supp)
    )
  
    if(meth == "t_test"){ 
      t_test(.,len ~ supp, ref.group = "OJ")
    }else{
      anova_test(.,len ~ supp)
    }
  
    
  
    x <- switch("t_test",
    "t_test" = t_test(data, len ~ supp, ref.group = "OJ"),
    "anova" = anova_test(data, len ~ supp)
    )
  x
  
  
  data2 <- ToothGrowth
  data2$new <- data2$dose
  data2 %>% group_by(dose)
  data2
  x <- c("supp","dose")
  y <- c("new")
  data2 %>% str()
  data2 %>% mutate(across(c(x, y), factor)) %>% str()
  ?across
  class(sapply(data2[x], factor))
  data2[!!!rlang::syms(x)] <- as.factor(data2[!!!rlang::syms(x)])
  ?rlang::syms
  ?do.call
  data %>%
    group_by(dose) %>% 
    t_test(len ~ supp, ref.group = "OJ") %>% add_significance(p.col="p")
  # for anova
  
  # stat.test <- data %>%
  data %>%
    t_test(len ~ supp)%>% #specify: paired, ref.group, comparisons
    adjust_pvalue(method = "bonferroni")
  
  x %>% add_significance()
    # aov(len ~ supp, data = .) %>%
  # t_test(len ~ supp, comparisons = list(c("OJ","VC"))) %>%
    #add p adjusted value olumn to the data frame: by default, but user can omit
    tukey_hsd()
    add_xy_position()
  
  aov(len~supp, data = data)
  anova_test(data, len~supp)
  stat.test
  
  data %>%
    #whether to group the variables: usually variable on x-axis 
    group_by(dose) %>% #if group by != None, than the chosen variable cannot be  provided in stat method
    #choose stat methods
    #formula: independent (numeric) ~ dependent (factor)
    # t_test(data, len ~ supp, ref.group = "OJ", detailed = TRUE) %>%
    t_test( len ~ supp, ref.group = "OJ") %>%#specify: paired, ref.group, comparisons
    # t_test(len ~ supp, comparisons = list(c("OJ","VC"))) %>%
    #determine p adjusted value: by default, but user can omit
    adjust_pvalue(method = "bonferroni") %>%
    #show significance: default - p-adjusted value; user can opt for p-value
    add_significance("p.adj")
  
  #https://rpkgs.datanovia.com/rstatix/index.html
  #https://www.datanovia.com/en/blog/how-to-add-p-values-onto-a-grouped-ggplot-using-the-ggpubr-r-package/
  data %>% group_by(dose) 
  data %>%
    anova_test( len ~ supp*dose)
  
    adjust_pvalue(method = "bonferroni") %>%
    add_significance("p.adj")
  
  data$dose <- factor(data$dose)
  data %>% 
    aov(data=., len ~ supp+dose) %>% tukey_hsd()
    
  
  aov(len~supp, data = data) %>% tukey_hsd()
  library(rstatix)
  library(tidyverse)
  library(rlang)
  x <- c("OJ","VC")
  stat.test <- data %>%
    group_by(dose) %>% 
    t_test(len ~ supp, comparisons = list(!!!syms(x))) %>% 
    adjust_pvalue(method = "bonferroni") %>%
    add_significance("p.adj")
  stat.test
  
  lst <- list(1,2,3, c(345,56))
unlist(lst[4] )
#Rough-------------
data <- ToothGrowth
data$dose <- as.factor(data$dose)

av_n <- aov(data= data, len ~ dose * supp)
get_anova_table(anova_test(data= data, len ~ dose * supp)) %>% as.data.frame()
av_n
summary(av_n)
# aov <- aov(data = data, value ~ species + sub)
# summary(aov)

#Determine the mean and position for labeling: use the two groups
meanLabPos_n <- data %>% group_by(dose,supp) %>% 
  summarise(mean = mean(len), quantl = quantile(len, probs =1, na.rm=TRUE), sd= sd(len)) %>% 
  arrange(desc(mean))

meanLabPos_n %>% as.data.frame()

#compare the mean
# tukey_df <- tukey_hsd(x=data, Light ~ Glass * temp_factor)
tukey_df_n <- TukeyHSD(av_n)
tukey_df_n
#get compact letter
clt_n <- multcompLetters4(av_n, tukey_df_n)
clt_n

#add compact letter to the mean table
clt_n1 <- as.data.frame.list(clt_n[[1]])
clt_n1$lab <- rownames(clt_n1)
clt_n2 <- as.data.frame.list(clt_n[[2]])
clt_n2$lab <- rownames(clt_n2)
clt_n3 <- as.data.frame.list(clt_n[[3]])
clt_n3$lab <- rownames(clt_n3)
clt_n1
clt_n2
clt_n3

meanLabPos_n$tkint <- clt_n3$Letters
meanLabPos_n2 <- left_join(meanLabPos_n, clt_n1, by=c("dose"="lab")) %>% select(1:7)
meanLabPos_n2 <- dplyr::rename(meanLabPos_n2, tk1=Letters)
meanLabPos_n2 <- left_join(meanLabPos_n2, clt_n2, by = c("supp"="lab")) %>% select(1:8)
meanLabPos_n2 <- dplyr::rename(meanLabPos_n2, tk2=Letters)

x <- "Glass"
j <- "lab"
names(j) <- x

left_join(meanLabPos_n, clt_n1, by=j)
#plot: user has to choose the suitable plot
#bar
#summary will be taken care when plotting: it will be similar with the meanLabPos
#interaction
ggplot(data, aes(dose, len, fill=supp)) + 
  geom_boxplot()+ 
  # facet_wrap(temp_factor~.)+#optional
  geom_text(data=meanLabPos_n2, aes(x = dose, y = quantl, label = tkint), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )

ggplot(data, aes(dose, len, fill=supp)) + 
  geom_boxplot()+
  facet_wrap(supp ~.)+
  geom_text(data=meanLabPos_n2, aes(x = dose, y = quantl, label = tk1), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )
ggplot(data, aes(supp, len, fill=dose)) + 
  geom_boxplot()+
  facet_wrap(dose ~.)+
  geom_text(data=meanLabPos_n2, aes(x = supp, y = quantl, label = tk2), position = position_dodge(0.9), size = 10, vjust=-0.5)+
  theme(
    axis.title.y = element_text(size = 5)
  )


meanLabPos_n2
#bar
ggplot(meanLabPos_n2, aes(x=Glass, y= mean, fill= temp_factor)) +
  geom_bar(stat = "identity", position = "dodge")+
  geom_text(aes(label=tkint),position = position_dodge(0.90), size = 10, vjust=-1)+
  theme(
    axis.title.y = element_text(size = 5)
  )
