
# function to get collaborators and names from GS profiles
fcollabs <- function(gsid, lookforcollabs) {

  htmlpage <- read_html(paste0("https://scholar.google.nl/citations?user=", gsid, "&hl=en")) # so we paste the google scholar id
  profilename <- htmlpage %>% html_nodes(xpath = "//*/div[@id='gsc_prf_in']") %>% html_text() # we extract the profile name of that google scholar page
  profilecollabs <- as.data.frame(0) # empty df necessary for later

  if (lookforcollabs == 1) { # so if you want to look for collabs, set function to 1
    profilecollabs <- htmlpage %>% html_nodes(xpath = "//*/div[@class='gsc_rsb_aa']") %>% html_text() # extract the line with the GS id
    profilecollabs <- str_match(profilecollabs , "gsc_rsb-\\s*(.*?)\\s*-img") # then get the ID inbtween specific substrings
    profilecollabs <-  as.data.frame(profilecollabs[,2]) # that returns two elements, of which second element is the cleanest

  }
  if (nrow(profilecollabs)>1) { # if there ARE collabs
    profilecollabs <- as.data.frame(profilecollabs) # we want to...
    profilecollabs[,c("gs_id")] <- gsid #... add gs_ids of focal GS profile
    profilecollabs[,c("name")] <- profilename #...and the the profile name of GS profile attached

  } else {
    profilecollabs <- as.data.frame(cbind(gsid, profilename)) # if NOT looking for collabs...
    names(profilecollabs) <- c("gs_id", "name") #...we only attach gs_id and profilename

  }

  return(profilecollabs)
}
