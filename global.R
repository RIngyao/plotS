# path2 <- "~/Documents/Temporary/git/srlab_database"
path2 <- "~/Documents/Jajo/git/srlab_database/"

path <- "/Volumes/Dr_Saurabh_epigenome/bis-files/jajo/analysis/repository/"
#library--------------------------------
options(shiny.maxRequestSize = 50*1024^2)
# library(coin)
# library(rcompanion)
# install.packages("Hmisc")
# install.packages("skimr")
# install.packages("svglite")
library(svglite)
library(MASS)
library(skimr)
library(shiny)
library(coin)
library(DT)
library(data.table)
library(shinydashboard)
library(tidyverse)
library(shinyjs)
library(reactable)
library(GenomicRanges)
library(bslib)
library(shinyWidgets)
library(readxl)
library(shinyFeedback)
library(shinyvalidate)
library(shinyauthr)
library(rstatix)
#remotes::install_github("paulc91/shinyauthr")
library(shinyauthr)
if(!require(ggpubr)){
  # install.packages("ggpubr")
  require(ggpubr)
}
if(!require(multcompView)){
  # install.packages("multcompView")
  require(multcompView)
}else{require(multcompView)}

# install.packages("multcompView")
# library(sodium) #implement later
#file path

# path <- "/repository/"
#Methylation--------------------------------------------------------

#single:IR64
si_ir_panicle_c <- paste0(path,"methylation/single_ir64_panicle_control.rds")
si_ir_flag_c <- paste0(path,"methylation/single_ir64_flagLeaf_control.rds")
si_ir_root_c <- paste0(path,"methylation/single_ir64_root_control.rds")
si_ir_panicle_s <- paste0(path,"methylation/single_ir64_panicle_stress.rds")
si_ir_flag_s <- paste0(path,"methylation/single_ir64_flagLeaf_stress.rds")
si_ir_root_s <- paste0(path,"methylation/single_ir64_root_stress.rds")
#single:N22
si_n_panicle_c <- paste0(path,"methylation/single_n22_panicle_control.rds")
si_n_flag_c <- paste0(path,"methylation/single_n22_flagLeaf_control.rds")
si_n_root_c <- paste0(path,"methylation/single_n22_root_control.rds")
si_n_panicle_s <- paste0(path,"methylation/single_n22_panicle_stress.rds")
si_n_flag_s <- paste0(path,"methylation/single_n22_flagLeaf_stress.rds")
si_n_root_s <- paste0(path,"methylation/single_n22_root_stress.rds")
#DMR:IR64
dmr_ir_panicle <- paste0(path,"methylation/dmr_ir_panicle.rds")
dmr_ir_flag <- paste0(path,"methylation/dmr_ir_flagLeaf.rds")
dmr_ir_root <- paste0(path,"methylation/dmr_ir_root.rds")
#DMR:N22
dmr_n_panicle <- paste0(path,"methylation/dmr_n22_panicle.rds")
dmr_n_flag <- paste0(path,"methylation/dmr_n22_flagLeaf.rds")
dmr_n_root <- paste0(path,"methylation/dmr_n22_root.rds")

#Histone----------------------------------------------------
#significant:H3k4
k4_ir_panicle_c <- paste0(path,"histone/h3k4me3_ir_panicle_c.txt") #sheet=7
k4_ir_flag_c <- paste0(path,"histone/h3k4me3_ir_flag_c.txt")#sheet=5
k4_n_panicle_c <- paste0(path,"histone/h3k4me3_n_panicle_c.txt") #sheet=3
k4_n_flag_c <- paste0(path,"histone/h3k4me3_n_flag_c.txt")#sheet=1

k4_ir_panicle_s <- paste0(path,"histone/h3k4me3_ir_panicle_s.txt") #sheet=8
k4_ir_flag_s <- paste0(path,"histone/h3k4me3_ir_flag_s.txt")#sheet=6
k4_n_panicle_s <- paste0(path,"histone/h3k4me3_n_panicle_s.txt") #sheet=4
k4_n_flag_s <- paste0(path,"histone/h3k4me3_n_flag_s.txt")#sheet=2

#significant: H3K9
k9_ir_panicle_c <- paste0(path,"histone/h3k9ac_ir_panicle_c.txt")#sheet =7
k9_ir_flag_c <- paste0(path,"histone/h3k9ac_ir_flag_c.txt")#sheet =5
k9_n_panicle_c <- paste0(path,"histone/h3k9ac_n_panicle_c.txt")#sheet =3
k9_n_flag_c <- paste0(path,"histone/h3k9ac_n_flag_c.txt")#sheet =1

k9_ir_panicle_s <- paste0(path,"histone/h3k9ac_ir_panicle_s.txt")#sheet =8
k9_ir_flag_s <- paste0(path,"histone/h3k9ac_ir_flag_s.txt")#sheet =6
k9_n_panicle_s <- paste0(path,"histone/h3k9ac_n_panicle_s.txt")#sheet =4
k9_n_flag_s <- paste0(path,"histone/h3k9ac_n_flag_s.txt")#sheet =2

#significant: H3k27
k27_ir_panicle_c <- paste0(path,"histone/h3k27me3_ir_panicle_c.txt")#sheet =7
k27_ir_flag_c <- paste0(path,"histone/h3k27me3_ir_flag_c.txt")#sheet =5
k27_n_panicle_c <- paste0(path,"histone/h3k27me3_n_panicle_c.txt")#sheet =3
k27_n_flag_c <- paste0(path,"histone/h3k27me3_n_flag_c.txt")#sheet =1

k27_ir_panicle_s <- paste0(path,"histone/h3k27me3_ir_panicle_s.txt")#sheet =8
k27_ir_flag_s <- paste0(path,"histone/h3k27me3_ir_flag_s.txt")#sheet =6
k27_n_panicle_s <- paste0(path,"histone/h3k27me3_n_panicle_s.txt")#sheet =4
k27_n_flag_s <- paste0(path,"histone/h3k27me3_n_flag_s.txt")#sheet =2

#differential
hist_diff <- paste0(path,"histone/DIFF-PEAKS-FOR-DATABASE.xlsx") 

#Transcriptome------------------------------------------------------------
fpkm <- paste0(path,"transcriptome/transcriptome-data-for-database.xlsx")


#miRNA notation list------------------------------------------------------
#store this in mysql
miRlist <- structure(list(name = c("miR156a", "miR156b-5p", "miR156b-3p", 
                                   "miR156c-5p", "miR156c-3p", "miR156d", "miR156e", "miR156f-5p", 
                                   "miR156f-3p", "miR156g-5p", "miR156g-3p", "miR156h-5p", "miR156h-3p", 
                                   "miR156i", "miR156j-5p", "miR156j-3p", "miR160a-5p", "miR160a-3p", 
                                   "miR160b-5p", "miR160b-3p", "miR160c-5p", "miR160c-3p", "miR160d-5p", 
                                   "miR160d-3p", "miR162a", "miR164a", "miR164b", "miR166a-5p", 
                                   "miR166a-3p", "miR166b-5p", "miR166b-3p", "miR166c-5p", "miR166c-3p", 
                                   "miR166d-5p", "miR166d-3p", "miR166e-5p", "miR166e-3p", "miR166f", 
                                   "miR167a-5p", "miR167a-3p", "miR167b", "miR167c-5p", "miR167c-3p", 
                                   "miR169a", "miR171a", "miR393a", "miR394", "miR395b", "miR395d", 
                                   "miR395e", "miR395g", "miR395h", "miR395i", "miR395j", "miR395k", 
                                   "miR395l", "miR395s", "miR395t", "miR395c", "miR395a", "miR395f", 
                                   "miR395u", "miR396a-5p", "miR396a-3p", "miR396b-5p", "miR396b-3p", 
                                   "miR396c-5p", "miR396c-3p", "miR397a", "miR397b", "miR398a", 
                                   "miR398b", "miR399a", "miR399b", "miR399c", "miR399d", "miR399e", 
                                   "miR399f", "miR399g", "miR399h", "miR399i", "miR399j", "miR399k", 
                                   "miR156k", "miR156l-5p", "miR156l-3p", "miR159a.2", "miR159a.1", 
                                   "miR159b", "miR159c", "miR159d", "miR159e", "miR159f", "miR319a-5p", 
                                   "miR319a-3p", "miR319a-3p.2-3p", "miR319b", "miR160e-5p", "miR160e-3p", 
                                   "miR160f-5p", "miR160f-3p", "miR162b", "miR164c", "miR164d", 
                                   "miR164e", "miR166k-5p", "miR166k-3p", "miR166l-5p", "miR166l-3p", 
                                   "miR167d-5p", "miR167d-3p", "miR167e-5p", "miR167e-3p", "miR167f", 
                                   "miR167g", "miR167h-5p", "miR167h-3p", "miR167i-5p", "miR167i-3p", 
                                   "miR168a-5p", "miR168a-3p", "miR168b", "miR169b", "miR169c", 
                                   "miR169d", "miR169e", "miR169f.2", "miR169f.1", "miR169g", "miR169h", 
                                   "miR169i-5p.2", "miR169i-5p.1", "miR169i-3p", "miR169j", "miR169k", 
                                   "miR169l", "miR169m", "miR169n", "miR169o", "miR169p", "miR169q", 
                                   "miR171b", "miR171c-5p", "miR171c-3p", "miR171d-5p", "miR171d-3p", 
                                   "miR171e-5p", "miR171e-3p", "miR171f-5p", "miR171f-3p", "miR171g", 
                                   "miR172a", "miR172b", "miR172c", "miR166g-5p", "miR166g-3p", 
                                   "miR166h-5p", "miR166h-3p", "miR166i-5p", "miR166i-3p", "miR171h", 
                                   "miR393b-5p", "miR393b-3p", "miR408-5p", "miR408-3p", "miR172d-5p", 
                                   "miR172d-3p", "miR171i-5p", "miR171i-3p", "miR167j", "miR166m", 
                                   "miR166j-5p", "miR166j-3p", "miR164f", "miR413", "miR414", "miR415", 
                                   "miR416", "miR417", "miR418", "miR419", "miR426", "miR435", "miR437", 
                                   "miR438", "miR390-5p", "miR390-3p", "miR439a", "miR439b", "miR439c", 
                                   "miR439d", "miR439e", "miR439f", "miR439g", "miR439h", "miR439i", 
                                   "miR440", "miR396e-5p", "miR396e-3p", "miR443", "miR444a-5p", 
                                   "miR444a-3p.2", "miR444a-3p.1", "miR528-5p", "miR528-3p", "miR529a", 
                                   "miR530-5p", "miR530-3p", "miR531a", "miR535-5p", "miR535-3p", 
                                   "miR395m", "miR395n", "miR395o", "miR395p", "miR395q", "miR395v", 
                                   "miR395w", "miR395r", "miR810a", "miR812a", "miR812b", "miR812c", 
                                   "miR812d", "miR812e", "miR814a", "miR814b", "miR814c", "miR815a", 
                                   "miR815b", "miR815c", "miR816", "miR817", "miR818a", "miR818b", 
                                   "miR818c", "miR818d", "miR818e", "miR820a", "miR820b", "miR820c", 
                                   "miR821a", "miR821b", "miR821c", "miR529b", "miR1423-5p", "miR1423-3p", 
                                   "miR1424", "miR1425-5p", "miR1425-3p", "miR1426", "miR1427", 
                                   "miR1428a-5p", "miR1428a-3p", "miR1429-5p", "miR1429-3p", "miR1430", 
                                   "miR1431", "miR1432-5p", "miR1432-3p", "miR169r-5p", "miR169r-3p", 
                                   "miR444b.2", "miR444b.1", "miR444c.2", "miR444c.1", "miR444d.3", 
                                   "miR444d.2", "miR444d.1", "miR444e", "miR444f", "miR810b.1", 
                                   "miR810b.2", "miR1435", "miR1436", "miR1437a", "miR1438", "miR1440a", 
                                   "miR1441", "miR1442", "miR1439", "miR531b", "miR1846d-5p", "miR1846d-3p", 
                                   "miR1847.1", "miR1847.2", "miR1848", "miR1849", "miR1850.1", 
                                   "miR1850.2", "miR1850.3", "miR1851", "miR1852", "miR1853-5p", 
                                   "miR1853-3p", "miR1854-5p", "miR1854-3p", "miR1855", "miR1856", 
                                   "miR1857-5p", "miR1857-3p", "miR1428b", "miR1428c", "miR1428d", 
                                   "miR1428e-5p", "miR1428e-3p", "miR1858a", "miR1858b", "miR1846a-5p", 
                                   "miR1846a-3p", "miR1846b-5p", "miR1846b-3p", "miR1859", "miR1860-5p", 
                                   "miR1860-3p", "miR1861a", "miR1861b", "miR1861c", "miR1861d", 
                                   "miR1861e", "miR1861f", "miR1861g", "miR1861h", "miR1861i", "miR1861j", 
                                   "miR1861k", "miR1861l", "miR1861m", "miR1861n", "miR1862a", "miR1862b", 
                                   "miR1862c", "miR1863a", "miR1864", "miR1865-5p", "miR1865-3p", 
                                   "miR1866-5p", "miR1866-3p", "miR1868", "miR812f", "miR1869", 
                                   "miR1870-5p", "miR1870-3p", "miR1871", "miR1872", "miR1873", 
                                   "miR1874-5p", "miR1874-3p", "miR1875", "miR1862d", "miR1876", 
                                   "miR1862e", "miR1877", "miR1878", "miR1879", "miR1880", "miR1881", 
                                   "miR1882a", "miR1882b", "miR1882c", "miR1882d", "miR1882e-5p", 
                                   "miR1882e-3p", "miR1882f", "miR1882g", "miR1882h", "miR812g", 
                                   "miR812h", "miR812i", "miR812j", "miR1883a", "miR1883b", "miR1319a", 
                                   "miR1320-5p", "miR1320-3p", "miR1846c-5p", "miR1846c-3p", "miR2055", 
                                   "miR827", "miR1846e", "miR1428f-5p", "miR1428g-5p", "miR2090", 
                                   "miR2091-5p", "miR2091-3p", "miR2092-5p", "miR2092-3p", "miR2093-5p", 
                                   "miR2093-3p", "miR2094-5p", "miR2094-3p", "miR2095-5p", "miR2095-3p", 
                                   "miR2096-5p", "miR2096-3p", "miR2097-5p", "miR2097-3p", "miR2098-5p", 
                                   "miR2098-3p", "miR2099-5p", "miR2099-3p", "miR2100-5p", "miR2100-3p", 
                                   "miR2101-5p", "miR2101-3p", "miR2102-5p", "miR2102-3p", "miR396f-5p", 
                                   "miR396f-3p", "miR2103", "miR2104", "miR2105", "miR2106", "miR2120", 
                                   "miR2121a", "miR2121b", "miR2122", "miR2118a", "miR2118b", "miR2118c", 
                                   "miR2118d", "miR2118e", "miR2118f", "miR2118g", "miR2118h", "miR2118i", 
                                   "miR2118j", "miR2118k", "miR2118l", "miR2118m", "miR2118n", "miR2118o", 
                                   "miR2118p", "miR2118q", "miR2118r", "miR2275a", "miR2275b", "miR2863a", 
                                   "miR2864.1", "miR2864.2", "miR2865", "miR2866", "miR2867-5p", 
                                   "miR2867-3p", "miR2868", "miR2869", "miR2870", "miR2863b", "miR2905", 
                                   "miR2871a-5p", "miR2871a-3p", "miR2871b-5p", "miR2871b-3p", "miR2872", 
                                   "miR2873a", "miR2874", "miR2875", "miR2876-5p", "miR2876-3p", 
                                   "miR2877", "miR2878-5p", "miR2878-3p", "miR1863c", "miR2879", 
                                   "miR2880", "miR396g", "miR396h", "miR396d", "miR1863b", "miR1863b.2", 
                                   "miR2907a", "miR2907b", "miR2907c", "miR2907d", "miR2918", "miR2919", 
                                   "miR2920", "miR2921", "miR2922", "miR2923", "miR2924", "miR2925", 
                                   "miR2926", "miR2927", "miR2928", "miR2929", "miR2930", "miR2931", 
                                   "miR2932", "miR395x", "miR395y", "miR812k", "miR812l", "miR812m", 
                                   "miR1862f", "miR1862g", "miR3979-5p", "miR3979-3p", "miR3980a-5p", 
                                   "miR3980a-3p", "miR3980b-5p", "miR3980b-3p", "miR812n-5p", "miR812n-3p", 
                                   "miR812o-5p", "miR812o-3p", "miR3981-5p", "miR3981-3p", "miR2873b", 
                                   "miR3982-5p", "miR3982-3p", "miR5071", "miR5072", "miR5073", 
                                   "miR5074", "miR5075", "miR5076", "miR5077", "miR5078", "miR5079a", 
                                   "miR5080", "miR5081", "miR5082", "miR5083", "miR5143a", "miR5144-5p", 
                                   "miR5144-3p", "miR5145", "miR5146", "miR5147", "miR2863c", "miR5148a", 
                                   "miR5148b", "miR5148c", "miR5149", "miR5150-5p", "miR5150-3p", 
                                   "miR5151", "miR5152-5p", "miR5152-3p", "miR5153", "miR5154", 
                                   "miR5155", "miR5156", "miR5157a-5p", "miR5157a-3p", "miR5157b-5p", 
                                   "miR5157b-3p", "miR5158", "miR5159", "miR5160", "miR5161", "miR5162", 
                                   "miR5337a", "miR5338", "miR5339", "miR5340", "miR5484", "miR5485", 
                                   "miR5486", "miR5487", "miR5488", "miR5489", "miR5490", "miR5491", 
                                   "miR5492", "miR5493", "miR5494", "miR5495", "miR5496", "miR5497", 
                                   "miR5498", "miR5499", "miR5500", "miR5501", "miR5502", "miR5503", 
                                   "miR5504", "miR5505", "miR5506", "miR5507", "miR5508", "miR5509", 
                                   "miR5510", "miR5511", "miR5512a", "miR5513", "miR2275c", "miR5514", 
                                   "miR5515", "miR5516a", "miR5517", "miR5518", "miR5519", "miR5521", 
                                   "miR5522", "miR5523", "miR2275d", "miR5524", "miR5525", "miR5526", 
                                   "miR5527", "miR5528", "miR5529", "miR5530", "miR5531", "miR5532", 
                                   "miR5533", "miR5534a", "miR5534b", "miR5535", "miR5536", "miR5537", 
                                   "miR5538", "miR5539a", "miR5540", "miR5541", "miR5542", "miR5543", 
                                   "miR5544", "miR5788", "miR812p", "miR812q", "miR5789", "miR5790", 
                                   "miR5791", "miR5792", "miR5793", "miR5794", "miR812r", "miR5795", 
                                   "miR5796", "miR5797", "miR5798", "miR812s", "miR5799", "miR5800", 
                                   "miR5801a", "miR5802", "miR812t", "miR812u", "miR5803", "miR5804", 
                                   "miR5805", "miR5806", "miR812v", "miR5807", "miR5801b", "miR5809", 
                                   "miR5810", "miR5811", "miR5812", "miR5813", "miR5814", "miR5815", 
                                   "miR5816", "miR5143b", "miR5817", "miR5818", "miR5819", "miR5820", 
                                   "miR5821", "miR5822", "miR5823", "miR5824", "miR1319b", "miR5825", 
                                   "miR5826", "miR5827", "miR5828", "miR5829", "miR5830", "miR5831", 
                                   "miR5179", "miR5832", "miR5833", "miR5834", "miR5835", "miR2873c", 
                                   "miR5836", "miR5837.2", "miR5837.1", "miR5516b", "miR6245", "miR1440b", 
                                   "miR6246", "miR6247", "miR6248", "miR5337b", "miR6249a", "miR5512b", 
                                   "miR6250", "miR6251", "miR6252", "miR6253", "miR6254", "miR6255", 
                                   "miR6256", "miR818f", "miR1437b-5p", "miR1437b-3p", "miR7692-5p", 
                                   "miR7692-3p", "miR7693-5p", "miR7693-3p", "miR7694-5p", "miR7694-3p", 
                                   "miR7695-5p", "miR7695-3p", "miR1861o", "miR5079b", "miR5539b", 
                                   "miR6249b", "miR531c", "miR11336-5p", "miR11336-3p", "miR11337-5p", 
                                   "miR11337-3p", "miR11338-5p", "miR11338-3p", "miR11339-5p", "miR11339-3p", 
                                   "miR11340-5p", "miR11340-3p", "miR11341-5p", "miR11341-3p", "miR11342-5p", 
                                   "miR11342-3p", "miR11343-5p", "miR11343-3p", "miR11344-5p", "miR11344-3p", 
                                   "miR2120b-5p", "miR2120b-3p", "miR5801c-5p", "miR5801c-3p", "miR6245b-5p", 
                                   "miR6245b-3p")), class = "data.frame", row.names = c(NA, -738L
                                   ))

#prefix 'osa-' to the name
miRlist$name <- paste0("osa-",miRlist$name)

#upload size permission
shiny.maxRequestSize = 50 * 1024^2 #50MB


head(miRlist)
#attendance table------------
# createAttendance <- function(){
#   colname2 <- c("name","date","month","entry time","exit time", "year")
#   attendanceFile <- data.frame(matrix(nrow = 1, ncol = length(colname2)))
#   colnames(attendanceFile) <- colname2
#   saveRDS(attendanceFile, paste0(path2,"/www/attendanceFile.rds"))
# }
# createAttendance()
# createStudent <- function(){
#   colname1 <- c("name", "uid", "pid")
#   student <- data.frame(matrix(nrow = 1, ncol = length(colname1)))
#   colnames(student) <- colname1
#   saveRDS(student, paste0(path2,"/www/student.rds"))
# }
#  createStudent()
student <- readRDS(paste0(path2,"/www/student.rds"))
attendanceFile <- readRDS(paste0(path2,"/www/attendanceFile.rds"))

#Objects necesary to create---------------
#plot that require x and y-axis
xyRequire <- c("box", "bar", "line", "scatter", "Violine plot") 
NS_methods <- list(Normalization= c("log2", "log10", "square-root", "box-cox"), Standardization = c("scale","") )

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
#function to get all variables: numeric and characters----------------------------------
#get all numeric or character variables
"
Function to determine the names of either numeric or character variables present in the data
checks = character. use 'integer' for numeric variable or 'character' for character variable
data = dataframe.
"
#i have use data.table (fread), so it will be integer, instead of numeric
allNumCharVar <- function(checks = "integer", data = "ptable()"){
  #get the data types of the column in the data frame
  varClass <- sapply(data, class)
  #filter the df based on the provided data type
  if(checks %in% c("integer", "numeric", "double")){
    var <- data[ varClass %in% c("integer", "numeric", "double") ]
  }else{
    var <- data[varClass == checks]
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
    message(var)
    ifelse(length(var) >= 2, var[index], var[1])
  }
}
# 
# x <- fread("~/Desktop/temp/bar_data.csv") %>% as.data.frame()
# x <- read_csv("~/Desktop/temp/bar_data.csv") 
# str(x)
# sapply(x, class)
# selectedVar2(data= x, check = "", index = 1)
# head(ToothGrowth)
# ins <- 1
# x[4]
# y <- c(1,2,3)
# y[4]
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
  if(ns_method == "log2"){ 
  
    new_df <- data %>% mutate( log2 = log2(.data[[y]]) )
    
  }else if(ns_method == "log10"){
  
    new_df <- data %>% mutate( log10 = log10(.data[[y]]) ) #log10(y)
    
  }else if(ns_method == "square-root"){
  
    new_df <- data %>% mutate( sqrt = sqrt(.data[[y]]) )#sqrt(y)
    
  }else if(ns_method == "box-cox"){
    #determine model
    # I have considered only the variable of x-axis while using the model
    # and ignored other independent variables provided in aesthetics.
    # Reason: so that I can display both the original and the transformed data 
    # in the organized table panel.
    message("run lm")
    message(y)
    message(x)
    models <- lm(formula = formula(eval(str2expression(y)) ~ eval(str2expression(x))), data = data)
    message("done lm2")
    message(models)
    #run boxcox
    # browser()
    bc <- MASS::boxcox(models, plotit = FALSE, na.action = NULL)
    
    message('get optimal lambda')
    #optimal lambda value
    opt_lba <- bc$x[which.max(bc$y)]
    message("transform")
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
      message(glue::glue("oName:{oName}"))
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
  
  message(glue::glue("ndf heres: {colnames(nDf)}"))
  message(nDf)
  return(nDf)
}

#replicate related function--------------------
"
Function to re-arrange replicates of each group/variable provided by the user.
It will processed the replicates only for one group at a time, not multiple groups.

arguments:
x = dataframe. data with both non-replicate and replicate column
y = dataframe. data with only non-replicate column. 
colName = character. Column name. To be used for the  tidied data
headerNo = numeric. row index of header used in the table. numeric sequence.
colNo = numeric. column index for the replicates of each group. It can be vector or range
stp = numeric. range from 0 to 1. 0 to process and 1 to stop processing 
      non-replicate columns
"
#colNo = numeric. column index for the replicates of each group. It can be range or vector
tidyReplicate <- function(x, y, headerNo = 1:2, colName= "column_name", colNo = c(2,3), stp=0){
  #First process the data for non replicate column and then for replicate column
  # browser()
  #non-replicate column: May not always be in character column when in proper format
  # later some column may have to be converted to numeric
  # and tidied data will be appended to this data
  # browser()
  if(stp == 0){
    
    #get column name from the header 
    if(!is_empty(y)){
      
      #get the header
      print(headerNo)
      message(y[headerNo, ])
      headr <- y[headerNo, ,drop=FALSE] %>% as.data.frame()
      message(headr)
      message(colnames(headr))
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
        message(head(y_headRe))
        
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
            message(headr[,i])
            if( all(is.na(headr[,i])) ){
              getName[i] <- paste0("Var",i)
            }else if( any(is.na(headr[,i])) ){
              
              #check whether there is any row with name for all the columns
              # if so, use that row as column  name
              noNaRow <- as.character()
              for(i in headerNo){
                if(all(!is.na(headr[i,]))){
                  
                  message(headr[i,])
                  #check for one more condition: skip row that starts with ..number in more 
                  # than one column (this are default header added while uploading data)
                  if( any( isTRUE(str_detect(headr[i,], regex("^\\.+[:digit:]"))) ) ){
                    next
                  }else{
                    message(headr[i,])
                    noNaRow <- headr[i,]
                  }
                  message(noNaRow)
                }
              }
              
              if(!is_empty(noNaRow)){
                message(noNaRow)
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
                if(any( isTRUE(str_detect(headr[n,], regex("^\\.+[:digit:]"))) ) ){
                  next
                }else{
                  message(headr[n,i])
                  #get the first name
                  getName[i] <- headr[n,i] 
                  break #get out of the nested loop
                }
              }
              
            }
          }
          
        }#end of for loop
        message(getName)
        message(str(getName))
        colnames(y_headRe) <- getName
        
      }
      message(y_headRe)
      message(colnames(y_headRe))
      #check wether data needs to be converted back to numeric as it should be in the original data provided
      # by the user
      for(i in seq_len(ncol(y_headRe))){
        message(head(y_headRe[,i]))
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
  message(colnames(x))
  message(colNo)
  message(str(x))
  
  x2 <- x[, colNo]
  #remove the header
  x2 <- x2[-c(headerNo),] %>% as.data.frame() # all columns will be present
  
  message("replicate selection")
  # convert to numeric
  onlyNumeric <- x2 %>% as.data.frame() %>% mutate_if(is.character, as.numeric)  #%>% as_tibble()
  
  
  # browser()
  
  
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
  #Reshape the data: keep replicate row-wise i.e. longer format (pivot_longer())
  message(colName)
  message(str(colName))
  message(colnames(onlyNumeric))
  message(newDf)
  message(str(newDf))
  colnames(newDf)
  newDf2 <- pivot_longer(newDf, cols = colnames(onlyNumeric), names_to = "replicates", values_to = colName)
  message("reshape done inside replicate func")
  message(head(newDf2))
  rownames(newDf2) <- NULL
  
  return(newDf2)
  
}

# "
# Old version: 
# Reason for rejection: some columns were missing after the final output

# Function to re-arrange replicates of each group/variable provided by the user.
# It will processed the replicates only for one group at a time, not multiple groups.
# 
# arguments:
# x = dataframe. data to apply the function
# colName = character. Column name. To be used for the  tidied data
# headerNo = numeric. row index of header used in the table.
# colNo = numeric. column index for the replicates of each group. It can be range or vector
# "
# tidyReplicate <- function(x=data, headerNo = 1:2, colName= "column_name", colNo=2:4){
#   
#   #For now, every elements in the data are in character
#   #remove the header
#   message("inside func3")
#   headerRemoved <- x[-c(headerNo),] %>% as.data.frame() # all columns will be present
#   message("headerRemoved")
#   message(glue::glue("headerRemoved: {head(headerRemoved)}"))
#   
#   #non-replicate column: It will be a character column when in proper format
#   # later tidied data will be appended to this data
#   message("nonnumeric")
#   #empty data frame to catch the character column
#   noNumeric <- data.frame()
#   colIndx <- 0 #empty index to get the header name later
#   
#   #Check whether the character columns should be a character or numeric
#   # and keep only the column that has to be character.
#   for(i in seq_len(ncol(headerRemoved))){
#     if( any(str_detect( headerRemoved[,i],regex('[a-zA-Z]') ) ) ){
#       if(length(colIndx) == 1 && colIndx == 0){
#         colIndx <- i
#       }else{
#         colIndx <- c(colIndx, i)
#       }
#       
#       if(is_empty(noNumeric)){
#         noNumeric <- headerRemoved[,i, drop=FALSE]  
#       }else{
#         col_n <- colnames(headerRemoved[,i, drop =FALSE])
#         noNumeric[, col_n] <- headerRemoved[,i]
#       }
#       
#     }
#   }
#   
#   message(head(noNumeric))
#   #get column name from the header 
#   if(!is_empty(noNumeric)){
#     
#     #get the header
#     headr <- x[headerNo, c(colIndx)] %>% as.data.frame()
#     message("if statment")
#     if(all(is.na(headr))){
#       
#       #if all is na i.e. no header name was given in the table.
#       #generate new column name
#       col_n <- ncol(noNumeric)
#       message("inside if")
#       colnames(noNumeric) <- paste0("variable",1:col_n)
#       message(head(noNumeric))
#       
#     }else{
#       message("header present")
#       #if header is included in the table, use the name and re-format in proper order
#       getName <- headr[!is.na(headr)]
#       colnames(noNumeric) <- getName[1]
#       
#     }
#     
#   }
#   
#   message("replicate selection")
#   #select only the column specified as replicates: colNo
#   df <- headerRemoved[, c(colNo)]
#   message(colnames(df))
#   # convert to numeric
#   message("converting to numeric")
#   onlyNumeric <- df %>% as.data.frame() %>% mutate_if(is.character, as.numeric)  #%>% as_tibble()
#   
#   message("converted to numeric")
#   message(head(onlyNumeric))
#   message(str(onlyNumeric))
#   # browser()
#   #generate and add column names
#   nn <- ncol(onlyNumeric)
#   colnames(onlyNumeric) <- paste0("Replicate_",1:nn)
#   message("merge")
#   #merge the noNumeric (character column) and onlyNumeric (replicate column)
#   if(!is_empty(noNumeric)){
#     newDf <- cbind(noNumeric, onlyNumeric)
#   }else{
#     newDf <- onlyNumeric
#   }
#   
#   message("merge done")
#   #Reshape the data: keep replicate row-wise i.e. longer format (pivot_longer())
#   newDf2 <- pivot_longer(newDf, cols = colnames(onlyNumeric), names_to = "replicates", values_to = colName)
#   message("reshape done inside replicate func")
#   message(head(newDf2))
#   rownames(newDf2) <- NULL
#   
#   return(newDf2)
#   
# }
# 
# "
# Function to determine mean and median of replicates of each group/variable provided by the user.
# Mean and median will be determined row-wise.
# It will processed the replicates only for one group at a time, not multiple groups.
# 
# arguments:
# x = dataframe. data to apply the function
# colName = character. Column name for the  tidied data
# headerNo = numeric. row index of header used in the table.
# colNo = numeric. column index for the replicates of each group. It can be range or vector
# stat = character. 'mean' or 'median'
# "
# replicateMeanMedian_perGroup <- function(x=data, headerNo = 1:2, colName= "column_name", colNo=1:4, stat = "mean"){
#   
#   #For now, every elements in the data are in character
#   #remove the header
#   message("inside func3")
#   headerRemoved <- x[-c(headerNo),] %>% as.data.frame() # all columns will be present
#   message("headerRemoved")
#   message(glue::glue("headerRemoved: {head(headerRemoved)}"))
#   
#   #non-replicate column. It will be a character column when in proper format
#   # later tidied data will be appended to this data
#   message("nonnumeric")
#   #empty data frame to catch the character column
#   noNumeric <- data.frame()
#   colIndx <- 0 #empty index to get the header name later
#   
#   #Check whether the character columns should be a character or numeric
#   # and keep only the column that has to be character.
#   for(i in seq_len(ncol(headerRemoved))){
#     if( any(str_detect( headerRemoved[,i],regex('[a-zA-Z]') ) ) ){
#       if(length(colIndx) == 1 && colIndx == 0){
#         colIndx <- i
#       }else{
#         colIndx <- c(colIndx, i)
#       }
#       if(is_empty(noNumeric)){
#         noNumeric <- headerRemoved[,i, drop=FALSE]  
#       }else{
#         col_n <- colnames(headerRemoved[,i, drop =FALSE])
#         noNumeric[, col_n] <- headerRemoved[,i]
#       }
#       
#     }
#   }
#   
#   message(noNumeric)
#   #get column name of the above column or non-replicates from the header 
#   if(!is_empty(noNumeric)){
#     
#     #get the header
#     headr <- x[1:2, c(colIndx)] %>% as.data.frame()
#     message("if statment")
#     if(all(is.na(headr))){
#       
#       #if all is na i.e. no header name was given in the table.
#       #generate new column name
#       col_n <- ncol(noNumeric)
#       message("inside if")
#       colnames(noNumeric) <- paste0("variable",1:col_n)
#       message(head(noNumeric))
#       
#     }else{
#       message("header present")
#       #if header is included in the table, use the name and re-format in proper order
#       getName <- headr[!is.na(headr)]
#       colnames(noNumeric) <- getName[1]
#       
#     }
#     
#   }
#   message("replicate selection")
#   #select only the column specified for replicates: colNo
#   df <- headerRemoved[, c(colNo)]
#   message(colnames(df))
#   # convert to numeric
#   message("converting to numeric")
#   onlyNumeric <- df %>% mutate_if(is.character, as.numeric)  #%>% as_tibble()
#   message("converted to numeric")
#   message(str(onlyNumeric))
#   #generate and add column names
#   nn <- ncol(onlyNumeric)
#   colnames(onlyNumeric) <- paste0("Replicate_",1:nn)
#   
#   #determine mean or median and sd
#   if(tolower(stat) == "mean"){
#     message("entering mean")
#     group_mean <- onlyNumeric %>% rowMeans(na.rm = TRUE)
#     message("calculated mean")
#     m_stat <- data.frame(mean = group_mean)
#     colnames(m_stat) <- colName
#     
#     message("mean finished")
#     #compute sd 
#     s <-apply(onlyNumeric, 1, sd)
#     #merge the mean and sd
#     nam <- paste0("sd_",colName)
#     m_stat[, nam]<- s
#   }else{
#     
#     #sort the replicates row-wise
#     group_sort <- t(apply(onlyNumeric,1,sort))
#     colnames(group_sort) <- colnames(onlyNumeric)
#     #determine median
#     group_median <- apply(group_sort, 1, median, na.rm=TRUE)
#     m_stat <- data.frame(median=group_median)
#     colnames(m_stat) <- colName
#     
#     #compute sd or mad
#     s <-apply(onlyNumeric, 1, mad)
#     #merge the mean and sd
#     nam <- paste0("mad_",colName)
#     m_stat[, nam]<- s
#   }
#   
#   
#   #append the mean or median value back to the original data
#   message("merge")
#   # message(glue::glue("noNumeric: {head(noNumeric)}, {head(onlyNumeric)}, {head(m_stat)}"))
#   message("merge2")
#   final <- cbind(noNumeric, onlyNumeric, m_stat) 
#   row.names(final) <- NULL
#   
#   return(final)
#   
# }

#function to add, or delete groups for comparison: output is lists
# grpAddDel <- function(lst = list(), grp = "givenGrp", act = "addOrDelete"){
#   index <- length(lst)
#   if(act == "add"){
#     lst[index+1] <- list(grp)
#   }else if(act == "delete"){
#     lst <- lst[-index]
#   }
#   return(lst)
# }
"
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
    message(getNumber)
    return(getNumber)
  }else{
    message(getTable)
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
#

#require table for summary
testTable <- reactiveValues(df=NULL) #statistic table
postHoc_table <- reactiveValues(df = NULL) #post-hoc analysis table
effectSize <- reactiveValues(df=NULL) #effect size table

#statistical computation function:
"arguments:
  data = a data frame
  method = character. chosen statistic method
  numericVar = character. dependant variable for the statistic
  catVar = character. It can be single or vector. independant variable
  compRef = variable for comparing or a reference group
  pairedD = whether data is paired or unpaired
  anovaType = type of anova: one-way (one) or two-way (two)
  ttestMethod = welch or student's test

"

computFunc <- function(data = "data", method = "none", numericVar = "numericVar()",
                       catVar = "catVar()", compRef = "compareOrReference()",
                       pairedD = "pairedData", anovaType = "anovaType()", 
                       ttestMethod = FALSE, ssType="ssType()", 
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
  if(method %in% c("t.test", "wilcox.test")){
    
    message("312wreference")
    message(glue::glue("referencegr3: {compRef}"))
    
    ref <- if(compRef == "reference group"){
      
      if(is_empty(rfGrpList)){
        message("empty ref\\")
        NULL
      }else {
        message("reference stage++")
        message(glue::glue("ref value: {cmpGrpList}"))
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
    message("hwlOOOOOOO1")
    message(glue::glue("compRef: {cmp}, {ref}"))
    message("hwlOOOOOOO")
  }
  #hard coded: revise
  if(method == "t.test"){
    message("forml=-=--")
    message(glue::glue("forml13:{forml}"))
    message(glue::glue("ttestMethod: {isTRUE(ttestMethod)}"))
    message("ttestMethod complete33")
    message(ref)
    message(str(ref))
    message(unlist(ref))
    # browser()
    test <- rstatix::t_test(data, formula = forml,
           ref.group = unlist(ref), #if(!is.null(cRf[[1]])) .data[[cRf[[1]]]] else NULL,
           comparisons = cmp, p.adjust.method = pAdjustMethod,
           paired = pairedD, var.equal = ttestMethod #welch's =FALSE, or student's test = TRUE
    )
    message("ttest done2 ")
    message(test)
    #global
    testTable$df <<- test 
    #compute effect size
    effectSize$df <<- cohens_d(data, formula = forml,
                               ref.group = unlist(ref),
                               comparisons = cmp, 
                               paired = pairedD, var.equal = ttestMethod,
                               ci = FALSE) #ci = TRUE is too slow
    
    return(test)
    
  }else if(method == "wilcox.test"){
    message("formlw=-=--")
    message(glue::glue("forml13w:{forml}"))
    message(str(data))
    message(colnames(data))
    message(data)
    
    
    message('start')
    test <- rstatix::wilcox_test(data = data, formula = forml,
                ref.group = unlist(ref), #if(compRef == "none"){NULL}else{if(switchGrpList == 0) NULL else .data[[cmpGrpList]]},
                comparisons = cmp, #if(compRef == "none"){NULL}else if(compRef == "comparions"){if(switchGrpList == 0) NULL else cmpGrpList},
                paired = pairedD,
                p.adjust.method = pAdjustMethod)
    message("done------")
    #global
    testTable$df <<- test
    #effect size: global. Display in the summary
    effectSize$df <<- rstatix::wilcox_effsize(data = data, formula = forml,
                                              ref.group = unlist(ref), 
                                              comparisons = cmp, 
                                              paired = pairedD,
                                              p.adjust.method = pAdjustMethod)
    
    return(test)
    
  }else if(method == "anova"){
    
    #Conduct ANOVA
    #formula for one-way and two-way is prepared by aovInFunc and reformulate
    message(glue::glue("running anova--=-="))
    if(anovaType == "one"){
      anova <- anova_test(data=data, formula=forml, type = ssType) #Default sum of square type = 2
    }else{
      anova <- anova_test(data=data, formula=forml)
    }
    anovaTable <- anova %>% as.data.frame() 
    message(glue::glue("anovaTable: {anovaTable}"))
    
    #rename the column. Global data
    message(glue::glue("renaming anova table------"))
    #This will be used as summary data and for further analysis
    testTable$df <<- rename(anovaTable,"DFn" = "Df", "DFd" = "Df_residual") 
    
    message(glue::glue("------catVar: {catVar}-------"))
    message(glue::glue("model==========={model}"))
    
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
      
      #add mean to the new_tk and sort it based on the mean: this is require so that letter is in the order of mean (ascending)
      new_tk_join <- left_join(new_tk, meanLabPos, by = c("group1" = unlist(catVar))) %>% arrange(mean)
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
      message(glue::glue("meanLabPos col one-way: {colnames(meanLabPos)}"))
      geomTextLabel <- meanLabPos %>% as.data.frame()#use in geom_text
      return(geomTextLabel)
      
    }else if(anovaType == "two"){
      
      #two anova here----------------------------
      #post-hoc analysis
      if(model == "non-additive"){
        
        #non-additive----------
        message("entering non-aditive))))))")
        #using base aov
        av <- aov(data=data, formula=forml) 
        
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
        
        
        message(glue::glue("meanLabPos: {meanLabPos}"))
        #compare the mean: using base TukeyHSD()
        tukey_df <- TukeyHSD(av) 
        
        
        #get compact letter
        clt <- multcompLetters4(av, tukey_df)
        
        #global save for additive figure for different groups
        # aovFigure_1_2 <<- av #anova
        postHoc_table$df <<- tukey_df#gloabal: save and display as summary
        aovMeanLabPos <<- meanLabPos #mean table
        aovClt <<- clt #compact letter
        
        message(glue::glue("))clt: {clt}"))
        
        #get the compact letter 
        clt_n1 <- as.data.frame.list(clt[[1]]) #group1
        clt_n1$lab <- rownames(clt_n1)
        clt_n2 <- as.data.frame.list(clt[[2]]) #group2
        clt_n2$lab <- rownames(clt_n2)
        clt_n3 <- as.data.frame.list(clt[[3]]) #interaction
        clt_n3$lab <- rownames(clt_n3)
        
        message("unlist")
        message(glue::glue("unlist:{unlist(catVar[[1]][1])}"))
        
        #add compact letter to the mean table
        #group1
        x <- catVar[1]
        colJ1 <- "lab"
        names(colJ1) <- x
        message(glue::glue("colJ1:{colJ1}"))
        meanLabPos_a <- left_join(meanLabPos1, clt_n1, by=colJ1) %>% select(1:5)
        meanLabPos_a <<- dplyr::rename(meanLabPos_a, tk1=Letters)
        message(glue::glue("nn1: {meanLabPos_a}"))
        message("non-group1 complete")
        message(glue::glue("unlist:{unlist(catVar[2])}"))
        
        #group2
        x <- unlist(catVar[2])
        colJ2 <- "lab"
        names(colJ2) <- x
        meanLabPos_a2 <- left_join(meanLabPos2, clt_n2, by = colJ2) %>% select(1:5)
        meanLabPos_a2 <<- dplyr::rename(meanLabPos_a2, tk2=Letters)
        message(glue::glue("nn2: {meanLabPos_a2}"))
        message("non- group2 complete")
        
        #interaction
        meanLabPos_i <- meanLabPos
        meanLabPos_i$tkint <- clt_n3$Letters
        message(glue::glue("meanLabPos col: {colnames(meanLabPos)}------"))
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
        message(glue::glue("meanLabPos1$tk1: {meanLabPos1$tk1}"))
        #group2
        meanLabPos2 <- data %>% group_by(!!!rlang::syms(catVar[2])) %>% 
          summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) %>%
          #sort is descending: one-way is sorted in ascending order
          arrange(desc(mean)) %>%
          #placed the groups in the first column
          select(!!!rlang::syms(catVar[2]), everything())
        message(glue::glue("meanLabPos1$tk2 : {meanLabPos1$tk2}"))
        
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
        
        message(glue::glue("))clt: {clt}"))
        #get all the required data for anova figure: interaction, group1, group2
        #add compact letter to the mean table
        clt_n1 <- as.data.frame.list(clt[[1]]) #group1
        clt_n1$lab <- rownames(clt_n1)
        clt_n2 <- as.data.frame.list(clt[[2]]) #group2
        clt_n2$lab <- rownames(clt_n2)
        
        message("unlist")
        message(glue::glue("unlist:{unlist(catVar[[1]][1])}"))
        #group1: to be used in join
        x <- catVar[1]
        colJ1 <- "lab"
        names(colJ1) <- x
        message(glue::glue("colJ1:{colJ1}"))
        meanLabPos_a <- left_join(meanLabPos1, clt_n1, by=colJ1) %>% select(1:4)
        meanLabPos_a <<- dplyr::rename(meanLabPos_a, tk1=Letters)
        message(glue::glue("nn1: {meanLabPos_a}"))
        message("non-group1 complete")
        message(glue::glue("unlist:{unlist(catVar[2])}"))
        
        #group2: to be used in join
        x <- catVar[2]
        colJ2 <- "lab"
        names(colJ2) <- x
        meanLabPos_a2 <- left_join(meanLabPos2, clt_n2, by = colJ2) %>% select(1:4)
        meanLabPos_a2 <<- dplyr::rename(meanLabPos_a2, tk2=Letters)
        message(glue::glue("nn2: {meanLabPos_a2}"))
        message("non- group2 complete")
        
        #two table will be generated
        # This can be confusing:
        # different tables will be used based on user's input for figure
        # tables will be directly access from global, not from the return object of this
        # function. This will save additional computation.
        meanLabPos_a #group1
        meanLabPos_a2 #group2
      }
      
    }
    
    
  }else if (method == 'Kruskal test'){
    #Kruskal test------------------
    message("Kruskal test on2")
    allMean <- data %>% group_by(!!!rlang::syms(catVar)) %>% 
      summarise(mean = mean(!!!rlang::syms(numericVar)), quantl = quantile(!!!rlang::syms(numericVar), probs =1, na.rm=TRUE)) 
    
    message(glue::glue("krusk mean: {allMean}"))
    #do the test
    kstat <- rstatix::kruskal_test(data=data, formula = forml)
    message("entering post hoc kruskal")
    #post hoc test
    #global
    
    posthoc <- dunn_test(data=data, formula = forml, p.adjust.method = pAdjustMethod, detailed=FALSE)
    message(glue::glue("krusk posthoc: {posthoc}"))
    #get compact letter
    if(isTRUE(pAdjust)){
      pval <- posthoc$p.adj
    }else{
      pval <- posthoc$p
    }
    
    #global
    testTable$df <<- kstat
    postHoc_table$df <<- posthoc %>% as.data.frame()
    #effect size
    effectSize$df <- kruskal_effsize(data=data, formula = forml, ci = FALSE) #ci = TRUE is too slow
    message("kruskal post hooooooooooooooooooooooooooooooooooooooooooooooccc")
    message(str(posthoc))
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
    message(glue::glue("krusk final: {colnames(df_final)}, {df_final}"))
    return(df_final)
    
  }
  
  # if(method == "t.test"){
  #   t_test(data, formula = forml, ref.group = .data[[cRf[[1]]]], #if(!is.null(cRf[[1]])) .data[[cRf[[1]]]] else NULL,
  #          comparisons =.data[[cRf[[2]]]], paired = pairedD)
  # }else if(method == "wilcox.text"){
  #   wilcox_test(data, formula = forml, ref.group = .data[[cRf[[1]]]], #if(!is.null(cRf[[1]])) .data[[cRf[[1]]]] else NULL,
  #               comparisons = .data[[cRf[[2]]]], paired = pairedD)
  # }else if(method == "anova"){
  #   switch(anovaType,
  #          #instead of anova_test(), i will use aov() and apply post hoc test
  #          #one way anova
  #          "one" = aov(data, .data[[numericVar]] ~ statInp),
  #          #two way anova
  #          "two" = aov(data, .data[[numericVar]] ~ eval(str2expression(statInp))),
  #          #repeated measures two-way anova: not implemented
  #          "three" = anova_test(data, .data[[numericVar]] ~ eval(str2expression(statInp)))
  #      )
  # }else if (method == 'sign test'){
  #   #needs to implement further
  #   #sign_test(data, .data[[numericVar]]~.data[[catVar]])
  # }
  
}

message("End of computFunc()------------")
#function to generate data for stat
#anova need more setting
generateStatData <- function(data = "ptable()", groupStat = "groupStat()", groupVar = "groupStatVarOption()",
                             method = "none", numericVar = "numericVar()",
                             catVar = "catVar()", compRef = "compareOrReference()",
                             pairedD = "pairedData", pAdjust = TRUE, 
                             ttestMethod=FALSE, #welch or student's test
                             model = "model", #model of anova
                             pAdjustMethod = NULL, labelSignif = "labelSt()",
                             cmpGrpList = NULL, rfGrpList = NULL, #switchGrpList = 0, #for ref.group and comparison: global list
                             xVar = "xyAxis()[[1]]", anovaType = "anovaType", ssType ="ssType()"){
  #convert the x-axis or group_by variable to factor.  
  #converting to factor is necessary for further processing
  message("entering generateStatData()-------------------")
  message(glue::glue("head of data: {head(data)}"))
  message(glue::glue("method gsd: {method}"))
  message(glue::glue("groupStat gsd: {groupStat}"))
  message(glue::glue("groupVar: {groupVar}"))
  message(glue::glue("numericVar: {numericVar}"))
  message(glue::glue("catVar: {catVar}"))
  
  #for anova, every independent variable has to be a factor
  #for other tests, it will depend on the type of computation
  if(method %in% c("anova", "Kruskal test")){
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
                   model = model, anovaType = anovaType, ssType = ssType, 
                   cmpGrpList = cmpGrpList, rfGrpList = rfGrpList, pAdjust = pAdjust, pAdjustMethod= pAdjustMethod) #switchGrpList = switchGrpList,
      
    }else if(groupStat == "yes"){
      message("running groupby----------")
      data %>% group_by(!!!rlang::syms(groupVar)) %>%
        #choose stat methods and apply
        computFunc(data = ., method = method, numericVar = numericVar, catVar = catVar, compRef = compRef, 
                   paired = pairedD, ttestMethod = ttestMethod, anovaType = anovaType, pAdjustMethod = pAdjustMethod)
    }
  }, error = function(e){print(e)})
  
  
  
  if(!method %in% c("anova", "Kruskal test")){
    
    #add p adjusted value column to the data frame: by default, but user can omit
    sData2 <- if(isTRUE(pAdjust)){
       
      sData1 %>%
        #add p adjusted value column 
        adjust_pvalue(method = pAdjustMethod) %>%
        #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
        add_significance(p.col = "p.adj") %>%
        #determine and add x and y position for labeling significance
        add_xy_position(x = xVar, dodge = 0.8)
    }else{
      sData1 %>%
        #add significance to the data frame column: default - p-adjusted value; user can opt for p-value
        add_significance(p.col = "p") %>%
        #determine and add x and y position for labeling significance
        add_xy_position(x = xVar, dodge = 0.8)
    }
    
  }#end of stat data for plots other than anova and krukal test
  
  #provide the output as list of computed data and user's choice for label
  if(method %in% c("anova", "Kruskal test")){
    list(sData1, NULL)
  }else{
    list(sData2, labelSignif)
  }
  
}


#Plot figure function--------------------------
#For appropriate parameters, theme, coloring, application of statistic of the figures: basic and advance
#Its a function factory
plotFig <- function(data = x, types = "reactive(input$plotType)", geom_type = "geom_", histLine = "meanLine",  useValueAsIs = FALSE, 
                    lineParam = lineParam,
                    facet = FALSE, facetType = 'grid_wrap', varRow = NULL, varColumn = NULL, nRow = NULL, nColumn = NULL, scales = "fixed",  
                    layer = "none", layerSize = layerSize, barSize = 0.2, ...){ #if y axis is required specifically mention in function parameter
  #inner: for further setting, apart from geom
  #outer
  if(types == "none"){
    gp <- ggplot(data = NULL)
  }else {
    gp <- ggplot(data = data, aes(...))
  }
  
  # if(types == "none"){
  #   gp <- ggplot(data = NULL)
  # }else if(isFALSE(lineParam[[1]])){
  #   gp <- ggplot(data = data, aes(...))
  # }else{
  #   #if TRUE, than it is for line and bar graph, which require sd computed data
  #   gp <- ggplot(data = data, aes(...)) + 
  #     #adding geom_errorbar
  #     lineParam[[3]]
  # }
  # typeFig <- reactive(req(input$plotType, cancelOutput = TRUE))
  if(types == "box"){
    #only for plot that require errorbar
    plt <- gp + 
      stat_boxplot(geom = "errorbar", width = barSize) +
      geom_type
  }else if(types == "histogram"){
    plt <- gp + geom_type + histLine
  }else{
    #other than boxplot
    plt <- gp +
      geom_type
  }
  message(glue::glue("lineParam: {lineParam[[1]]}"))
  #Add error bar for line and bar graph
  if(isFALSE(lineParam[[1]])){
    plt <- plt
  }else{
    #if TRUE, than it is for line and bar graph, which require sd computed data
    plt <- plt + 
      #adding geom_errorbar
      lineParam[[3]]
  }
  
  #add layer
  if(layer != "none"){
    cal <- ifelse(types %in% c("box", "Violine plot"), "median", "mean")
    plt <- switch(layer,
                  "line" = plt + stat_summary(fun = cal, geom = 'line', aes(group = 1), size = layerSize),
                  "smooth" = plt + geom_smooth(size = layerSize),
                  "point" = plt + geom_point(size = layerSize),
                  "jitter" = plt + geom_jitter(size = layerSize)
    )
  }
  #facet
  if(isTRUE(facet)){
    if(facetType == "grid"){
      #I've used .data[[]] here, because I couldn't used in setFig(). This is not recommended!!
      if(is.null(varRow)){
        #plt <- plt+facet_grid(rows = vars(NULL), cols = vars(unlist(map(1:length(varColumn), .data[[varColumn]]))), scale = tolower(scales))
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
  
  #inner function to add more setting if user need
  #arguments for the inner function will be provided by setFig() later. Not a recommended way of writing function.
  "
  Inner function to add more advance settings
  arguments:
    advance = logical, TRUE whenever aesthetic or statistical method are applied
    varSet = variable for filling color
    autoCust = either the color should be auto filled or customize
    methodSt = statistical method
    removeBracket = remove bracket for annotating statistical significance
    statData = Data to be used for annotating statistical significane
    anovaType = type of anova: one-way or two-way anova
    aovX = variable used in x-axis. This is required to display figure for two-way anova.
  "
  function(advance = FALSE,
           #color parameters
           varSet="none", #= "reactive(req(input$colorSet, cancelOutput = TRUE))",
           autoCust, #= "reactive(req(input$autoCustome, cancelOutput = TRUE))",
           colorTxt, #= "reactive(input$colorAdd)", 
           #argument for stat data
           methodSt = "none", #= "methodSt",
           removeBracket=FALSE,
           statData,#= "statData",
           anovaType,
           aovX=aovX#This is require for two-way anova
  ){ #="anovaType" 
    #no need to provide function parameters for basic plot: the default will be used
    message("inner function")
    
    if(isFALSE(advance)){
      #basic plot: default
      message("display basic")
      plt
    }else if (isTRUE(advance)){
      # advance settings
      message("display advance")
      if(varSet != "none"){
        message("color")
        
        #User choice to auto fill or customize the color
        if(autoCust == "auto filled"){
          newPlt <<- plt #Make it global, to be used just before customization
          #coloring will be implemented while using the function
          plt
        }else if(autoCust == "customize"){
          #this will execute only if the customize option is selected
          message(glue::glue("colorTxt : {colorTxt}"))
          message(glue::glue("varSet : {varSet}"))
          #get number of variables
          countVar <- length(unique(data[[varSet]]))
          # data %>%
          # dplyr::distinct(.data[[varSet]], .keep_all = F) %>% nrow()
          
          editC <- if(colorTxt == "noneProvided"){
            "not provided" #if no color is provided
          }else{
            #process the given color input by removing space and comma
            message("Processing color--------pc----")
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
          if(length(editC) < countVar){
            #display the color of the global plot
            message(glue::glue("editC less number : {editC}"))
            message(glue::glue("edit length: {length(editC)}"))
            newPlt
          }else if(length(editC) == countVar){
            message(glue::glue("editC final color: {editC}"))
            #add color to the plot
            if(types %in% c("line", "frequency polygon", "scatter")){
              plt <- plt + scale_color_manual(values = tolower(editC))
            }else{
              plt <- plt + scale_fill_manual(values = tolower(editC))
            }
            newPlt <<- plt #save global
          }else{validate(glue::glue("Provide only {countVar} colors"))}
        }#end of customizing color
      }#end for color setting
      
      #statistics annotation: computed data will be provided as arguments
      if(methodSt != "none"){
        
        message("label inside function22--------")
        if(!methodSt %in% c("anova", "Kruskal test")){
          message("not anova------")
          message(glue::glue("stat4:{methodSt}"))
          message("statData[[2]]")
          message(str(statData) )
          message(statData)
          plt <- plt + stat_pvalue_manual(statData[[1]], label = statData[[2]], tip.length = 0.01, remove.bracket = removeBracket, bracket.size = 0.4, bracket.nudge.y = 5, inherit.aes=FALSE)
        }else if(methodSt == "anova"){
          message("Anova stat method 2====")
          #get the details for labeling the plot
          
          textData <- statData[[1]] %>% as.data.frame()
          message("textData===")
          message(head(textData))
          message(colnames(textData))
          col <- colnames(textData)
          message(glue::glue("inner function col: {col}"))
          
          x_name <- col[1]
          message(glue::glue("inner function x_name: {x_name}"))
          message(glue::glue("inner function text data: {textData}"))
          
          if(anovaType == "one"){
            y_name <- col[3]
            letr <- col[4]
            plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                      label = eval(str2expression(letr))), size = 7, vjust=-0.5, na.rm = TRUE)
          }else{
            message(glue::glue("aovX:{str(aovX)}, {is.null(aovX)}"))
            
            #get the position from the table
            if(aovX == "Interaction"){
              y_name <- col[4]
              letr <- col[5]
            }else if(aovX == "group1"){
              y_name <- col[3]
              letr <- col[4]
            }else{
              x_name <- aovX
              y_name <- col[3]
              letr <- col[4]
            }
            
            plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                      label = eval(str2expression(letr))), position= position_dodge2(0.9), size = 7, vjust=-0.25, na.rm = TRUE)
          }#end of two-way anova
          #end of anova
        }else if(methodSt == "Kruskal test"){
          message("entering Kruskal test=00000000")
          message(glue::glue("data: {statData[[1]]}"))
          textData <- statData[[1]] %>% as.data.frame()
          col <- colnames(textData)
          
          x_name <- col[1]
          y_name <- col[3]
          letr <- col[4]
          message(glue::glue("inner function x_name: {x_name}"))
          message(glue::glue("inner function text data: {textData}"))
          #plot krukal test
          plt <- plt + coord_cartesian(clip="off") + geom_text(data=textData, aes(x=eval(str2expression(x_name)), y = eval(str2expression(y_name)),
                                                    label = eval(str2expression(letr))), position= position_dodge2(0.9), size = 7, vjust=-0.25, na.rm = TRUE)
        }#end of Kruskal test
        
      }#end of statistics
    }#end of advance setting
    message("geom_text added====")
    message("after condition:inner")
    # gp <- plt
    # gp2 <<- ggplot_build(gp)
    # message(glue::glue("ggp: {gp2}"))
    plt
  }#end of inner function
}#end of outer function

#theme function---------------------
themeF <- function(thme = "user preferred theme"){
  switch(thme,
         "default" = theme(),
         "white" = theme_classic(),
         "white with grid lines" = theme_bw(),
         "dark" = theme_dark(),
         "blank" = theme_void())
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

#Guide and input provider function to plotFig()----------------------
"All the arguments required for plotting the figure using 
plotFig() will be provided by the below function : setFig()"
setFig <- function(data,# = "ptable()",
                   figType,# = "reactive(req(input$plotType, cancelOutput = TRUE))",
                   geomType,# = "geom_boxplot()",
                   barSize = 0.5, 
                   histLine = NULL,
                   dis = FALSE,
                   xy,# = "reactive(input$xAxis) and reactive(input$yAxis)", 
                   lineParam = lineParam,
                   textSize,# = "reactive(input$textSize)",
                   titleSize,# = "reactive(input$titleSize)",
                   xyLable,# = "xyLable()",
                   themes,# = "reactive(input$theme)",
                   #parameters to add color
                   varSet="none",# = "reactive(req(input$colorSet, cancelOutput = TRUE))",
                   autoCust,# = "reactive(req(input$autoCustome, cancelOutput = TRUE))",
                   colorTxt,# = "reactive(input$colorAdd)", #color
                   #more aesthetic
                   shapeLine,# = "reactive(input$shapeLine)",
                   shapeSet,# = "reactive(isTruthy(input$shapeSet)",
                   lineSet, #= "reactive(isTruthy(input$lineSet)",
                   #parameters for statistic
                   methodSt= "none",# = "reactive(req(input$stat))",
                   removeBracket=FALSE, #it is either true or false
                   statData,# = "statData",
                   aovX="Interaction", #default is Interaction
                   anovaType,# = "anovaType()",
                   #legend parameter
                   legendPosition,# = "legendPosition",
                   legendDirection,# = "legendDirection",
                   legendTitle,# = "legendTitle",
                   legendSize,# = "legendSize",
                   #other theme
                   stripBackground = FALSE, #for facet
                   #facet parameter
                   facet = FALSE,
                   faceType = NULL,#grid or wrap
                   varRow = NULL,
                   varColumn = NULL,
                   nRow = NULL, 
                   nColumn = NULL, 
                   scales = NULL, #fixed or free
                   #additional layer
                   layer = "none",
                   layerSize = layerSize,
                   ...){ #dis is for applying the advance option: TRUE for apply and FALSE for don't apply
  #data need to be changed based on the type of plots
  if(isFALSE(lineParam[[1]])){
    #no change in data from ptable()
    data <- data
  }else{
    #for line graph
    if(figType == 'scatter'){
      data <- data
    }else{
      data <- lineParam[[2]]
    }
    
  }
  #convert the x-axis into factor: this is necessary especially if user provide numerical variables for x-axis
  #this conversion will take place only for certain figType(), not for all
  if(figType %in% c("box","Violine plot", "line")){
    message("-------------1. Reminder: check the factor of x and y axis---------------------")
    # data <- as.data.frame(data)
    message(glue::glue("xy1[1:{xy}"))
    data[[xy[[1]]]] <- as.factor(data[[xy[[1]]]])
  }else{ #if(figType %in% c("line", "scatter")){
    message("-------------2. Reminder: check the factor of x and y axis---------------------")
    data
  }
  # #convert all aesthetic to factor
  # if(varSet != "none" && shapeLine != "none"){
  #   
  #   data1 <- data %>% mutate(across(varSet, factor))
  #   
  #   if(shapeSet != "reactive(isTruthy(input$shapeSet)" && lineSet != "reactive(isTruthy(input$lineSet)"){
  #     data1 <- data1 %>% mutate(across(c(shapeSet, lineSet), factor))
  #   }else if (shapeSet != "reactive(isTruthy(input$shapeSet)" && lineSet == "reactive(isTruthy(input$lineSet)"){
  #     data1 <- data1 %>% mutate(across(shapeSet, factor))
  #   }else if (shapeSet == "reactive(isTruthy(input$shapeSet)" && lineSet != "reactive(isTruthy(input$lineSet)"){
  #     data1 <- data1 %>% mutate(across(lineSet, factor))
  #   }
  #   
  #   data <- data1
  #   
  # }else if(varSet == "none" && shapeLine != "none"){
  #   
  #   if(shapeSet != "reactive(isTruthy(input$shapeSet)" && lineSet != "reactive(isTruthy(input$lineSet)"){
  #     data <- data %>% mutate(across(c(shapeSet, lineSet), factor))
  #   }else if (shapeSet != "reactive(isTruthy(input$shapeSet)" && lineSet == "reactive(isTruthy(input$lineSet)"){
  #     data <- data %>% mutate(across(shapeSet, factor))
  #   }else if (shapeSet == "reactive(isTruthy(input$shapeSet)" && lineSet != "reactive(isTruthy(input$lineSet)"){
  #     data <- data %>% mutate(across(lineSet, factor))
  #   }
  #   
  # }
  #first plot the type of figure: geom_
  #Here, i've added the aethetic of shape and line type: For color it will be implemented later
  #hard coded
  if(shapeLine == "Shape"){
    if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
      #plots with x- and y-axis
      # pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], shape = .data[[shapeSet]],
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], shape = .data[[shapeSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer, layerSize = layerSize,  barSize = barSize, ...)#.data[[x]], y = .data[[y]], ...)
    }else{
      #plots with only x-axis
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], shape = .data[[shapeSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer, layerSize = layerSize, barSize = barSize, ...)#.data[[x]], ...)
    }
  }else if(shapeLine == "Line type"){
    if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
      #plots with x- and y-axis
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], linetype = .data[[lineSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn,  scales = scales, 
                        layer= layer,  layerSize = layerSize, barSize = barSize, ...)#.data[[x]], y = .data[[y]], ...)
    }else{
      ##plots with x-axis only
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], linetype = .data[[lineSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn,  scales = scales, 
                        layer = layer, layerSize = layerSize, barSize = barSize, ...)#.data[[x]], ...)
    }
  }else if (all(shapeLine %in% c("Shape","Line type"))){
    if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
      #plots with x- and y-axis
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType,histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], shape = .data[[shapeSet]], linetype = .data[[lineSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer = layer, layerSize = layerSize, barSize = barSize, ...)#.data[[x]], y = .data[[y]], ...)
    }else{
      #plots with x-axis only
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], shape = .data[[shapeSet]], linetype = .data[[lineSet]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer = layer, layerSize = layerSize, barSize = barSize, ...)#.data[[x]], ...)
    }
  }else{
    #plots without shape and/or line
    if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
      #plots with x- and y-axis
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer = layer, layerSize = layerSize, barSize = barSize, ...)#.data[[x]], y = .data[[y]], ...)
    }else{
      #plots with x-axis only
      pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]],
                        lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
                        layer = layer, layerSize = layerSize, barSize = barSize,...)#.data[[x]], ...)
    }
  }
  
  #handle user choice to remove legend title
  otherTheme <- if(isTRUE(legendTitle)){
    if(isTRUE(stripBackground)){
      theme(
        axis.text = element_text(size = textSize, face = "bold"),
        axis.title = element_text(size = titleSize, face = "bold"),
        legend.position = legendPosition,
        legend.direction = legendDirection,
        legend.title = element_blank(),
        legend.text = element_text(size = legendSize, face = "bold"),
        strip.text = element_text(size = textSize, face = "bold"),
        strip.background = element_blank())
    }else{
      theme(
        axis.text = element_text(size = textSize, face = "bold"),
        axis.title = element_text(size = titleSize, face = "bold"),
        legend.position = legendPosition,
        legend.direction = legendDirection,
        legend.title = element_blank(),
        legend.text = element_text(size = legendSize, face = "bold"),
        strip.text = element_text(size = textSize, face = "bold"))
    }
  }else{
    if(isTRUE(stripBackground)){
      theme(
        axis.text = element_text(size = textSize, face = "bold"),
        axis.title = element_text(size = titleSize, face = "bold"),
        legend.position = legendPosition,
        legend.direction = legendDirection,
        legend.title = element_text(size = legendSize, face = "bold"),
        legend.text = element_text(size = legendSize, face = "bold"),
        strip.text = element_text(size = textSize, face = "bold"),
        strip.background = element_blank())
    }else{
      theme(
        axis.text = element_text(size = textSize, face = "bold"),
        axis.title = element_text(size = titleSize, face = "bold"),
        legend.position = legendPosition,
        legend.direction = legendDirection,
        legend.title = element_text(size = legendSize, face = "bold"),
        legend.text = element_text(size = legendSize, face = "bold"),
        strip.text = element_text(size = textSize, face = "bold"))
    }
    
  }
  #use inner function for more details
  if(isFALSE(dis)){
    #basic plot
    pltSet(advance = dis)+ #addThemes
      axisLabs(x =xyLable[[1]], y = xyLable[[2]])+
      themeF(thme = themes)+
      otherTheme
  }else if(isTRUE(dis)){
    #advance plot
    message("advance----------")
    pltSet(advance = dis,
           varSet = varSet,
           autoCust = autoCust,
           colorTxt = colorTxt,
           methodSt = methodSt,
           removeBracket=removeBracket,
           statData = statData,
           anovaType = anovaType, 
           aovX=aovX)+ 
      #addThemes
      axisLabs(x =xyLable[[1]], y = xyLable[[2]])+
      themeF(thme = themes)+
      otherTheme
  }
} # end of display plot function







#rough---------------
# plotFig_original <- function(data = x, types = "reactive(input$plotType)", geom_type = "geom_", histLine = "meanLine",  useValueAsIs = FALSE, 
#                     lineParam = lineParam,
#                     facet = FALSE, facetType = 'grid_wrap', varRow = NULL, varColumn = NULL, nRow = NULL, nColumn = NULL, scales = "fixed",  
#                     layer = "none", layerSize = layerSize, ...){ #if y axis is required specifically mention in function parameter
#   #outer: for setting of geom
#   #inner: for further setting, apart from geom
#   #outer
#   if(types == "none"){
#     gp <- ggplot(data = NULL)
#   }else if(isFALSE(lineParam[[1]])){
#     gp <- ggplot(data = data, aes(...))
#   }else{
#     #if TRUE, than it is for line graph, which require sd computed data
#     gp <- ggplot(data = data, aes(...)) + 
#       #adding geom_errorbar
#       lineParam[[3]]
#   }
#   # typeFig <- reactive(req(input$plotType, cancelOutput = TRUE))
#   if(types == "box"){
#     #only for plot that require errorbar
#     plt <- gp + 
#       stat_boxplot(geom = "errorbar")+
#       geom_type
#   }else if(types == "histogram"){
#     plt <- gp + geom_type + histLine
#   }else{
#     #other than boxplot
#     plt <- gp +
#       geom_type
#   }
#   
#   #add layer
#   if(layer != "none"){
#     cal <- ifelse(types %in% c("box"), "median", "mean")
#     plt <- switch(layer,
#                   "line" = plt + stat_summary(fun = cal, geom = 'line', aes(group = 1), size = layerSize),
#                   "smooth" = plt + geom_smooth(size = layerSize),
#                   "point" = plt + geom_point(size = layerSize),
#                   "jitter" = plt + geom_jitter(size = layerSize)
#     )
#   }
#   #facet
#   if(isTRUE(facet)){
#     if(facetType == "grid"){
#       #I've used .data[[]] here, because I couldn't used in setFig(). This is not recommended!!
#       if(is.null(varRow)){
#         #plt <- plt+facet_grid(rows = vars(NULL), cols = vars(unlist(map(1:length(varColumn), .data[[varColumn]]))), scale = tolower(scales))
#         plt <- plt+facet_grid(rows = vars(NULL), cols = vars(.data[[varColumn]]), scale = tolower(scales))
#       }else if(is.null(varColumn)){
#         plt <- plt+facet_grid(rows = vars(.data[[varRow]]), cols = vars(NULL), scale = tolower(scales))
#       }else{
#         plt <- plt+facet_grid(rows = vars(.data[[varRow]]), cols = vars(.data[[varColumn]]), scale = tolower(scales))
#       }
#     }else if(facetType == "wrap"){
#       if(is.null(varRow)){
#         plt <- plt + facet_wrap(facets = vars(NULL), nrow = nRow, ncol = nColumn, scale = tolower(scales))
#       }else{
#         plt <- plt + facet_wrap(facets = vars(.data[[varRow]]), nrow = nRow, ncol = nColumn, scale = tolower(scales))
#       }
#     }else{plt}
#   }
#   
#   #inner function to add more setting if user need
#   function(advance = FALSE,
#            #color parameters
#            varSet = "reactive(req(input$colorSet, cancelOutput = TRUE))",
#            autoCust = "reactive(req(input$autoCustome, cancelOutput = TRUE))",
#            colorTxt = "reactive(input$colorAdd)", 
#            #argument for stat data
#            statData = "statData"
#            # methodSt = "reactive(req(input$stat))",
#            # labelSt = "reactive(input$chooseFormat)",
#            # compareOrReference = "input$compareOrReference",
#            #get the list of grouping for statistic: this would be available in global env
#            cmpGrpList = "cmpGrpList()",
#            switchGrpList = "switchGrpList()"){ 
#     #no need to provide function parameters for basic plot: the default will be used
#     message("inner function")
#     
#     if(isFALSE(advance)){
#       #basic plot: default
#       message("display basic")
#       plt
#     }else if (isTRUE(advance)){
#       # advance settings
#       message("display advance")
#       if(varSet != "none"){
#         message("color")
#         #User choice to auto fill or customize the color
#         if(autoCust == "auto filled"){
#           newPlt <<- plt #Make it global, to be used just before customization
#           #coloring will be implemented while using the function
#           plt
#         }
#         #this will execute only if the customize option is selected
#         else if(autoCust == "customize"){
#           message(colorTxt)
#           #get number of variables
#           countVar <- data %>%
#             distinct(.data[[varSet]], .keep_all = T) %>% nrow()
#           
#           editC <- if(colorTxt == ""){
#             "not provided" #if no color is provided
#           }else{
#             #process the given color input by removing space and comma
#             inputC <- strsplit(str_trim(gsub(" |,", " ", colorTxt))," +")[[1]]
#             #Select only the required number of colors if user provide more than 
#             #the required number.
#             if(length(inputC) > countVar){
#               inputC[1:countVar]
#             }else{ inputC }
#           }
#           
#           if(length(editC) < countVar){
#             #display the color of the global plot
#             message(editC)
#             newPlt
#           }else if(length(editC) == countVar){
#             message(inputC)
#             #add color to the plot
#             if(types %in% c("histogram", "line", "frequency polygon")){
#               plt <- plt + scale_color_manual(values = tolower(inputC))
#             }else{
#               plt <- plt + scale_fill_manual(values = tolower(inputC))
#             }
#             newPlt <<- plt #save global
#           }else{validate(glue::glue("Provide only {countVar} colors"))}
#         }#end of customizing color
#       }#end for color setting
#       message("length of grpList")
#       message(length(grpList))
#       #check for requirement of statistics: data and method for computing statistic will be provided as one arguments
#       if(methodSt != "none"){
#         if(compareOrReference == "none"){
#           message("none-----------------")
#           plt <- plt + stat_compare_means(method = methodSt, label = labelSt, vjust = -0.5) 
#         }else{
#           myCompareGroup <- cmpGrpList
#           message("not none:switch-----------------")
#           message(switchGrpList)
#           #check for empty list, even if options is shown for comparison or reference
#           if(switchGrpList == 0){
#             #if empty i.e. 0, than no need to compare
#             message("0 off")
#             plt <- plt + stat_compare_means(method = methodSt, label = labelSt, vjust = -0.5)
#           }else{
#             message("not 0: on")
#             plt <- switch(compareOrReference,
#                           "comparison" = plt + stat_compare_means(method = methodSt, label = labelSt, vjust = -0.5, comparisons = myCompareGroup),
#                           "reference group" = plt + stat_compare_means(method = methodSt, label = labelSt, vjust = -0.5, ref.group = myCompareGroup[[1]])
#             )#end switch 
#           }
#         }#end group comparisons or referencing
#       }#end of statistics
#     }#end of advance setting
#     message("after condition:inner")
#     plt
#   }#end of inner function
# }#end of outer function
# setFig_original <- function(data = ptable(),
#                    figType = "reactive(req(input$plotType, cancelOutput = TRUE))",
#                    geomType = geom_boxplot(),
#                    histLine = NULL,
#                    dis = FALSE,
#                    xy = "reactive(input$xAxis) and reactive(input$yAxis)", 
#                    lineParam = lineParam,
#                    textSize = "reactive(input$textSize)",
#                    titleSize = "reactive(input$titleSize)",
#                    xyLable = xyLable(),
#                    themes = "reactive(input$theme)",
#                    #parameters to add color
#                    varSet = "reactive(req(input$colorSet, cancelOutput = TRUE))",
#                    autoCust = "reactive(req(input$autoCustome, cancelOutput = TRUE))",
#                    colorTxt = "reactive(input$colorAdd)", #color
#                    #more aesthetic
#                    shapeLine = "reactive(input$shapeLine)",
#                    shapeSet = "reactive(isTruthy(input$shapeSet)",
#                    lineSet= "reactive(isTruthy(input$lineSet)",
#                    #parameters for statistic
#                    methodSt = "reactive(req(input$stat))",
#                    labelSt = "reactive(input$chooseFormat)",
#                    compareOrReference = "input$compareOrReference",
#                    cmpGrpList = "cmpGrpList",
#                    switchGrpList = "switchGrpList()",
#                    #legend parameter
#                    legendPosition = "legendPosition",
#                    legendDirection = "legendDirection",
#                    legendTitle = "legendTitle",
#                    legendSize = "legendSize",
#                    #other theme
#                    stripBackground = FALSE, #for facet
#                    #facet parameter
#                    facet = FALSE,
#                    faceType = NULL,#grid or wrap
#                    varRow = NULL,
#                    varColumn = NULL,
#                    nRow = NULL, 
#                    nColumn = NULL, 
#                    scales = NULL, #fixed or free
#                    #additional layer
#                    layer = "none",
#                    layerSize = layerSize,
#                    ...){ #dis is for applying the advance option: TRUE for apply and FALSE for don't apply
#   #data need to be changed based on the type of plots
#   if(isFALSE(lineParam[[1]])){
#     #no change in data from ptable()
#     data <- data
#   }else{
#     #for line graph
#     data <- lineParam[[2]]
#   }
#   #convert the x-axis into factor: this is necessary especially if user provide numerical variables for x-axis
#   data[[xy[[1]]]] <- as.factor(data[[xy[[1]]]])
#   #first plot the type of figure: geom_
#   #Here, i've added the aethetic of shape and line type: For color it will be implemented later
#   if(shapeLine == "Shape"){
#     if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
#       #require x- and y-axis and must be reactive
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], shape = .data[[shapeSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer, layerSize = layerSize,...)#.data[[x]], y = .data[[y]], ...)
#     }else{
#       #set only x axis for other plots
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], shape = .data[[shapeSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer, layerSize = layerSize,...)#.data[[x]], ...)
#     }
#   }else if(shapeLine == "Line type"){
#     if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
#       #require x- and y-axis and must be reactive
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], linetype = .data[[lineSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn,  scales = scales, 
#                         layer= layer,  layerSize = layerSize,...)#.data[[x]], y = .data[[y]], ...)
#     }else{
#       #set only x axis for other plots
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], linetype = .data[[lineSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn,  scales = scales, 
#                         layer = layer, layerSize = layerSize,...)#.data[[x]], ...)
#     }
#   }else if (all(shapeLine %in% c("Shape","Line type"))){
#     if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
#       #require x- and y-axis and must be reactive
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType,histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]], shape = .data[[shapeSet]], linetype = .data[[lineSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer = layer, layerSize = layerSize,...)#.data[[x]], y = .data[[y]], ...)
#     }else{
#       #set only x axis for other plots
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], shape = .data[[shapeSet]], linetype = .data[[lineSet]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer = layer, layerSize = layerSize,...)#.data[[x]], ...)
#     }
#   }else{
#     if(!is.null(xy[[1]]) && !is.null(xy[[2]])){
#       #require x- and y-axis and must be reactive
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]], y = .data[[xy[[2]]]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer = layer, layerSize = layerSize,...)#.data[[x]], y = .data[[y]], ...)
#     }else{
#       #set only x axis for other plots
#       pltSet <- plotFig(data = data, types = figType, geom_type = geomType, histLine = histLine, x = .data[[xy[[1]]]],
#                         lineParam = lineParam, facet = facet, facetType = faceType, varRow = varRow, varColumn = varColumn, nRow = nRow, nColumn = nColumn, scales = scales, 
#                         layer = layer, layerSize = layerSize,...)#.data[[x]], ...)
#     }
#   }
#   
#   #handle user choice to remove legend title
#   otherTheme <- if(isTRUE(legendTitle)){
#     if(isTRUE(stripBackground)){
#       theme(
#         axis.text = element_text(size = textSize),
#         axis.title = element_text(size = titleSize, face = "bold"),
#         legend.position = legendPosition,
#         legend.direction = legendDirection,
#         legend.title = element_blank(),
#         legend.text = element_text(size = legendSize, face = "bold"),
#         strip.text = element_text(size = textSize, face = "bold"),
#         strip.background = element_blank())
#     }else{
#       theme(
#         axis.text = element_text(size = textSize),
#         axis.title = element_text(size = titleSize, face = "bold"),
#         legend.position = legendPosition,
#         legend.direction = legendDirection,
#         legend.title = element_blank(),
#         legend.text = element_text(size = legendSize, face = "bold"),
#         strip.text = element_text(size = textSize, face = "bold"))
#     }
#   }else{
#     if(isTRUE(stripBackground)){
#       theme(
#         axis.text = element_text(size = textSize),
#         axis.title = element_text(size = titleSize, face = "bold"),
#         legend.position = legendPosition,
#         legend.direction = legendDirection,
#         legend.title = element_text(size = legendSize, face = "bold"),
#         legend.text = element_text(size = legendSize, face = "bold"),
#         strip.text = element_text(size = textSize, face = "bold"),
#         strip.background = element_blank())
#     }else{
#       theme(
#         axis.text = element_text(size = textSize),
#         axis.title = element_text(size = titleSize, face = "bold"),
#         legend.position = legendPosition,
#         legend.direction = legendDirection,
#         legend.title = element_text(size = legendSize, face = "bold"),
#         legend.text = element_text(size = legendSize, face = "bold"),
#         strip.text = element_text(size = textSize, face = "bold"))
#     }
#     
#   }
#   #use inner function for more details
#   if(isFALSE(dis)){
#     #basic plot
#     pltSet(advance = dis)+ #addThemes
#       axisLabs(x =xyLable[[1]], y = xyLable[[2]])+
#       themeF(thme = themes)+
#       otherTheme
#   }else if(isTRUE(dis)){
#     #advance plot
#     pltSet(advance = dis,
#            varSet = varSet,
#            autoCust = autoCust,
#            colorTxt = colorTxt,
#            methodSt = methodSt,
#            labelSt = labelSt,
#            cmpGrpList = cmpGrpList,
#            switchGrpList = switchGrpList,
#            compareOrReference = compareOrReference)+ #addThemes
#       axisLabs(x =xyLable[[1]], y = xyLable[[2]])+
#       themeF(thme = themes)+
#       otherTheme
#   }
# } # end of display plot function

# structure(list(name = c("miR156a", "miR156b-5p", "miR156b-3p", 
#                         "miR156c-5p", "miR156c-3p", "miR156d", "miR156e", "miR156f-5p", 
#                         "miR156f-3p", "miR156g-5p", "miR156g-3p", "miR156h-5p", "miR156h-3p", 
#                         "miR156i", "miR156j-5p", "miR156j-3p", "miR160a-5p", "miR160a-3p", 
#                         "miR160b-5p", "miR160b-3p", "miR160c-5p", "miR160c-3p", "miR160d-5p", 
#                         "miR160d-3p", "miR162a", "miR164a", "miR164b", "miR166a-5p", 
#                         "miR166a-3p", "miR166b-5p", "miR166b-3p", "miR166c-5p", "miR166c-3p", 
#                         "miR166d-5p", "miR166d-3p", "miR166e-5p", "miR166e-3p", "miR166f", 
#                         "miR167a-5p", "miR167a-3p", "miR167b", "miR167c-5p", "miR167c-3p", 
#                         "miR169a", "miR171a", "miR393a", "miR394", "miR395b", "miR395d", 
#                         "miR395e", "miR395g", "miR395h", "miR395i", "miR395j", "miR395k", 
#                         "miR395l", "miR395s", "miR395t", "miR395c", "miR395a", "miR395f", 
#                         "miR395u", "miR396a-5p", "miR396a-3p", "miR396b-5p", "miR396b-3p", 
#                         "miR396c-5p", "miR396c-3p", "miR397a", "miR397b", "miR398a", 
#                         "miR398b", "miR399a", "miR399b", "miR399c", "miR399d", "miR399e", 
#                         "miR399f", "miR399g", "miR399h", "miR399i", "miR399j", "miR399k", 
#                         "miR156k", "miR156l-5p", "miR156l-3p", "miR159a.2", "miR159a.1", 
#                         "miR159b", "miR159c", "miR159d", "miR159e", "miR159f", "miR319a-5p", 
#                         "miR319a-3p", "miR319a-3p.2-3p", "miR319b", "miR160e-5p", "miR160e-3p", 
#                         "miR160f-5p", "miR160f-3p", "miR162b", "miR164c", "miR164d", 
#                         "miR164e", "miR166k-5p", "miR166k-3p", "miR166l-5p", "miR166l-3p", 
#                         "miR167d-5p", "miR167d-3p", "miR167e-5p", "miR167e-3p", "miR167f", 
#                         "miR167g", "miR167h-5p", "miR167h-3p", "miR167i-5p", "miR167i-3p", 
#                         "miR168a-5p", "miR168a-3p", "miR168b", "miR169b", "miR169c", 
#                         "miR169d", "miR169e", "miR169f.2", "miR169f.1", "miR169g", "miR169h", 
#                         "miR169i-5p.2", "miR169i-5p.1", "miR169i-3p", "miR169j", "miR169k", 
#                         "miR169l", "miR169m", "miR169n", "miR169o", "miR169p", "miR169q", 
#                         "miR171b", "miR171c-5p", "miR171c-3p", "miR171d-5p", "miR171d-3p", 
#                         "miR171e-5p", "miR171e-3p", "miR171f-5p", "miR171f-3p", "miR171g", 
#                         "miR172a", "miR172b", "miR172c", "miR166g-5p", "miR166g-3p", 
#                         "miR166h-5p", "miR166h-3p", "miR166i-5p", "miR166i-3p", "miR171h", 
#                         "miR393b-5p", "miR393b-3p", "miR408-5p", "miR408-3p", "miR172d-5p", 
#                         "miR172d-3p", "miR171i-5p", "miR171i-3p", "miR167j", "miR166m", 
#                         "miR166j-5p", "miR166j-3p", "miR164f", "miR413", "miR414", "miR415", 
#                         "miR416", "miR417", "miR418", "miR419", "miR426", "miR435", "miR437", 
#                         "miR438", "miR390-5p", "miR390-3p", "miR439a", "miR439b", "miR439c", 
#                         "miR439d", "miR439e", "miR439f", "miR439g", "miR439h", "miR439i", 
#                         "miR440", "miR396e-5p", "miR396e-3p", "miR443", "miR444a-5p", 
#                         "miR444a-3p.2", "miR444a-3p.1", "miR528-5p", "miR528-3p", "miR529a", 
#                         "miR530-5p", "miR530-3p", "miR531a", "miR535-5p", "miR535-3p", 
#                         "miR395m", "miR395n", "miR395o", "miR395p", "miR395q", "miR395v", 
#                         "miR395w", "miR395r", "miR810a", "miR812a", "miR812b", "miR812c", 
#                         "miR812d", "miR812e", "miR814a", "miR814b", "miR814c", "miR815a", 
#                         "miR815b", "miR815c", "miR816", "miR817", "miR818a", "miR818b", 
#                         "miR818c", "miR818d", "miR818e", "miR820a", "miR820b", "miR820c", 
#                         "miR821a", "miR821b", "miR821c", "miR529b", "miR1423-5p", "miR1423-3p", 
#                         "miR1424", "miR1425-5p", "miR1425-3p", "miR1426", "miR1427", 
#                         "miR1428a-5p", "miR1428a-3p", "miR1429-5p", "miR1429-3p", "miR1430", 
#                         "miR1431", "miR1432-5p", "miR1432-3p", "miR169r-5p", "miR169r-3p", 
#                         "miR444b.2", "miR444b.1", "miR444c.2", "miR444c.1", "miR444d.3", 
#                         "miR444d.2", "miR444d.1", "miR444e", "miR444f", "miR810b.1", 
#                         "miR810b.2", "miR1435", "miR1436", "miR1437a", "miR1438", "miR1440a", 
#                         "miR1441", "miR1442", "miR1439", "miR531b", "miR1846d-5p", "miR1846d-3p", 
#                         "miR1847.1", "miR1847.2", "miR1848", "miR1849", "miR1850.1", 
#                         "miR1850.2", "miR1850.3", "miR1851", "miR1852", "miR1853-5p", 
#                         "miR1853-3p", "miR1854-5p", "miR1854-3p", "miR1855", "miR1856", 
#                         "miR1857-5p", "miR1857-3p", "miR1428b", "miR1428c", "miR1428d", 
#                         "miR1428e-5p", "miR1428e-3p", "miR1858a", "miR1858b", "miR1846a-5p", 
#                         "miR1846a-3p", "miR1846b-5p", "miR1846b-3p", "miR1859", "miR1860-5p", 
#                         "miR1860-3p", "miR1861a", "miR1861b", "miR1861c", "miR1861d", 
#                         "miR1861e", "miR1861f", "miR1861g", "miR1861h", "miR1861i", "miR1861j", 
#                         "miR1861k", "miR1861l", "miR1861m", "miR1861n", "miR1862a", "miR1862b", 
#                         "miR1862c", "miR1863a", "miR1864", "miR1865-5p", "miR1865-3p", 
#                         "miR1866-5p", "miR1866-3p", "miR1868", "miR812f", "miR1869", 
#                         "miR1870-5p", "miR1870-3p", "miR1871", "miR1872", "miR1873", 
#                         "miR1874-5p", "miR1874-3p", "miR1875", "miR1862d", "miR1876", 
#                         "miR1862e", "miR1877", "miR1878", "miR1879", "miR1880", "miR1881", 
#                         "miR1882a", "miR1882b", "miR1882c", "miR1882d", "miR1882e-5p", 
#                         "miR1882e-3p", "miR1882f", "miR1882g", "miR1882h", "miR812g", 
#                         "miR812h", "miR812i", "miR812j", "miR1883a", "miR1883b", "miR1319a", 
#                         "miR1320-5p", "miR1320-3p", "miR1846c-5p", "miR1846c-3p", "miR2055", 
#                         "miR827", "miR1846e", "miR1428f-5p", "miR1428g-5p", "miR2090", 
#                         "miR2091-5p", "miR2091-3p", "miR2092-5p", "miR2092-3p", "miR2093-5p", 
#                         "miR2093-3p", "miR2094-5p", "miR2094-3p", "miR2095-5p", "miR2095-3p", 
#                         "miR2096-5p", "miR2096-3p", "miR2097-5p", "miR2097-3p", "miR2098-5p", 
#                         "miR2098-3p", "miR2099-5p", "miR2099-3p", "miR2100-5p", "miR2100-3p", 
#                         "miR2101-5p", "miR2101-3p", "miR2102-5p", "miR2102-3p", "miR396f-5p", 
#                         "miR396f-3p", "miR2103", "miR2104", "miR2105", "miR2106", "miR2120", 
#                         "miR2121a", "miR2121b", "miR2122", "miR2118a", "miR2118b", "miR2118c", 
#                         "miR2118d", "miR2118e", "miR2118f", "miR2118g", "miR2118h", "miR2118i", 
#                         "miR2118j", "miR2118k", "miR2118l", "miR2118m", "miR2118n", "miR2118o", 
#                         "miR2118p", "miR2118q", "miR2118r", "miR2275a", "miR2275b", "miR2863a", 
#                         "miR2864.1", "miR2864.2", "miR2865", "miR2866", "miR2867-5p", 
#                         "miR2867-3p", "miR2868", "miR2869", "miR2870", "miR2863b", "miR2905", 
#                         "miR2871a-5p", "miR2871a-3p", "miR2871b-5p", "miR2871b-3p", "miR2872", 
#                         "miR2873a", "miR2874", "miR2875", "miR2876-5p", "miR2876-3p", 
#                         "miR2877", "miR2878-5p", "miR2878-3p", "miR1863c", "miR2879", 
#                         "miR2880", "miR396g", "miR396h", "miR396d", "miR1863b", "miR1863b.2", 
#                         "miR2907a", "miR2907b", "miR2907c", "miR2907d", "miR2918", "miR2919", 
#                         "miR2920", "miR2921", "miR2922", "miR2923", "miR2924", "miR2925", 
#                         "miR2926", "miR2927", "miR2928", "miR2929", "miR2930", "miR2931", 
#                         "miR2932", "miR395x", "miR395y", "miR812k", "miR812l", "miR812m", 
#                         "miR1862f", "miR1862g", "miR3979-5p", "miR3979-3p", "miR3980a-5p", 
#                         "miR3980a-3p", "miR3980b-5p", "miR3980b-3p", "miR812n-5p", "miR812n-3p", 
#                         "miR812o-5p", "miR812o-3p", "miR3981-5p", "miR3981-3p", "miR2873b", 
#                         "miR3982-5p", "miR3982-3p", "miR5071", "miR5072", "miR5073", 
#                         "miR5074", "miR5075", "miR5076", "miR5077", "miR5078", "miR5079a", 
#                         "miR5080", "miR5081", "miR5082", "miR5083", "miR5143a", "miR5144-5p", 
#                         "miR5144-3p", "miR5145", "miR5146", "miR5147", "miR2863c", "miR5148a", 
#                         "miR5148b", "miR5148c", "miR5149", "miR5150-5p", "miR5150-3p", 
#                         "miR5151", "miR5152-5p", "miR5152-3p", "miR5153", "miR5154", 
#                         "miR5155", "miR5156", "miR5157a-5p", "miR5157a-3p", "miR5157b-5p", 
#                         "miR5157b-3p", "miR5158", "miR5159", "miR5160", "miR5161", "miR5162", 
#                         "miR5337a", "miR5338", "miR5339", "miR5340", "miR5484", "miR5485", 
#                         "miR5486", "miR5487", "miR5488", "miR5489", "miR5490", "miR5491", 
#                         "miR5492", "miR5493", "miR5494", "miR5495", "miR5496", "miR5497", 
#                         "miR5498", "miR5499", "miR5500", "miR5501", "miR5502", "miR5503", 
#                         "miR5504", "miR5505", "miR5506", "miR5507", "miR5508", "miR5509", 
#                         "miR5510", "miR5511", "miR5512a", "miR5513", "miR2275c", "miR5514", 
#                         "miR5515", "miR5516a", "miR5517", "miR5518", "miR5519", "miR5521", 
#                         "miR5522", "miR5523", "miR2275d", "miR5524", "miR5525", "miR5526", 
#                         "miR5527", "miR5528", "miR5529", "miR5530", "miR5531", "miR5532", 
#                         "miR5533", "miR5534a", "miR5534b", "miR5535", "miR5536", "miR5537", 
#                         "miR5538", "miR5539a", "miR5540", "miR5541", "miR5542", "miR5543", 
#                         "miR5544", "miR5788", "miR812p", "miR812q", "miR5789", "miR5790", 
#                         "miR5791", "miR5792", "miR5793", "miR5794", "miR812r", "miR5795", 
#                         "miR5796", "miR5797", "miR5798", "miR812s", "miR5799", "miR5800", 
#                         "miR5801a", "miR5802", "miR812t", "miR812u", "miR5803", "miR5804", 
#                         "miR5805", "miR5806", "miR812v", "miR5807", "miR5801b", "miR5809", 
#                         "miR5810", "miR5811", "miR5812", "miR5813", "miR5814", "miR5815", 
#                         "miR5816", "miR5143b", "miR5817", "miR5818", "miR5819", "miR5820", 
#                         "miR5821", "miR5822", "miR5823", "miR5824", "miR1319b", "miR5825", 
#                         "miR5826", "miR5827", "miR5828", "miR5829", "miR5830", "miR5831", 
#                         "miR5179", "miR5832", "miR5833", "miR5834", "miR5835", "miR2873c", 
#                         "miR5836", "miR5837.2", "miR5837.1", "miR5516b", "miR6245", "miR1440b", 
#                         "miR6246", "miR6247", "miR6248", "miR5337b", "miR6249a", "miR5512b", 
#                         "miR6250", "miR6251", "miR6252", "miR6253", "miR6254", "miR6255", 
#                         "miR6256", "miR818f", "miR1437b-5p", "miR1437b-3p", "miR7692-5p", 
#                         "miR7692-3p", "miR7693-5p", "miR7693-3p", "miR7694-5p", "miR7694-3p", 
#                         "miR7695-5p", "miR7695-3p", "miR1861o", "miR5079b", "miR5539b", 
#                         "miR6249b", "miR531c", "miR11336-5p", "miR11336-3p", "miR11337-5p", 
#                         "miR11337-3p", "miR11338-5p", "miR11338-3p", "miR11339-5p", "miR11339-3p", 
#                         "miR11340-5p", "miR11340-3p", "miR11341-5p", "miR11341-3p", "miR11342-5p", 
#                         "miR11342-3p", "miR11343-5p", "miR11343-3p", "miR11344-5p", "miR11344-3p", 
#                         "miR2120b-5p", "miR2120b-3p", "miR5801c-5p", "miR5801c-3p", "miR6245b-5p", 
#                         "miR6245b-3p")), class = "data.frame", row.names = c(NA, -738L
#                         ))