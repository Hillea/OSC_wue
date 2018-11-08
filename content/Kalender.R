# creates date frame for dates in class

### Library
library(magrittr)
library(dplyr)
library(stringi)
library(knitr)
library(kableExtra) ## to do for "Awesome HTML Table with knitr::kable"

###17 Sitzungen (inkl. Vorlesungsfreitage/ -zeit)
Nr. <- c(1:3)

### Daten für jede Sitzung
Termine <- c()

for (i in Nr.){
  day <- (as.Date("2018-11-14") + (i*14-14)) %>% format("%d. %B %Y")
  Termine <- c(Termine,day)
}


### Thema für jede Sitzung
Thema <- c(
  
  ### Sitzung 1
  'Die 7 Todsünden der Psychologie',
  
  ### Sitzung 2
  'Gibt es eine Replikationskrise?',
  
  ### Sitzung 3
  'Was ist eine Replikation und was sollte repliziert werden?'
  
) 


### Paper für jede Sitzung
Paper <- c(
  
  ### Sitzung 1
  'Open Science Collaboration. (2015). 
Estimating the reproducibility of 
  psychological science. Science, 349, 
  aac4716.',
  
  ### Sitzung 2
  'Gibt es eine Replikationskrise?',
  
  ### Sitzung 3
  'Was ist eine Replikation und was sollte repliziert werden?'
  
) 

### zusätzliche Paper für jede Sitzung
zusPaper <- c(
  
  ### Sitzung 1
  'Open Science Collaboration. (2015). 
  Estimating the reproducibility of 
  psychological science. Science, 349, 
  aac4716.',
  
  ### Sitzung 2
  'Gibt es eine Replikationskrise?',
  
  ### Sitzung 3
  'Was ist eine Replikation und was sollte repliziert werden?'
  
) 

### Nr. Termin Thema in einer Tabelle
sitzungen <- data.frame(Nr., Termine, Thema, Paper, zusPaper) %>% 
  
  ### Vorlesungsfreie Tage
  filter(
    
    ### Weihnachten
    Termine != "24. Dezember 2018",
    
    ### Silvester
    Termine != "31. Dezember 2018") %>% 
  
  mutate(
    
    ### Anzahl Sitzungen ohne vorlesungsfreie Tage
    'Nr.' = 1:n())

### Tabelle in html für slides
sitzung_html <- 
  sitzungen %>%
  
  ### delete link to other slides in html table
  mutate(
    Thema = ifelse(
      stri_detect_coll(Thema, "Folien"),
      stri_extract_all_regex(Thema, ".+?(?=, \\[Folien\\])"),
      as.character(Thema))) %>% 
  
  kable(
    format = 'html',
    table.attr = "style='width:100%;'",
    align = c("c","c","l", "l", "l"))

### Tabelle in markdown für index.md
sitzung_md <- kable(sitzungen, format = 'markdown', align = c("c","c","l")) 

rm(day, i, Nr., Thema, Termine)

