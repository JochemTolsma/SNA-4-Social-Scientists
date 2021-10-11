```{r, eval=FALSE}

library(data.table)
library(tidyverse)
require(xml2)
require(rvest)
require(scholar)
require(stringr)


#save page
soc_staff_rug <- read_html("https://www.rug.nl/gmw/sociology/organisation/staff/")

#find links to personal names
links <- soc_staff_rug %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  str_subset("/staff/")

links <- links[-c(1:5, 92)]

websites <- NA
for (i in 1:length(links)) {
  websites[i] <- paste("https://www.rug.nl", links[i], sep="")
}
websites
#save names

names_staff <- list()

for (i in 1:length(websites)) {
  soc_staff_ind <- read_html(websites[i])
  names <- soc_staff_ind  %>% html_nodes(".rug-mb-0") %>% html_text
  names_staff[[i]] <- names[3]
  print(i)
}

names_staff

<!---there is a very nice sheet cheat for stringr--->

res <- str_split(unlist(names_staff), "\\(")
res2 <- sapply(res, function(x) x[2])
res3 <- str_split(res2, "\\)")
res3
firstname <- sapply(res3, function(x) x[1])
lastname <- sapply(res3, function(x) x[2])
lastname <- res3 <- str_split(lastname, "\\,")
lastname <- sapply(lastname, function(x) x[1])

soc_staff_rug <- na.omit(data.frame(firstname, lastname))

save(soc_staff_rug, file="addfiles\\soc_staff_rug.Rdata")
