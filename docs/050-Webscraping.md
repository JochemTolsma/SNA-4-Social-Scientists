# (PART) Part 4 Webscraping  {-} 

# Webscraping for Sociologists {#webintro}

Latest Version: 26-08-2021

Please email any comments to: bas.hofstra@ru.nl	

<!---I think I have run into the rate limit. to be able to build the book, I have set eval=FALSE globally--->




## Chapter overview
<p class= "quote">
"[The] technological revolution in mobile, Web, and Internet communications has the potential to revolutionize our understanding of ourselves and how we interact. Merton was right: Social science has still not found its Kepler. But three hundred years after Alexander Pope argued that the proper study of mankind should lie not in the heavens but in ourselves, we have finally found our telescope. Let the revolution begin..." [@watts2011everything: 266]
</p>

Watts' already-famous quote predicts a revolution in the social sciences. He and others [see also @lazer2009social] essentially argue that social science will be revolutionized by the unprecedented use of of the social internet. Given that people overwhelmingly adopted internet technologies and given that many of the platforms that offer these technologies automatically archive all kinds of behavior [@spiro2016research] such as clicks, messages, social media relationships, and so forth, there may be a treasure trove of data on the internet that social scientists can use for their research on social processes. In this chapter, we discuss some of the promises and pitfalls of webscraping so-called "digital trace" data [@golder2014digital] on the internet for social network analysis. We are then going to discuss some different techniques that are often used for webscraping. Note that the fast-pace nature of the internet inherently means that by the time you read this text, some of the things we discuss will be outdated. (Which can be argued to be one of the pitfalls of social science research with webscraping!) We are also getting our hands dirty with a hands-on example of digital trace data that we are going to collect ourselves. So by the end of this chapter, you will be familiar with some of the unique opportunities and difficulties of webscraped (social network) data, have a birds-eye perspective on the different techniques for scraping the web for your own research, have knowledge on the ethics surrounding webscraping, and have more in-depth experience on one specific package for webscraping bibliometric data in `R`. In short, you will have firsthand knowledge on the current state-of-the-art in sociological data collection. There are really good, exhaustive resources for webscraping and computational sociology. See, for instance, the book by Robert Ackland [@ackland2013web]. Yet, to get up to speed for this chapter, you need to read the first chapter of Bas Hofstra's dissertation [@hofstra2017online], Golder and Macy's Annual Review of Sociology article [@golder2014digital], and Lazer and colleagues' Science article [@lazer2009social]. 

(TODO: referenties in blue box zetten)

### Definitions

> **Webscraping**
>
> :   The process by which you collect data from the internet. This can entail different routes: manual data collection, automated data collection via code, and so forth.

> **Digital footprints**
>
> :   Automatically logged behavioral signals that actors -- broadly construed: individuals, companies, organizations, groups, etc. -- leave on the internet. This may imply many things, including the messages one leaves on Instagram posts, back-and-forth conversations on Whatsapp, companies' job advertisements, university course texts, and so forth. All of these signals can capture some social process: networking on social media, signalling specific job requirements, or university course prerequisites. This also means that digital footprints can contain a lot of different and sometimes unstructured data types. Social network data is obvious: who is friends with whom on Facebook, who Tweets to whom, and so forth. Network data (not social) is also obvious. For instance, which website links to what other websites. (Sidenote: Google's page-rank algorithm made them succesful, and this page-rank algorithm is based on network centrality that essentially filters out "influential" websites quickly. In other words, Google became such an influential company because of network analyses.) It can also contain (unstructured) text data, which in itself signals a lot of interesting social processes that one may consider. 

> **Computational sociology**
>
> :   Problem-driven, empirical sociology, but with the empirical part specifically containing some form of digital footprint data and/or some new methodological technique. Sociologists are usually (necessarily?) interested in digital footprints concerning some social process. Because digital footprints are often related to social *network* processes (e.g., befriending on Facebook, messaging on Twitter, etc.), a lot of computational sociology includes some form of social network analysis. Because this is  often, though not always, the case, discussing webscraping in the context of this book on social network analyses makes perfect sense. Some claim Agent-Based Modelling to be part of computational sociology too, others not. Again others claim performing RSiena analyses is part of computational sociology, others not. Note that this definition-issue is somewhat of a useless moving target. Computational sociology's definition will be different next week depending on who you ask. In this book, we use a pragmatic definition. This means that you are a computational sociologists if you use digital footprint data and/or use relatively new methodological techniques in your research. Also note that there is a certain cause-effect sequence in the three definions above: using webscraping techniques to gather digital footprint data to study social problems makes you a computational sociologist.

## Promises and pitfalls

Like every data source in the social sciences and beyond, there are unique features as well as difficult challenges to webscraped data. In this subsection, we will discuss some of these advantages and challenges of webscraping and, by extension, digital footprint data. Like we discussed before, most of the research using webscraped digital footprint data concerns social networks and so we situate these promises and pitfalls in the context of social network analysis. Note, however, that some of the promises and pitfalls generalize to other types of digital footprint data too.

### Promises

##### **(Social) networks** {-}  

One of the crucial advantages of scraping data from the internet is that it is relatively easy to collect sociologically interesting network data. This may sound like a surprising thing to note in a book on social network analyses. But imagine a world without the internet, and then imagine that you are a social scientist interested in *weak ties*. What toolset do you have available to collect data on and then study those weak ties? You would probably think about qualitative interviews or collecting survey data. For the purpose of studying weak ties, however, both of these methods of data collection suffer from some some weaknesses. For instance, it is incredibly hard for respondents to recall those social ties that are weakly related. So asking about weak ties will likely not yield very reliable and valid results. That is, respondents will mostly acquiesce to naming those ties that they met recently or which are relatively stronger. (There are some techniques to circumvent some of these issues, but those have their own drawbacks too [see @hofstra2021beyond].) Most surveys are also restricted, in that respondents can only name five social ties. It is possible to collect sociometric data of entire contexts in surveys, for instance by presenting respondents with a class-roster or department-roster and asking them who their trustees, friends, etc. This book even devotes an entire section to such data. Yet, such a design is pretty expensive to set up and quite taxing for respondents.

In contrast, an inherent feature of many places on the social internet, respondents curate themselves who their connections are over a long time-span (e.g., friendships on Facebook) or leave many traces of interactions (e.g., mentioning someone on Twitter). Sometimes networks online are even pushed towards network closure by recommendation systems on platforms like Facebook or Instagram. These data are relatively easy and cheap to collect with some creativity on the scientist's part. This will often lead to large and complete networks are not restricted by relationship type (e.g., strong or weak), social context (e.g., family or school friends), respondent recall (acquiesce to strong ties), or social desirability bias (e.g., only nominating the popular kid in town). As an examplary paper who circumvents some of the "regular" biases of social network research mentioned above, see @hofstra2017sources who analyze segregation among weak ties by means of Facebook data. The benefits mentioned here are also prime reasons as to why much research using digital traces incorporates some type of social network analysis.

##### **Dynamics** {-}  

A second advantage of webscraped data is that these data are often *time-stamped*. This means that the the researcher knows exactly when the digital trace -- e.g., the social interaction on Twitter -- occurred. So the researcher can potentially perform some sort of longitudinal analyses so as to come closer to causal estimates in inferential statistical models. In the context of webscraped social networks this is particularly useful so as to separate selection from influence in larger social networks. Gathering such longitudinal sociometric data for many social foci (e.g., school classes) is difficult (yet, definitely not impossible!), whereas collecting time-stamped social interactions on the internet may be somewhat easier. Note also that whereas network data collected in, for instance, school classes often contain the same time-stamp and that longitudinal sociometric data is often collected using the same timestamp 

##### **Signals** {-}  

A third advantage of webscraped data is that it can potentially capture behavioral signals that are otherwise hard to come by. In controlled lab environments some xyz, it's hard. In survey data it's hard to xyz. Yet, online xyz, makes that we can xyz. Similar to online social network data, digital footprints can be unobtrusively collected, such that social desirability biases or xyz . One should, however, be aware that the way one behaves online may not necessarily be representative for "offline" behavior. Yet, to study sensitive topics such as political polarization, x, or y, digital trace data may offer an alternative route (one that is less prone to social desirability biases) to xxx.

##### **Size** {-}  

Finally, and we discuss why this is both a blessing and a curse, webscraping can lead to collected data that may contain a lot of observations. See this study of xyz, or this study by xyz of abc. More data is not always better data, yet the sheer size of data -- under appropriate sampling! -- may make it easier to observe some intervention xyz. See xyz.

### Pitfalls

##### **Sampling** {-}

- Often non representative (convenience sampling)

##### **Size** {-}

- Data size may be a pitfall; hard to analyze, sampling necessary, and sampling from social networks is especially hard

##### **Thin** {-}

- Many rows, yet not much information about those rows

##### **Data structure** {-}

- Unstructured data, hard to work with, requires some skill/imagination

## Best of both worlds?

The most-impactful computational sociology papers leverage the strengths of digital trace data but simultaneously account for (or at least acknowledge) its weaknesses. Some examples here

## Where does this lead us?

1- New tests of old sociological hypotheses made possible by the availability of digital footprint data;
2- Tests of newly derived sociological hypotheses made possible by the availability of digital footprint data;
3- Tests of new theories about "the internet" as social phenomenon by itself.

(TO DO: Small worlds nieuwe test oude vraag: mooi voorbeeld om te integreren.)

## Ethics

In webscraping digital footprins, one has to always consider ethics. In an ideal situation, a researcher has informed consent to study research subjects. In practice, however, the nature of webscraping digital footprints makes it very difficult to obtain such consent. Ethic review boards

## Webscraping techniques

### Manual

Army of research assistants looking up information, saving that

### APIs

Utilizing structures in place

### Crawling

Designing own crawlers

---

## Hands-on webscraping

<!---I think you should make clear in the beginning, what you want to scrape and why!! --> 
<!---I think you should also introduce the packge, manual, vignette a bit. So students see how you came up with the used functions. --->

Now that we learned about webscraping and some of its techniques, it is time to get our hands dirty ourselves. In what follows is a short tutorial on webscraping where we will be collecting data from webpages on the internet. We will use the specific case of sociology staff at Radboud University. What do they publish? Where? And with whom do they collaborate? We assume you followed the R tutorial in this book, or that you otherwise have at least some experience with coding in R. In the rest of this tutorial, we will switch between base R and Tidyverse (just a bit), whatever is most convenient. (Note that this will happen often if you become an applied computational sociologist.)

### Staging your script

* Open a new R-script (via file --\> new --\> RScript (or simply hit *Ctrl+Shift+N* or *Cmd+Shift+N* if you work on Mac)
* Before you start scraping and analyzing, take all the precautionary steps noted in \@ref(tutorial)

So for this tutorial, your starting script will look something like this:


```r
######################################### Title: Webscraping in R Author: Bas Hofstra Version: 29-07-2021

# start with clean workspace
rm(list = ls())

library(tidyverse)  # I assume you already installed this one!
install.packages("httr")
require(httr)
install.packages("xml2")
require(xml2)
install.packages("rvest")
require(rvest)
install.packages("devtools")
require(devtools)
# Note we're doing something different here. We're installing a *latest* version directly from GitHub
# This is because the released version of this packages contains some errors!
devtools::install_github("jkeirstead/scholar")

require(scholar)

# define workdirectory, note the double backslashes setwd('/yourpathhere)'
```

### Getting "anchor" data

What do we mean by anchor data? Our goal is to get to know (i) who the Radboud University Department of Sociology staff is, (ii) what they publish with respect to scientific work, and (iii) who they collaborate with. So that means at least three data sources we need to collect from somewhere. What would be a nice starting (read: anchor) point be? First, we have to know who is on the sociology staff. Let's check out [the Radboud sociology website](https://www.ru.nl/sociology/). There is lots of intruiging information, but not on who is who. There is, however, a specific link to the [research staff](https://www.ru.nl/sociology/research/staff/). Here we do see a nice list on who is on the sociology staff. How do we get that data? It is actually quite simple, the package `xml2` has a very nice function `html_read()` which simply derives the source html of a webpage:



```r
# Let's first get the staff page read_html is a function that simply extracts html webpages and puts
# them in xml format
soc_staff <- read_html("https://www.ru.nl/sociology/research/staff/")
```


```r
head(soc_staff)
```

That looks kinda weird. What type of object did we store it by putting the html into `soc_staff`?

```r
class(soc_staff)
```

So it is is stored in something that's called an xml object. Not important for now what that is. But it is important to extract the relevant table that we saw on the sociology staff website. How do we do that? Go to the [https://www.ru.nl/sociology/research/staff/]("googlechromes://www.ru.nl/sociology/research/staff/") in Google Chrome and then press "Inspect" on the webpage (right click--\>Inspect).



Look at the screenshot below, you should be able to see something like this. In the html code we extracted from the Radboud website, we need to go to one of the nodes first. If you move your cursor over "body" in the html code on the right-hand side of your screen, the entire "body" of the page should become some shade of blue. This means that the elements encapsulated in the "body" node captures everything that turned blue.



Next, we need to look at the specific elements on the page that we need to extract. Somewhat by informed trial and error, looking for the correct code, we can select the elements we want. In the screenshot below, you see that the "td" elements actually are the ones we need. So we need code that looks for the node "body" and the "td" elements in the xml object and then extract those elements in it. Note that you can click on the arrows once you are in the "Inspect" mode in the web browser to trial-and-error to get at the correct elements.



Something like the code below should do just that:


```r
# so we need to find WHERE the table is located in the html 'inspect element' in mozilla firefox or
# 'view page source' and you see that everything AFTER /td in the 'body' of the page seems to be the
# table we do need
soc_staff <- soc_staff %>% rvest::html_nodes("body") %>% xml2::xml_find_all("//td") %>% rvest::html_text()
```



> Question: What happens in the code above? Why do we specify 'body' and '//td'? 

Let us check out what happened to the soc_staff object now:




```r
head(soc_staff)  # looks much better!
```

```
#> [1] "Staff:"                                                                                        
#> [2] "Expertise:"                                                                                    
#> [3] "Batenburg, prof. dr. R. (Ronald)"                                                              
#> [4] "Healthcare, labour market and healthcare professions and training"                             
#> [5] "Begall, dr. K.H. (Katia)"                                                                      
#> [6] "Family, life course, labour market participation, division of household tasks and gender norms"
```

So it looks much nicer but does not seem to be in the entirely correct order. We have odd rows and even rows: odd rows are names, even rows have the expertise of staff. We need to get a bit creative to put the data in a nicer format. The `%%` operator gives a "remainder" of integers (whole numbers). So 10/2=5 with no remainder, but 11/2=5 with a remainder of 1. 

```r
odd <- function(x) x%%2 != 0
even <- function(x) x%%2 == 0
```

> Question: Can you find out what the following function does?

How long are the data?


```r
nstaf <- length(soc_staff)
nstaf
```

```
#> [1] 92
```

Alright, can we get the odd rows out of there?


```r
soc_names <- soc_staff[odd(1:nstaf)]  # in the 1 until 94st number, get the odd elements
soc_names
```

```
#>  [1] "Staff:"                                                                                                                                                            
#>  [2] "Batenburg, prof. dr. R. (Ronald)"                                                                                                                                  
#>  [3] "Begall, dr. K.H. (Katia)"                                                                                                                                          
#>  [4] "Bekhuis, dr. H. (Hidde)"                                                                                                                                           
#>  [5] "Berg, dr. L. van den (Lonneke)"                                                                                                                                    
#>  [6] "Blommaert, dr. L. (Lieselotte)"                                                                                                                                    
#>  [7] "Damman, dr. M. (Marleen)"                                                                                                                                          
#>  [8] "Eisinga, prof. dr. R.N. (Rob)"                                                                                                                                     
#>  [9] "Gesthuizen, dr. M.J.W. (Maurice)"                                                                                                                                  
#> [10] "Glas, dr. S. (Saskia)"                                                                                                                                             
#> [11] "Hek, dr. M. van (Margriet)"                                                                                                                                        
#> [12] "Hoekman, dr. R. H. A.(Remco)"                                                                                                                                      
#> [13] "Hofstra, dr. B. (Bas)"                                                                                                                                             
#> [14] "Kraaykamp, prof. dr. G.L.M. (Gerbert)"                                                                                                                             
#> [15] "Meuleman, dr. (Roza)"                                                                                                                                              
#> [16] "Savelkoul, dr. M.J. (Michael)"                                                                                                                                     
#> [17] "Scheepers, prof. dr. P.L.H. (Peer)"                                                                                                                                
#> [18] "Spierings, dr. C.H.B.M. (Niels)"                                                                                                                                   
#> [19] "Tolsma, dr. J. (Jochem)"                                                                                                                                           
#> [20] "\r\n                                Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department\r\n                              "
#> [21] "Visser, dr. M. (Mark)"                                                                                                                                             
#> [22] "Wolbers, prof. dr. M.H.J. (Maarten)"                                                                                                                               
#> [23] "PhD:"                                                                                                                                                              
#> [24] "Bussemakers, C. (Carlijn) MSc"                                                                                                                                     
#> [25] "Franken, R. (Rob) MSc"                                                                                                                                             
#> [26] "Firat, M. (Mustafa) MSc"                                                                                                                                           
#> [27] "Geurts, P.G. (Nella) MSc"                                                                                                                                          
#> [28] "Hendriks, I.P. (Inge) MSc"                                                                                                                                         
#> [29] "Jeroense, T.M.G. (Thijmen) MSc"                                                                                                                                    
#> [30] "Linders, N. (Nik) MSc"                                                                                                                                             
#> [31] "Loh, S.M. (Renae) MSc"                                                                                                                                             
#> [32] "Meijeren, M. (Maikel) MSc"                                                                                                                                         
#> [33] "Mensvoort, C.A. van (Carly) MSc"                                                                                                                                   
#> [34] "Müller, K. (Katrin) MSc"                                                                                                                                           
#> [35] "Raiber, K. (Klara) MSc"                                                                                                                                            
#> [36] "Ramaekers, M.J.M. (Marlou) MSc"                                                                                                                                    
#> [37] "Wiertsema, S. (Sara) MSc"                                                                                                                                          
#> [38] "External PhD:"                                                                                                                                                     
#> [39] "Betkó, drs. J.G. (János)"                                                                                                                                          
#> [40] "Houten, J. (Jasper) van MSc"                                                                                                                                       
#> [41] "Middendorp J. (Jansje) van MSc"                                                                                                                                    
#> [42] "Vis, E. (Elize) MSc"                                                                                                                                               
#> [43] "Weber, T. (Tijmen) MSc"                                                                                                                                            
#> [44] "Guest researchers:"                                                                                                                                                
#> [45] "Sterkens, dr. C.J.A. (Carl)"                                                                                                                                       
#> [46] "Vermeer, dr. P.A.D.M. (Paul)"
```

And how about people's expertise?

```r
soc_experts <- soc_staff[even(1:nstaf)]  # in the 1 until 94st number, get the even elements
soc_experts
```

```
#>  [1] "Expertise:"                                                                                                    
#>  [2] "Healthcare, labour market and healthcare professions and training"                                             
#>  [3] "Family, life course, labour market participation, division of household tasks and gender norms"                
#>  [4] "Welfare state, nationalism and sports"                                                                         
#>  [5] "Family, life course and transition to adulthood"                                                               
#>  [6] "Discrimination and inequality on the labour market"                                                            
#>  [7] "Labour market, life course, older workers, retirement and solo self-employed"                                  
#>  [8] "Methods of research and statistics"                                                                            
#>  [9] "\r\n                                Poverty en social cohesion\r\n                              "              
#> [10] "Islam, gender attitudes and sexuality"                                                                         
#> [11] "Educational inequality, gender inequality, organizational sociology and culture"                               
#> [12] "Sports and policy sociology"                                                                                   
#> [13] "Diversity, inequality and innovation"                                                                          
#> [14] "Educational inequality, culture and health"                                                                    
#> [15] "Culture and nationalism"                                                                                       
#> [16] "Ethnic diversity, prejudice and social cohesion"                                                               
#> [17] "Comparative research, social cohesion and diversity"                                                           
#> [18] "Islam, gender, populism, social media, Middle East and migration"                                              
#> [19] "Inequality, criminology and ethnic diversity"                                                                  
#> [20] "Health, family and work"                                                                                       
#> [21] "Older workers, radicalism and social cohesion"                                                                 
#> [22] "Educational inequality and labour market inequality"                                                           
#> [23] "Expertise:"                                                                                                    
#> [24] "Adverse youth experiences and social inequality"                                                               
#> [25] "Sport networks and motivation for sustainable sports participation"                                            
#> [26] "Social inequality, older workers, life course and retirement"                                                  
#> [27] "Integration and migration"                                                                                     
#> [28] "Resistance to refugees and social cohesion"                                                                    
#> [29] "Political participation, segregation, opinion polarization and voting behaviour"                               
#> [30] "Populism, gender, masculinity and sexuality"                                                                   
#> [31] "Educational sociology, social stratification, gender inequality and information communication technology (ICT)"
#> [32] "Social capital, volunteer work and diversity"                                                                  
#> [33] "Gender, leadership and social norms"                                                                           
#> [34] "Opinions about discrimination, migration and inequality"                                                       
#> [35] "Informal care, employment, social inequality and gender"                                                       
#> [36] "Prosocial behaviour and family"                                                                                
#> [37] "Inequality in sports and physical activity, school-to-work transition and employment"                          
#> [38] "Expertise:"                                                                                                    
#> [39] "Social assistance benefit, poverty, reintegration, RCT and social experiment"                                  
#> [40] "Sports"                                                                                                        
#> [41] "Home administration"                                                                                           
#> [42] "Healthcare, labour market, healthcare professions and training, health and social capital"                     
#> [43] "International student mobility and the internationalization of higher education"                               
#> [44] "Expertise:"                                                                                                    
#> [45] "Religious conflicts, cohesion, religion and the philosophy of life"                                            
#> [46] "Socialization processes, secularisation, religion and the philosophy of life"
```

Finally, can we merge those two vectors?

```r
soc_df <- data.frame(cbind(soc_names, soc_experts))  # columnbind those and we have a DF for soc staff!
soc_df
```

```
#>                                                                                                                                                             soc_names
#> 1                                                                                                                                                              Staff:
#> 2                                                                                                                                    Batenburg, prof. dr. R. (Ronald)
#> 3                                                                                                                                            Begall, dr. K.H. (Katia)
#> 4                                                                                                                                             Bekhuis, dr. H. (Hidde)
#> 5                                                                                                                                      Berg, dr. L. van den (Lonneke)
#> 6                                                                                                                                      Blommaert, dr. L. (Lieselotte)
#> 7                                                                                                                                            Damman, dr. M. (Marleen)
#> 8                                                                                                                                       Eisinga, prof. dr. R.N. (Rob)
#> 9                                                                                                                                    Gesthuizen, dr. M.J.W. (Maurice)
#> 10                                                                                                                                              Glas, dr. S. (Saskia)
#> 11                                                                                                                                         Hek, dr. M. van (Margriet)
#> 12                                                                                                                                       Hoekman, dr. R. H. A.(Remco)
#> 13                                                                                                                                              Hofstra, dr. B. (Bas)
#> 14                                                                                                                              Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 15                                                                                                                                               Meuleman, dr. (Roza)
#> 16                                                                                                                                      Savelkoul, dr. M.J. (Michael)
#> 17                                                                                                                                 Scheepers, prof. dr. P.L.H. (Peer)
#> 18                                                                                                                                    Spierings, dr. C.H.B.M. (Niels)
#> 19                                                                                                                                            Tolsma, dr. J. (Jochem)
#> 20 \r\n                                Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department\r\n                              
#> 21                                                                                                                                              Visser, dr. M. (Mark)
#> 22                                                                                                                                Wolbers, prof. dr. M.H.J. (Maarten)
#> 23                                                                                                                                                               PhD:
#> 24                                                                                                                                      Bussemakers, C. (Carlijn) MSc
#> 25                                                                                                                                              Franken, R. (Rob) MSc
#> 26                                                                                                                                            Firat, M. (Mustafa) MSc
#> 27                                                                                                                                           Geurts, P.G. (Nella) MSc
#> 28                                                                                                                                          Hendriks, I.P. (Inge) MSc
#> 29                                                                                                                                     Jeroense, T.M.G. (Thijmen) MSc
#> 30                                                                                                                                              Linders, N. (Nik) MSc
#> 31                                                                                                                                              Loh, S.M. (Renae) MSc
#> 32                                                                                                                                          Meijeren, M. (Maikel) MSc
#> 33                                                                                                                                    Mensvoort, C.A. van (Carly) MSc
#> 34                                                                                                                                            Müller, K. (Katrin) MSc
#> 35                                                                                                                                             Raiber, K. (Klara) MSc
#> 36                                                                                                                                     Ramaekers, M.J.M. (Marlou) MSc
#> 37                                                                                                                                           Wiertsema, S. (Sara) MSc
#> 38                                                                                                                                                      External PhD:
#> 39                                                                                                                                           Betkó, drs. J.G. (János)
#> 40                                                                                                                                        Houten, J. (Jasper) van MSc
#> 41                                                                                                                                     Middendorp J. (Jansje) van MSc
#> 42                                                                                                                                                Vis, E. (Elize) MSc
#> 43                                                                                                                                             Weber, T. (Tijmen) MSc
#> 44                                                                                                                                                 Guest researchers:
#> 45                                                                                                                                        Sterkens, dr. C.J.A. (Carl)
#> 46                                                                                                                                       Vermeer, dr. P.A.D.M. (Paul)
#>                                                                                                       soc_experts
#> 1                                                                                                      Expertise:
#> 2                                               Healthcare, labour market and healthcare professions and training
#> 3                  Family, life course, labour market participation, division of household tasks and gender norms
#> 4                                                                           Welfare state, nationalism and sports
#> 5                                                                 Family, life course and transition to adulthood
#> 6                                                              Discrimination and inequality on the labour market
#> 7                                    Labour market, life course, older workers, retirement and solo self-employed
#> 8                                                                              Methods of research and statistics
#> 9                \r\n                                Poverty en social cohesion\r\n                              
#> 10                                                                          Islam, gender attitudes and sexuality
#> 11                                Educational inequality, gender inequality, organizational sociology and culture
#> 12                                                                                    Sports and policy sociology
#> 13                                                                           Diversity, inequality and innovation
#> 14                                                                     Educational inequality, culture and health
#> 15                                                                                        Culture and nationalism
#> 16                                                                Ethnic diversity, prejudice and social cohesion
#> 17                                                            Comparative research, social cohesion and diversity
#> 18                                               Islam, gender, populism, social media, Middle East and migration
#> 19                                                                   Inequality, criminology and ethnic diversity
#> 20                                                                                        Health, family and work
#> 21                                                                  Older workers, radicalism and social cohesion
#> 22                                                            Educational inequality and labour market inequality
#> 23                                                                                                     Expertise:
#> 24                                                                Adverse youth experiences and social inequality
#> 25                                             Sport networks and motivation for sustainable sports participation
#> 26                                                   Social inequality, older workers, life course and retirement
#> 27                                                                                      Integration and migration
#> 28                                                                     Resistance to refugees and social cohesion
#> 29                                Political participation, segregation, opinion polarization and voting behaviour
#> 30                                                                    Populism, gender, masculinity and sexuality
#> 31 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 32                                                                   Social capital, volunteer work and diversity
#> 33                                                                            Gender, leadership and social norms
#> 34                                                        Opinions about discrimination, migration and inequality
#> 35                                                        Informal care, employment, social inequality and gender
#> 36                                                                                 Prosocial behaviour and family
#> 37                           Inequality in sports and physical activity, school-to-work transition and employment
#> 38                                                                                                     Expertise:
#> 39                                   Social assistance benefit, poverty, reintegration, RCT and social experiment
#> 40                                                                                                         Sports
#> 41                                                                                            Home administration
#> 42                      Healthcare, labour market, healthcare professions and training, health and social capital
#> 43                                International student mobility and the internationalization of higher education
#> 44                                                                                                     Expertise:
#> 45                                             Religious conflicts, cohesion, religion and the philosophy of life
#> 46                                   Socialization processes, secularisation, religion and the philosophy of life
```

That looks much better! Now we only need to remove the redundant rows that state "expertise", "staff," and so forth.


```r
# inspect again, and remove the rows we don't need (check for yourself to be certain!)


delrows <- which(soc_df$soc_names == "Staff:" | soc_df$soc_names == "PhD:" | soc_df$soc_names == "External PhD:" | 
    soc_df$soc_names == "Guest researchers:")

soc_df <- soc_df[-delrows, ]

soc_df
```

```
#>                                                                                                                                                             soc_names
#> 2                                                                                                                                    Batenburg, prof. dr. R. (Ronald)
#> 3                                                                                                                                            Begall, dr. K.H. (Katia)
#> 4                                                                                                                                             Bekhuis, dr. H. (Hidde)
#> 5                                                                                                                                      Berg, dr. L. van den (Lonneke)
#> 6                                                                                                                                      Blommaert, dr. L. (Lieselotte)
#> 7                                                                                                                                            Damman, dr. M. (Marleen)
#> 8                                                                                                                                       Eisinga, prof. dr. R.N. (Rob)
#> 9                                                                                                                                    Gesthuizen, dr. M.J.W. (Maurice)
#> 10                                                                                                                                              Glas, dr. S. (Saskia)
#> 11                                                                                                                                         Hek, dr. M. van (Margriet)
#> 12                                                                                                                                       Hoekman, dr. R. H. A.(Remco)
#> 13                                                                                                                                              Hofstra, dr. B. (Bas)
#> 14                                                                                                                              Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 15                                                                                                                                               Meuleman, dr. (Roza)
#> 16                                                                                                                                      Savelkoul, dr. M.J. (Michael)
#> 17                                                                                                                                 Scheepers, prof. dr. P.L.H. (Peer)
#> 18                                                                                                                                    Spierings, dr. C.H.B.M. (Niels)
#> 19                                                                                                                                            Tolsma, dr. J. (Jochem)
#> 20 \r\n                                Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department\r\n                              
#> 21                                                                                                                                              Visser, dr. M. (Mark)
#> 22                                                                                                                                Wolbers, prof. dr. M.H.J. (Maarten)
#> 24                                                                                                                                      Bussemakers, C. (Carlijn) MSc
#> 25                                                                                                                                              Franken, R. (Rob) MSc
#> 26                                                                                                                                            Firat, M. (Mustafa) MSc
#> 27                                                                                                                                           Geurts, P.G. (Nella) MSc
#> 28                                                                                                                                          Hendriks, I.P. (Inge) MSc
#> 29                                                                                                                                     Jeroense, T.M.G. (Thijmen) MSc
#> 30                                                                                                                                              Linders, N. (Nik) MSc
#> 31                                                                                                                                              Loh, S.M. (Renae) MSc
#> 32                                                                                                                                          Meijeren, M. (Maikel) MSc
#> 33                                                                                                                                    Mensvoort, C.A. van (Carly) MSc
#> 34                                                                                                                                            Müller, K. (Katrin) MSc
#> 35                                                                                                                                             Raiber, K. (Klara) MSc
#> 36                                                                                                                                     Ramaekers, M.J.M. (Marlou) MSc
#> 37                                                                                                                                           Wiertsema, S. (Sara) MSc
#> 39                                                                                                                                           Betkó, drs. J.G. (János)
#> 40                                                                                                                                        Houten, J. (Jasper) van MSc
#> 41                                                                                                                                     Middendorp J. (Jansje) van MSc
#> 42                                                                                                                                                Vis, E. (Elize) MSc
#> 43                                                                                                                                             Weber, T. (Tijmen) MSc
#> 45                                                                                                                                        Sterkens, dr. C.J.A. (Carl)
#> 46                                                                                                                                       Vermeer, dr. P.A.D.M. (Paul)
#>                                                                                                       soc_experts
#> 2                                               Healthcare, labour market and healthcare professions and training
#> 3                  Family, life course, labour market participation, division of household tasks and gender norms
#> 4                                                                           Welfare state, nationalism and sports
#> 5                                                                 Family, life course and transition to adulthood
#> 6                                                              Discrimination and inequality on the labour market
#> 7                                    Labour market, life course, older workers, retirement and solo self-employed
#> 8                                                                              Methods of research and statistics
#> 9                \r\n                                Poverty en social cohesion\r\n                              
#> 10                                                                          Islam, gender attitudes and sexuality
#> 11                                Educational inequality, gender inequality, organizational sociology and culture
#> 12                                                                                    Sports and policy sociology
#> 13                                                                           Diversity, inequality and innovation
#> 14                                                                     Educational inequality, culture and health
#> 15                                                                                        Culture and nationalism
#> 16                                                                Ethnic diversity, prejudice and social cohesion
#> 17                                                            Comparative research, social cohesion and diversity
#> 18                                               Islam, gender, populism, social media, Middle East and migration
#> 19                                                                   Inequality, criminology and ethnic diversity
#> 20                                                                                        Health, family and work
#> 21                                                                  Older workers, radicalism and social cohesion
#> 22                                                            Educational inequality and labour market inequality
#> 24                                                                Adverse youth experiences and social inequality
#> 25                                             Sport networks and motivation for sustainable sports participation
#> 26                                                   Social inequality, older workers, life course and retirement
#> 27                                                                                      Integration and migration
#> 28                                                                     Resistance to refugees and social cohesion
#> 29                                Political participation, segregation, opinion polarization and voting behaviour
#> 30                                                                    Populism, gender, masculinity and sexuality
#> 31 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 32                                                                   Social capital, volunteer work and diversity
#> 33                                                                            Gender, leadership and social norms
#> 34                                                        Opinions about discrimination, migration and inequality
#> 35                                                        Informal care, employment, social inequality and gender
#> 36                                                                                 Prosocial behaviour and family
#> 37                           Inequality in sports and physical activity, school-to-work transition and employment
#> 39                                   Social assistance benefit, poverty, reintegration, RCT and social experiment
#> 40                                                                                                         Sports
#> 41                                                                                            Home administration
#> 42                      Healthcare, labour market, healthcare professions and training, health and social capital
#> 43                                International student mobility and the internationalization of higher education
#> 45                                             Religious conflicts, cohesion, religion and the philosophy of life
#> 46                                   Socialization processes, secularisation, religion and the philosophy of life
```

Now we have a nice relatively clean dataset with all sociology staff and their expterise. But there is yet some work to do before we can move on. We need to do some data cleaning. Ideally, we have staff their first and last names in clean columns. So the last name seems easy, everything before the comma. Do you understand the code below? `gsub` is a function that remove something and replaces it with something else. In the code below it replaces everything that's behind a comma with nothing in the column `soc_names` in the data frame `soc_df`.  

The first name is trickier, we need some more difficult *expressions* to extract first names from this string. It's not necessary for now to exactly know how the expressions below work, but if you want to get into it, here's [a nice resource](https://r4ds.had.co.nz/strings.html). The important part of the code below is that it extracts everything that's in between the brackets.


```r
# Last name seems to be everything before the comma
soc_df$last_name <- gsub(",.*$", "", soc_df$soc_names)

# first name is everything between brackets
soc_df$first_name <- str_extract_all(soc_df$soc_names, "(?<=\\().+?(?=\\))", simplify = TRUE)

soc_df
```

```
#>                                                                                                                                                             soc_names
#> 2                                                                                                                                    Batenburg, prof. dr. R. (Ronald)
#> 3                                                                                                                                            Begall, dr. K.H. (Katia)
#> 4                                                                                                                                             Bekhuis, dr. H. (Hidde)
#> 5                                                                                                                                      Berg, dr. L. van den (Lonneke)
#> 6                                                                                                                                      Blommaert, dr. L. (Lieselotte)
#> 7                                                                                                                                            Damman, dr. M. (Marleen)
#> 8                                                                                                                                       Eisinga, prof. dr. R.N. (Rob)
#> 9                                                                                                                                    Gesthuizen, dr. M.J.W. (Maurice)
#> 10                                                                                                                                              Glas, dr. S. (Saskia)
#> 11                                                                                                                                         Hek, dr. M. van (Margriet)
#> 12                                                                                                                                       Hoekman, dr. R. H. A.(Remco)
#> 13                                                                                                                                              Hofstra, dr. B. (Bas)
#> 14                                                                                                                              Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 15                                                                                                                                               Meuleman, dr. (Roza)
#> 16                                                                                                                                      Savelkoul, dr. M.J. (Michael)
#> 17                                                                                                                                 Scheepers, prof. dr. P.L.H. (Peer)
#> 18                                                                                                                                    Spierings, dr. C.H.B.M. (Niels)
#> 19                                                                                                                                            Tolsma, dr. J. (Jochem)
#> 20 \r\n                                Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department\r\n                              
#> 21                                                                                                                                              Visser, dr. M. (Mark)
#> 22                                                                                                                                Wolbers, prof. dr. M.H.J. (Maarten)
#> 24                                                                                                                                      Bussemakers, C. (Carlijn) MSc
#> 25                                                                                                                                              Franken, R. (Rob) MSc
#> 26                                                                                                                                            Firat, M. (Mustafa) MSc
#> 27                                                                                                                                           Geurts, P.G. (Nella) MSc
#> 28                                                                                                                                          Hendriks, I.P. (Inge) MSc
#> 29                                                                                                                                     Jeroense, T.M.G. (Thijmen) MSc
#> 30                                                                                                                                              Linders, N. (Nik) MSc
#> 31                                                                                                                                              Loh, S.M. (Renae) MSc
#> 32                                                                                                                                          Meijeren, M. (Maikel) MSc
#> 33                                                                                                                                    Mensvoort, C.A. van (Carly) MSc
#> 34                                                                                                                                            Müller, K. (Katrin) MSc
#> 35                                                                                                                                             Raiber, K. (Klara) MSc
#> 36                                                                                                                                     Ramaekers, M.J.M. (Marlou) MSc
#> 37                                                                                                                                           Wiertsema, S. (Sara) MSc
#> 39                                                                                                                                           Betkó, drs. J.G. (János)
#> 40                                                                                                                                        Houten, J. (Jasper) van MSc
#> 41                                                                                                                                     Middendorp J. (Jansje) van MSc
#> 42                                                                                                                                                Vis, E. (Elize) MSc
#> 43                                                                                                                                             Weber, T. (Tijmen) MSc
#> 45                                                                                                                                        Sterkens, dr. C.J.A. (Carl)
#> 46                                                                                                                                       Vermeer, dr. P.A.D.M. (Paul)
#>                                                                                                       soc_experts
#> 2                                               Healthcare, labour market and healthcare professions and training
#> 3                  Family, life course, labour market participation, division of household tasks and gender norms
#> 4                                                                           Welfare state, nationalism and sports
#> 5                                                                 Family, life course and transition to adulthood
#> 6                                                              Discrimination and inequality on the labour market
#> 7                                    Labour market, life course, older workers, retirement and solo self-employed
#> 8                                                                              Methods of research and statistics
#> 9                \r\n                                Poverty en social cohesion\r\n                              
#> 10                                                                          Islam, gender attitudes and sexuality
#> 11                                Educational inequality, gender inequality, organizational sociology and culture
#> 12                                                                                    Sports and policy sociology
#> 13                                                                           Diversity, inequality and innovation
#> 14                                                                     Educational inequality, culture and health
#> 15                                                                                        Culture and nationalism
#> 16                                                                Ethnic diversity, prejudice and social cohesion
#> 17                                                            Comparative research, social cohesion and diversity
#> 18                                               Islam, gender, populism, social media, Middle East and migration
#> 19                                                                   Inequality, criminology and ethnic diversity
#> 20                                                                                        Health, family and work
#> 21                                                                  Older workers, radicalism and social cohesion
#> 22                                                            Educational inequality and labour market inequality
#> 24                                                                Adverse youth experiences and social inequality
#> 25                                             Sport networks and motivation for sustainable sports participation
#> 26                                                   Social inequality, older workers, life course and retirement
#> 27                                                                                      Integration and migration
#> 28                                                                     Resistance to refugees and social cohesion
#> 29                                Political participation, segregation, opinion polarization and voting behaviour
#> 30                                                                    Populism, gender, masculinity and sexuality
#> 31 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 32                                                                   Social capital, volunteer work and diversity
#> 33                                                                            Gender, leadership and social norms
#> 34                                                        Opinions about discrimination, migration and inequality
#> 35                                                        Informal care, employment, social inequality and gender
#> 36                                                                                 Prosocial behaviour and family
#> 37                           Inequality in sports and physical activity, school-to-work transition and employment
#> 39                                   Social assistance benefit, poverty, reintegration, RCT and social experiment
#> 40                                                                                                         Sports
#> 41                                                                                            Home administration
#> 42                      Healthcare, labour market, healthcare professions and training, health and social capital
#> 43                                International student mobility and the internationalization of higher education
#> 45                                             Religious conflicts, cohesion, religion and the philosophy of life
#> 46                                   Socialization processes, secularisation, religion and the philosophy of life
#>                                       last_name first_name
#> 2                                     Batenburg     Ronald
#> 3                                        Begall      Katia
#> 4                                       Bekhuis      Hidde
#> 5                                          Berg    Lonneke
#> 6                                     Blommaert Lieselotte
#> 7                                        Damman    Marleen
#> 8                                       Eisinga        Rob
#> 9                                    Gesthuizen    Maurice
#> 10                                         Glas     Saskia
#> 11                                          Hek   Margriet
#> 12                                      Hoekman      Remco
#> 13                                      Hofstra        Bas
#> 14                                    Kraaykamp    Gerbert
#> 15                                     Meuleman       Roza
#> 16                                    Savelkoul    Michael
#> 17                                    Scheepers       Peer
#> 18                                    Spierings      Niels
#> 19                                       Tolsma     Jochem
#> 20 \r\n                                Verbakel      Ellen
#> 21                                       Visser       Mark
#> 22                                      Wolbers    Maarten
#> 24                                  Bussemakers    Carlijn
#> 25                                      Franken        Rob
#> 26                                        Firat    Mustafa
#> 27                                       Geurts      Nella
#> 28                                     Hendriks       Inge
#> 29                                     Jeroense    Thijmen
#> 30                                      Linders        Nik
#> 31                                          Loh      Renae
#> 32                                     Meijeren     Maikel
#> 33                                    Mensvoort      Carly
#> 34                                       Müller     Katrin
#> 35                                       Raiber      Klara
#> 36                                    Ramaekers     Marlou
#> 37                                    Wiertsema       Sara
#> 39                                        Betkó      János
#> 40                                       Houten     Jasper
#> 41               Middendorp J. (Jansje) van MSc     Jansje
#> 42                                          Vis      Elize
#> 43                                        Weber     Tijmen
#> 45                                     Sterkens       Carl
#> 46                                      Vermeer       Paul
```

So we need yet to do some manual cleaning, one name seemed to be inconsistent with how the other names were listed on the webpage. As data get bigger, this becomes impossible to do manually and we simply have to accept this as noise. 


```r
soc_df$last_name <- gsub(" J. \\(Jansje\\) van MSc", "", soc_df$last_name)
```

Not quite there yet. To be sure, we'll trim some white space in the variables we know created. This means we remove spaces before and after strings.

<!---
Dont we want to have everything in lower case? 
Dont you want to run a script to remove all common special characters?
---> 



```r
# trimws looses all spacing before and after (if you specify 'both') a character string
soc_df$last_name <- trimws(soc_df$last_name, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$first_name <- trimws(soc_df$first_name, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$soc_experts <- trimws(soc_df$soc_experts, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$soc_names <- trimws(soc_df$soc_names, which = c("both"), whitespace = "[ \t\r\n]")
```

Finally, because we're quite sure that all these staff belong to Radboud University, we simply create a variable that contains a character string.


```r
# set affiliation to radboud, comes in handy for querying google scholar
soc_df$affiliation <- "radboud university"
```

How do the data look?

```r
soc_df
```

```
#>                                                                                       soc_names
#> 2                                                              Batenburg, prof. dr. R. (Ronald)
#> 3                                                                      Begall, dr. K.H. (Katia)
#> 4                                                                       Bekhuis, dr. H. (Hidde)
#> 5                                                                Berg, dr. L. van den (Lonneke)
#> 6                                                                Blommaert, dr. L. (Lieselotte)
#> 7                                                                      Damman, dr. M. (Marleen)
#> 8                                                                 Eisinga, prof. dr. R.N. (Rob)
#> 9                                                              Gesthuizen, dr. M.J.W. (Maurice)
#> 10                                                                        Glas, dr. S. (Saskia)
#> 11                                                                   Hek, dr. M. van (Margriet)
#> 12                                                                 Hoekman, dr. R. H. A.(Remco)
#> 13                                                                        Hofstra, dr. B. (Bas)
#> 14                                                        Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 15                                                                         Meuleman, dr. (Roza)
#> 16                                                                Savelkoul, dr. M.J. (Michael)
#> 17                                                           Scheepers, prof. dr. P.L.H. (Peer)
#> 18                                                              Spierings, dr. C.H.B.M. (Niels)
#> 19                                                                      Tolsma, dr. J. (Jochem)
#> 20 Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department
#> 21                                                                        Visser, dr. M. (Mark)
#> 22                                                          Wolbers, prof. dr. M.H.J. (Maarten)
#> 24                                                                Bussemakers, C. (Carlijn) MSc
#> 25                                                                        Franken, R. (Rob) MSc
#> 26                                                                      Firat, M. (Mustafa) MSc
#> 27                                                                     Geurts, P.G. (Nella) MSc
#> 28                                                                    Hendriks, I.P. (Inge) MSc
#> 29                                                               Jeroense, T.M.G. (Thijmen) MSc
#> 30                                                                        Linders, N. (Nik) MSc
#> 31                                                                        Loh, S.M. (Renae) MSc
#> 32                                                                    Meijeren, M. (Maikel) MSc
#> 33                                                              Mensvoort, C.A. van (Carly) MSc
#> 34                                                                      Müller, K. (Katrin) MSc
#> 35                                                                       Raiber, K. (Klara) MSc
#> 36                                                               Ramaekers, M.J.M. (Marlou) MSc
#> 37                                                                     Wiertsema, S. (Sara) MSc
#> 39                                                                     Betkó, drs. J.G. (János)
#> 40                                                                  Houten, J. (Jasper) van MSc
#> 41                                                               Middendorp J. (Jansje) van MSc
#> 42                                                                          Vis, E. (Elize) MSc
#> 43                                                                       Weber, T. (Tijmen) MSc
#> 45                                                                  Sterkens, dr. C.J.A. (Carl)
#> 46                                                                 Vermeer, dr. P.A.D.M. (Paul)
#>                                                                                                       soc_experts
#> 2                                               Healthcare, labour market and healthcare professions and training
#> 3                  Family, life course, labour market participation, division of household tasks and gender norms
#> 4                                                                           Welfare state, nationalism and sports
#> 5                                                                 Family, life course and transition to adulthood
#> 6                                                              Discrimination and inequality on the labour market
#> 7                                    Labour market, life course, older workers, retirement and solo self-employed
#> 8                                                                              Methods of research and statistics
#> 9                                                                                      Poverty en social cohesion
#> 10                                                                          Islam, gender attitudes and sexuality
#> 11                                Educational inequality, gender inequality, organizational sociology and culture
#> 12                                                                                    Sports and policy sociology
#> 13                                                                           Diversity, inequality and innovation
#> 14                                                                     Educational inequality, culture and health
#> 15                                                                                        Culture and nationalism
#> 16                                                                Ethnic diversity, prejudice and social cohesion
#> 17                                                            Comparative research, social cohesion and diversity
#> 18                                               Islam, gender, populism, social media, Middle East and migration
#> 19                                                                   Inequality, criminology and ethnic diversity
#> 20                                                                                        Health, family and work
#> 21                                                                  Older workers, radicalism and social cohesion
#> 22                                                            Educational inequality and labour market inequality
#> 24                                                                Adverse youth experiences and social inequality
#> 25                                             Sport networks and motivation for sustainable sports participation
#> 26                                                   Social inequality, older workers, life course and retirement
#> 27                                                                                      Integration and migration
#> 28                                                                     Resistance to refugees and social cohesion
#> 29                                Political participation, segregation, opinion polarization and voting behaviour
#> 30                                                                    Populism, gender, masculinity and sexuality
#> 31 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 32                                                                   Social capital, volunteer work and diversity
#> 33                                                                            Gender, leadership and social norms
#> 34                                                        Opinions about discrimination, migration and inequality
#> 35                                                        Informal care, employment, social inequality and gender
#> 36                                                                                 Prosocial behaviour and family
#> 37                           Inequality in sports and physical activity, school-to-work transition and employment
#> 39                                   Social assistance benefit, poverty, reintegration, RCT and social experiment
#> 40                                                                                                         Sports
#> 41                                                                                            Home administration
#> 42                      Healthcare, labour market, healthcare professions and training, health and social capital
#> 43                                International student mobility and the internationalization of higher education
#> 45                                             Religious conflicts, cohesion, religion and the philosophy of life
#> 46                                   Socialization processes, secularisation, religion and the philosophy of life
#>      last_name first_name        affiliation
#> 2    Batenburg     Ronald radboud university
#> 3       Begall      Katia radboud university
#> 4      Bekhuis      Hidde radboud university
#> 5         Berg    Lonneke radboud university
#> 6    Blommaert Lieselotte radboud university
#> 7       Damman    Marleen radboud university
#> 8      Eisinga        Rob radboud university
#> 9   Gesthuizen    Maurice radboud university
#> 10        Glas     Saskia radboud university
#> 11         Hek   Margriet radboud university
#> 12     Hoekman      Remco radboud university
#> 13     Hofstra        Bas radboud university
#> 14   Kraaykamp    Gerbert radboud university
#> 15    Meuleman       Roza radboud university
#> 16   Savelkoul    Michael radboud university
#> 17   Scheepers       Peer radboud university
#> 18   Spierings      Niels radboud university
#> 19      Tolsma     Jochem radboud university
#> 20    Verbakel      Ellen radboud university
#> 21      Visser       Mark radboud university
#> 22     Wolbers    Maarten radboud university
#> 24 Bussemakers    Carlijn radboud university
#> 25     Franken        Rob radboud university
#> 26       Firat    Mustafa radboud university
#> 27      Geurts      Nella radboud university
#> 28    Hendriks       Inge radboud university
#> 29    Jeroense    Thijmen radboud university
#> 30     Linders        Nik radboud university
#> 31         Loh      Renae radboud university
#> 32    Meijeren     Maikel radboud university
#> 33   Mensvoort      Carly radboud university
#> 34      Müller     Katrin radboud university
#> 35      Raiber      Klara radboud university
#> 36   Ramaekers     Marlou radboud university
#> 37   Wiertsema       Sara radboud university
#> 39       Betkó      János radboud university
#> 40      Houten     Jasper radboud university
#> 41  Middendorp     Jansje radboud university
#> 42         Vis      Elize radboud university
#> 43       Weber     Tijmen radboud university
#> 45    Sterkens       Carl radboud university
#> 46     Vermeer       Paul radboud university
```






Pretty good, so I think we can move on to the next section.

### Google Scholar Profiles and Publications

What we now have is a data frame of sociology staff members. So we succesfully gathered the anchor data set we can move on with. Next, we need to find out whether these staff have a Google Scholar profile. I imagine you have accessed [Google Scholar](www.scholar.google.com) many times during your studies for finding scientists or publications. The nice thing about Google Scholar is that it lists collaborators, publications, and citations on profiles. So what we first need to do is look for Google Scholar profiles among sociology staff. Luckily, we cleaned first and last names and have their affiliation. That makes looking them up much easier. So we need to do this for every person in our data frame. Before we query Google Scholar, we first need to learn a neat trick: *for loops*. Can you follow the code below? We can do all kinds of things automatically in a for loop.



```r
# The 'for loop': for every i in a vector (can be numbers, strings, etc.), say 1 to 10, you can do
# 'something'
for (i in 1:10) {
    print(i)  # So for every i from 1 to 10, we print i, see what happens!
}
```

```
#> [1] 1
#> [1] 2
#> [1] 3
#> [1] 4
#> [1] 5
#> [1] 6
#> [1] 7
#> [1] 8
#> [1] 9
#> [1] 10
```

```r
# # or do something more complicated p <- rnorm(10, 0, 1) # draw 10 normally distributed numbers with
# mean 0 and SD 1 (so z-scores, essentially) plot(density(p)) # relatively, normal, right?  u <- 0 #
# make an element we can fill up in the loop below for (i in 1:10) { u[i] <- p[i]*p[i] # get
# p-squared for every i-th element in vector p print(u[i]) # and print that squared element }
```

Now that we know how to implement for loops in our workflow, we can utilize them to do slightly more complicated stuff. We want to know the identifying *link* on Google Scholar for each sociology staff member. We first set an empty identifier in our data frame so that we can "fill up" that data column later.

```r
soc_df$gs_id <- ""  # we set an empty identifier
```

So let's move on with attempting to find Google Scholar profiles. The package `scholar` has a very nice function `get_scholar_id`. It needs a last name, first name, and affiliation. Luckily, we already found those on the Radboud University website! So we can fill in those. Let's try it for one staff member first.


```r
source("addfiles/function_fix.R")  # Put the function_fix.R in your working directory, we need this first line.
get_scholar_id_fix(last_name = "tolsma", first_name = "jochem", affiliation = "radboud university")
```

```
#> [1] "Iu23-90AAAAJ"
```

We now know that Jochem's Scholar ID is "Iu23-90AAAAJ". That's very convenient, because now we can use the package `scholar` to extract a range of useful information from his Google Scholar profile. Let's try it out on his profile first. Notice the nice function `get_profiles`. We simply have to input his Google Scholar ID and it shows everything on the profile


```r
get_profile("Iu23-90AAAAJ")  # Jochem's profile
```

```
#> $id
#> [1] "Iu23-90AAAAJ"
#> 
#> $name
#> [1] "Jochem Tolsma"
#> 
#> $affiliation
#> [1] "Professor, Radboud University Nijmegen / University of Groningen"
#> 
#> $total_cites
#> [1] 2260
#> 
#> $h_index
#> [1] 22
#> 
#> $i10_index
#> [1] 33
#> 
#> $fields
#> [1] "verified email at ru.nl - homepage"
#> 
#> $homepage
#> [1] "http://www.jochemtolsma.nl/"
#> 
#> $interests
#> [1] "social divisions between groups" "segregation"                    
#> [3] "inequality"                     
#> 
#> $coauthors
#>  [1] "Tom van der Meer"   "Maarten HJ Wolbers" "Gerbert Kraaykamp"  "peer scheepers"    
#>  [5] "Michael Savelkoul"  "Stijn Ruiter"       "Marcel Lubbers"     "Maurice Gesthuizen"
#>  [9] "Marcel Coenders"    "Nan Dirk de Graaf"  "Tobias H. Stark"    "Sara Kinsbergen"   
#> [13] "Christiaan Monden"  "Matthijs Kalmijn"   "Lincoln Quillian"   "Marloes de Lange"  
#> [17] "Ariana Need"        "Thomas Feliciani"   "Andreas Flache"     "René Veenstra"
```

Next up, Jochem's publications. Notice how not everything is in a nice data frame format yet, we'll get to that later.


```r
get_publications("Iu23-90AAAAJ")  # Jochem's pubs
```

```
#>                                                                                                                                                                                 title
#> 1                                                                                                                                 Ethnic diversity and its effects on social cohesion
#> 2                                    Anti-Muslim attitudes in the Netherlands: Tests of contradictory hypotheses derived from ethnic competition theory and intergroup contact theory
#> 3                                                                                  The impact of neighbourhood and municipality characteristics on social cohesion in the Netherlands
#> 4            The effects of parental reading socialization and early school involvement on children’s academic performance: A panel study of primary school pupils in the Netherlands
#> 5                                                                                Ethnic competition and opposition to ethnic intermarriage in the Netherlands: A multi-level approach
#> 6                              Who is bullying whom in ethnically diverse primary schools? Exploring links between bullying, ethnicity, and ethnic diversity in Dutch primary schools
#> 7                                                                          When do people report crime to the police? Results from a factorial survey design in the Netherlands, 2010
#> 8                                                        Education and cultural integration among ethnic minorities and natives in the Netherlands: A test of the integration paradox
#> 9                                                                                                       Trends in ethnic educational inequalities in the Netherlands: a cohort design
#> 10                                  Explaining participation differentials in Dutch higher education: the impact of subjective success probabilities on level choice and field choice
#> 11                                                                                    Does intergenerational social mobility affect antagonistic attitudes towards ethnic minorities?
#> 12                                                      The impact of adolescents' classroom and neighborhood ethnic diversity on same-and cross-ethnic friendships within classrooms
#> 13        Losing Wallets, Retaining Trust? The Relationship Between Ethnic Heterogeneity and Trusting Coethnic and Non-coethnic Neighbours and Non-neighbours to Return a Lost Wallet
#> 14             Neighbourhood ethnic composition and voting for the radical right in The Netherlands. The role of perceived neighbourhood threat and interethnic neighbourhood contact
#> 15                                                                                          At which geographic scale does ethnic diversity affect intra-neighborhood social capital?
#> 16                                                Educational expansion and field of study: trends in the intergenerational transmission of educational inequality in the Netherlands
#> 17                                                                                                             The NEtherlands Longitudinal Lifecourse Study (NELLS, Panel): Codebook
#> 18                                                                       Bringing the beneficiary closer: Explanations for volunteering time in Dutch private development initiatives
#> 19    Onderwijs als nieuwe sociale scheidslijn? De gevolgen van onderwijsexpansie voor sociale mobiliteit, de waarde van diploma’s en het relatieve belang van opleiding in Nederland
#> 20                                                                                                                                                         Naar een open samenleving?
#> 21                                                                              Explaining monetary donations to international development organisations: A factorial survey approach
#> 22                                                                                          Social origin and occupational success at labour market entry in The Netherlands, 1931–80
#> 23                                                                                                  How friends’ involvement in crime affects the risk of offending and victimization
#> 24                     Perceptions as the crucial link? The mediating role of neighborhood perceptions in the relationship between the neighborhood context and neighborhood cohesion
#> 25                                                                                      How, when and where can spatial segregation induce opinion polarization? Two competing models
#> 26                                                                                                                                                                 VU Research Portal
#> 27 Ethnic hostility among ethnic majority and minority groups in the Netherlands: An investigation into the impact of social mobility experiences, the local living environment and …
#> 28                                                                                         Explaining natives' interethnic friendship and contact with colleagues in European regions
#> 29                                                                                      Netherlands Longitudinal Lifecourse Study-NELLS Panel Wave 1 2009 and Wave 2 2013-version 1.1
#> 30                                                      Combating hooliganism in the Netherlands: An evaluation of measures to combat hooliganism with longitudinal registration data
#> 31    De onderwijskansen van allochtone en autochtone Nederlanders vergeleken: Een cohort-design [Ethnic inequality of educational opportunities in the Netherlands: A cohort design]
#> 32                                                                                                Trust and contact in diverse neighbourhoods: An interplay of four ethnicity effects
#> 33      Size is in the eye of the beholder: How differences between neighbourhoods and individuals explain variation in estimations of the ethnic out-group size in the neighbourhood
#> 34                                                                           Like two peas in a pod? Explaining friendship selection processes related to victimization and offending
#> 35                                                                           Aangiftebereidheid: Welke overwegingen spelen een rol bij de beslissing om wel of niet aangifte te doen?
#> 36                                                                                                               De aangifte van delicten bij de multichannelstrategie van de politie
#> 37                                                       Parents, television and children's weight status: On lasting effects of parental television socialization in the Netherlands
#> 38                                                                                                                       Taakstraffen langs de lat: strafopvattingen van Nederlanders
#> 39                                 Co-occurrence of adverse childhood experiences and its association with family characteristics. A latent class analysis with Dutch population data
#> 40                                                                                                        Opleiding als sociale scheidslijn. Een nieuw perspectief op een oude kloof.
#> 41                                                                                                   Archeologische verwachtings-en beleidskaart buitengebied gemeente Midden-Drenthe
#> 42     Under what conditions do ethnic minority candidates attract the ethnic minority vote? How neighbourhood and candidate characteristics affected ethnic affinity voting in the …
#> 43                                                   Where does ethnic concentration matter for populist radical right support? An analysis of geographical scale and the halo effect
#> 44                                                                                     Vrijheid versus veiligheid: Wie steunt vrijheidsbeperking omwille van veiligheid in Nederland?
#> 45                                                                                                                                                  Opleiding als sociale scheidslijn
#> 46                                                                                                                                                     Dader, slachtoffer, of beiden?
#> 47                                                                                                                    Education's impact on explanations of radical right-wing voting
#> 48                                                                                                     Social origin and inequality in educational returns in the Dutch labour market
#> 49                                                                                                         Opleiding als sociale scheidslijn: Een nieuw perspectief op een oude kloof
#> 50                                                                                                                                                              De burger als rechter
#> 51                                                                     Exposure to asylum seekers and changing support for the radical right: A natural experiment in the Netherlands
#> 52                                                                                               Ontwikkelingen in de maatschappelijke positie van middelbaar opgeleiden in Nederland
#> 53                                                Integratie en depressie: De relatie tussen sociaal-culturele integratie en depressieklachten bij Turkse en Marokkaanse Nederlanders
#> 54                                                  Integratie en depressie-De relatie tussen sociaal-culturele integratie en depressieklachten bij Turkse en Marokkaanse Nederlander
#> 55                                                                                                                                                            Integratie en depressie
#> 56                                                                                                                    Preferences for work arrangements: A discrete choice experiment
#> 57                                                         Fairly paid but dissatisfied? Determinants of pay fairness and pay satisfaction: Evidence from Germany and the Netherlands
#> 58                                                                                      In hoeverre verklaart de etnische samenstelling van de buurt de kans om te stemmen op de PVV?
#> 59                                                                                  Soort zoekt soort: vriendschapselectieprocessen met betrekking tot slachtofferschap en daderschap
#> 60                                                                                                                                          Joran Laméris Radboud University Nijmegen
#> 61                                    Modeling opinion dynamics in a real city: How realistic spatial patterns of demographic attributes affect the emergence of opinion polarization
#> 62                      Summary of “How, When and Where Can Spatial Segregation Induce Opinion Polarization? Two Competing Models”: Paper Under Review as JASSS Fast Track Submission
#> 63                                                                                                                                    ICS Alumni revisited [Brochure tbv Lustrum ICS]
#> 64                                                                                                                                               ICS Alumni Survey 2016 [Databestand]
#> 65                                      Modeling opinion dynamics in a simulated city. Realistic spatial patterns of demographic attributes and the emergence of opinion polarization
#> 66                                                                                                               De invloed van grootouders op het opleidingsniveau van kleinkinderen
#> 67                                                                                                                                 Opleiding als sociale scheidslijn: Een tegengeluid
#> 68                                                                                  Opleiding als sociale scheidslijn: aanleiding, probleemstelling, bestaande inzichten en werkwijze
#> 69                                                                                                                   De samenhang in het opleidingsniveau tussen (huwelijks) partners
#> 70                                                                                                Sociale herkomst en ongelijkheid in de opbrengsten van diploma's op de arbeidsmarkt
#> 71                                                                                                  De rol van het opleidingsniveau voor het starten en stoppen met vrijwilligerswerk
#> 72                                                                                                            Trends in de opleidingskloof op verschillende maatschappelijke domeinen
#> 73                                                                                 Was, is of wordt opleiding de sociale scheidslijn? Een terugblik, stand van zaken en toekomstvisie
#> 74                                                                                                                                                                          DANS EASY
#> 75                                                                                               Klein en vrijwillig of groot en ervaren? Een analyse van de voorkeuren van donateurs
#> 76                                                                    De burger als rechter, onderzoek naar geprefereerde sancties voor misdrijven in Nederland (projectnummer 1933B)
#> 77                                                                          Aangiftebereidheid: Welke overwegingen spelen een rol bij de beslissing om wel of niet aangifte te doen?|
#> 78                                                                                                                                  Onderwijsexpansie veroorzaakt nieuwe ongelijkheid
#> 79                                                                                                                 Sociale daling schaadt vertrouwen: Effecten van sociale mobiliteit
#> 80                                                                                                                                       Toenemende gelijkheid is nog geen verheffing
#> 81                   Over ouders, televisiekijken en (over) gewicht: Een studie naar de langetermijneffecten van ouderlijke televisiesocialisatie op het lichaamsgewicht van kinderen
#> 82                                                                      Onderwijsexpansie en opleidingsrichting: Trends in de intergenerationele overdracht van onderwijsongelijkheid
#> 83                                                                                     Does Intergenerational Social Mobility affect Antagonistic Attitudes towards Ethnic Minorities
#> 84                                                            De invloed van lands-, gemeente-en buurtkenmerken op sociaal kapitaal: Putnam's hypothese getest in Europa en Nederland
#> 85                                                                                                                                                           Causes of dyads (theory)
#> 86                                                                                                                                                                Egocentric Networks
#> 87                                                                                                                                                       Onbeperkte mogelijkheden 122
#> 88                                                 De invloed van lands-, gemeente-en buurtkenmerken op sociaal kapitaal Gesthuizen, M.; Scheepers, P.; Tolsma, J.; Meer, TWG van der
#> 89                                                                                            The Role of Recent Migrants’ Country of Origin Engagement in Dutch Language Proficiency
#> 90 Notes on Contributors Female Education and Marriage Dissolution: Is it a Selection Effect? Fabrizio Bernardi and Juan-Ignacio Martinez-Pastor 693 Age, Inequality, and Reactions …
#> 91   Notes on Contributors The Effects of Parental Reading Socialization and Early School Involvement on Children’s Academic Performance: A Panel Study of Primary School Pupils in …
#> 92                                                                                                                                                M1-102: Social capital and networks
#> 93                                                                                                   Social origin and occupational success at labour market entry in the Netherlands
#>                                                                        author
#> 1                                                    T Van der Meer, J Tolsma
#> 2                            M Savelkoul, P Scheepers, J Tolsma, L Hagendoorn
#> 3                                      J Tolsma, T van der Meer, M Gesthuizen
#> 4                              R Kloosterman, N Notten, J Tolsma, G Kraaykamp
#> 5                                             J Tolsma, M Lubbers, M Coenders
#> 6                               J Tolsma, I van Deurzen, TH Stark, R Veenstra
#> 7                                         J Tolsma, J Blaauw, M Te Grotenhuis
#> 8                                            J Tolsma, M Lubbers, M Gijsberts
#> 9                                             J Tolsma, M Coenders, M Lubbers
#> 10                                                J Tolsma, A Need, U De Jong
#> 11                                          J Tolsma, ND De Graaf, L Quillian
#> 12                               A Munniksma, P Scheepers, TH Stark, J Tolsma
#> 13                                                 J Tolsma, TWG van der Meer
#> 14                                           M Savelkoul, J Laméris, J Tolsma
#> 15                                           R Sluiter, J Tolsma, P Scheepers
#> 16                                         G Kraaykamp, J Tolsma, MHJ Wolbers
#> 17                J Tolsma, GLM Kraaykamp, PM de Graaf, M Kalmijn, CWS Monden
#> 18                                           S Kinsbergen, J Tolsma, S Ruiter
#> 19                                                      J Tolsma, MHJ Wolbers
#> 20                                                      J Tolsma, MHJ Wolbers
#> 21                                                     S Kinsbergen, J Tolsma
#> 22                                                      J Tolsma, MHJ Wolbers
#> 23                                   JJ Rokven, G de Boer, J Tolsma, S Ruiter
#> 24                                               J Laméris, JR Hipp, J Tolsma
#> 25                                            T Feliciani, A Flache, J Tolsma
#> 26                   S Ruiter, J Tolsma, M De Hoon, H Elffers, P Van der Laan
#> 27                                                                   J Tolsma
#> 28                                         M Savelkoul, J Tolsma, P Scheepers
#> 29                 J Tolsma, GLM Kraaykamp, PM De Graaf, M Kalmijn, CM Monden
#> 30                                     D Schaap, M Postma, L Jansen, J Tolsma
#> 31                                          J Tolsma, MTA Coenders, M Lubbers
#> 32                                                 J Tolsma, TWG Van der Meer
#> 33                                 J Laméris, G Kraaykamp, S Ruiter, J Tolsma
#> 34                                 JJ Rokven, J Tolsma, S Ruiter, G Kraaykamp
#> 35                                                                   J Tolsma
#> 36                                                    PFM Boekhoorn, J Tolsma
#> 37                                            N Notten, G Kraaykamp, J Tolsma
#> 38                                                         S Ruiter, J Tolsma
#> 39                                       C Bussemakers, G Kraaykamp, J Tolsma
#> 40                                          M de Lange, J Tolsma, MHJ Wolbers
#> 41                                                     MG Marinelli, J Tolsma
#> 42                                        R van der Zwan, J Tolsma, M Lubbers
#> 43                                               D van Wijk, G Bolt, J Tolsma
#> 44                                            G Jansen, J Tolsma, ND de Graaf
#> 45                                             M Lange, J Tolsma, MHJ Wolbers
#> 46                                               J Rokven, S Ruiter, J Tolsma
#> 47                                                        M Lubbers, J Tolsma
#> 48                                                      J Tolsma, MHJ Wolbers
#> 49                                             M Lange, J Tolsma, MHJ Wolbers
#> 50                              S Ruiter, J Tolsma, M Hoon, H Elffers, P Laan
#> 51                                           J Tolsma, J Laméris, M Savelkoul
#> 52                                                      J Tolsma, MHJ Wolbers
#> 53                                                           R Zwan, J Tolsma
#> 54                                                   R van der Zwan, J Tolsma
#> 55                                                   R van der Zwan, J Tolsma
#> 56                                                 P Valet, C Sauer, J Tolsma
#> 57                                             J Adriaans, CG Sauer, J Tolsma
#> 58                                           M Savelkoul, J Laméris, J Tolsma
#> 59                                  J Rokven, J Tolsma, S Ruiter, G Kraaykamp
#> 60                                                          JR Hipp, J Tolsma
#> 61                                            T Feliciani, A Flache, J Tolsma
#> 62                                            T Feliciani, A Flache, J Tolsma
#> 63                               PE Thijs, GLM Kraaykamp, M Scholte, J Tolsma
#> 64                               GLM Kraaykamp, M Scholte, PE Thijs, J Tolsma
#> 65                                    T Feliciani, A Flache, J Tolsma, M Maes
#> 66                                                      MHJ Wolbers, WC Ultee
#> 67                                                                   J Tolsma
#> 68                                          M de Lange, J Tolsma, MHJ Wolbers
#> 69                                                      J Tolsma, ND de Graaf
#> 70                                                      J Tolsma, MHJ Wolbers
#> 71                                            D Wiertz, J Tolsma, ND de Graaf
#> 72                                                          M Lange, J Tolsma
#> 73                                                      J Tolsma, MHJ Wolbers
#> 74                  J Tolsma, GLM Kraaykamp, DM de Graaf, M Kalmijn, C Monden
#> 75                                                     S Kinsbergen, J Tolsma
#> 76                              S Ruiter, J Tolsma, M Hoon, H Elffers, D Laan
#> 77                                                                   J Tolsma
#> 78                                       GLM Kraaykamp, MHJ Wolbers, J Tolsma
#> 79                                                      J Tolsma, MHJ Wolbers
#> 80                                                      MHJ Wolbers, J Tolsma
#> 81                                          N Notten, GLM Kraaykamp, J Tolsma
#> 82                                       GLM Kraaykamp, J Tolsma, MHJ Wolbers
#> 83                                         NDG de Graaf, J Tolsma, L Quillian
#> 84                  MJW Gesthuizen, PLH Scheepers, J Tolsma, TWG van der Meer
#> 85                                                                   J Tolsma
#> 86                                                                   J Tolsma
#> 87 T Fischer, J Winkels, M Visser, M Gesthuizen, P Scheepers, A ten Cate, ...
#> 88                                                               M Gesthuizen
#> 89                                                         N Geurts, J Tolsma
#> 90       P Horvat, G Evans, G Rohwer, M Savelkoul, P Scheepers, J Tolsma, ...
#> 91             R Kloosterman, N Notten, J Tolsma, G Kraaykamp, J Hansson, ...
#> 92                                                J Laméris, J Tolsma, J Hipp
#> 93                                                      J Tolsma, MHJ Wolbers
#>                                                                             journal
#> 1                                                        Annual Review of Sociology
#> 2                                                      European sociological review
#> 3                                                                     Acta Politica
#> 4                                                      European Sociological Review
#> 5                                                      European Sociological Review
#> 6                                                                   Social Networks
#> 7                                               Journal of experimental criminology
#> 8                                           Journal of Ethnic and Migration Studies
#> 9                                                      European Sociological Review
#> 10                                                     European Sociological Review
#> 11                                                 The British Journal of Sociology
#> 12                                               Journal of Research on Adolescence
#> 13                                                       Social Indicators Research
#> 14                                                     European Sociological Review
#> 15                                                          Social science research
#> 16                                        British Journal of Sociology of Education
#> 17             Nijmegen; Tilburg; Amsterdam: Radboud University Nijmegen; Tilburg …
#> 18                                         Nonprofit and Voluntary Sector Quarterly
#> 19                                                                                 
#> 20                                                                                 
#> 21                                                          Social science research
#> 22                                                                 Acta Sociologica
#> 23                                                  European journal of criminology
#> 24                                                          Social science research
#> 25                                                                                 
#> 26                                                                                 
#> 27                                                [Sl]: sn [ICS dissertation series
#> 28                                          Journal of Ethnic and Migration Studies
#> 29                                                     DANS. DOI: https://doi. org/
#> 30                                 European Journal on Criminal Policy and Research
#> 31                                                                                 
#> 32                                                          Social science research
#> 33                                 International Journal of Intercultural Relations
#> 34                                                  European Journal of Criminology
#> 35                                 Proces-verbaal, aangifte en forensisch onderzoek
#> 36          Apeldoorn; Nijmegen: Politie & Wetenschap; BBSO en Radboud Universiteit
#> 37                                                    Journal of Children and Media
#> 38                                                                                 
#> 39                                                            Child abuse & neglect
#> 40                                                                            Maklu
#> 41                                                           Oranjewoud, Heerenveen
#> 42                                                              Political Geography
#> 43                                                              Political Geography
#> 44                                                             Mens en maatschappij
#> 45                                                                                 
#> 46                                                    Tijdschrift voor Criminologie
#> 47                                                London: University College London
#> 48                                          Education, Occupation and Social Origin
#> 49                                                      Antwerpen/Apeldoorn: Garant
#> 50                                                                             NSCR
#> 51                                                                         PLoS One
#> 52                                                                    Den Haag: WRR
#> 53                                                                                 
#> 54                                                             Mens en maatschappij
#> 55                                                        De relatie tussen sociaal
#> 56                                                                         PloS one
#> 57                     New York, NY: Society for the Advancement of Socio-Economics
#> 58                                                             Mens en Maatschappij
#> 59                                                             Mens en maatschappij
#> 60                                                                                 
#> 61                                                                                 
#> 62     International Conference on Principles and Practice of Multi-Agent Systems …
#> 63 Nijmegen: Interuniversity Center for Social Science Theory and Methodology (ICS)
#> 64 Nijmegen: Interuniversity Center for Social Science Theory and Methodology (ICS)
#> 65                                                     Social Simulation Conference
#> 66            Lange, M. de; Tolsma, J.; Wolbers, MHJ (ed.), Opleiding als sociale …
#> 67                                          Sociologos: Tijdschrift voor Sociologie
#> 68       Opleiding als sociale scheidslijn. Een nieuw perspectief op een oude kloof
#> 69                                                      Antwerpen/Apeldoorn: Garant
#> 70                                                      Antwerpen/Apeldoorn: Garant
#> 71            Lange, M. de; Tolsma, J.; Wolbers, MHJ (ed.), Opleiding als sociale …
#> 72                                                      Antwerpen/Apeldoorn: Garant
#> 73            Lange, M. de; Tolsma, J.; Wolbers, MHJ (ed.), Opleiding als sociale …
#> 74                                                                        DANS EASY
#> 75                                                                  Amsterdam: NCDO
#> 76                                                                        DANS EASY
#> 77                                                           Cahiers Politiestudies
#> 78                                                       [Sl]: Sociale Vraagstukken
#> 79                                                                                 
#> 80                                                                                 
#> 81                                                                Assen: Van Gorcum
#> 82                                                                   Amsterdam: AUP
#> 83                                                                  Wiley Blackwell
#> 84                                                       Den Haag/Nijmegen: SCP-NSV
#> 85                                                                                 
#> 86                                                                                 
#> 87                                                                                 
#> 88                                                                                 
#> 89                                                                                 
#> 90                                                                                 
#> 91                                                                                 
#> 92                                                                Book of Abstracts
#> 93                                                                                 
#>                                                                   number cites year
#> 1                                                        40 (1), 459-478   427 2014
#> 2                                                        27 (6), 741-758   287 2011
#> 3                                                                 44 (3)   267 2009
#> 4                                                        27 (3), 291-306   120 2011
#> 5                                                        24 (2), 215-230   120 2008
#> 6                                                          35 (1), 51-61   106 2013
#> 7                                                         8 (2), 117-134    75 2012
#> 8                                                        38 (5), 793-813    68 2012
#> 9                                                        23 (3), 325-339    68 2007
#> 10                                                       26 (2), 235-252    62 2010
#> 11                                                       60 (2), 257-277    61 2009
#> 12                                                         27 (1), 20-33    43 2017
#> 13                                                                          35 2016
#> 14                                                       33 (2), 209-224    32 2017
#> 15                                                             54, 80-95    32 2015
#> 16                                                     34 (5-6), 888-906    32 2013
#> 17                                                                          31 2014
#> 18                                                         42 (1), 59-83    29 2013
#> 19                                                                          28 2010
#> 20                                                                          26 2010
#> 21                                                     42 (6), 1571-1586    24 2013
#> 22                                                       57 (3), 253-269    22 2014
#> 23                                                       14 (6), 697-719    19 2017
#> 24                                                             72, 53-68    17 2018
#> 25                                                                          17 2017
#> 26                                                                          17 2011
#> 27                                                                  155]    17 2009
#> 28                                                       41 (5), 683-709    15 2015
#> 29                                               /10.17026/dans-25n-2xjv    14 2014
#> 30                                                         21 (1), 83-97    13 2015
#> 31                                                                          13 2007
#> 32                                                            73, 92-106    12 2018
#> 33                                                             63, 80-94    10 2018
#> 34                                                       13 (2), 231-256     9 2016
#> 35                                                                    11     9 2011
#> 36                                                                           7 2016
#> 37                                                        7 (2), 235-252     7 2013
#> 38                                                                           7 2010
#> 39                                                            98, 104185     6 2019
#> 40                                                                           6 2015
#> 41                                                                           6 2009
#> 42                                                            77, 102098     5 2020
#> 43                                                            77, 102097     5 2020
#> 44                                                         83 (1), 47-69     5 2008
#> 45                                                                           4 2016
#> 46                                                           55 (3), 278     4 2013
#> 47                                                                           4 2011
#> 48                                                                           3 2016
#> 49                                                                           3 2015
#> 50                                                                           3 2011
#> 51                                                      16 (2), e0245644     2 2021
#> 52                                                                           2 2017
#> 53                                                                           2 2013
#> 54                                                       88 (2), 177-205     1 2013
#> 55                                                                           1 2013
#> 56                                                      16 (7), e0254483     0 2021
#> 57                                                                           0 2019
#> 58                                                         93 (1), 82-85     0 2018
#> 59                                                       92 (3), 327-329     0 2017
#> 60                                                                           0 2017
#> 61 9th Conference of the International Network of Analytical Sociology …     0 2016
#> 62                                                                           0 2016
#> 63                                                                           0 2016
#> 64                                                                           0 2016
#> 65                                                                  2016     0 2016
#> 66                                                                           0 2015
#> 67                                                           36, 276-285     0 2015
#> 68                                                                  9-32     0 2015
#> 69                                                                           0 2015
#> 70                                                                           0 2015
#> 71                                                                           0 2015
#> 72                                                                           0 2015
#> 73                                                                           0 2015
#> 74                                                                           0 2014
#> 75                                                                           0 2014
#> 76                                                                           0 2013
#> 77                                                             2 (4), 11     0 2012
#> 78                                                                           0 2011
#> 79                                                                           0 2011
#> 80                                                                           0 2011
#> 81                                                                           0 2011
#> 82                                                                           0 2011
#> 83                                                                           0 2009
#> 84                                                                           0 2009
#> 85                                                                           0   NA
#> 86                                                                           0   NA
#> 87                                                                           0   NA
#> 88                                                                           0   NA
#> 89                                                                           0   NA
#> 90                                                                           0   NA
#> 91                                                                           0   NA
#> 92                                                                     1     0   NA
#> 93                                                                           0   NA
#>                                                               cid        pubid
#> 1     17240473400423700490,461159763596233481,1315542974843119305 UxriW0iASnsC
#> 2                                             9140218593636983243 9yKSN-GCB0IC
#> 3                                              203105297399726489 UeHWp8X0CEIC
#> 4                                             9327830809512404486 qjMakFHDy7sC
#> 5                                            17191703704621608544 u5HHmVD_uO8C
#> 6                                            15442728615805262127 kNdYIx-mwKoC
#> 7                                             3147100585201897138 UebtZRa9Y70C
#> 8                                            16121967639591190378 eQOLeE2rZwMC
#> 9                                             5904489841843560927 d1gkVwhDpl0C
#> 10 18143881066769803140,18233438384904663264,12975380653095517868 Tyk-4Ss8FVUC
#> 11                                           10446633547221929964 2osOgNQ5qMEC
#> 12                                           18309594979069207516 maZDTaKrznsC
#> 13                                            2251620908592189324 BqipwSGYUEgC
#> 14                       4894344398065441656,17805961515959316077 ldfaerwXgEUC
#> 15                                            7670225499012303854 e5wmG9Sq2KIC
#> 16                                            2401615506068930127 7PzlFSSx8tAC
#> 17                                            8792123396141403739 xtRiw3GOFMkC
#> 18                                            2112276567018030922 _FxGoFyzp5QC
#> 19                                           16059273116934807949 YsMSGLbcyi4C
#> 20                                            2539524527836644253 Y0pCki6q_DkC
#> 21                                           10149692484122806616 aqlVkmm33-oC
#> 22                                            8248470043986462984 M3ejUd6NZC8C
#> 23                                           13322468554278639475 vV6vV6tmYwMC
#> 24                                           16357054384393453824 D03iK_w7-QYC
#> 25                                            6880814424039971499 g5m5HwL7SMYC
#> 26                                            5199682358769198644 KlAtU1dfN6UC
#> 27                                           10378332126833599949 IjCSPb-OGe4C
#> 28                                           18182577779862774305 -f6ydRqryjwC
#> 29                        9375222806902931665,3745616990512837825 mB3voiENLucC
#> 30                                            9528443224826780083 ZeXyd9-uunAC
#> 31                                              41511425553822262 zYLM7Y9cAGgC
#> 32                                            8349908030823257502 pyW8ca7W8N0C
#> 33                                            1627288244325129498 a0OBvERweLwC
#> 34                                           16075774780598089063 k_IJM867U9cC
#> 35                                           10745397192148013810 LkGwnXOMwfcC
#> 36                                           14256154602665082067 JV2RwH3_ST0C
#> 37                                             818925813101569366 Se3iqnhoufwC
#> 38                                           15258532569899652859 W7OEmFMy1HYC
#> 39                                             163003866819331000 CHSYGLWDkRkC
#> 40                                            6027896113597554400 isC4tDSrTZIC
#> 41                                             641362829363743487 kzcrU_BdoSEC
#> 42                                            7114430646392466648 uWQEDVKXjbEC
#> 43                                            4092382021694339447 SP6oXDckpogC
#> 44                                            6273244451878075724 ufrVoPGSRksC
#> 45                                            4589290607551316207 O3NaXMp0MMsC
#> 46                                           10200636729873805270 QIV2ME_5wuYC
#> 47                                           10658172101302530460 4TOpqqG69KYC
#> 48                                           10107474183324844052 YFjsv_pBGBYC
#> 49                                            8633532378010504541 p2g8aNsByqUC
#> 50                                           16411127097378483929 ns9cj8rnVeAC
#> 51                                           10820360089296230361 Fu2w8maKXqMC
#> 52                                           12961270881488694754 u_35RYKgDlwC
#> 53                                           10798588282304546316 35N4QoGY0k4C
#> 54                                              53571672086000399 dhFuZR0502QC
#> 55                                           12114359551598956835 f2IySw72cVMC
#> 56                                                           <NA> tKAzc9rXhukC
#> 57                                                           <NA> OU6Ihb5iCvQC
#> 58                                                           <NA> b0M2c_1WBrUC
#> 59                                                           <NA> dfsIfKJdRG4C
#> 60                                                           <NA> u9iWguZQMMsC
#> 61                                                           <NA> 7T2F9Uy0os0C
#> 62                                                           <NA> NJ774b8OgUMC
#> 63                                                           <NA> lSLTfruPkqcC
#> 64                                                           <NA> RYcK_YlVTxYC
#> 65                                                           <NA> NaGl4SEjCO4C
#> 66                                                           <NA> nb7KW1ujOQ8C
#> 67                                                           <NA> NMxIlDl6LWMC
#> 68                                                           <NA> TFP_iSt0sucC
#> 69                                                           <NA> bEWYMUwI8FkC
#> 70                                                           <NA> iH-uZ7U-co4C
#> 71                                                           <NA> r0BpntZqJG4C
#> 72                                                           <NA> j3f4tGmQtD8C
#> 73                                                           <NA> 4JMBOYKVnBMC
#> 74                                                           <NA> XiSMed-E-HIC
#> 75                                                           <NA> yD5IFk8b50cC
#> 76                                                           <NA> 738O_yMBCRsC
#> 77                                                           <NA> P5F9QuxV20EC
#> 78                                                           <NA> _kc_bZDykSQC
#> 79                                                           <NA> ULOm3_A8WrAC
#> 80                                                           <NA> Zph67rFs4hoC
#> 81                                                           <NA> 3fE2CSJIrl8C
#> 82                                                           <NA> 5nxA0vEk-isC
#> 83                                                           <NA> dshw04ExmUIC
#> 84                                                           <NA> YOwf2qJgpHMC
#> 85                                                           <NA> WbkHhVStYXYC
#> 86                                                           <NA> Tiz5es2fbqcC
#> 87                                                           <NA> 1sJd4Hv_s6UC
#> 88                                                           <NA> cFHS6HbyZ2cC
#> 89                                                           <NA> 4OULZ7Gr8RgC
#> 90                                                           <NA> rO6llkc54NcC
#> 91                                                           <NA> 3s1wT3WcHBgC
#> 92                                                           <NA> M05iB0D1s5AC
#> 93                                                           <NA> 70eg2SAEIzsC
```

When and how often was Jochem cited? Seems like an increasing trend line!


```r
get_citation_history("Iu23-90AAAAJ")  # Jochem's citation history
```

```
#>    year cites
#> 1  2008    12
#> 2  2009    21
#> 3  2010    26
#> 4  2011    79
#> 5  2012    79
#> 6  2013   116
#> 7  2014   151
#> 8  2015   204
#> 9  2016   228
#> 10 2017   223
#> 11 2018   267
#> 12 2019   297
#> 13 2020   305
#> 14 2021   228
```

Get jochem's collaborators, and the collaborators of those collaborators. So essentially a "one-step-further-than-Jochem" network. 


```r
get_coauthors("Iu23-90AAAAJ", n_coauthors = 50, n_deep = 1)  # Jochem's collaborators and their co-authors!
```

```
#>                 author                               coauthors
#> 1        Jochem Tolsma                        Tom Van Der Meer
#> 2        Jochem Tolsma                      Maarten Hj Wolbers
#> 3        Jochem Tolsma                       Gerbert Kraaykamp
#> 4        Jochem Tolsma                          Peer Scheepers
#> 5        Jochem Tolsma                       Michael Savelkoul
#> 6        Jochem Tolsma                            Stijn Ruiter
#> 7        Jochem Tolsma                          Marcel Lubbers
#> 8        Jochem Tolsma                      Maurice Gesthuizen
#> 9        Jochem Tolsma                         Marcel Coenders
#> 10       Jochem Tolsma                       Nan Dirk De Graaf
#> 11       Jochem Tolsma                         Tobias H. Stark
#> 12       Jochem Tolsma                         Sara Kinsbergen
#> 13       Jochem Tolsma                       Christiaan Monden
#> 14       Jochem Tolsma                        Matthijs Kalmijn
#> 15       Jochem Tolsma                        Lincoln Quillian
#> 16       Jochem Tolsma                        Marloes De Lange
#> 17       Jochem Tolsma                             Ariana Need
#> 18       Jochem Tolsma                        Thomas Feliciani
#> 19       Jochem Tolsma                          Andreas Flache
#> 20       Jochem Tolsma                           René Veenstra
#> 21    Tom Van Der Meer                             Paul Dekker
#> 22    Tom Van Der Meer                          Peer Scheepers
#> 23    Tom Van Der Meer                     Wouter Van Der Brug
#> 24    Tom Van Der Meer                           Jochem Tolsma
#> 25    Tom Van Der Meer                   Manfred Te Grotenhuis
#> 26    Tom Van Der Meer                         Erika Van Elsas
#> 27    Tom Van Der Meer                      Maurice Gesthuizen
#> 28    Tom Van Der Meer                       Sarah L. De Lange
#> 29    Tom Van Der Meer                      Eefje Steenvoorden
#> 30    Tom Van Der Meer                       Armen Hakhverdian
#> 31    Tom Van Der Meer                         Eelco Harteveld
#> 32    Tom Van Der Meer                          Erik Van Ingen
#> 33    Tom Van Der Meer                          Huib Pellikaan
#> 34    Tom Van Der Meer                        Mérove Gijsberts
#> 35    Tom Van Der Meer                              Ben Pelzer
#> 36    Tom Van Der Meer                         Jan W. Van Deth
#> 37    Tom Van Der Meer                            Jaco Dagevos
#> 38    Tom Van Der Meer                            Sonja Zmerli
#> 39    Tom Van Der Meer                          Loes Aaldering
#> 40    Tom Van Der Meer                            Tim Reeskens
#> 44  Maarten Hj Wolbers                      Maurice Gesthuizen
#> 45  Maarten Hj Wolbers                        Marloes De Lange
#> 46  Maarten Hj Wolbers                       Gerbert Kraaykamp
#> 47  Maarten Hj Wolbers                              Wout Ultee
#> 48  Maarten Hj Wolbers                           Jochem Tolsma
#> 49  Maarten Hj Wolbers                        Paul M. De Graaf
#> 50  Maarten Hj Wolbers                             Mark Visser
#> 51  Maarten Hj Wolbers                           Jaap Dronkers
#> 52  Maarten Hj Wolbers                              Emer Smyth
#> 53  Maarten Hj Wolbers                             Ruud Luijkx
#> 54  Maarten Hj Wolbers                           Walter Müller
#> 55  Maarten Hj Wolbers                           Renze Kolster
#> 56  Maarten Hj Wolbers                             Tanja Traag
#> 57  Maarten Hj Wolbers                       Don Westerheijden
#> 58  Maarten Hj Wolbers                             Muja Ardita
#> 59  Maarten Hj Wolbers                           Nicole Tieben
#> 60  Maarten Hj Wolbers                         Andries De Grip
#> 61  Maarten Hj Wolbers                    Lieselotte Blommaert
#> 62  Maarten Hj Wolbers                           Richard Layte
#> 63  Maarten Hj Wolbers                        Margriet Van Hek
#> 67   Gerbert Kraaykamp                       Nan Dirk De Graaf
#> 68   Gerbert Kraaykamp                        Paul M. De Graaf
#> 69   Gerbert Kraaykamp                        Matthijs Kalmijn
#> 70   Gerbert Kraaykamp                              Tim Huijts
#> 71   Gerbert Kraaykamp                      Maarten Hj Wolbers
#> 72   Gerbert Kraaykamp                       Christiaan Monden
#> 73   Gerbert Kraaykamp                      Maurice Gesthuizen
#> 74   Gerbert Kraaykamp                             Mark Levels
#> 75   Gerbert Kraaykamp                           Jochem Tolsma
#> 76   Gerbert Kraaykamp                              Wout Ultee
#> 77   Gerbert Kraaykamp              Herman G. Van De Werfhorst
#> 78   Gerbert Kraaykamp                           Roza Meuleman
#> 79   Gerbert Kraaykamp                             Mark Visser
#> 80   Gerbert Kraaykamp                          Koen Van Eijck
#> 81   Gerbert Kraaykamp                        Margriet Van Hek
#> 82   Gerbert Kraaykamp                          Ellen Verbakel
#> 83   Gerbert Kraaykamp                          Stéfanie André
#> 84   Gerbert Kraaykamp                      Jesper Jelle Rözer
#> 85   Gerbert Kraaykamp                              Niels Blom
#> 86   Gerbert Kraaykamp                          Marcel Lubbers
#> 90      Peer Scheepers                         Marcel Coenders
#> 91      Peer Scheepers                          Marcel Lubbers
#> 92      Peer Scheepers                             Rob Eisinga
#> 93      Peer Scheepers                   Manfred Te Grotenhuis
#> 94      Peer Scheepers                        Mérove Gijsberts
#> 95      Peer Scheepers                      Maurice Gesthuizen
#> 96      Peer Scheepers                        Tom Van Der Meer
#> 97      Peer Scheepers                       Michael Savelkoul
#> 98      Peer Scheepers                            Jaak Billiet
#> 99      Peer Scheepers                           Hans De Witte
#> 100     Peer Scheepers                         Maurice Vergeer
#> 101     Peer Scheepers            Karin M Van Der Pal-De Bruin
#> 102     Peer Scheepers                         Agnieszka Kanas
#> 103     Peer Scheepers                           Jochem Tolsma
#> 104     Peer Scheepers                             Ruben Konig
#> 105     Peer Scheepers                        Pytrik Schafraad
#> 106     Peer Scheepers                      Frans Van Der Slik
#> 107     Peer Scheepers                             Mark Visser
#> 108     Peer Scheepers                             Paula Thijs
#> 109     Peer Scheepers                              Ben Pelzer
#> 113  Michael Savelkoul                          Peer Scheepers
#> 114  Michael Savelkoul                      Maurice Gesthuizen
#> 115  Michael Savelkoul                           Jochem Tolsma
#> 116  Michael Savelkoul                 William M. Van Der Veld
#> 117  Michael Savelkoul                         Dietlind Stolle
#> 118  Michael Savelkoul                          Miles Hewstone
#> 122       Stijn Ruiter                            Wim Bernasco
#> 123       Stijn Ruiter                       Nan Dirk De Graaf
#> 124       Stijn Ruiter                           Jochem Tolsma
#> 125       Stijn Ruiter                       Gerbert Kraaykamp
#> 126       Stijn Ruiter                      Frank Van Tubergen
#> 127       Stijn Ruiter                         Shane D Johnson
#> 128       Stijn Ruiter                            Daniel Birks
#> 129       Stijn Ruiter                        Michael Townsley
#> 130       Stijn Ruiter                     Marieke Van De Rakt
#> 131       Stijn Ruiter                        Paul Nieuwbeerta
#> 132       Stijn Ruiter                   Jean-Louis Van Gelder
#> 133       Stijn Ruiter                            Gentry White
#> 134       Stijn Ruiter                           Frank Weerman
#> 135       Stijn Ruiter                        Paul M. De Graaf
#> 136       Stijn Ruiter                           Hidde Bekhuis
#> 137       Stijn Ruiter                         Marcel Coenders
#> 138       Stijn Ruiter                              Scott Baum
#> 139       Stijn Ruiter                     Lieven J.r. Pauwels
#> 140       Stijn Ruiter               Marleen Weulen Kranenbarg
#> 141       Stijn Ruiter                            René Bekkers
#> 145     Marcel Lubbers                          Peer Scheepers
#> 146     Marcel Lubbers                         Marcel Coenders
#> 147     Marcel Lubbers                        Mérove Gijsberts
#> 148     Marcel Lubbers                             Eva Jaspers
#> 149     Marcel Lubbers                           Roza Meuleman
#> 150     Marcel Lubbers                           Jochem Tolsma
#> 151     Marcel Lubbers                             Rob Eisinga
#> 152     Marcel Lubbers                        Maykel Verkuyten
#> 153     Marcel Lubbers                       Nan Dirk De Graaf
#> 154     Marcel Lubbers                           Hidde Bekhuis
#> 155     Marcel Lubbers                           Tim Immerzeel
#> 156     Marcel Lubbers                            Jaak Billiet
#> 157     Marcel Lubbers                         Niels Spierings
#> 158     Marcel Lubbers                             Mark Visser
#> 159     Marcel Lubbers                         Maurice Vergeer
#> 160     Marcel Lubbers                       Roos Van Der Zwan
#> 161     Marcel Lubbers                           Claudia Diehl
#> 162     Marcel Lubbers                            Nella Geurts
#> 163     Marcel Lubbers                             Hilde Coffe
#> 164     Marcel Lubbers                    Jeanette A.j. Renema
#> 168 Maurice Gesthuizen                          Peer Scheepers
#> 169 Maurice Gesthuizen                       Gerbert Kraaykamp
#> 170 Maurice Gesthuizen                        Marloes De Lange
#> 171 Maurice Gesthuizen                        Tom Van Der Meer
#> 172 Maurice Gesthuizen                             Mark Visser
#> 173 Maurice Gesthuizen                       Michael Savelkoul
#> 174 Maurice Gesthuizen             "Heike Solga" Or "H. Solga"
#> 175 Maurice Gesthuizen                           Jochem Tolsma
#> 176 Maurice Gesthuizen                             Bram Steijn
#> 177 Maurice Gesthuizen                             Ariana Need
#> 178 Maurice Gesthuizen                        Paul M. De Graaf
#> 179 Maurice Gesthuizen                          Ellen Verbakel
#> 180 Maurice Gesthuizen                              Tim Huijts
#> 181 Maurice Gesthuizen                          Stéfanie André
#> 182 Maurice Gesthuizen                       Jasper Van Houten
#> 183 Maurice Gesthuizen                          Geert Driessen
#> 184 Maurice Gesthuizen                            Beate Volker
#> 185 Maurice Gesthuizen                 William M. Van Der Veld
#> 186 Maurice Gesthuizen                         Jan Paul Heisig
#> 187 Maurice Gesthuizen                            J.c. Vrooman
#> 194  Nan Dirk De Graaf                       Gerbert Kraaykamp
#> 195  Nan Dirk De Graaf                        Paul M. De Graaf
#> 196  Nan Dirk De Graaf                        Paul Nieuwbeerta
#> 197  Nan Dirk De Graaf                             Ariana Need
#> 198  Nan Dirk De Graaf                            Stijn Ruiter
#> 199  Nan Dirk De Graaf                          Geoffrey Evans
#> 200  Nan Dirk De Graaf                         Anthony F Heath
#> 201  Nan Dirk De Graaf                   Manfred Te Grotenhuis
#> 202  Nan Dirk De Graaf                            Giedo Jansen
#> 203  Nan Dirk De Graaf              Herman G. Van De Werfhorst
#> 204  Nan Dirk De Graaf                         Jonathan Kelley
#> 205  Nan Dirk De Graaf                       Christiaan Monden
#> 206  Nan Dirk De Graaf                          Marcel Lubbers
#> 207  Nan Dirk De Graaf                            René Bekkers
#> 208  Nan Dirk De Graaf                      Harry Bg Ganzeboom
#> 209  Nan Dirk De Graaf                           Jochem Tolsma
#> 210  Nan Dirk De Graaf                             Eva Jaspers
#> 211  Nan Dirk De Graaf                             Ruud Luijkx
#> 212  Nan Dirk De Graaf                        Lincoln Quillian
#> 213  Nan Dirk De Graaf                   Jacques  A. Hagenaars
#> 217    Tobias H. Stark                          Anke Munniksma
#> 218    Tobias H. Stark                           René Veenstra
#> 219    Tobias H. Stark                        Maykel Verkuyten
#> 220    Tobias H. Stark                              Josh Pasek
#> 221    Tobias H. Stark                          Trevor Tompson
#> 222    Tobias H. Stark                           Jochem Tolsma
#> 223    Tobias H. Stark               J. Ashwin Rambaran, Ph.d.
#> 224    Tobias H. Stark                       Ioana Van Deurzen
#> 234   Matthijs Kalmijn                        Paul M. De Graaf
#> 235   Matthijs Kalmijn                            Kène Henkens
#> 236   Matthijs Kalmijn                      Frank Van Tubergen
#> 237   Matthijs Kalmijn                       Gerbert Kraaykamp
#> 238   Matthijs Kalmijn                       Aart C. Liefbroer
#> 239   Matthijs Kalmijn                            Wilfred Uunk
#> 240   Matthijs Kalmijn                       Christiaan Monden
#> 241   Matthijs Kalmijn                          Marleen Damman
#> 242   Matthijs Kalmijn                      Anne-Rigt Poortman
#> 243   Matthijs Kalmijn                           Katya Ivanova
#> 244   Matthijs Kalmijn                      Harry Bg Ganzeboom
#> 245   Matthijs Kalmijn                    Jornt J. Mandemakers
#> 246   Matthijs Kalmijn                          Ellen Verbakel
#> 247   Matthijs Kalmijn                             Ruud Luijkx
#> 248   Matthijs Kalmijn                           Jaap Dronkers
#> 249   Matthijs Kalmijn            Marjolein Broese Van Groenou
#> 250   Matthijs Kalmijn                     Tanja Van Der Lippe
#> 251   Matthijs Kalmijn                          Erik Van Ingen
#> 252   Matthijs Kalmijn Nells - Netherlands Longitudinal Lif...
#> 256   Lincoln Quillian                           Jochem Tolsma
#> 269     Andreas Flache                            Michael Macy
#> 270     Andreas Flache                             Michael Mäs
#> 271     Andreas Flache                         Tobias H. Stark
#> 272     Andreas Flache                       Rainer Hegselmann
#> 273     Andreas Flache                           René Veenstra
#> 274     Andreas Flache                           Rafael Wittek
#> 275     Andreas Flache                      Guillaume Deffuant
#> 276     Andreas Flache                            Dirk Helbing
#> 277     Andreas Flache                          Anke Munniksma
#> 278     Andreas Flache                           Károly Takács
#> 279     Andreas Flache                           James A Kitts
#> 280     Andreas Flache                        Maykel Verkuyten
#> 281     Andreas Flache                           Nigel Gilbert
#> 282     Andreas Flache                         Maxi San Miguel
#> 283     Andreas Flache                           Rosaria Conte
#> 284     Andreas Flache                           Andrzej Nowak
#> 285     Andreas Flache                          Josep M. Pujol
#> 286     Andreas Flache                              André Grow
#> 287     Andreas Flache                             Werner Raub
#> 288     Andreas Flache                         Rene Torenvlied
#> 292      René Veenstra                     Ormel, Johan (Hans)
#> 293      René Veenstra                          Frank Verhulst
#> 294      René Veenstra                     Siegwart Lindenberg
#> 295      René Veenstra                   Jan Kornelis Dijkstra
#> 296      René Veenstra                       Tineke Oldehinkel
#> 297      René Veenstra                           Gijs Huitsing
#> 298      René Veenstra                    Christina Salmivalli
#> 299      René Veenstra                        Wilma Vollebergh
#> 300      René Veenstra                      Christian Steglich
#> 301      René Veenstra                         Tina Kretschmer
#> 302      René Veenstra                          Jelle Sijtsema
#> 303      René Veenstra                          Miranda Sentse
#> 304      René Veenstra                     Sijmen A Reijneveld
#> 305      René Veenstra                Rozemarijn Van Der Ploeg
#> 306      René Veenstra                    Catharina A. Hartman
#> 307      René Veenstra                             Miia Sainio
#> 308      René Veenstra                          Beau Oldenburg
#> 309      René Veenstra                 Marijtje A.j. Van Duijn
#> 310      René Veenstra                        Henning Tiemeier
#> 311      René Veenstra                      Antonius Cillessen
```

Notice, however, that we could easily plot Jochem's collaboration network already! (Though we leave the specifics for the sister-tutorial on viz.)

<!---this one bugs. have set eval=FALSE---> 


```r
plot_coauthors(get_coauthors("Iu23-90AAAAJ", n_coauthors = 50, n_deep = 1), size_labels = 2)  # Doesn't look like much yet, but we'll make it prettier later.
```

So let's gather these data, but now for *all* sociology staff simultaneously! For this, we use the for loop again. The for loop I make below is a bit more complicated, but follows the same logic as before. For each row (i) in `soc_df`, we attempt to query Google Scholar on the basis of the first name, last name, and affiliation listed in that row in the data frame. We use some handy subsetting, e.g., `soc_df[i, 3]` means we input `last_name=` with the last name (which is the third column) found in the i-th row in the data frame. The same goes for first name and affiliation. We fill up `gs_id` in the data frame with the Google Scholar IDs we'll hopefully find. The `for (i in nrow(soc_df))` simply means we let i run for however many rows the data frame has. Finally, the `tryCatch({})` function makes that we can continue the loop even though we may encounter errors for a given row. Here, that probably means that not every row (i.e., sociology staff member) can be found on Google Scholar. We print the error, but continue the for loop with the `tryCatch({})` function. In the final rows of the code below. We simply drop those rows that we cannot identify on Google Scholar.

<!--- i dont think it is good practice to use column numbers. peharps your code will change. best to use column names ---> 
<!---why did you set eval=FALSE? does not take too long. Don't forget we cache everything---> 
<!---if you use eval=FALSE. Don't forget to save the objects and load them in next script (with echo=FALSE)--->


```r
# Look throught get_scholar_id_fix(last_name, first_name, affiliation) 
# if we can find google scholar profiles of sociology staff!
for (i in 1:nrow(soc_df)) {
  
  tryCatch({
     soc_df[i,c("gs_id")] <- get_scholar_id_fix(last_name = soc_df[i, 3], # so search on last_name of staff (third column)
                                             first_name = soc_df[i,4],  # search on first_name of staff (fourth column)
                                             affiliation = soc_df[i,5]) # search on affiliation of each staff (fifth column)

    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")}) # continue on error, but print the error
  }

# remove those without pubs from the df
# seems we're left with about 34 sociology staff members!
soc_df <- soc_df[!soc_df$gs_id == "", ]
```






```r
soc_df
```

```
#>                                                                                       soc_names
#> 2                                                              Batenburg, prof. dr. R. (Ronald)
#> 3                                                                      Begall, dr. K.H. (Katia)
#> 4                                                                       Bekhuis, dr. H. (Hidde)
#> 5                                                                Berg, dr. L. van den (Lonneke)
#> 6                                                                Blommaert, dr. L. (Lieselotte)
#> 7                                                                      Damman, dr. M. (Marleen)
#> 8                                                                 Eisinga, prof. dr. R.N. (Rob)
#> 9                                                              Gesthuizen, dr. M.J.W. (Maurice)
#> 10                                                                        Glas, dr. S. (Saskia)
#> 11                                                                   Hek, dr. M. van (Margriet)
#> 12                                                                 Hoekman, dr. R. H. A.(Remco)
#> 13                                                                        Hofstra, dr. B. (Bas)
#> 14                                                        Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 15                                                                         Meuleman, dr. (Roza)
#> 16                                                                Savelkoul, dr. M.J. (Michael)
#> 17                                                           Scheepers, prof. dr. P.L.H. (Peer)
#> 18                                                              Spierings, dr. C.H.B.M. (Niels)
#> 19                                                                      Tolsma, dr. J. (Jochem)
#> 20 Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department
#> 21                                                                        Visser, dr. M. (Mark)
#> 22                                                          Wolbers, prof. dr. M.H.J. (Maarten)
#> 24                                                                Bussemakers, C. (Carlijn) MSc
#> 25                                                                        Franken, R. (Rob) MSc
#> 26                                                                      Firat, M. (Mustafa) MSc
#> 27                                                                     Geurts, P.G. (Nella) MSc
#> 29                                                               Jeroense, T.M.G. (Thijmen) MSc
#> 31                                                                        Loh, S.M. (Renae) MSc
#> 33                                                              Mensvoort, C.A. van (Carly) MSc
#> 34                                                                      Müller, K. (Katrin) MSc
#> 35                                                                       Raiber, K. (Klara) MSc
#> 36                                                               Ramaekers, M.J.M. (Marlou) MSc
#> 40                                                                  Houten, J. (Jasper) van MSc
#> 41                                                               Middendorp J. (Jansje) van MSc
#> 43                                                                       Weber, T. (Tijmen) MSc
#>                                                                                                       soc_experts
#> 2                                               Healthcare, labour market and healthcare professions and training
#> 3                  Family, life course, labour market participation, division of household tasks and gender norms
#> 4                                                                           Welfare state, nationalism and sports
#> 5                                                                 Family, life course and transition to adulthood
#> 6                                                              Discrimination and inequality on the labour market
#> 7                                    Labour market, life course, older workers, retirement and solo self-employed
#> 8                                                                              Methods of research and statistics
#> 9                                                                                      Poverty en social cohesion
#> 10                                                                          Islam, gender attitudes and sexuality
#> 11                                Educational inequality, gender inequality, organizational sociology and culture
#> 12                                                                                    Sports and policy sociology
#> 13                                                                           Diversity, inequality and innovation
#> 14                                                                     Educational inequality, culture and health
#> 15                                                                                        Culture and nationalism
#> 16                                                                Ethnic diversity, prejudice and social cohesion
#> 17                                                            Comparative research, social cohesion and diversity
#> 18                                               Islam, gender, populism, social media, Middle East and migration
#> 19                                                                   Inequality, criminology and ethnic diversity
#> 20                                                                                        Health, family and work
#> 21                                                                  Older workers, radicalism and social cohesion
#> 22                                                            Educational inequality and labour market inequality
#> 24                                                                Adverse youth experiences and social inequality
#> 25                                             Sport networks and motivation for sustainable sports participation
#> 26                                                   Social inequality, older workers, life course and retirement
#> 27                                                                                      Integration and migration
#> 29                                Political participation, segregation, opinion polarization and voting behaviour
#> 31 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 33                                                                            Gender, leadership and social norms
#> 34                                                        Opinions about discrimination, migration and inequality
#> 35                                                        Informal care, employment, social inequality and gender
#> 36                                                                                 Prosocial behaviour and family
#> 40                                                                                                         Sports
#> 41                                                                                            Home administration
#> 43                                International student mobility and the internationalization of higher education
#>      last_name first_name        affiliation        gs_id
#> 2    Batenburg     Ronald radboud university UK7nVSEAAAAJ
#> 3       Begall      Katia radboud university e7zfTqMAAAAJ
#> 4      Bekhuis      Hidde radboud university Q4saWX8AAAAJ
#> 5         Berg    Lonneke radboud university vzBNQ1kAAAAJ
#> 6    Blommaert Lieselotte radboud university RG54uasAAAAJ
#> 7       Damman    Marleen radboud university MEv-V_YAAAAJ
#> 8      Eisinga        Rob radboud university GDHdsXAAAAAJ
#> 9   Gesthuizen    Maurice radboud university n6hiblQAAAAJ
#> 10        Glas     Saskia radboud university ZMc0j2YAAAAJ
#> 11         Hek   Margriet radboud university ZvLlx2EAAAAJ
#> 12     Hoekman      Remco radboud university LsMimOEAAAAJ
#> 13     Hofstra        Bas radboud university Nx7pDywAAAAJ
#> 14   Kraaykamp    Gerbert radboud university l8aM4jAAAAAJ
#> 15    Meuleman       Roza radboud university iKs_5WkAAAAJ
#> 16   Savelkoul    Michael radboud university _f3krXUAAAAJ
#> 17   Scheepers       Peer radboud university hPeXxvEAAAAJ
#> 18   Spierings      Niels radboud university cy3Ye6sAAAAJ
#> 19      Tolsma     Jochem radboud university Iu23-90AAAAJ
#> 20    Verbakel      Ellen radboud university w2McVJAAAAAJ
#> 21      Visser       Mark radboud university ItITloQAAAAJ
#> 22     Wolbers    Maarten radboud university TqKrXnMAAAAJ
#> 24 Bussemakers    Carlijn radboud university bDPtkIoAAAAJ
#> 25     Franken        Rob radboud university p3IwtT4AAAAJ
#> 26       Firat    Mustafa radboud university _ukytQYAAAAJ
#> 27      Geurts      Nella radboud university VCTvbTkAAAAJ
#> 29    Jeroense    Thijmen radboud university izq-KNUAAAAJ
#> 31         Loh      Renae radboud university tFaMPOQAAAAJ
#> 33   Mensvoort      Carly radboud university z6iMs-UAAAAJ
#> 34      Müller     Katrin radboud university lkVq32sAAAAJ
#> 35      Raiber      Klara radboud university xE65HUcAAAAJ
#> 36   Ramaekers     Marlou radboud university fp99JAQAAAAJ
#> 40      Houten     Jasper radboud university iR4UIwwAAAAJ
#> 41  Middendorp     Jansje radboud university gs0li6MAAAAJ
#> 43       Weber     Tijmen radboud university KfLALRIAAAAJ
```

It works! So what is left to do is simply to get the data we already extracted for Jochem, but for all sociology staff. For that, we need a bunch of for loops. Let's first gather the profiles and publications. We store those in a `list()` which is an object in which you can store multiple data frames, vectors, matrices, and so forth. This is particularly good for for loops because you can store information that is -- at first sight -- not necessarily compatible. For instance, matrices of different length. Note that bind a Google Scholar ID to the publications too. 


```r
soc_list_profiles <- list()  # first we create an empty list that we then fill up with the for loop
soc_list_publications <- list()

for (i in 1:nrow(soc_df)) {
    
    # note how you call different elements in a list '[[]]', fill in the i-th element
    soc_list_profiles[[i]] <- get_profile(soc_df[i, c("gs_id")])  # Note how we call row i (remember how to call rows in a DF/Matrix) and then the associated scholar id
    soc_list_publications[[i]] <- get_publications(soc_df[i, c("gs_id")])
    soc_list_publications[[i]][, c("gs_id")] <- soc_df[i, c("gs_id")]  # note that we again attach an id
    # so both functions here call the entire profile and pubs for an author, based on google scholar ids
    
}
# Notice how fast the data blow up! 34 scholars publish ~3000 papers
soc_df_publications <- bind_rows(soc_list_publications)
```






<!---this really goes too fast for students---> 

We need to do some relatively involved data handling to attach the Google Scholar profiles in `soc_list_profiles` to the `soc_df`. That is mostly because profile elements can contain more than one row. For instance, co-authors are stored in long format per profile that do not easily merge to a data frame where each staff member is a row. So we need to get only the profile elements that have a single element per profile element (e.g., total cites). Seems these are the first 8 elements. So we need to get those out of the lists and store those in a new list. We use a couple of functions to first `unlist` the 1 tot 8-th elements in that list, make it a data frame, and *transpose* the data such that each row contains 8 columns. We then use the function `bind_rows()` to simply make a data frame from the list elements. We then merge it to `soc_df`. So what we end up with is a sociology staff data frame with much more information than before: citations, indices, expertise listed on Google Scholar, and so forth.


```r
# get the profiles too, just to be sure
soc_profiles_df <- list()
for (i in 1:length(soc_list_profiles)) {
    soc_profiles_df[[i]] <- data.frame(t(unlist(soc_list_profiles[[i]][1:8])))  #some annyoing data handling
}
soc_profiles_df <- bind_rows(soc_profiles_df)
soc_df <- left_join(soc_df, soc_profiles_df, by = c(gs_id = "id"))  # merge data with soc_df
```






```r
soc_df
```

```
#>                                                                                       soc_names
#> 1                                                              Batenburg, prof. dr. R. (Ronald)
#> 2                                                                      Begall, dr. K.H. (Katia)
#> 3                                                                       Bekhuis, dr. H. (Hidde)
#> 4                                                                Berg, dr. L. van den (Lonneke)
#> 5                                                                Blommaert, dr. L. (Lieselotte)
#> 6                                                                      Damman, dr. M. (Marleen)
#> 7                                                                 Eisinga, prof. dr. R.N. (Rob)
#> 8                                                              Gesthuizen, dr. M.J.W. (Maurice)
#> 9                                                                         Glas, dr. S. (Saskia)
#> 10                                                                   Hek, dr. M. van (Margriet)
#> 11                                                                 Hoekman, dr. R. H. A.(Remco)
#> 12                                                                        Hofstra, dr. B. (Bas)
#> 13                                                        Kraaykamp, prof. dr. G.L.M. (Gerbert)
#> 14                                                                         Meuleman, dr. (Roza)
#> 15                                                                Savelkoul, dr. M.J. (Michael)
#> 16                                                           Scheepers, prof. dr. P.L.H. (Peer)
#> 17                                                              Spierings, dr. C.H.B.M. (Niels)
#> 18                                                                      Tolsma, dr. J. (Jochem)
#> 19 Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department
#> 20                                                                        Visser, dr. M. (Mark)
#> 21                                                          Wolbers, prof. dr. M.H.J. (Maarten)
#> 22                                                                Bussemakers, C. (Carlijn) MSc
#> 23                                                                        Franken, R. (Rob) MSc
#> 24                                                                      Firat, M. (Mustafa) MSc
#> 25                                                                     Geurts, P.G. (Nella) MSc
#> 26                                                               Jeroense, T.M.G. (Thijmen) MSc
#> 27                                                                        Loh, S.M. (Renae) MSc
#> 28                                                              Mensvoort, C.A. van (Carly) MSc
#> 29                                                                      Müller, K. (Katrin) MSc
#> 30                                                                       Raiber, K. (Klara) MSc
#> 31                                                               Ramaekers, M.J.M. (Marlou) MSc
#> 32                                                                  Houten, J. (Jasper) van MSc
#> 33                                                               Middendorp J. (Jansje) van MSc
#> 34                                                                       Weber, T. (Tijmen) MSc
#>                                                                                                       soc_experts
#> 1                                               Healthcare, labour market and healthcare professions and training
#> 2                  Family, life course, labour market participation, division of household tasks and gender norms
#> 3                                                                           Welfare state, nationalism and sports
#> 4                                                                 Family, life course and transition to adulthood
#> 5                                                              Discrimination and inequality on the labour market
#> 6                                    Labour market, life course, older workers, retirement and solo self-employed
#> 7                                                                              Methods of research and statistics
#> 8                                                                                      Poverty en social cohesion
#> 9                                                                           Islam, gender attitudes and sexuality
#> 10                                Educational inequality, gender inequality, organizational sociology and culture
#> 11                                                                                    Sports and policy sociology
#> 12                                                                           Diversity, inequality and innovation
#> 13                                                                     Educational inequality, culture and health
#> 14                                                                                        Culture and nationalism
#> 15                                                                Ethnic diversity, prejudice and social cohesion
#> 16                                                            Comparative research, social cohesion and diversity
#> 17                                               Islam, gender, populism, social media, Middle East and migration
#> 18                                                                   Inequality, criminology and ethnic diversity
#> 19                                                                                        Health, family and work
#> 20                                                                  Older workers, radicalism and social cohesion
#> 21                                                            Educational inequality and labour market inequality
#> 22                                                                Adverse youth experiences and social inequality
#> 23                                             Sport networks and motivation for sustainable sports participation
#> 24                                                   Social inequality, older workers, life course and retirement
#> 25                                                                                      Integration and migration
#> 26                                Political participation, segregation, opinion polarization and voting behaviour
#> 27 Educational sociology, social stratification, gender inequality and information communication technology (ICT)
#> 28                                                                            Gender, leadership and social norms
#> 29                                                        Opinions about discrimination, migration and inequality
#> 30                                                        Informal care, employment, social inequality and gender
#> 31                                                                                 Prosocial behaviour and family
#> 32                                                                                                         Sports
#> 33                                                                                            Home administration
#> 34                                International student mobility and the internationalization of higher education
#>      last_name first_name      affiliation.x        gs_id                      name
#> 1    Batenburg     Ronald radboud university UK7nVSEAAAAJ          Ronald Batenburg
#> 2       Begall      Katia radboud university e7zfTqMAAAAJ              Katia Begall
#> 3      Bekhuis      Hidde radboud university Q4saWX8AAAAJ             Hidde Bekhuis
#> 4         Berg    Lonneke radboud university vzBNQ1kAAAAJ      Lonneke van den Berg
#> 5    Blommaert Lieselotte radboud university RG54uasAAAAJ      Lieselotte Blommaert
#> 6       Damman    Marleen radboud university MEv-V_YAAAAJ            Marleen Damman
#> 7      Eisinga        Rob radboud university GDHdsXAAAAAJ               Rob Eisinga
#> 8   Gesthuizen    Maurice radboud university n6hiblQAAAAJ        Maurice Gesthuizen
#> 9         Glas     Saskia radboud university ZMc0j2YAAAAJ               Saskia Glas
#> 10         Hek   Margriet radboud university ZvLlx2EAAAAJ          Margriet van Hek
#> 11     Hoekman      Remco radboud university LsMimOEAAAAJ             Remco Hoekman
#> 12     Hofstra        Bas radboud university Nx7pDywAAAAJ               Bas Hofstra
#> 13   Kraaykamp    Gerbert radboud university l8aM4jAAAAAJ         Gerbert Kraaykamp
#> 14    Meuleman       Roza radboud university iKs_5WkAAAAJ             Roza Meuleman
#> 15   Savelkoul    Michael radboud university _f3krXUAAAAJ         Michael Savelkoul
#> 16   Scheepers       Peer radboud university hPeXxvEAAAAJ            peer scheepers
#> 17   Spierings      Niels radboud university cy3Ye6sAAAAJ           Niels Spierings
#> 18      Tolsma     Jochem radboud university Iu23-90AAAAJ             Jochem Tolsma
#> 19    Verbakel      Ellen radboud university w2McVJAAAAAJ            Ellen Verbakel
#> 20      Visser       Mark radboud university ItITloQAAAAJ               Mark Visser
#> 21     Wolbers    Maarten radboud university TqKrXnMAAAAJ        Maarten HJ Wolbers
#> 22 Bussemakers    Carlijn radboud university bDPtkIoAAAAJ       Carlijn Bussemakers
#> 23     Franken        Rob radboud university p3IwtT4AAAAJ            Rob JM Franken
#> 24       Firat    Mustafa radboud university _ukytQYAAAAJ               mustafa Inc
#> 25      Geurts      Nella radboud university VCTvbTkAAAAJ              Nella Geurts
#> 26    Jeroense    Thijmen radboud university izq-KNUAAAAJ          Thijmen Jeroense
#> 27         Loh      Renae radboud university tFaMPOQAAAAJ        Renae Sze Ming Loh
#> 28   Mensvoort      Carly radboud university z6iMs-UAAAAJ       Carly van Mensvoort
#> 29      Müller     Katrin radboud university lkVq32sAAAAJ Kathrin Friederike Müller
#> 30      Raiber      Klara radboud university xE65HUcAAAAJ              Klara Raiber
#> 31   Ramaekers     Marlou radboud university fp99JAQAAAAJ          Marlou Ramaekers
#> 32      Houten     Jasper radboud university iR4UIwwAAAAJ         Jasper van Houten
#> 33  Middendorp     Jansje radboud university gs0li6MAAAAJ     Jansje van Middendorp
#> 34       Weber     Tijmen radboud university KfLALRIAAAAJ              Tijmen Weber
#>                                                                                    affiliation.y
#> 1                    Programmaleider NIVEL en bijzonder hoogleraar Radboud Universiteit Nijmegen
#> 2                                                                    Radboud University Nijmegen
#> 3                                                Post Doc Sociology, Radboud University Nijmegen
#> 4                                                                             Radboud University
#> 5                          Sociology/Social Cultural Research, Radboud University, Nijmegen, the
#> 6                                                        Assistant Professor, Utrecht University
#> 7                         Professor social science research methods, Radboud University Nijmegen
#> 8                   Sociology, Radboud University Nijmegen, the Netherland - Assistant Professor
#> 9                                                                PhD student, Radboud University
#> 10                                                                            Radboud University
#> 11                            Director, Mulier Institute / Senior researcher, Radboud University
#> 12                                                       Assistant Professor, Radboud University
#> 13                                         Professor of Sociology, Radboud Universiteit Nijmegen
#> 14                                 Assistant Professor - Sociology - Radboud University Nijmegen
#> 15                 Assistant Professor - Sociology, Radboud University Nijmegen, the Netherlands
#> 16             hoogleraar methodologie, faculteit der sociale wetenschappen radboud universiteit
#> 17                                          Associate Professor of Sociology, Radboud University
#> 18                              Professor, Radboud University Nijmegen / University of Groningen
#> 19                  Professor of Sociology, Department of Sociology, Radboud University Nijmegen
#> 20                                                       Assistant Professor, Radboud University
#> 21                                          Professor of Sociology, Radboud University, Nijmegen
#> 22                                                   Department of Sociology, Radboud University
#> 23                                                                           Unknown affiliation
#> 24                                                                              firat university
#> 25                                                   Department of Sociology, Radboud University
#> 26                                                    PhD candidate, Radboud University Nijmegen
#> 27                                                             PhD candidate, Radboud University
#> 28                                                                            Radboud University
#> 29                                                       Post-Doc, Universtität Rostock/CAIS NRW
#> 30                                                    PhD candidate, Radboud University Nijmegen
#> 31                                                             PhD Candidate, Radboud University
#> 32 PhD Candidate, HAN Institute of Sport and Exercise Studies (Hogeschool van Arnhem en Nijmegen
#> 33                                                        Buitenpromovendus Radboud Universiteit
#> 34                          Lecturer Statistics and Research, HAN University of Applied Sciences
#>    total_cites h_index i10_index                                          fields
#> 1         3608      30        87           verified email at nivel.nl - homepage
#> 2          936       9         9                     verified email at maw.ru.nl
#> 3          348       8         7                         verified email at ru.nl
#> 4           34       3         2          verified email at maw.ru.nl - homepage
#> 5          317       7         7              verified email at ru.nl - homepage
#> 6          515      10        12              verified email at uu.nl - homepage
#> 7         4994      33        77              verified email at ru.nl - homepage
#> 8         2425      24        41          verified email at maw.ru.nl - homepage
#> 9           70       4         2                         verified email at ru.nl
#> 10         262       8         7                     verified email at maw.ru.nl
#> 11         610      12        15 verified email at mulierinstituut.nl - homepage
#> 12         384       7         7              verified email at ru.nl - homepage
#> 13        7724      46        98          verified email at maw.ru.nl - homepage
#> 14         214       8         6                         verified email at ru.nl
#> 15         580       8         7                     verified email at maw.ru.nl
#> 16       14399      61       180                     verified email at maw.ru.nl
#> 17        1662      22        33              verified email at ru.nl - homepage
#> 18        2260      22        33              verified email at ru.nl - homepage
#> 19        1474      24        32          verified email at maw.ru.nl - homepage
#> 20         381       9         8              verified email at ru.nl - homepage
#> 21        3624      29        58              verified email at ru.nl - homepage
#> 22          37       3         1                     verified email at maw.ru.nl
#> 23        1219      11        12                               no verified email
#> 24        5298      34       173                  verified email at firat.edu.tr
#> 25          32       3         1                         verified email at ru.nl
#> 26           1       1         0              verified email at ru.nl - homepage
#> 27          70       2         2              verified email at ru.nl - homepage
#> 28          35       2         2              verified email at ru.nl - homepage
#> 29         201       9         9     verified email at uni-rostock.de - homepage
#> 30           4       1         0          verified email at maw.ru.nl - homepage
#> 31        <NA>    <NA>      <NA>                         verified email at ru.nl
#> 32          31       4         1              verified email at ru.nl - homepage
#> 33           3       1         0                         verified email at ru.nl
#> 34          42       2         2                        verified email at han.nl
#>                                                                                                    homepage
#> 1                                                                  https://www.nivel.nl/nl/ronald-batenburg
#> 2                                                                                                      <NA>
#> 3                                                                                                      <NA>
#> 4                                                        https://www.ru.nl/personen/berg-l-van-den-lonneke/
#> 5                                                              http://www.ru.nl/english/people/blommaert-e/
#> 6                                                                           https://www.uu.nl/staff/MDamman
#> 7                                                                           http://robeisinga.ruhosting.nl/
#> 8  http://www.ru.nl/methodenentechnieken/methoden-technieken/medewerkers/vm_medewerkers/maurice_gesthuizen/
#> 9                                                                                                      <NA>
#> 10                                                                                                     <NA>
#> 11                                    https://www.mulierinstituut.nl/over-mulier/medewerkers/remco-hoekman/
#> 12                                                                               http://www.bashofstra.com/
#> 13                                                            https://www.ru.nl/english/people/kraaykamp-g/
#> 14                                                                                                     <NA>
#> 15                                                                                                     <NA>
#> 16                                                                                                     <NA>
#> 17                                                            https://www.ru.nl/english/people/spierings-c/
#> 18                                                                              http://www.jochemtolsma.nl/
#> 19                                                                             http://www.ellenverbakel.nl/
#> 20                                                         https://www.researchgate.net/profile/Mark_Visser
#> 21                                                                        http://www.socsci.ru.nl/maartenw/
#> 22                                                                                                     <NA>
#> 23                                                                                                     <NA>
#> 24                                                                                                     <NA>
#> 25                                                                                                     <NA>
#> 26                                                                   https://www.ru.nl/personen/jeroense-t/
#> 27                                                                                     http://renaeloh.com/
#> 28                                                        https://www.ru.nl/english/people/mensvoort-c-van/
#> 29         https://www.imf.uni-rostock.de/institut/mitarbeiterinnen/lehrende/dr-kathrin-friederike-mueller/
#> 30                                                               https://www.ru.nl/english/people/raiber-k/
#> 31                                                                                                     <NA>
#> 32                                                       https://www.researchgate.net/profile/Jasper_Houten
#> 33                                                                                                     <NA>
#> 34                                                                                                     <NA>
```


So we have papers and profile. Remember how we got Jochem's citation history? We want that for each staff member too. Yet again, we use a for loop. We first store the citation history in a list. But notice the `if` statement! We only continue the for loop for that i-th element if some statement is `TRUE`. Here, we attempt to find out if the i-th element, the citation history of the staff member, has a length than is larger than 0. Some staff members are never cited (which happens all the time if papers are only just published), and so for these staff members that is no list element that contains information. We only attach a Google Scholar ID for those staff members that are cited at least once. We bind the rows again and end up with a data frame in *long format*: three columns with years, cites, and Google Scholar ID. Therefore, there is more than one row per staff member.


```r
# get citation history of a scholar
soc_staff_cit <- list()
for (i in 1:nrow(soc_df)) {
    
    soc_staff_cit[[i]] <- get_citation_history(soc_df[i, c("gs_id")])
    
    if (nrow(soc_staff_cit[[i]]) > 0) {
        soc_staff_cit[[i]][, c("gs_id")] <- soc_df[i, c("gs_id")]  # again attach the gs_id as third column
    }
}
soc_staff_cit <- bind_rows(soc_staff_cit)
colnames(soc_staff_cit)[3] <- "gs_id"
```





```r
soc_staff_cit
```

```
#>     year cites        gs_id
#> 1   1999    14 UK7nVSEAAAAJ
#> 2   2000    25 UK7nVSEAAAAJ
#> 3   2001    21 UK7nVSEAAAAJ
#> 4   2002    18 UK7nVSEAAAAJ
#> 5   2003    35 UK7nVSEAAAAJ
#> 6   2004    24 UK7nVSEAAAAJ
#> 7   2005    53 UK7nVSEAAAAJ
#> 8   2006    64 UK7nVSEAAAAJ
#> 9   2007    52 UK7nVSEAAAAJ
#> 10  2008    80 UK7nVSEAAAAJ
#> 11  2009   115 UK7nVSEAAAAJ
#> 12  2010   134 UK7nVSEAAAAJ
#> 13  2011   158 UK7nVSEAAAAJ
#> 14  2012   186 UK7nVSEAAAAJ
#> 15  2013   219 UK7nVSEAAAAJ
#> 16  2014   207 UK7nVSEAAAAJ
#> 17  2015   257 UK7nVSEAAAAJ
#> 18  2016   336 UK7nVSEAAAAJ
#> 19  2017   307 UK7nVSEAAAAJ
#> 20  2018   358 UK7nVSEAAAAJ
#> 21  2019   314 UK7nVSEAAAAJ
#> 22  2020   335 UK7nVSEAAAAJ
#> 23  2021   183 UK7nVSEAAAAJ
#> 24  2008     5 e7zfTqMAAAAJ
#> 25  2009    18 e7zfTqMAAAAJ
#> 26  2010    28 e7zfTqMAAAAJ
#> 27  2011    29 e7zfTqMAAAAJ
#> 28  2012    32 e7zfTqMAAAAJ
#> 29  2013    48 e7zfTqMAAAAJ
#> 30  2014    51 e7zfTqMAAAAJ
#> 31  2015    61 e7zfTqMAAAAJ
#> 32  2016    77 e7zfTqMAAAAJ
#> 33  2017   120 e7zfTqMAAAAJ
#> 34  2018    99 e7zfTqMAAAAJ
#> 35  2019   119 e7zfTqMAAAAJ
#> 36  2020   137 e7zfTqMAAAAJ
#> 37  2021   102 e7zfTqMAAAAJ
#> 38  2008     1 Q4saWX8AAAAJ
#> 39  2009     4 Q4saWX8AAAAJ
#> 40  2010     7 Q4saWX8AAAAJ
#> 41  2011     7 Q4saWX8AAAAJ
#> 42  2012    17 Q4saWX8AAAAJ
#> 43  2013    22 Q4saWX8AAAAJ
#> 44  2014    36 Q4saWX8AAAAJ
#> 45  2015    29 Q4saWX8AAAAJ
#> 46  2016    37 Q4saWX8AAAAJ
#> 47  2017    25 Q4saWX8AAAAJ
#> 48  2018    33 Q4saWX8AAAAJ
#> 49  2019    50 Q4saWX8AAAAJ
#> 50  2020    40 Q4saWX8AAAAJ
#> 51  2021    32 Q4saWX8AAAAJ
#> 52  2018     1 vzBNQ1kAAAAJ
#> 53  2019     6 vzBNQ1kAAAAJ
#> 54  2020     9 vzBNQ1kAAAAJ
#> 55  2021    15 vzBNQ1kAAAAJ
#> 56  2012     3 RG54uasAAAAJ
#> 57  2013     3 RG54uasAAAAJ
#> 58  2014     8 RG54uasAAAAJ
#> 59  2015    24 RG54uasAAAAJ
#> 60  2016    19 RG54uasAAAAJ
#> 61  2017    34 RG54uasAAAAJ
#> 62  2018    41 RG54uasAAAAJ
#> 63  2019    58 RG54uasAAAAJ
#> 64  2020    72 RG54uasAAAAJ
#> 65  2021    51 RG54uasAAAAJ
#> 66  2011     2 MEv-V_YAAAAJ
#> 67  2012     7 MEv-V_YAAAAJ
#> 68  2013    15 MEv-V_YAAAAJ
#> 69  2014    19 MEv-V_YAAAAJ
#> 70  2015    30 MEv-V_YAAAAJ
#> 71  2016    60 MEv-V_YAAAAJ
#> 72  2017    65 MEv-V_YAAAAJ
#> 73  2018    78 MEv-V_YAAAAJ
#> 74  2019    88 MEv-V_YAAAAJ
#> 75  2020    85 MEv-V_YAAAAJ
#> 76  2021    60 MEv-V_YAAAAJ
#> 77  1991    18 GDHdsXAAAAAJ
#> 78  1992    13 GDHdsXAAAAAJ
#> 79  1993    14 GDHdsXAAAAAJ
#> 80  1994    41 GDHdsXAAAAAJ
#> 81  1995    38 GDHdsXAAAAAJ
#> 82  1996    37 GDHdsXAAAAAJ
#> 83  1997    26 GDHdsXAAAAAJ
#> 84  1998    24 GDHdsXAAAAAJ
#> 85  1999    36 GDHdsXAAAAAJ
#> 86  2000    47 GDHdsXAAAAAJ
#> 87  2001    50 GDHdsXAAAAAJ
#> 88  2002    44 GDHdsXAAAAAJ
#> 89  2003    42 GDHdsXAAAAAJ
#> 90  2004    35 GDHdsXAAAAAJ
#> 91  2005    48 GDHdsXAAAAAJ
#> 92  2006    63 GDHdsXAAAAAJ
#> 93  2007    58 GDHdsXAAAAAJ
#> 94  2008    83 GDHdsXAAAAAJ
#> 95  2009   120 GDHdsXAAAAAJ
#> 96  2010    98 GDHdsXAAAAAJ
#> 97  2011   104 GDHdsXAAAAAJ
#> 98  2012   143 GDHdsXAAAAAJ
#> 99  2013   184 GDHdsXAAAAAJ
#> 100 2014   277 GDHdsXAAAAAJ
#> 101 2015   345 GDHdsXAAAAAJ
#> 102 2016   411 GDHdsXAAAAAJ
#> 103 2017   441 GDHdsXAAAAAJ
#> 104 2018   527 GDHdsXAAAAAJ
#> 105 2019   495 GDHdsXAAAAAJ
#> 106 2020   591 GDHdsXAAAAAJ
#> 107 2021   447 GDHdsXAAAAAJ
#> 108 2005    10 n6hiblQAAAAJ
#> 109 2006    19 n6hiblQAAAAJ
#> 110 2007    28 n6hiblQAAAAJ
#> 111 2008    47 n6hiblQAAAAJ
#> 112 2009    54 n6hiblQAAAAJ
#> 113 2010    67 n6hiblQAAAAJ
#> 114 2011   128 n6hiblQAAAAJ
#> 115 2012   121 n6hiblQAAAAJ
#> 116 2013   175 n6hiblQAAAAJ
#> 117 2014   200 n6hiblQAAAAJ
#> 118 2015   231 n6hiblQAAAAJ
#> 119 2016   252 n6hiblQAAAAJ
#> 120 2017   237 n6hiblQAAAAJ
#> 121 2018   206 n6hiblQAAAAJ
#> 122 2019   208 n6hiblQAAAAJ
#> 123 2020   210 n6hiblQAAAAJ
#> 124 2021   186 n6hiblQAAAAJ
#> 125 2018     2 ZMc0j2YAAAAJ
#> 126 2019    13 ZMc0j2YAAAAJ
#> 127 2020    29 ZMc0j2YAAAAJ
#> 128 2021    26 ZMc0j2YAAAAJ
#> 129 2014     3 ZvLlx2EAAAAJ
#> 130 2015     4 ZvLlx2EAAAAJ
#> 131 2016    19 ZvLlx2EAAAAJ
#> 132 2017    15 ZvLlx2EAAAAJ
#> 133 2018    31 ZvLlx2EAAAAJ
#> 134 2019    55 ZvLlx2EAAAAJ
#> 135 2020    78 ZvLlx2EAAAAJ
#> 136 2021    55 ZvLlx2EAAAAJ
#> 137 2010     4 LsMimOEAAAAJ
#> 138 2011     7 LsMimOEAAAAJ
#> 139 2012    12 LsMimOEAAAAJ
#> 140 2013    24 LsMimOEAAAAJ
#> 141 2014    40 LsMimOEAAAAJ
#> 142 2015    36 LsMimOEAAAAJ
#> 143 2016    53 LsMimOEAAAAJ
#> 144 2017    76 LsMimOEAAAAJ
#> 145 2018    81 LsMimOEAAAAJ
#> 146 2019    49 LsMimOEAAAAJ
#> 147 2020   122 LsMimOEAAAAJ
#> 148 2021    98 LsMimOEAAAAJ
#> 149 2014     2 Nx7pDywAAAAJ
#> 150 2015     2 Nx7pDywAAAAJ
#> 151 2016    15 Nx7pDywAAAAJ
#> 152 2017    25 Nx7pDywAAAAJ
#> 153 2018    33 Nx7pDywAAAAJ
#> 154 2019    28 Nx7pDywAAAAJ
#> 155 2020   105 Nx7pDywAAAAJ
#> 156 2021   162 Nx7pDywAAAAJ
#> 157 1997    22 l8aM4jAAAAAJ
#> 158 1998    19 l8aM4jAAAAAJ
#> 159 1999    31 l8aM4jAAAAAJ
#> 160 2000    49 l8aM4jAAAAAJ
#> 161 2001    77 l8aM4jAAAAAJ
#> 162 2002    87 l8aM4jAAAAAJ
#> 163 2003    98 l8aM4jAAAAAJ
#> 164 2004   116 l8aM4jAAAAAJ
#> 165 2005   126 l8aM4jAAAAAJ
#> 166 2006   176 l8aM4jAAAAAJ
#> 167 2007   205 l8aM4jAAAAAJ
#> 168 2008   256 l8aM4jAAAAAJ
#> 169 2009   246 l8aM4jAAAAAJ
#> 170 2010   303 l8aM4jAAAAAJ
#> 171 2011   360 l8aM4jAAAAAJ
#> 172 2012   363 l8aM4jAAAAAJ
#> 173 2013   460 l8aM4jAAAAAJ
#> 174 2014   474 l8aM4jAAAAAJ
#> 175 2015   512 l8aM4jAAAAAJ
#> 176 2016   614 l8aM4jAAAAAJ
#> 177 2017   581 l8aM4jAAAAAJ
#> 178 2018   655 l8aM4jAAAAAJ
#> 179 2019   621 l8aM4jAAAAAJ
#> 180 2020   662 l8aM4jAAAAAJ
#> 181 2021   440 l8aM4jAAAAAJ
#> 182 2012     1 iKs_5WkAAAAJ
#> 183 2013     5 iKs_5WkAAAAJ
#> 184 2014    14 iKs_5WkAAAAJ
#> 185 2015    19 iKs_5WkAAAAJ
#> 186 2016    23 iKs_5WkAAAAJ
#> 187 2017    30 iKs_5WkAAAAJ
#> 188 2018    31 iKs_5WkAAAAJ
#> 189 2019    39 iKs_5WkAAAAJ
#> 190 2020    23 iKs_5WkAAAAJ
#> 191 2021    20 iKs_5WkAAAAJ
#> 192 2011    10 _f3krXUAAAAJ
#> 193 2012    24 _f3krXUAAAAJ
#> 194 2013    32 _f3krXUAAAAJ
#> 195 2014    51 _f3krXUAAAAJ
#> 196 2015    67 _f3krXUAAAAJ
#> 197 2016    54 _f3krXUAAAAJ
#> 198 2017    63 _f3krXUAAAAJ
#> 199 2018    80 _f3krXUAAAAJ
#> 200 2019    64 _f3krXUAAAAJ
#> 201 2020    70 _f3krXUAAAAJ
#> 202 2021    54 _f3krXUAAAAJ
#> 203 1994    60 hPeXxvEAAAAJ
#> 204 1995    35 hPeXxvEAAAAJ
#> 205 1996    39 hPeXxvEAAAAJ
#> 206 1997    33 hPeXxvEAAAAJ
#> 207 1998    35 hPeXxvEAAAAJ
#> 208 1999    47 hPeXxvEAAAAJ
#> 209 2000    74 hPeXxvEAAAAJ
#> 210 2001   122 hPeXxvEAAAAJ
#> 211 2002   107 hPeXxvEAAAAJ
#> 212 2003   153 hPeXxvEAAAAJ
#> 213 2004   170 hPeXxvEAAAAJ
#> 214 2005   180 hPeXxvEAAAAJ
#> 215 2006   253 hPeXxvEAAAAJ
#> 216 2007   336 hPeXxvEAAAAJ
#> 217 2008   439 hPeXxvEAAAAJ
#> 218 2009   515 hPeXxvEAAAAJ
#> 219 2010   511 hPeXxvEAAAAJ
#> 220 2011   622 hPeXxvEAAAAJ
#> 221 2012   767 hPeXxvEAAAAJ
#> 222 2013   782 hPeXxvEAAAAJ
#> 223 2014   935 hPeXxvEAAAAJ
#> 224 2015  1129 hPeXxvEAAAAJ
#> 225 2016  1076 hPeXxvEAAAAJ
#> 226 2017  1182 hPeXxvEAAAAJ
#> 227 2018  1206 hPeXxvEAAAAJ
#> 228 2019  1163 hPeXxvEAAAAJ
#> 229 2020  1235 hPeXxvEAAAAJ
#> 230 2021   863 hPeXxvEAAAAJ
#> 231 2011    12 cy3Ye6sAAAAJ
#> 232 2012    21 cy3Ye6sAAAAJ
#> 233 2013    42 cy3Ye6sAAAAJ
#> 234 2014    55 cy3Ye6sAAAAJ
#> 235 2015    74 cy3Ye6sAAAAJ
#> 236 2016   141 cy3Ye6sAAAAJ
#> 237 2017   140 cy3Ye6sAAAAJ
#> 238 2018   223 cy3Ye6sAAAAJ
#> 239 2019   285 cy3Ye6sAAAAJ
#> 240 2020   346 cy3Ye6sAAAAJ
#> 241 2021   287 cy3Ye6sAAAAJ
#> 242 2008    12 Iu23-90AAAAJ
#> 243 2009    21 Iu23-90AAAAJ
#> 244 2010    26 Iu23-90AAAAJ
#> 245 2011    79 Iu23-90AAAAJ
#> 246 2012    79 Iu23-90AAAAJ
#> 247 2013   116 Iu23-90AAAAJ
#> 248 2014   151 Iu23-90AAAAJ
#> 249 2015   204 Iu23-90AAAAJ
#> 250 2016   228 Iu23-90AAAAJ
#> 251 2017   223 Iu23-90AAAAJ
#> 252 2018   267 Iu23-90AAAAJ
#> 253 2019   297 Iu23-90AAAAJ
#> 254 2020   305 Iu23-90AAAAJ
#> 255 2021   228 Iu23-90AAAAJ
#> 256 2007     7 w2McVJAAAAAJ
#> 257 2008     3 w2McVJAAAAAJ
#> 258 2009    14 w2McVJAAAAAJ
#> 259 2010    19 w2McVJAAAAAJ
#> 260 2011    19 w2McVJAAAAAJ
#> 261 2012    19 w2McVJAAAAAJ
#> 262 2013    51 w2McVJAAAAAJ
#> 263 2014    50 w2McVJAAAAAJ
#> 264 2015    76 w2McVJAAAAAJ
#> 265 2016   113 w2McVJAAAAAJ
#> 266 2017   138 w2McVJAAAAAJ
#> 267 2018   175 w2McVJAAAAAJ
#> 268 2019   229 w2McVJAAAAAJ
#> 269 2020   312 w2McVJAAAAAJ
#> 270 2021   220 w2McVJAAAAAJ
#> 271 2012     1 ItITloQAAAAJ
#> 272 2013     5 ItITloQAAAAJ
#> 273 2014    12 ItITloQAAAAJ
#> 274 2015    15 ItITloQAAAAJ
#> 275 2016    38 ItITloQAAAAJ
#> 276 2017    38 ItITloQAAAAJ
#> 277 2018    57 ItITloQAAAAJ
#> 278 2019    71 ItITloQAAAAJ
#> 279 2020    74 ItITloQAAAAJ
#> 280 2021    60 ItITloQAAAAJ
#> 281 1999    11 TqKrXnMAAAAJ
#> 282 2000    17 TqKrXnMAAAAJ
#> 283 2001    28 TqKrXnMAAAAJ
#> 284 2002    33 TqKrXnMAAAAJ
#> 285 2003    44 TqKrXnMAAAAJ
#> 286 2004    41 TqKrXnMAAAAJ
#> 287 2005    61 TqKrXnMAAAAJ
#> 288 2006    64 TqKrXnMAAAAJ
#> 289 2007    83 TqKrXnMAAAAJ
#> 290 2008   109 TqKrXnMAAAAJ
#> 291 2009   102 TqKrXnMAAAAJ
#> 292 2010   148 TqKrXnMAAAAJ
#> 293 2011   196 TqKrXnMAAAAJ
#> 294 2012   129 TqKrXnMAAAAJ
#> 295 2013   222 TqKrXnMAAAAJ
#> 296 2014   236 TqKrXnMAAAAJ
#> 297 2015   251 TqKrXnMAAAAJ
#> 298 2016   305 TqKrXnMAAAAJ
#> 299 2017   301 TqKrXnMAAAAJ
#> 300 2018   295 TqKrXnMAAAAJ
#> 301 2019   308 TqKrXnMAAAAJ
#> 302 2020   299 TqKrXnMAAAAJ
#> 303 2021   259 TqKrXnMAAAAJ
#> 304 2017     1 bDPtkIoAAAAJ
#> 305 2018     4 bDPtkIoAAAAJ
#> 306 2019     8 bDPtkIoAAAAJ
#> 307 2020    13 bDPtkIoAAAAJ
#> 308 2021    10 bDPtkIoAAAAJ
#> 309 2003    12 p3IwtT4AAAAJ
#> 310 2004    26 p3IwtT4AAAAJ
#> 311 2005    35 p3IwtT4AAAAJ
#> 312 2006    39 p3IwtT4AAAAJ
#> 313 2007    76 p3IwtT4AAAAJ
#> 314 2008    54 p3IwtT4AAAAJ
#> 315 2009    78 p3IwtT4AAAAJ
#> 316 2010    75 p3IwtT4AAAAJ
#> 317 2011    81 p3IwtT4AAAAJ
#> 318 2012    92 p3IwtT4AAAAJ
#> 319 2013    74 p3IwtT4AAAAJ
#> 320 2014    87 p3IwtT4AAAAJ
#> 321 2015    75 p3IwtT4AAAAJ
#> 322 2016    85 p3IwtT4AAAAJ
#> 323 2017    62 p3IwtT4AAAAJ
#> 324 2018    73 p3IwtT4AAAAJ
#> 325 2019    65 p3IwtT4AAAAJ
#> 326 2020    70 p3IwtT4AAAAJ
#> 327 2021    49 p3IwtT4AAAAJ
#> 328 2005    17 _ukytQYAAAAJ
#> 329 2006    19 _ukytQYAAAAJ
#> 330 2007    34 _ukytQYAAAAJ
#> 331 2008    73 _ukytQYAAAAJ
#> 332 2009    56 _ukytQYAAAAJ
#> 333 2010    82 _ukytQYAAAAJ
#> 334 2011    40 _ukytQYAAAAJ
#> 335 2012    59 _ukytQYAAAAJ
#> 336 2013    60 _ukytQYAAAAJ
#> 337 2014    87 _ukytQYAAAAJ
#> 338 2015    73 _ukytQYAAAAJ
#> 339 2016    89 _ukytQYAAAAJ
#> 340 2017   314 _ukytQYAAAAJ
#> 341 2018   750 _ukytQYAAAAJ
#> 342 2019   922 _ukytQYAAAAJ
#> 343 2020  1100 _ukytQYAAAAJ
#> 344 2021  1461 _ukytQYAAAAJ
#> 345 2017     4 VCTvbTkAAAAJ
#> 346 2018     4 VCTvbTkAAAAJ
#> 347 2019     7 VCTvbTkAAAAJ
#> 348 2020     5 VCTvbTkAAAAJ
#> 349 2021    12 VCTvbTkAAAAJ
#> 350 2019    10 tFaMPOQAAAAJ
#> 351 2020    29 tFaMPOQAAAAJ
#> 352 2021    31 tFaMPOQAAAAJ
#> 353 2016     4 z6iMs-UAAAAJ
#> 354 2017     9 z6iMs-UAAAAJ
#> 355 2018     6 z6iMs-UAAAAJ
#> 356 2019     6 z6iMs-UAAAAJ
#> 357 2020     6 z6iMs-UAAAAJ
#> 358 2021     3 z6iMs-UAAAAJ
#> 359 2010     6 lkVq32sAAAAJ
#> 360 2011     3 lkVq32sAAAAJ
#> 361 2012    12 lkVq32sAAAAJ
#> 362 2013     8 lkVq32sAAAAJ
#> 363 2014    27 lkVq32sAAAAJ
#> 364 2015    10 lkVq32sAAAAJ
#> 365 2016    15 lkVq32sAAAAJ
#> 366 2017    11 lkVq32sAAAAJ
#> 367 2018    13 lkVq32sAAAAJ
#> 368 2019    33 lkVq32sAAAAJ
#> 369 2020    39 lkVq32sAAAAJ
#> 370 2021    17 lkVq32sAAAAJ
#> 371 2013     1 iR4UIwwAAAAJ
#> 372 2014     1 iR4UIwwAAAAJ
#> 373 2015     2 iR4UIwwAAAAJ
#> 374 2016     4 iR4UIwwAAAAJ
#> 375 2017     4 iR4UIwwAAAAJ
#> 376 2018     3 iR4UIwwAAAAJ
#> 377 2019     3 iR4UIwwAAAAJ
#> 378 2020     6 iR4UIwwAAAAJ
#> 379 2021     7 iR4UIwwAAAAJ
#> 380 2019     1 gs0li6MAAAAJ
#> 381 2020     0 gs0li6MAAAAJ
#> 382 2021     2 gs0li6MAAAAJ
#> 383 2017     3 KfLALRIAAAAJ
#> 384 2018     4 KfLALRIAAAAJ
#> 385 2019    10 KfLALRIAAAAJ
#> 386 2020    11 KfLALRIAAAAJ
#> 387 2021    11 KfLALRIAAAAJ
```




<!---should you not explain somewhere that in google scholar you have to add you coauthors manually---> 
<!---why only 10? And which 10. should you not --->
<!---I think this goes wrong, you may end up looking for some coauthors multiple times---> 

Next, we get the collaborators. For loop should be clear by now. We get collaborators for a given Google Scholar ID, 50 of them, with a distance of at most 1. We then bind_rows again, and remove those staff members that did not list any collaborator.


```r
# the first 10 at most! n_deep means the co-authors of my co-authors, which can blow up fairly
# quickly, so keep that number low.
soc_collabs <- list()
for (i in 1:nrow(soc_df)) {
    
    # one deep
    soc_collabs[[i]] <- get_coauthors(soc_df[i, c("gs_id")], n_coauthors = 10, n_deep = 1)  # note again the gs_id that I use
    soc_collabs[[i]][, c("gs_id")] <- soc_df[i, c("gs_id")]
    
}

soc_df_collabs <- data.frame(bind_rows(soc_collabs))

soc_df_collabs <- soc_df_collabs[!is.na(soc_df_collabs$author), ]
```






```r
soc_df_collabs
```

```
#>                                              author                                   coauthors
#> ...2                                   Katia Begall                            Melinda C. Mills
#> ...3                                   Katia Begall                                Patrick Präg
#> ...4                                   Katia Begall                           Letizia Mencarini
#> ...5                                   Katia Begall                      Tanturri Maria Letizia
#> ...6                                   Katia Begall                          Harry Bg Ganzeboom
#> ...7                                   Katia Begall                          Anne-Rigt Poortman
#> ...8                                   Katia Begall                      Leonie Van Breeschoten
#> ...9                                   Katia Begall                         Tanja Van Der Lippe
#> ...10                                  Katia Begall                               Katya Ivanova
#> ...11                                  Katia Begall                              Laura Den Dulk
#> ...12                              Melinda C. Mills                        Hans-Peter Blossfeld
#> ...13                              Melinda C. Mills                               Nicola Barban
#> ...14                              Melinda C. Mills                                 Felix Tropf
#> ...15                              Melinda C. Mills                              Harold Snieder
#> ...16                              Melinda C. Mills                             Nicoletta Balbo
#> ...17                              Melinda C. Mills                                Katia Begall
#> ...18                              Melinda C. Mills                      Tanturri Maria Letizia
#> ...19                              Melinda C. Mills                               René Veenstra
#> ...20                              Melinda C. Mills                        Francesco C. Billari
#> ...21                                  Patrick Präg                            Melinda C. Mills
#> ...22                                  Patrick Präg                               Rafael Wittek
#> ...23                                  Patrick Präg                                Katia Begall
#> ...24                                  Patrick Präg                              Andreas Baierl
#> ...25                                  Patrick Präg                                Lea Ellwardt
#> ...26                                  Patrick Präg                           Christiaan Monden
#> ...27                                  Patrick Präg                            Lindsay Richards
#> ...28                                  Patrick Präg                            Alexi Gugushvili
#> ...29                                  Patrick Präg                              Aleksi Karhula
#> ...30                                  Patrick Präg                              Kieron Barclay
#> ...31                             Letizia Mencarini                             Arnstein Aassve
#> ...32                             Letizia Mencarini                      Tanturri Maria Letizia
#> ...33                             Letizia Mencarini                             Daniele Vignoli
#> ...34                             Letizia Mencarini                             Stefano Mazzuco
#> ...35                             Letizia Mencarini                               Ariane Pailhé
#> ...36                             Letizia Mencarini                                  Anne Solaz
#> ...37                             Letizia Mencarini                             Marco Le Moglie
#> ...38                             Letizia Mencarini                              Dominique Anxo
#> ...39                             Letizia Mencarini                                Gianni Betti
#> ...40                             Letizia Mencarini                               Giulia Fuochi
#> ...41                        Tanturri Maria Letizia                             Chiara Seghieri
#> ...42                        Tanturri Maria Letizia                             Cheti Nicoletti
#> ...43                            Harry Bg Ganzeboom                              Donald Treiman
#> ...44                            Harry Bg Ganzeboom                            Paul M. De Graaf
#> ...45                            Harry Bg Ganzeboom                                 Ruud Luijkx
#> ...46                            Harry Bg Ganzeboom                                  Wout Ultee
#> ...47                            Harry Bg Ganzeboom                                 Ineke Nagel
#> ...48                            Harry Bg Ganzeboom                             Niels Spierings
#> ...49                            Harry Bg Ganzeboom                              Bernhard Nauck
#> ...50                            Harry Bg Ganzeboom                               Lucinda Platt
#> ...51                            Harry Bg Ganzeboom                            Paul Nieuwbeerta
#> ...52                            Harry Bg Ganzeboom                            Efe Kerem Sozeri
#> ...53                        Leonie Van Breeschoten                         Tanja Van Der Lippe
#> ...54                        Leonie Van Breeschoten                            Nikki Van Gerwen
#> ...55                        Leonie Van Breeschoten                             Jelle Lössbroek
#> ...56                        Leonie Van Breeschoten                             Zoltán Lippényi
#> ...57                        Leonie Van Breeschoten                            Margriet Van Hek
#> ...58                        Leonie Van Breeschoten                             Marie Evertsson
#> ...59                        Leonie Van Breeschoten                          Anne-Rigt Poortman
#> ...60                        Leonie Van Breeschoten                                Katia Begall
#> ...61                        Leonie Van Breeschoten                                Anne Roeters
#> ...62                        Leonie Van Breeschoten                              Laura Den Dulk
#> ...63                           Tanja Van Der Lippe                                 Yvonne Kops
#> ...64                           Tanja Van Der Lippe                             Agnieszka Kanas
#> ...65                           Tanja Van Der Lippe                           Gerbert Kraaykamp
#> ...66                           Tanja Van Der Lippe                                  Jan Skopek
#> ...67                           Tanja Van Der Lippe                            Tally Katz-Gerro
#> ...69                          Lonneke Van Den Berg                              Thomas Leopold
#> ...70                          Lonneke Van Den Berg                            Matthijs Kalmijn
#> ...71                          Lonneke Van Den Berg                            Ruben Van Gaalen
#> ...72                                Thomas Leopold                                  Jan Skopek
#> ...73                                Thomas Leopold                                 Marcel Raab
#> ...74                                Thomas Leopold                            Matthijs Kalmijn
#> ...75                                Thomas Leopold                              Sebastian Pink
#> ...76                                Thomas Leopold                             Clemens Lechner
#> ...77                                Thomas Leopold                              Liliya Leopold
#> ...78                                Thomas Leopold                                   Thijs Bol
#> ...79                                Thomas Leopold                        Hans-Peter Blossfeld
#> ...80                                Thomas Leopold                              Florian Schulz
#> ...81                                Thomas Leopold                        Dragana Stojmenovska
#> ...82                              Matthijs Kalmijn                            Paul M. De Graaf
#> ...83                              Matthijs Kalmijn                                Kène Henkens
#> ...84                              Matthijs Kalmijn                          Frank Van Tubergen
#> ...85                              Matthijs Kalmijn                           Gerbert Kraaykamp
#> ...86                              Matthijs Kalmijn                           Aart C. Liefbroer
#> ...87                              Matthijs Kalmijn                                Wilfred Uunk
#> ...88                              Matthijs Kalmijn                           Christiaan Monden
#> ...89                              Matthijs Kalmijn                              Marleen Damman
#> ...90                              Matthijs Kalmijn                          Anne-Rigt Poortman
#> ...91                              Matthijs Kalmijn                               Katya Ivanova
#> ...92                          Lieselotte Blommaert                             Marcel Coenders
#> ...93                          Lieselotte Blommaert                          Frank Van Tubergen
#> ...94                          Lieselotte Blommaert                          Maarten Hj Wolbers
#> ...95                          Lieselotte Blommaert                          Maurice Gesthuizen
#> ...96                          Lieselotte Blommaert                                 Muja Ardita
#> ...97                          Lieselotte Blommaert                                Stijn Ruiter
#> ...98                          Lieselotte Blommaert                         Tanja Van Der Lippe
#> ...99                          Lieselotte Blommaert                       Marieke Van Den Brink
#> ...100                         Lieselotte Blommaert                               Roza Meuleman
#> ...101                         Lieselotte Blommaert                             Anete Butkevica
#> ...102                           Frank Van Tubergen                                  Ineke Maas
#> ...103                           Frank Van Tubergen                            Matthijs Kalmijn
#> ...104                           Frank Van Tubergen                  Herman G. Van De Werfhorst
#> ...105                           Frank Van Tubergen                             Agnieszka Kanas
#> ...106                           Frank Van Tubergen                             Marcel Coenders
#> ...107                           Frank Van Tubergen                            Borja Martinovic
#> ...108                           Frank Van Tubergen                                Stijn Ruiter
#> ...109                           Frank Van Tubergen                              Jan O. Jonsson
#> ...110                           Frank Van Tubergen                                Frank Kalter
#> ...111                           Frank Van Tubergen                         Tanja Van Der Lippe
#> ...112                           Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...113                           Maarten Hj Wolbers                            Marloes De Lange
#> ...114                           Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...115                           Maarten Hj Wolbers                                  Wout Ultee
#> ...116                           Maarten Hj Wolbers                               Jochem Tolsma
#> ...117                           Maarten Hj Wolbers                            Paul M. De Graaf
#> ...118                           Maarten Hj Wolbers                                 Mark Visser
#> ...119                           Maarten Hj Wolbers                               Jaap Dronkers
#> ...120                           Maarten Hj Wolbers                                  Emer Smyth
#> ...121                           Maarten Hj Wolbers                                 Ruud Luijkx
#> ...122                           Maurice Gesthuizen                              Peer Scheepers
#> ...123                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...124                           Maurice Gesthuizen                            Marloes De Lange
#> ...125                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...126                           Maurice Gesthuizen                                 Mark Visser
#> ...127                           Maurice Gesthuizen                           Michael Savelkoul
#> ...128                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...129                           Maurice Gesthuizen                               Jochem Tolsma
#> ...130                           Maurice Gesthuizen                                 Bram Steijn
#> ...131                           Maurice Gesthuizen                                 Ariana Need
#> ...132                                  Muja Ardita                          Maarten Hj Wolbers
#> ...133                                  Muja Ardita                          Maurice Gesthuizen
#> ...134                                  Muja Ardita                        Lieselotte Blommaert
#> ...135                                 Stijn Ruiter                                Wim Bernasco
#> ...136                                 Stijn Ruiter                           Nan Dirk De Graaf
#> ...137                                 Stijn Ruiter                               Jochem Tolsma
#> ...138                                 Stijn Ruiter                           Gerbert Kraaykamp
#> ...139                                 Stijn Ruiter                          Frank Van Tubergen
#> ...140                                 Stijn Ruiter                             Shane D Johnson
#> ...141                                 Stijn Ruiter                                Daniel Birks
#> ...142                                 Stijn Ruiter                            Michael Townsley
#> ...143                                 Stijn Ruiter                         Marieke Van De Rakt
#> ...144                                 Stijn Ruiter                            Paul Nieuwbeerta
#> ...145                          Tanja Van Der Lippe                                 Yvonne Kops
#> ...146                          Tanja Van Der Lippe                             Agnieszka Kanas
#> ...147                          Tanja Van Der Lippe                           Gerbert Kraaykamp
#> ...148                          Tanja Van Der Lippe                                  Jan Skopek
#> ...149                          Tanja Van Der Lippe                            Tally Katz-Gerro
#> ...150                        Marieke Van Den Brink                                 Benschop, Y
#> ...151                        Marieke Van Den Brink                                M Thunnissen
#> ...152                        Marieke Van Den Brink                        Charlotte Holgersson
#> ...153                        Marieke Van Den Brink                                Laura Berger
#> ...154                        Marieke Van Den Brink                               Joke Leenders
#> ...155                        Marieke Van Den Brink                      Jennifer Anne De Vries
#> ...156                        Marieke Van Den Brink                           Inge Bleijenbergh
#> ...157                        Marieke Van Den Brink                   Professor Elisabeth Kelan
#> ...158                        Marieke Van Den Brink                             Patrizia Zanoni
#> ...159                                Roza Meuleman                           Gerbert Kraaykamp
#> ...160                                Roza Meuleman                              Marcel Lubbers
#> ...161                                Roza Meuleman                              Stéfanie André
#> ...162                                Roza Meuleman                                 Mike Savage
#> ...163                                Roza Meuleman                               Hidde Bekhuis
#> ...164                                Roza Meuleman                              Ellen Verbakel
#> ...165                                Roza Meuleman                              Peer Scheepers
#> ...166                                Roza Meuleman                            Maykel Verkuyten
#> ...167                                Roza Meuleman                        Lieselotte Blommaert
#> ...168                                Roza Meuleman                        Jeanette A.j. Renema
#> ...170                                  Rob Eisinga                              Peer Scheepers
#> ...171                                  Rob Eisinga                                  Ben Pelzer
#> ...172                                  Rob Eisinga                       Manfred Te Grotenhuis
#> ...173                                  Rob Eisinga                           Christine Teelken
#> ...174                                  Rob Eisinga                         Philip Hans Franses
#> ...175                                  Rob Eisinga                          Tatjana Van Strien
#> ...176                                  Rob Eisinga                                 Ruben Konig
#> ...177                                  Rob Eisinga                               Rutger Engels
#> ...178                                  Rob Eisinga                                 Sophie Bolt
#> ...179                                  Rob Eisinga Dr. Ing. Peter O. Gerrits, Senior Anatom...
#> ...180                               Peer Scheepers                             Marcel Coenders
#> ...181                               Peer Scheepers                              Marcel Lubbers
#> ...182                               Peer Scheepers                                 Rob Eisinga
#> ...183                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...184                               Peer Scheepers                            Mérove Gijsberts
#> ...185                               Peer Scheepers                          Maurice Gesthuizen
#> ...186                               Peer Scheepers                            Tom Van Der Meer
#> ...187                               Peer Scheepers                           Michael Savelkoul
#> ...188                               Peer Scheepers                                Jaak Billiet
#> ...189                               Peer Scheepers                               Hans De Witte
#> ...190                        Manfred Te Grotenhuis                                  Ben Pelzer
#> ...191                        Manfred Te Grotenhuis                              Peer Scheepers
#> ...192                        Manfred Te Grotenhuis                                 Rob Eisinga
#> ...193                        Manfred Te Grotenhuis                           Rense Nieuwenhuis
#> ...194                        Manfred Te Grotenhuis                            Tom Van Der Meer
#> ...195                        Manfred Te Grotenhuis                           Nan Dirk De Graaf
#> ...196                        Manfred Te Grotenhuis                 Alexander W. Schmidt-Catran
#> ...197                        Manfred Te Grotenhuis                          Frank Van Tubergen
#> ...198                        Manfred Te Grotenhuis                                 Rik Linssen
#> ...199                        Manfred Te Grotenhuis                               Jochem Tolsma
#> ...200                            Christine Teelken                                 Rob Eisinga
#> ...201                            Christine Teelken                          I. Van Der Weijden
#> ...202                            Christine Teelken                                   Mike Dent
#> ...203                            Christine Teelken                                 Ewan Ferlie
#> ...204                            Christine Teelken                    Professor Rune Todnem By
#> ...205                            Christine Teelken                              Geert Driessen
#> ...206                            Christine Teelken                               Rosemary Deem
#> ...207                            Christine Teelken                                M Thunnissen
#> ...208                            Christine Teelken                              Peter Sleegers
#> ...209                            Christine Teelken                              Jeroen Huisman
#> ...210                           Tatjana Van Strien                               Rutger Engels
#> ...211                           Tatjana Van Strien                             Machteld Ouwens
#> ...212                           Tatjana Van Strien                              Ausiàs Cebolla
#> ...213                           Tatjana Van Strien                           J.m.a.m. Janssens
#> ...214                           Tatjana Van Strien                                 Rob Eisinga
#> ...215                           Tatjana Van Strien                                  Rosa Banos
#> ...216                           Tatjana Van Strien                             Hanna Konttinen
#> ...217                           Tatjana Van Strien                          Juan Ramón Barrada
#> ...218                           Tatjana Van Strien                       Marieke W. Verheijden
#> ...219                           Tatjana Van Strien                              Judith Homberg
#> ...220                                  Ruben Konig                                 Rob Eisinga
#> ...221                                  Ruben Konig                              Peer Scheepers
#> ...222                                  Ruben Konig                               Paul Ketelaar
#> ...223                                  Ruben Konig                           Gerbert Kraaykamp
#> ...224                                  Ruben Konig                           Rense Nieuwenhuis
#> ...225                                  Ruben Konig                       Manfred Te Grotenhuis
#> ...226                                  Ruben Konig                                  Ben Pelzer
#> ...227                                  Ruben Konig                            Esther Rozendaal
#> ...228                                  Ruben Konig                                 Gabi Schaap
#> ...229                                  Ruben Konig                 Alexander W. Schmidt-Catran
#> ...230                                Rutger Engels                                 Scholte Rhj
#> ...231                                Rutger Engels                               Ad A Vermulst
#> ...232                                Rutger Engels                                   Roy Otten
#> ...233                                Rutger Engels                                   Wim Meeus
#> ...234                                Rutger Engels                      Regina Van Den Eijnden
#> ...235                                Rutger Engels                            Marloes Kleinjan
#> ...236                                Rutger Engels                           Geertjan Overbeek
#> ...237                                Rutger Engels                          Tatjana Van Strien
#> ...238                                Rutger Engels                              Isabela Granic
#> ...239                                Rutger Engels                           Emmanuel Kuntsche
#> ...240  Dr. Ing. Peter O. Gerrits, Senior Anatomist                           Richard W Horobin
#> ...241  Dr. Ing. Peter O. Gerrits, Senior Anatomist                                 Sophie Bolt
#> ...242  Dr. Ing. Peter O. Gerrits, Senior Anatomist                                Van Der Want
#> ...243                           Maurice Gesthuizen                              Peer Scheepers
#> ...244                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...245                           Maurice Gesthuizen                            Marloes De Lange
#> ...246                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...247                           Maurice Gesthuizen                                 Mark Visser
#> ...248                           Maurice Gesthuizen                           Michael Savelkoul
#> ...249                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...250                           Maurice Gesthuizen                               Jochem Tolsma
#> ...251                           Maurice Gesthuizen                                 Bram Steijn
#> ...252                           Maurice Gesthuizen                                 Ariana Need
#> ...253                               Peer Scheepers                             Marcel Coenders
#> ...254                               Peer Scheepers                              Marcel Lubbers
#> ...255                               Peer Scheepers                                 Rob Eisinga
#> ...256                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...257                               Peer Scheepers                            Mérove Gijsberts
#> ...258                               Peer Scheepers                          Maurice Gesthuizen
#> ...259                               Peer Scheepers                            Tom Van Der Meer
#> ...260                               Peer Scheepers                           Michael Savelkoul
#> ...261                               Peer Scheepers                                Jaak Billiet
#> ...262                               Peer Scheepers                               Hans De Witte
#> ...263                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...264                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...265                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...266                            Gerbert Kraaykamp                                  Tim Huijts
#> ...267                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...268                            Gerbert Kraaykamp                           Christiaan Monden
#> ...269                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...270                            Gerbert Kraaykamp                                 Mark Levels
#> ...271                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...272                            Gerbert Kraaykamp                                  Wout Ultee
#> ...273                             Tom Van Der Meer                                 Paul Dekker
#> ...274                             Tom Van Der Meer                              Peer Scheepers
#> ...275                             Tom Van Der Meer                         Wouter Van Der Brug
#> ...276                             Tom Van Der Meer                               Jochem Tolsma
#> ...277                             Tom Van Der Meer                       Manfred Te Grotenhuis
#> ...278                             Tom Van Der Meer                             Erika Van Elsas
#> ...279                             Tom Van Der Meer                          Maurice Gesthuizen
#> ...280                             Tom Van Der Meer                           Sarah L. De Lange
#> ...281                             Tom Van Der Meer                          Eefje Steenvoorden
#> ...282                             Tom Van Der Meer                           Armen Hakhverdian
#> ...283                                  Mark Visser                           Gerbert Kraaykamp
#> ...284                                  Mark Visser                          Maurice Gesthuizen
#> ...285                                  Mark Visser                          Maarten Hj Wolbers
#> ...286                                  Mark Visser                              Peer Scheepers
#> ...287                                  Mark Visser                                 Eva Jaspers
#> ...288                                  Mark Visser                              Marcel Lubbers
#> ...289                                  Mark Visser                              Marijn Scholte
#> ...290                                  Mark Visser                           Anette Eva Fasang
#> ...291                                  Mark Visser                           Jasper Van Houten
#> ...292                                  Mark Visser                                  Wout Ultee
#> ...293                            Michael Savelkoul                              Peer Scheepers
#> ...294                            Michael Savelkoul                          Maurice Gesthuizen
#> ...295                            Michael Savelkoul                               Jochem Tolsma
#> ...296                            Michael Savelkoul                     William M. Van Der Veld
#> ...297                            Michael Savelkoul                             Dietlind Stolle
#> ...298                            Michael Savelkoul                              Miles Hewstone
#> ...299                                Jochem Tolsma                            Tom Van Der Meer
#> ...300                                Jochem Tolsma                          Maarten Hj Wolbers
#> ...301                                Jochem Tolsma                           Gerbert Kraaykamp
#> ...302                                Jochem Tolsma                              Peer Scheepers
#> ...303                                Jochem Tolsma                           Michael Savelkoul
#> ...304                                Jochem Tolsma                                Stijn Ruiter
#> ...305                                Jochem Tolsma                              Marcel Lubbers
#> ...306                                Jochem Tolsma                          Maurice Gesthuizen
#> ...307                                Jochem Tolsma                             Marcel Coenders
#> ...308                                Jochem Tolsma                           Nan Dirk De Graaf
#> ...309                                  Bram Steijn                              Victor Bekkers
#> ...310                                  Bram Steijn                                Lars Tummers
#> ...311                                  Bram Steijn                                J. Edelenbos
#> ...312                                  Bram Steijn                               Peter Leisink
#> ...313                                  Bram Steijn                             Erik Hans Klijn
#> ...314                                  Bram Steijn                              Ben S. Kuipers
#> ...315                                  Bram Steijn                          Kea Gartje Tijdens
#> ...316                                  Bram Steijn                                 Ariana Need
#> ...317                                  Bram Steijn                           Mirko Noordegraaf
#> ...318                                  Bram Steijn                           Sandra Groeneveld
#> ...320                             Margriet Van Hek                           Gerbert Kraaykamp
#> ...321                             Margriet Van Hek                          Maarten Hj Wolbers
#> ...322                             Margriet Van Hek                         Tanja Van Der Lippe
#> ...323                             Margriet Van Hek                                  Ben Pelzer
#> ...324                             Margriet Van Hek                            Claudia Buchmann
#> ...325                             Margriet Van Hek                      Leonie Van Breeschoten
#> ...326                             Margriet Van Hek                                 Anke Heyder
#> ...327                             Margriet Van Hek                            Mieke Van Houtte
#> ...328                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...329                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...330                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...331                            Gerbert Kraaykamp                                  Tim Huijts
#> ...332                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...333                            Gerbert Kraaykamp                           Christiaan Monden
#> ...334                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...335                            Gerbert Kraaykamp                                 Mark Levels
#> ...336                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...337                            Gerbert Kraaykamp                                  Wout Ultee
#> ...338                           Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...339                           Maarten Hj Wolbers                            Marloes De Lange
#> ...340                           Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...341                           Maarten Hj Wolbers                                  Wout Ultee
#> ...342                           Maarten Hj Wolbers                               Jochem Tolsma
#> ...343                           Maarten Hj Wolbers                            Paul M. De Graaf
#> ...344                           Maarten Hj Wolbers                                 Mark Visser
#> ...345                           Maarten Hj Wolbers                               Jaap Dronkers
#> ...346                           Maarten Hj Wolbers                                  Emer Smyth
#> ...347                           Maarten Hj Wolbers                                 Ruud Luijkx
#> ...348                          Tanja Van Der Lippe                                 Yvonne Kops
#> ...349                          Tanja Van Der Lippe                             Agnieszka Kanas
#> ...350                          Tanja Van Der Lippe                           Gerbert Kraaykamp
#> ...351                          Tanja Van Der Lippe                                  Jan Skopek
#> ...352                          Tanja Van Der Lippe                            Tally Katz-Gerro
#> ...353                             Claudia Buchmann                               Anne Mcdaniel
#> ...354                             Claudia Buchmann                                Emily Hannum
#> ...355                             Claudia Buchmann                               Hyunjoon Park
#> ...356                             Claudia Buchmann                           Dennis J. Condron
#> ...357                             Claudia Buchmann                         Vincent J. Roscigno
#> ...358                             Claudia Buchmann                                  Ben Dalton
#> ...359                             Claudia Buchmann                           Emilio A. Parrado
#> ...360                             Claudia Buchmann                           Elizabeth Stearns
#> ...361                             Claudia Buchmann                           Gerbert Kraaykamp
#> ...362                             Claudia Buchmann                            Margriet Van Hek
#> ...363                       Leonie Van Breeschoten                         Tanja Van Der Lippe
#> ...364                       Leonie Van Breeschoten                            Nikki Van Gerwen
#> ...365                       Leonie Van Breeschoten                             Jelle Lössbroek
#> ...366                       Leonie Van Breeschoten                             Zoltán Lippényi
#> ...367                       Leonie Van Breeschoten                            Margriet Van Hek
#> ...368                       Leonie Van Breeschoten                             Marie Evertsson
#> ...369                       Leonie Van Breeschoten                          Anne-Rigt Poortman
#> ...370                       Leonie Van Breeschoten                                Katia Begall
#> ...371                       Leonie Van Breeschoten                                Anne Roeters
#> ...372                       Leonie Van Breeschoten                              Laura Den Dulk
#> ...373                                  Anke Heyder                           Sebastian Bergold
#> ...374                                  Anke Heyder                              Tobias Richter
#> ...375                                  Anke Heyder                       Olga Kunina-Habenicht
#> ...376                                  Anke Heyder                            Elmar Souvignier
#> ...377                                  Anke Heyder                             Linda Wirthwein
#> ...378                                  Anke Heyder                                Silke Hertel
#> ...379                                  Anke Heyder                              Andrei Cimpian
#> ...380                                  Anke Heyder                           Jörn R. Sparfeldt
#> ...381                                  Anke Heyder                              Martin Brunner
#> ...382                                  Anke Heyder                                Anna Südkamp
#> ...383                             Mieke Van Houtte                             Jannick Demanet
#> ...384                             Mieke Van Houtte                           Dimitri Van Maele
#> ...385                             Mieke Van Houtte                         Stevens Peter A. J.
#> ...386                             Mieke Van Houtte                                 Simon Boone
#> ...387                             Mieke Van Houtte                              Lore Van Praag
#> ...388                             Mieke Van Houtte                                  Jo Tondeur
#> ...389                             Mieke Van Houtte                                  Ann Buysse
#> ...390                             Mieke Van Houtte                               Martin Valcke
#> ...391                             Mieke Van Houtte                                  Pb Forsyth
#> ...392                             Mieke Van Houtte                                 Paul Enzlin
#> ...394                                  Bas Hofstra                                Rense Corten
#> ...395                                  Bas Hofstra                          Frank Van Tubergen
#> ...396                                  Bas Hofstra                            Daniel Mcfarland
#> ...397                                  Bas Hofstra                Sebastian Munoz-Najar Galvez
#> ...398                                  Bas Hofstra                                    Bryan He
#> ...399                                  Bas Hofstra                                Dan Jurafsky
#> ...400                                  Bas Hofstra                              Vivek Kulkarni
#> ...401                                  Bas Hofstra                           Nicole B. Ellison
#> ...402                                  Bas Hofstra                         Niek C. De Schipper
#> ...403                                  Bas Hofstra                             Vincent Buskens
#> ...404                                 Rense Corten                             Vincent Buskens
#> ...405                                 Rense Corten                             Amber Ronteltap
#> ...406                                 Rense Corten                          Maarten Ter Huurne
#> ...407                                 Rense Corten                                 Bas Hofstra
#> ...408                                 Rense Corten                              Lukas Norbutas
#> ...409                                 Rense Corten                          Frank Van Tubergen
#> ...410                                 Rense Corten                           Michal Bojanowski
#> ...411                                 Rense Corten                                  Karen Cook
#> ...412                                 Rense Corten                               Jaap Dronkers
#> ...413                                 Rense Corten                           Wojtek Przepiorka
#> ...414                           Frank Van Tubergen                                  Ineke Maas
#> ...415                           Frank Van Tubergen                            Matthijs Kalmijn
#> ...416                           Frank Van Tubergen                  Herman G. Van De Werfhorst
#> ...417                           Frank Van Tubergen                             Agnieszka Kanas
#> ...418                           Frank Van Tubergen                             Marcel Coenders
#> ...419                           Frank Van Tubergen                            Borja Martinovic
#> ...420                           Frank Van Tubergen                                Stijn Ruiter
#> ...421                           Frank Van Tubergen                              Jan O. Jonsson
#> ...422                           Frank Van Tubergen                                Frank Kalter
#> ...423                           Frank Van Tubergen                         Tanja Van Der Lippe
#> ...424                             Daniel Mcfarland                                Dan Jurafsky
#> ...425                             Daniel Mcfarland                             Reuben J Thomas
#> ...426                             Daniel Mcfarland                       Christopher D Manning
#> ...427                             Daniel Mcfarland                                 James Moody
#> ...428                             Daniel Mcfarland                             Linus Dahlander
#> ...429                             Daniel Mcfarland                               Daniel Ramage
#> ...430                             Daniel Mcfarland                                 David Diehl
#> ...431                             Daniel Mcfarland                               Jure Leskovec
#> ...432                             Daniel Mcfarland                           Craig M. Rawlings
#> ...433                             Daniel Mcfarland                                 Xiaolin Shi
#> ...434                 Sebastian Munoz-Najar Galvez                            Daniel Mcfarland
#> ...435                 Sebastian Munoz-Najar Galvez                                 Bas Hofstra
#> ...436                 Sebastian Munoz-Najar Galvez                        Raphael H. Heiberger
#> ...437                                 Dan Jurafsky                       Christopher D Manning
#> ...438                                 Dan Jurafsky                             James H. Martin
#> ...439                                 Dan Jurafsky                                    Jiwei Li
#> ...440                                 Dan Jurafsky                                   Andrew Ng
#> ...441                                 Dan Jurafsky                               Jure Leskovec
#> ...442                                 Dan Jurafsky                          Nathanael Chambers
#> ...443                                 Dan Jurafsky                                   Rion Snow
#> ...444                                 Dan Jurafsky                              Kadri Hacioglu
#> ...445                                 Dan Jurafsky                               Daniel Gildea
#> ...446                                 Dan Jurafsky                            Michelle Gregory
#> ...447                               Vivek Kulkarni                               Steven Skiena
#> ...448                               Vivek Kulkarni                               Bryan Perozzi
#> ...449                               Vivek Kulkarni                           William Yang Wang
#> ...450                               Vivek Kulkarni                                Rami Al-Rfou
#> ...451                               Vivek Kulkarni                          H. Andrew Schwartz
#> ...452                               Vivek Kulkarni                                Haochen Chen
#> ...453                               Vivek Kulkarni                            Daniel Mcfarland
#> ...454                               Vivek Kulkarni                Sebastian Munoz-Najar Galvez
#> ...455                               Vivek Kulkarni                                 Bas Hofstra
#> ...456                               Vivek Kulkarni                                Dan Jurafsky
#> ...457                            Nicole B. Ellison                                 Cliff Lampe
#> ...458                            Nicole B. Ellison                          Charles Steinfield
#> ...459                            Nicole B. Ellison                                  Danah Boyd
#> ...460                            Nicole B. Ellison                               Jessica Vitak
#> ...461                            Nicole B. Ellison                           Rebecca Gray, Phd
#> ...462                            Nicole B. Ellison                         Donghee Yvette Wohn
#> ...463                            Nicole B. Ellison                              Jennifer Gibbs
#> ...464                            Nicole B. Ellison                               Rebecca Heino
#> ...465                            Nicole B. Ellison                          Jeffrey T. Hancock
#> ...466                            Nicole B. Ellison                                 Mary Madden
#> ...467                          Niek C. De Schipper                                 Bas Hofstra
#> ...468                              Vincent Buskens                                 Werner Raub
#> ...469                              Vincent Buskens                                Rense Corten
#> ...470                              Vincent Buskens                          Arnout Van De Rijt
#> ...471                              Vincent Buskens                               Jeroen Weesie
#> ...472                              Vincent Buskens                              Chris Snijders
#> ...473                              Vincent Buskens                                Vincenz Frey
#> ...474                              Vincent Buskens                              Davide Barrera
#> ...475                              Vincent Buskens                          Maarten Ter Huurne
#> ...476                              Vincent Buskens                             Amber Ronteltap
#> ...477                              Vincent Buskens                        Nynke Van Miltenburg
#> ...478                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...479                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...480                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...481                            Gerbert Kraaykamp                                  Tim Huijts
#> ...482                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...483                            Gerbert Kraaykamp                           Christiaan Monden
#> ...484                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...485                            Gerbert Kraaykamp                                 Mark Levels
#> ...486                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...487                            Gerbert Kraaykamp                                  Wout Ultee
#> ...488                            Nan Dirk De Graaf                           Gerbert Kraaykamp
#> ...489                            Nan Dirk De Graaf                            Paul M. De Graaf
#> ...490                            Nan Dirk De Graaf                            Paul Nieuwbeerta
#> ...491                            Nan Dirk De Graaf                                 Ariana Need
#> ...492                            Nan Dirk De Graaf                                Stijn Ruiter
#> ...493                            Nan Dirk De Graaf                              Geoffrey Evans
#> ...494                            Nan Dirk De Graaf                             Anthony F Heath
#> ...495                            Nan Dirk De Graaf                       Manfred Te Grotenhuis
#> ...496                            Nan Dirk De Graaf                                Giedo Jansen
#> ...497                            Nan Dirk De Graaf                  Herman G. Van De Werfhorst
#> ...498                             Paul M. De Graaf                            Matthijs Kalmijn
#> ...499                             Paul M. De Graaf                          Harry Bg Ganzeboom
#> ...500                             Paul M. De Graaf                           Nan Dirk De Graaf
#> ...501                             Paul M. De Graaf                           Gerbert Kraaykamp
#> ...502                             Paul M. De Graaf                                 Ruud Luijkx
#> ...503                             Paul M. De Graaf                                  Wout Ultee
#> ...504                             Paul M. De Graaf                                 Inge Sieben
#> ...505                             Paul M. De Graaf                              Ellen Verbakel
#> ...506                             Paul M. De Graaf                          Maarten Hj Wolbers
#> ...507                             Paul M. De Graaf                              Donald Treiman
#> ...508                             Matthijs Kalmijn                            Paul M. De Graaf
#> ...509                             Matthijs Kalmijn                                Kène Henkens
#> ...510                             Matthijs Kalmijn                          Frank Van Tubergen
#> ...511                             Matthijs Kalmijn                           Gerbert Kraaykamp
#> ...512                             Matthijs Kalmijn                           Aart C. Liefbroer
#> ...513                             Matthijs Kalmijn                                Wilfred Uunk
#> ...514                             Matthijs Kalmijn                           Christiaan Monden
#> ...515                             Matthijs Kalmijn                              Marleen Damman
#> ...516                             Matthijs Kalmijn                          Anne-Rigt Poortman
#> ...517                             Matthijs Kalmijn                               Katya Ivanova
#> ...518                           Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...519                           Maarten Hj Wolbers                            Marloes De Lange
#> ...520                           Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...521                           Maarten Hj Wolbers                                  Wout Ultee
#> ...522                           Maarten Hj Wolbers                               Jochem Tolsma
#> ...523                           Maarten Hj Wolbers                            Paul M. De Graaf
#> ...524                           Maarten Hj Wolbers                                 Mark Visser
#> ...525                           Maarten Hj Wolbers                               Jaap Dronkers
#> ...526                           Maarten Hj Wolbers                                  Emer Smyth
#> ...527                           Maarten Hj Wolbers                                 Ruud Luijkx
#> ...528                           Maurice Gesthuizen                              Peer Scheepers
#> ...529                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...530                           Maurice Gesthuizen                            Marloes De Lange
#> ...531                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...532                           Maurice Gesthuizen                                 Mark Visser
#> ...533                           Maurice Gesthuizen                           Michael Savelkoul
#> ...534                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...535                           Maurice Gesthuizen                               Jochem Tolsma
#> ...536                           Maurice Gesthuizen                                 Bram Steijn
#> ...537                           Maurice Gesthuizen                                 Ariana Need
#> ...538                                Jochem Tolsma                            Tom Van Der Meer
#> ...539                                Jochem Tolsma                          Maarten Hj Wolbers
#> ...540                                Jochem Tolsma                           Gerbert Kraaykamp
#> ...541                                Jochem Tolsma                              Peer Scheepers
#> ...542                                Jochem Tolsma                           Michael Savelkoul
#> ...543                                Jochem Tolsma                                Stijn Ruiter
#> ...544                                Jochem Tolsma                              Marcel Lubbers
#> ...545                                Jochem Tolsma                          Maurice Gesthuizen
#> ...546                                Jochem Tolsma                             Marcel Coenders
#> ...547                                Jochem Tolsma                           Nan Dirk De Graaf
#> ...548                                Roza Meuleman                           Gerbert Kraaykamp
#> ...549                                Roza Meuleman                              Marcel Lubbers
#> ...550                                Roza Meuleman                              Stéfanie André
#> ...551                                Roza Meuleman                                 Mike Savage
#> ...552                                Roza Meuleman                               Hidde Bekhuis
#> ...553                                Roza Meuleman                              Ellen Verbakel
#> ...554                                Roza Meuleman                              Peer Scheepers
#> ...555                                Roza Meuleman                            Maykel Verkuyten
#> ...556                                Roza Meuleman                        Lieselotte Blommaert
#> ...557                                Roza Meuleman                        Jeanette A.j. Renema
#> ...558                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...559                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...560                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...561                            Gerbert Kraaykamp                                  Tim Huijts
#> ...562                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...563                            Gerbert Kraaykamp                           Christiaan Monden
#> ...564                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...565                            Gerbert Kraaykamp                                 Mark Levels
#> ...566                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...567                            Gerbert Kraaykamp                                  Wout Ultee
#> ...568                               Marcel Lubbers                              Peer Scheepers
#> ...569                               Marcel Lubbers                             Marcel Coenders
#> ...570                               Marcel Lubbers                            Mérove Gijsberts
#> ...571                               Marcel Lubbers                                 Eva Jaspers
#> ...572                               Marcel Lubbers                               Roza Meuleman
#> ...573                               Marcel Lubbers                               Jochem Tolsma
#> ...574                               Marcel Lubbers                                 Rob Eisinga
#> ...575                               Marcel Lubbers                            Maykel Verkuyten
#> ...576                               Marcel Lubbers                           Nan Dirk De Graaf
#> ...577                               Marcel Lubbers                               Hidde Bekhuis
#> ...578                               Stéfanie André                               Jaap Dronkers
#> ...579                               Stéfanie André                            Caroline Dewilde
#> ...580                               Stéfanie André                           Gerbert Kraaykamp
#> ...581                               Stéfanie André                               Roza Meuleman
#> ...582                               Stéfanie André                              Peter M Kruyen
#> ...583                               Stéfanie André                              Mara A. Yerkes
#> ...584                               Stéfanie André                             Janna Besamusca
#> ...585                               Stéfanie André                         Fenella Fleischmann
#> ...586                               Stéfanie André                                 Ruud Luijkx
#> ...587                               Stéfanie André                             E.p.w.a. Jansen
#> ...588                                  Mike Savage                                  Alan Warde
#> ...589                                  Mike Savage                             Brian Longhurst
#> ...590                                  Mike Savage                                Andrew Miles
#> ...591                                  Mike Savage                               Susan Halford
#> ...592                                  Mike Savage                              Gaynor Bagnall
#> ...593                                  Mike Savage                                Fiona Devine
#> ...594                                  Mike Savage                                   Yaojun Li
#> ...595                                  Mike Savage                                David Wright
#> ...596                                  Mike Savage                           Johs. Hjellbrekke
#> ...597                                  Mike Savage                                Sam Friedman
#> ...598                               Ellen Verbakel                            Paul M. De Graaf
#> ...599                               Ellen Verbakel                           Gerbert Kraaykamp
#> ...600                               Ellen Verbakel                                 Inge Sieben
#> ...601                               Ellen Verbakel                            Matthijs Kalmijn
#> ...602                               Ellen Verbakel                                 Eva Jaspers
#> ...603                               Ellen Verbakel                          Maurice Gesthuizen
#> ...604                               Ellen Verbakel                                 Ruud Luijkx
#> ...605                               Ellen Verbakel                              Marcel Lubbers
#> ...606                               Ellen Verbakel                              Peer Scheepers
#> ...607                               Peer Scheepers                             Marcel Coenders
#> ...608                               Peer Scheepers                              Marcel Lubbers
#> ...609                               Peer Scheepers                                 Rob Eisinga
#> ...610                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...611                               Peer Scheepers                            Mérove Gijsberts
#> ...612                               Peer Scheepers                          Maurice Gesthuizen
#> ...613                               Peer Scheepers                            Tom Van Der Meer
#> ...614                               Peer Scheepers                           Michael Savelkoul
#> ...615                               Peer Scheepers                                Jaak Billiet
#> ...616                               Peer Scheepers                               Hans De Witte
#> ...617                             Maykel Verkuyten                             Jellie Sierksma
#> ...618                         Lieselotte Blommaert                             Marcel Coenders
#> ...619                         Lieselotte Blommaert                          Frank Van Tubergen
#> ...620                         Lieselotte Blommaert                          Maarten Hj Wolbers
#> ...621                         Lieselotte Blommaert                          Maurice Gesthuizen
#> ...622                         Lieselotte Blommaert                                 Muja Ardita
#> ...623                         Lieselotte Blommaert                                Stijn Ruiter
#> ...624                         Lieselotte Blommaert                         Tanja Van Der Lippe
#> ...625                         Lieselotte Blommaert                       Marieke Van Den Brink
#> ...626                         Lieselotte Blommaert                               Roza Meuleman
#> ...627                         Lieselotte Blommaert                             Anete Butkevica
#> ...628                         Jeanette A.j. Renema                              Marcel Lubbers
#> ...629                         Jeanette A.j. Renema                               Verena Seibel
#> ...630                         Jeanette A.j. Renema                               Hidde Bekhuis
#> ...631                         Jeanette A.j. Renema                       Troels Fage Hedegaard
#> ...632                         Jeanette A.j. Renema                               Roza Meuleman
#> ...633                         Jeanette A.j. Renema                                   Nan Jiang
#> ...634                            Michael Savelkoul                              Peer Scheepers
#> ...635                            Michael Savelkoul                          Maurice Gesthuizen
#> ...636                            Michael Savelkoul                               Jochem Tolsma
#> ...637                            Michael Savelkoul                     William M. Van Der Veld
#> ...638                            Michael Savelkoul                             Dietlind Stolle
#> ...639                            Michael Savelkoul                              Miles Hewstone
#> ...640                               Peer Scheepers                             Marcel Coenders
#> ...641                               Peer Scheepers                              Marcel Lubbers
#> ...642                               Peer Scheepers                                 Rob Eisinga
#> ...643                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...644                               Peer Scheepers                            Mérove Gijsberts
#> ...645                               Peer Scheepers                          Maurice Gesthuizen
#> ...646                               Peer Scheepers                            Tom Van Der Meer
#> ...647                               Peer Scheepers                           Michael Savelkoul
#> ...648                               Peer Scheepers                                Jaak Billiet
#> ...649                               Peer Scheepers                               Hans De Witte
#> ...650                           Maurice Gesthuizen                              Peer Scheepers
#> ...651                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...652                           Maurice Gesthuizen                            Marloes De Lange
#> ...653                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...654                           Maurice Gesthuizen                                 Mark Visser
#> ...655                           Maurice Gesthuizen                           Michael Savelkoul
#> ...656                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...657                           Maurice Gesthuizen                               Jochem Tolsma
#> ...658                           Maurice Gesthuizen                                 Bram Steijn
#> ...659                           Maurice Gesthuizen                                 Ariana Need
#> ...660                                Jochem Tolsma                            Tom Van Der Meer
#> ...661                                Jochem Tolsma                          Maarten Hj Wolbers
#> ...662                                Jochem Tolsma                           Gerbert Kraaykamp
#> ...663                                Jochem Tolsma                              Peer Scheepers
#> ...664                                Jochem Tolsma                           Michael Savelkoul
#> ...665                                Jochem Tolsma                                Stijn Ruiter
#> ...666                                Jochem Tolsma                              Marcel Lubbers
#> ...667                                Jochem Tolsma                          Maurice Gesthuizen
#> ...668                                Jochem Tolsma                             Marcel Coenders
#> ...669                                Jochem Tolsma                           Nan Dirk De Graaf
#> ...670                               Miles Hewstone                                   Ed Cairns
#> ...671                               Miles Hewstone                                Alberto Voci
#> ...672                               Miles Hewstone                            Richard J. Crisp
#> ...673                               Miles Hewstone                             Jared Kenworthy
#> ...674                               Miles Hewstone                          Rhiannon N. Turner
#> ...675                               Miles Hewstone                                  Mark Rubin
#> ...676                               Miles Hewstone                               Hermann Swart
#> ...677                               Miles Hewstone                               Oliver Christ
#> ...678                               Miles Hewstone                             Steven Vertovec
#> ...679                               Miles Hewstone                                Jake Harwood
#> ...680                               Peer Scheepers                             Marcel Coenders
#> ...681                               Peer Scheepers                              Marcel Lubbers
#> ...682                               Peer Scheepers                                 Rob Eisinga
#> ...683                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...684                               Peer Scheepers                            Mérove Gijsberts
#> ...685                               Peer Scheepers                          Maurice Gesthuizen
#> ...686                               Peer Scheepers                            Tom Van Der Meer
#> ...687                               Peer Scheepers                           Michael Savelkoul
#> ...688                               Peer Scheepers                                Jaak Billiet
#> ...689                               Peer Scheepers                               Hans De Witte
#> ...690                               Marcel Lubbers                              Peer Scheepers
#> ...691                               Marcel Lubbers                             Marcel Coenders
#> ...692                               Marcel Lubbers                            Mérove Gijsberts
#> ...693                               Marcel Lubbers                                 Eva Jaspers
#> ...694                               Marcel Lubbers                               Roza Meuleman
#> ...695                               Marcel Lubbers                               Jochem Tolsma
#> ...696                               Marcel Lubbers                                 Rob Eisinga
#> ...697                               Marcel Lubbers                            Maykel Verkuyten
#> ...698                               Marcel Lubbers                           Nan Dirk De Graaf
#> ...699                               Marcel Lubbers                               Hidde Bekhuis
#> ...700                                  Rob Eisinga                              Peer Scheepers
#> ...701                                  Rob Eisinga                                  Ben Pelzer
#> ...702                                  Rob Eisinga                       Manfred Te Grotenhuis
#> ...703                                  Rob Eisinga                           Christine Teelken
#> ...704                                  Rob Eisinga                         Philip Hans Franses
#> ...705                                  Rob Eisinga                          Tatjana Van Strien
#> ...706                                  Rob Eisinga                                 Ruben Konig
#> ...707                                  Rob Eisinga                               Rutger Engels
#> ...708                                  Rob Eisinga                                 Sophie Bolt
#> ...709                                  Rob Eisinga Dr. Ing. Peter O. Gerrits, Senior Anatom...
#> ...710                        Manfred Te Grotenhuis                                  Ben Pelzer
#> ...711                        Manfred Te Grotenhuis                              Peer Scheepers
#> ...712                        Manfred Te Grotenhuis                                 Rob Eisinga
#> ...713                        Manfred Te Grotenhuis                           Rense Nieuwenhuis
#> ...714                        Manfred Te Grotenhuis                            Tom Van Der Meer
#> ...715                        Manfred Te Grotenhuis                           Nan Dirk De Graaf
#> ...716                        Manfred Te Grotenhuis                 Alexander W. Schmidt-Catran
#> ...717                        Manfred Te Grotenhuis                          Frank Van Tubergen
#> ...718                        Manfred Te Grotenhuis                                 Rik Linssen
#> ...719                        Manfred Te Grotenhuis                               Jochem Tolsma
#> ...720                           Maurice Gesthuizen                              Peer Scheepers
#> ...721                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...722                           Maurice Gesthuizen                            Marloes De Lange
#> ...723                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...724                           Maurice Gesthuizen                                 Mark Visser
#> ...725                           Maurice Gesthuizen                           Michael Savelkoul
#> ...726                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...727                           Maurice Gesthuizen                               Jochem Tolsma
#> ...728                           Maurice Gesthuizen                                 Bram Steijn
#> ...729                           Maurice Gesthuizen                                 Ariana Need
#> ...730                             Tom Van Der Meer                                 Paul Dekker
#> ...731                             Tom Van Der Meer                              Peer Scheepers
#> ...732                             Tom Van Der Meer                         Wouter Van Der Brug
#> ...733                             Tom Van Der Meer                               Jochem Tolsma
#> ...734                             Tom Van Der Meer                       Manfred Te Grotenhuis
#> ...735                             Tom Van Der Meer                             Erika Van Elsas
#> ...736                             Tom Van Der Meer                          Maurice Gesthuizen
#> ...737                             Tom Van Der Meer                           Sarah L. De Lange
#> ...738                             Tom Van Der Meer                          Eefje Steenvoorden
#> ...739                             Tom Van Der Meer                           Armen Hakhverdian
#> ...740                            Michael Savelkoul                              Peer Scheepers
#> ...741                            Michael Savelkoul                          Maurice Gesthuizen
#> ...742                            Michael Savelkoul                               Jochem Tolsma
#> ...743                            Michael Savelkoul                     William M. Van Der Veld
#> ...744                            Michael Savelkoul                             Dietlind Stolle
#> ...745                            Michael Savelkoul                              Miles Hewstone
#> ...746                                 Jaak Billiet                               Bart Meuleman
#> ...747                                 Jaak Billiet                             Marc Swyngedouw
#> ...748                                 Jaak Billiet                               Eldad Davidov
#> ...749                                 Jaak Billiet                               Hans De Witte
#> ...750                                 Jaak Billiet                               Peter Schmidt
#> ...751                                 Jaak Billiet                                 Ineke Stoop
#> ...752                                 Jaak Billiet                              Peer Scheepers
#> ...753                                 Jaak Billiet                                Jan Cieciuch
#> ...754                                 Jaak Billiet                                 Rob Eisinga
#> ...755                                 Jaak Billiet                              Marcel Lubbers
#> ...756                                Hans De Witte                              Nele De Cuyper
#> ...757                                Hans De Witte                         Anja Van Den Broeck
#> ...758                                Hans De Witte                               Elfi Baillien
#> ...759                                Hans De Witte                               Guy Notelaers
#> ...760                                Hans De Witte                       Maarten Vansteenkiste
#> ...761                                Hans De Witte                               Magnus Sverke
#> ...762                                Hans De Witte                            Wilmar Schaufeli
#> ...763                                Hans De Witte                           Katharina Näswall
#> ...764                                Hans De Witte                               Bert Schreurs
#> ...765                                Hans De Witte                                Jaak Billiet
#> ...766                              Niels Spierings                              Kristof Jacobs
#> ...767                              Niels Spierings                          Harry Bg Ganzeboom
#> ...768                              Niels Spierings                              Bernhard Nauck
#> ...769                              Niels Spierings                               Lucinda Platt
#> ...770                              Niels Spierings                              Sait Bayrakdar
#> ...771                              Niels Spierings                            Efe Kerem Sozeri
#> ...772                              Niels Spierings                                Mieke Verloo
#> ...773                              Niels Spierings                                Jeroen Smits
#> ...774                              Niels Spierings                              Marcel Lubbers
#> ...775                              Niels Spierings                           Sarah L. De Lange
#> ...776                               Kristof Jacobs                             Niels Spierings
#> ...777                               Kristof Jacobs                                 Simon Otjes
#> ...778                           Harry Bg Ganzeboom                              Donald Treiman
#> ...779                           Harry Bg Ganzeboom                            Paul M. De Graaf
#> ...780                           Harry Bg Ganzeboom                                 Ruud Luijkx
#> ...781                           Harry Bg Ganzeboom                                  Wout Ultee
#> ...782                           Harry Bg Ganzeboom                                 Ineke Nagel
#> ...783                           Harry Bg Ganzeboom                             Niels Spierings
#> ...784                           Harry Bg Ganzeboom                              Bernhard Nauck
#> ...785                           Harry Bg Ganzeboom                               Lucinda Platt
#> ...786                           Harry Bg Ganzeboom                            Paul Nieuwbeerta
#> ...787                           Harry Bg Ganzeboom                            Efe Kerem Sozeri
#> ...788                               Bernhard Nauck                              Anja Steinbach
#> ...789                               Bernhard Nauck                          Gisela Trommsdorff
#> ...790                               Bernhard Nauck                               Josef Brüderl
#> ...791                               Bernhard Nauck                            Johannes Huinink
#> ...792                               Bernhard Nauck                          Harry Bg Ganzeboom
#> ...793                               Bernhard Nauck                             Niels Spierings
#> ...794                               Bernhard Nauck                               Lucinda Platt
#> ...795                               Bernhard Nauck                            Efe Kerem Sozeri
#> ...796                               Bernhard Nauck                              Sait Bayrakdar
#> ...797                               Bernhard Nauck                               Sabine Walper
#> ...798                               Sait Bayrakdar                            Efe Kerem Sozeri
#> ...799                               Sait Bayrakdar                             Niels Spierings
#> ...800                               Sait Bayrakdar                          Harry Bg Ganzeboom
#> ...801                               Sait Bayrakdar                              Bernhard Nauck
#> ...802                               Sait Bayrakdar                               Lucinda Platt
#> ...803                               Sait Bayrakdar                                Rory Coulter
#> ...804                               Sait Bayrakdar                           Philipp M. Lersch
#> ...805                               Sait Bayrakdar                                 Sergi Vidal
#> ...806                               Sait Bayrakdar                              Ann Berrington
#> ...807                                 Jeroen Smits                           Christiaan Monden
#> ...808                                 Jeroen Smits                          Ayse Gunduz Hosgor
#> ...809                                 Jeroen Smits                               Hyunjoon Park
#> ...810                                 Jeroen Smits                                Mieke Verloo
#> ...811                                 Jeroen Smits                             Niels Spierings
#> ...812                                 Jeroen Smits                           Pieter Hooimeijer
#> ...813                               Marcel Lubbers                              Peer Scheepers
#> ...814                               Marcel Lubbers                             Marcel Coenders
#> ...815                               Marcel Lubbers                            Mérove Gijsberts
#> ...816                               Marcel Lubbers                                 Eva Jaspers
#> ...817                               Marcel Lubbers                               Roza Meuleman
#> ...818                               Marcel Lubbers                               Jochem Tolsma
#> ...819                               Marcel Lubbers                                 Rob Eisinga
#> ...820                               Marcel Lubbers                            Maykel Verkuyten
#> ...821                               Marcel Lubbers                           Nan Dirk De Graaf
#> ...822                               Marcel Lubbers                               Hidde Bekhuis
#> ...823                            Sarah L. De Lange                         Wouter Van Der Brug
#> ...824                            Sarah L. De Lange                           Matthijs Rooduijn
#> ...825                            Sarah L. De Lange                            Tjitske Akkerman
#> ...826                            Sarah L. De Lange                            Tom Van Der Meer
#> ...827                            Sarah L. De Lange                              Huib Pellikaan
#> ...828                            Sarah L. De Lange                            Meindert Fennema
#> ...829                            Sarah L. De Lange                  Liza Mügge (Née Liza Nell)
#> ...830                            Sarah L. De Lange                              Caterina Froio
#> ...831                            Sarah L. De Lange                             Eelco Harteveld
#> ...832                            Sarah L. De Lange                                   Cas Mudde
#> ...833                                Jochem Tolsma                            Tom Van Der Meer
#> ...834                                Jochem Tolsma                          Maarten Hj Wolbers
#> ...835                                Jochem Tolsma                           Gerbert Kraaykamp
#> ...836                                Jochem Tolsma                              Peer Scheepers
#> ...837                                Jochem Tolsma                           Michael Savelkoul
#> ...838                                Jochem Tolsma                                Stijn Ruiter
#> ...839                                Jochem Tolsma                              Marcel Lubbers
#> ...840                                Jochem Tolsma                          Maurice Gesthuizen
#> ...841                                Jochem Tolsma                             Marcel Coenders
#> ...842                                Jochem Tolsma                           Nan Dirk De Graaf
#> ...843                             Tom Van Der Meer                                 Paul Dekker
#> ...844                             Tom Van Der Meer                              Peer Scheepers
#> ...845                             Tom Van Der Meer                         Wouter Van Der Brug
#> ...846                             Tom Van Der Meer                               Jochem Tolsma
#> ...847                             Tom Van Der Meer                       Manfred Te Grotenhuis
#> ...848                             Tom Van Der Meer                             Erika Van Elsas
#> ...849                             Tom Van Der Meer                          Maurice Gesthuizen
#> ...850                             Tom Van Der Meer                           Sarah L. De Lange
#> ...851                             Tom Van Der Meer                          Eefje Steenvoorden
#> ...852                             Tom Van Der Meer                           Armen Hakhverdian
#> ...853                           Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...854                           Maarten Hj Wolbers                            Marloes De Lange
#> ...855                           Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...856                           Maarten Hj Wolbers                                  Wout Ultee
#> ...857                           Maarten Hj Wolbers                               Jochem Tolsma
#> ...858                           Maarten Hj Wolbers                            Paul M. De Graaf
#> ...859                           Maarten Hj Wolbers                                 Mark Visser
#> ...860                           Maarten Hj Wolbers                               Jaap Dronkers
#> ...861                           Maarten Hj Wolbers                                  Emer Smyth
#> ...862                           Maarten Hj Wolbers                                 Ruud Luijkx
#> ...863                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...864                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...865                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...866                            Gerbert Kraaykamp                                  Tim Huijts
#> ...867                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...868                            Gerbert Kraaykamp                           Christiaan Monden
#> ...869                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...870                            Gerbert Kraaykamp                                 Mark Levels
#> ...871                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...872                            Gerbert Kraaykamp                                  Wout Ultee
#> ...873                               Peer Scheepers                             Marcel Coenders
#> ...874                               Peer Scheepers                              Marcel Lubbers
#> ...875                               Peer Scheepers                                 Rob Eisinga
#> ...876                               Peer Scheepers                       Manfred Te Grotenhuis
#> ...877                               Peer Scheepers                            Mérove Gijsberts
#> ...878                               Peer Scheepers                          Maurice Gesthuizen
#> ...879                               Peer Scheepers                            Tom Van Der Meer
#> ...880                               Peer Scheepers                           Michael Savelkoul
#> ...881                               Peer Scheepers                                Jaak Billiet
#> ...882                               Peer Scheepers                               Hans De Witte
#> ...883                            Michael Savelkoul                              Peer Scheepers
#> ...884                            Michael Savelkoul                          Maurice Gesthuizen
#> ...885                            Michael Savelkoul                               Jochem Tolsma
#> ...886                            Michael Savelkoul                     William M. Van Der Veld
#> ...887                            Michael Savelkoul                             Dietlind Stolle
#> ...888                            Michael Savelkoul                              Miles Hewstone
#> ...889                                 Stijn Ruiter                                Wim Bernasco
#> ...890                                 Stijn Ruiter                           Nan Dirk De Graaf
#> ...891                                 Stijn Ruiter                               Jochem Tolsma
#> ...892                                 Stijn Ruiter                           Gerbert Kraaykamp
#> ...893                                 Stijn Ruiter                          Frank Van Tubergen
#> ...894                                 Stijn Ruiter                             Shane D Johnson
#> ...895                                 Stijn Ruiter                                Daniel Birks
#> ...896                                 Stijn Ruiter                            Michael Townsley
#> ...897                                 Stijn Ruiter                         Marieke Van De Rakt
#> ...898                                 Stijn Ruiter                            Paul Nieuwbeerta
#> ...899                               Marcel Lubbers                              Peer Scheepers
#> ...900                               Marcel Lubbers                             Marcel Coenders
#> ...901                               Marcel Lubbers                            Mérove Gijsberts
#> ...902                               Marcel Lubbers                                 Eva Jaspers
#> ...903                               Marcel Lubbers                               Roza Meuleman
#> ...904                               Marcel Lubbers                               Jochem Tolsma
#> ...905                               Marcel Lubbers                                 Rob Eisinga
#> ...906                               Marcel Lubbers                            Maykel Verkuyten
#> ...907                               Marcel Lubbers                           Nan Dirk De Graaf
#> ...908                               Marcel Lubbers                               Hidde Bekhuis
#> ...909                           Maurice Gesthuizen                              Peer Scheepers
#> ...910                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...911                           Maurice Gesthuizen                            Marloes De Lange
#> ...912                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...913                           Maurice Gesthuizen                                 Mark Visser
#> ...914                           Maurice Gesthuizen                           Michael Savelkoul
#> ...915                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...916                           Maurice Gesthuizen                               Jochem Tolsma
#> ...917                           Maurice Gesthuizen                                 Bram Steijn
#> ...918                           Maurice Gesthuizen                                 Ariana Need
#> ...919                            Nan Dirk De Graaf                           Gerbert Kraaykamp
#> ...920                            Nan Dirk De Graaf                            Paul M. De Graaf
#> ...921                            Nan Dirk De Graaf                            Paul Nieuwbeerta
#> ...922                            Nan Dirk De Graaf                                 Ariana Need
#> ...923                            Nan Dirk De Graaf                                Stijn Ruiter
#> ...924                            Nan Dirk De Graaf                              Geoffrey Evans
#> ...925                            Nan Dirk De Graaf                             Anthony F Heath
#> ...926                            Nan Dirk De Graaf                       Manfred Te Grotenhuis
#> ...927                            Nan Dirk De Graaf                                Giedo Jansen
#> ...928                            Nan Dirk De Graaf                  Herman G. Van De Werfhorst
#> ...929                               Ellen Verbakel                            Paul M. De Graaf
#> ...930                               Ellen Verbakel                           Gerbert Kraaykamp
#> ...931                               Ellen Verbakel                                 Inge Sieben
#> ...932                               Ellen Verbakel                            Matthijs Kalmijn
#> ...933                               Ellen Verbakel                                 Eva Jaspers
#> ...934                               Ellen Verbakel                          Maurice Gesthuizen
#> ...935                               Ellen Verbakel                                 Ruud Luijkx
#> ...936                               Ellen Verbakel                              Marcel Lubbers
#> ...937                               Ellen Verbakel                              Peer Scheepers
#> ...938                             Paul M. De Graaf                            Matthijs Kalmijn
#> ...939                             Paul M. De Graaf                          Harry Bg Ganzeboom
#> ...940                             Paul M. De Graaf                           Nan Dirk De Graaf
#> ...941                             Paul M. De Graaf                           Gerbert Kraaykamp
#> ...942                             Paul M. De Graaf                                 Ruud Luijkx
#> ...943                             Paul M. De Graaf                                  Wout Ultee
#> ...944                             Paul M. De Graaf                                 Inge Sieben
#> ...945                             Paul M. De Graaf                              Ellen Verbakel
#> ...946                             Paul M. De Graaf                          Maarten Hj Wolbers
#> ...947                             Paul M. De Graaf                              Donald Treiman
#> ...948                            Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...949                            Gerbert Kraaykamp                            Paul M. De Graaf
#> ...950                            Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...951                            Gerbert Kraaykamp                                  Tim Huijts
#> ...952                            Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...953                            Gerbert Kraaykamp                           Christiaan Monden
#> ...954                            Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...955                            Gerbert Kraaykamp                                 Mark Levels
#> ...956                            Gerbert Kraaykamp                               Jochem Tolsma
#> ...957                            Gerbert Kraaykamp                                  Wout Ultee
#> ...958                             Matthijs Kalmijn                            Paul M. De Graaf
#> ...959                             Matthijs Kalmijn                                Kène Henkens
#> ...960                             Matthijs Kalmijn                          Frank Van Tubergen
#> ...961                             Matthijs Kalmijn                           Gerbert Kraaykamp
#> ...962                             Matthijs Kalmijn                           Aart C. Liefbroer
#> ...963                             Matthijs Kalmijn                                Wilfred Uunk
#> ...964                             Matthijs Kalmijn                           Christiaan Monden
#> ...965                             Matthijs Kalmijn                              Marleen Damman
#> ...966                             Matthijs Kalmijn                          Anne-Rigt Poortman
#> ...967                             Matthijs Kalmijn                               Katya Ivanova
#> ...968                                  Eva Jaspers                              Marcel Lubbers
#> ...969                                  Eva Jaspers                         Tanja Van Der Lippe
#> ...970                                  Eva Jaspers                                  Ineke Maas
#> ...971                                  Eva Jaspers                              Ellen Verbakel
#> ...972                                  Eva Jaspers                           Nan Dirk De Graaf
#> ...973                                  Eva Jaspers                           Gerbert Kraaykamp
#> ...974                                  Eva Jaspers                                 Mark Visser
#> ...975                                  Eva Jaspers                               Tim Immerzeel
#> ...976                                  Eva Jaspers                              Peer Scheepers
#> ...977                           Maurice Gesthuizen                              Peer Scheepers
#> ...978                           Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...979                           Maurice Gesthuizen                            Marloes De Lange
#> ...980                           Maurice Gesthuizen                            Tom Van Der Meer
#> ...981                           Maurice Gesthuizen                                 Mark Visser
#> ...982                           Maurice Gesthuizen                           Michael Savelkoul
#> ...983                           Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...984                           Maurice Gesthuizen                               Jochem Tolsma
#> ...985                           Maurice Gesthuizen                                 Bram Steijn
#> ...986                           Maurice Gesthuizen                                 Ariana Need
#> ...987                                  Ruud Luijkx                          Harry Bg Ganzeboom
#> ...988                                  Ruud Luijkx                            Paul M. De Graaf
#> ...989                                  Ruud Luijkx                               Richard Breen
#> ...990                                  Ruud Luijkx                                 Loek Halman
#> ...991                                  Ruud Luijkx                                Ruud Muffels
#> ...992                                  Ruud Luijkx                               Walter Müller
#> ...993                                  Ruud Luijkx                                Anna Manzoni
#> ...994                                  Ruud Luijkx                  Herman G. Van De Werfhorst
#> ...995                                  Ruud Luijkx                        Hans-Peter Blossfeld
#> ...996                                  Ruud Luijkx                                 Inge Sieben
#> ...997                               Marcel Lubbers                              Peer Scheepers
#> ...998                               Marcel Lubbers                             Marcel Coenders
#> ...999                               Marcel Lubbers                            Mérove Gijsberts
#> ...1000                              Marcel Lubbers                                 Eva Jaspers
#> ...1001                              Marcel Lubbers                               Roza Meuleman
#> ...1002                              Marcel Lubbers                               Jochem Tolsma
#> ...1003                              Marcel Lubbers                                 Rob Eisinga
#> ...1004                              Marcel Lubbers                            Maykel Verkuyten
#> ...1005                              Marcel Lubbers                           Nan Dirk De Graaf
#> ...1006                              Marcel Lubbers                               Hidde Bekhuis
#> ...1007                              Peer Scheepers                             Marcel Coenders
#> ...1008                              Peer Scheepers                              Marcel Lubbers
#> ...1009                              Peer Scheepers                                 Rob Eisinga
#> ...1010                              Peer Scheepers                       Manfred Te Grotenhuis
#> ...1011                              Peer Scheepers                            Mérove Gijsberts
#> ...1012                              Peer Scheepers                          Maurice Gesthuizen
#> ...1013                              Peer Scheepers                            Tom Van Der Meer
#> ...1014                              Peer Scheepers                           Michael Savelkoul
#> ...1015                              Peer Scheepers                                Jaak Billiet
#> ...1016                              Peer Scheepers                               Hans De Witte
#> ...1017                                 Mark Visser                           Gerbert Kraaykamp
#> ...1018                                 Mark Visser                          Maurice Gesthuizen
#> ...1019                                 Mark Visser                          Maarten Hj Wolbers
#> ...1020                                 Mark Visser                              Peer Scheepers
#> ...1021                                 Mark Visser                                 Eva Jaspers
#> ...1022                                 Mark Visser                              Marcel Lubbers
#> ...1023                                 Mark Visser                              Marijn Scholte
#> ...1024                                 Mark Visser                           Anette Eva Fasang
#> ...1025                                 Mark Visser                           Jasper Van Houten
#> ...1026                                 Mark Visser                                  Wout Ultee
#> ...1027                           Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...1028                           Gerbert Kraaykamp                            Paul M. De Graaf
#> ...1029                           Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...1030                           Gerbert Kraaykamp                                  Tim Huijts
#> ...1031                           Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...1032                           Gerbert Kraaykamp                           Christiaan Monden
#> ...1033                           Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...1034                           Gerbert Kraaykamp                                 Mark Levels
#> ...1035                           Gerbert Kraaykamp                               Jochem Tolsma
#> ...1036                           Gerbert Kraaykamp                                  Wout Ultee
#> ...1037                          Maurice Gesthuizen                              Peer Scheepers
#> ...1038                          Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...1039                          Maurice Gesthuizen                            Marloes De Lange
#> ...1040                          Maurice Gesthuizen                            Tom Van Der Meer
#> ...1041                          Maurice Gesthuizen                                 Mark Visser
#> ...1042                          Maurice Gesthuizen                           Michael Savelkoul
#> ...1043                          Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...1044                          Maurice Gesthuizen                               Jochem Tolsma
#> ...1045                          Maurice Gesthuizen                                 Bram Steijn
#> ...1046                          Maurice Gesthuizen                                 Ariana Need
#> ...1047                          Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...1048                          Maarten Hj Wolbers                            Marloes De Lange
#> ...1049                          Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...1050                          Maarten Hj Wolbers                                  Wout Ultee
#> ...1051                          Maarten Hj Wolbers                               Jochem Tolsma
#> ...1052                          Maarten Hj Wolbers                            Paul M. De Graaf
#> ...1053                          Maarten Hj Wolbers                                 Mark Visser
#> ...1054                          Maarten Hj Wolbers                               Jaap Dronkers
#> ...1055                          Maarten Hj Wolbers                                  Emer Smyth
#> ...1056                          Maarten Hj Wolbers                                 Ruud Luijkx
#> ...1057                              Peer Scheepers                             Marcel Coenders
#> ...1058                              Peer Scheepers                              Marcel Lubbers
#> ...1059                              Peer Scheepers                                 Rob Eisinga
#> ...1060                              Peer Scheepers                       Manfred Te Grotenhuis
#> ...1061                              Peer Scheepers                            Mérove Gijsberts
#> ...1062                              Peer Scheepers                          Maurice Gesthuizen
#> ...1063                              Peer Scheepers                            Tom Van Der Meer
#> ...1064                              Peer Scheepers                           Michael Savelkoul
#> ...1065                              Peer Scheepers                                Jaak Billiet
#> ...1066                              Peer Scheepers                               Hans De Witte
#> ...1067                                 Eva Jaspers                              Marcel Lubbers
#> ...1068                                 Eva Jaspers                         Tanja Van Der Lippe
#> ...1069                                 Eva Jaspers                                  Ineke Maas
#> ...1070                                 Eva Jaspers                              Ellen Verbakel
#> ...1071                                 Eva Jaspers                           Nan Dirk De Graaf
#> ...1072                                 Eva Jaspers                           Gerbert Kraaykamp
#> ...1073                                 Eva Jaspers                                 Mark Visser
#> ...1074                                 Eva Jaspers                               Tim Immerzeel
#> ...1075                                 Eva Jaspers                              Peer Scheepers
#> ...1076                              Marcel Lubbers                              Peer Scheepers
#> ...1077                              Marcel Lubbers                             Marcel Coenders
#> ...1078                              Marcel Lubbers                            Mérove Gijsberts
#> ...1079                              Marcel Lubbers                                 Eva Jaspers
#> ...1080                              Marcel Lubbers                               Roza Meuleman
#> ...1081                              Marcel Lubbers                               Jochem Tolsma
#> ...1082                              Marcel Lubbers                                 Rob Eisinga
#> ...1083                              Marcel Lubbers                            Maykel Verkuyten
#> ...1084                              Marcel Lubbers                           Nan Dirk De Graaf
#> ...1085                              Marcel Lubbers                               Hidde Bekhuis
#> ...1086                          Maarten Hj Wolbers                          Maurice Gesthuizen
#> ...1087                          Maarten Hj Wolbers                            Marloes De Lange
#> ...1088                          Maarten Hj Wolbers                           Gerbert Kraaykamp
#> ...1089                          Maarten Hj Wolbers                                  Wout Ultee
#> ...1090                          Maarten Hj Wolbers                               Jochem Tolsma
#> ...1091                          Maarten Hj Wolbers                            Paul M. De Graaf
#> ...1092                          Maarten Hj Wolbers                                 Mark Visser
#> ...1093                          Maarten Hj Wolbers                               Jaap Dronkers
#> ...1094                          Maarten Hj Wolbers                                  Emer Smyth
#> ...1095                          Maarten Hj Wolbers                                 Ruud Luijkx
#> ...1096                          Maurice Gesthuizen                              Peer Scheepers
#> ...1097                          Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...1098                          Maurice Gesthuizen                            Marloes De Lange
#> ...1099                          Maurice Gesthuizen                            Tom Van Der Meer
#> ...1100                          Maurice Gesthuizen                                 Mark Visser
#> ...1101                          Maurice Gesthuizen                           Michael Savelkoul
#> ...1102                          Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...1103                          Maurice Gesthuizen                               Jochem Tolsma
#> ...1104                          Maurice Gesthuizen                                 Bram Steijn
#> ...1105                          Maurice Gesthuizen                                 Ariana Need
#> ...1106                           Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...1107                           Gerbert Kraaykamp                            Paul M. De Graaf
#> ...1108                           Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...1109                           Gerbert Kraaykamp                                  Tim Huijts
#> ...1110                           Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...1111                           Gerbert Kraaykamp                           Christiaan Monden
#> ...1112                           Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...1113                           Gerbert Kraaykamp                                 Mark Levels
#> ...1114                           Gerbert Kraaykamp                               Jochem Tolsma
#> ...1115                           Gerbert Kraaykamp                                  Wout Ultee
#> ...1116                               Jochem Tolsma                            Tom Van Der Meer
#> ...1117                               Jochem Tolsma                          Maarten Hj Wolbers
#> ...1118                               Jochem Tolsma                           Gerbert Kraaykamp
#> ...1119                               Jochem Tolsma                              Peer Scheepers
#> ...1120                               Jochem Tolsma                           Michael Savelkoul
#> ...1121                               Jochem Tolsma                                Stijn Ruiter
#> ...1122                               Jochem Tolsma                              Marcel Lubbers
#> ...1123                               Jochem Tolsma                          Maurice Gesthuizen
#> ...1124                               Jochem Tolsma                             Marcel Coenders
#> ...1125                               Jochem Tolsma                           Nan Dirk De Graaf
#> ...1126                            Paul M. De Graaf                            Matthijs Kalmijn
#> ...1127                            Paul M. De Graaf                          Harry Bg Ganzeboom
#> ...1128                            Paul M. De Graaf                           Nan Dirk De Graaf
#> ...1129                            Paul M. De Graaf                           Gerbert Kraaykamp
#> ...1130                            Paul M. De Graaf                                 Ruud Luijkx
#> ...1131                            Paul M. De Graaf                                  Wout Ultee
#> ...1132                            Paul M. De Graaf                                 Inge Sieben
#> ...1133                            Paul M. De Graaf                              Ellen Verbakel
#> ...1134                            Paul M. De Graaf                          Maarten Hj Wolbers
#> ...1135                            Paul M. De Graaf                              Donald Treiman
#> ...1136                                 Mark Visser                           Gerbert Kraaykamp
#> ...1137                                 Mark Visser                          Maurice Gesthuizen
#> ...1138                                 Mark Visser                          Maarten Hj Wolbers
#> ...1139                                 Mark Visser                              Peer Scheepers
#> ...1140                                 Mark Visser                                 Eva Jaspers
#> ...1141                                 Mark Visser                              Marcel Lubbers
#> ...1142                                 Mark Visser                              Marijn Scholte
#> ...1143                                 Mark Visser                           Anette Eva Fasang
#> ...1144                                 Mark Visser                           Jasper Van Houten
#> ...1145                                 Mark Visser                                  Wout Ultee
#> ...1146                               Jaap Dronkers                               Juho Härkönen
#> ...1147                               Jaap Dronkers                           Gerbert Kraaykamp
#> ...1148                               Jaap Dronkers                            Marloes De Lange
#> ...1149                               Jaap Dronkers                                 Bram Lancee
#> ...1150                               Jaap Dronkers                  Herman G. Van De Werfhorst
#> ...1151                               Jaap Dronkers                                Maarten Vink
#> ...1152                               Jaap Dronkers                              Stéfanie André
#> ...1153                               Jaap Dronkers                            Matthijs Kalmijn
#> ...1154                               Jaap Dronkers                                 Ariana Need
#> ...1155                               Jaap Dronkers                          Harry Bg Ganzeboom
#> ...1156                                 Ruud Luijkx                          Harry Bg Ganzeboom
#> ...1157                                 Ruud Luijkx                            Paul M. De Graaf
#> ...1158                                 Ruud Luijkx                               Richard Breen
#> ...1159                                 Ruud Luijkx                                 Loek Halman
#> ...1160                                 Ruud Luijkx                                Ruud Muffels
#> ...1161                                 Ruud Luijkx                               Walter Müller
#> ...1162                                 Ruud Luijkx                                Anna Manzoni
#> ...1163                                 Ruud Luijkx                  Herman G. Van De Werfhorst
#> ...1164                                 Ruud Luijkx                        Hans-Peter Blossfeld
#> ...1165                                 Ruud Luijkx                                 Inge Sieben
#> ...1166                         Carlijn Bussemakers                           Gerbert Kraaykamp
#> ...1167                         Carlijn Bussemakers                             Niels Spierings
#> ...1168                         Carlijn Bussemakers                         Kars Van Oosterhout
#> ...1169                         Carlijn Bussemakers                               Jochem Tolsma
#> ...1170                           Gerbert Kraaykamp                           Nan Dirk De Graaf
#> ...1171                           Gerbert Kraaykamp                            Paul M. De Graaf
#> ...1172                           Gerbert Kraaykamp                            Matthijs Kalmijn
#> ...1173                           Gerbert Kraaykamp                                  Tim Huijts
#> ...1174                           Gerbert Kraaykamp                          Maarten Hj Wolbers
#> ...1175                           Gerbert Kraaykamp                           Christiaan Monden
#> ...1176                           Gerbert Kraaykamp                          Maurice Gesthuizen
#> ...1177                           Gerbert Kraaykamp                                 Mark Levels
#> ...1178                           Gerbert Kraaykamp                               Jochem Tolsma
#> ...1179                           Gerbert Kraaykamp                                  Wout Ultee
#> ...1180                             Niels Spierings                              Kristof Jacobs
#> ...1181                             Niels Spierings                          Harry Bg Ganzeboom
#> ...1182                             Niels Spierings                              Bernhard Nauck
#> ...1183                             Niels Spierings                               Lucinda Platt
#> ...1184                             Niels Spierings                              Sait Bayrakdar
#> ...1185                             Niels Spierings                            Efe Kerem Sozeri
#> ...1186                             Niels Spierings                                Mieke Verloo
#> ...1187                             Niels Spierings                                Jeroen Smits
#> ...1188                             Niels Spierings                              Marcel Lubbers
#> ...1189                             Niels Spierings                           Sarah L. De Lange
#> ...1190                               Jochem Tolsma                            Tom Van Der Meer
#> ...1191                               Jochem Tolsma                          Maarten Hj Wolbers
#> ...1192                               Jochem Tolsma                           Gerbert Kraaykamp
#> ...1193                               Jochem Tolsma                              Peer Scheepers
#> ...1194                               Jochem Tolsma                           Michael Savelkoul
#> ...1195                               Jochem Tolsma                                Stijn Ruiter
#> ...1196                               Jochem Tolsma                              Marcel Lubbers
#> ...1197                               Jochem Tolsma                          Maurice Gesthuizen
#> ...1198                               Jochem Tolsma                             Marcel Coenders
#> ...1199                               Jochem Tolsma                           Nan Dirk De Graaf
#> ...1201                                 Mustafa Inc                              Fairouz Tchier
#> ...1202                                Nella Geurts                              Marcel Lubbers
#> ...1203                                Nella Geurts                             Niels Spierings
#> ...1204                                Nella Geurts                                 Tine Davids
#> ...1205                              Marcel Lubbers                              Peer Scheepers
#> ...1206                              Marcel Lubbers                             Marcel Coenders
#> ...1207                              Marcel Lubbers                            Mérove Gijsberts
#> ...1208                              Marcel Lubbers                                 Eva Jaspers
#> ...1209                              Marcel Lubbers                               Roza Meuleman
#> ...1210                              Marcel Lubbers                               Jochem Tolsma
#> ...1211                              Marcel Lubbers                                 Rob Eisinga
#> ...1212                              Marcel Lubbers                            Maykel Verkuyten
#> ...1213                              Marcel Lubbers                           Nan Dirk De Graaf
#> ...1214                              Marcel Lubbers                               Hidde Bekhuis
#> ...1215                             Niels Spierings                              Kristof Jacobs
#> ...1216                             Niels Spierings                          Harry Bg Ganzeboom
#> ...1217                             Niels Spierings                              Bernhard Nauck
#> ...1218                             Niels Spierings                               Lucinda Platt
#> ...1219                             Niels Spierings                              Sait Bayrakdar
#> ...1220                             Niels Spierings                            Efe Kerem Sozeri
#> ...1221                             Niels Spierings                                Mieke Verloo
#> ...1222                             Niels Spierings                                Jeroen Smits
#> ...1223                             Niels Spierings                              Marcel Lubbers
#> ...1224                             Niels Spierings                           Sarah L. De Lange
#> ...1225                                 Tine Davids                   Francien Th. M. Van Driel
#> ...1226                                 Tine Davids                                 Ruerd Ruben
#> ...1227                                 Tine Davids                              Melissa Siegel
#> ...1228                                 Tine Davids                                Hein De Haas
#> ...1229                                 Tine Davids                              Karin Willemse
#> ...1230                                 Tine Davids                                Lothar Smith
#> ...1231                                 Tine Davids                        Marianne H. Marchand
#> ...1232                                 Tine Davids                                Lau Schulpen
#> ...1236                   Kathrin Friederike Müller                          Margreth Lünenborg
#> ...1237                   Kathrin Friederike Müller                           Claudia Riesmeyer
#> ...1238                   Kathrin Friederike Müller                                 Annika Sehl
#> ...1239                   Kathrin Friederike Müller                             Stephanie Geise
#> ...1240                   Kathrin Friederike Müller                               Melanie Magin
#> ...1241                          Margreth Lünenborg                            Elfriede Fürsich
#> ...1242                                 Annika Sehl                              Alessio Cornia
#> ...1243                                 Annika Sehl                        Rasmus Kleis Nielsen
#> ...1244                                 Annika Sehl                                 Teresa Naab
#> ...1245                                 Annika Sehl                        Dr. Stephan Weichert
#> ...1246                                 Annika Sehl                              Felix M. Simon
#> ...1247                                 Annika Sehl                           Claudia Riesmeyer
#> ...1248                                 Annika Sehl                            Richard Fletcher
#> ...1249                                 Annika Sehl                   Kathrin Friederike Müller
#> ...1250                                 Annika Sehl                               Melanie Magin
#> ...1251                                 Annika Sehl                                Lucas Graves
#> ...1252                               Melanie Magin                              Pascal Jürgens
#> ...1253                               Melanie Magin                                Stefan Geiss
#> ...1254                               Melanie Magin                               Joerg Hassler
#> ...1255                               Melanie Magin                                Uta Russmann
#> ...1256                               Melanie Magin                                Olaf Jandura
#> ...1257                               Melanie Magin                               Marcus Maurer
#> ...1258                               Melanie Magin                                Peter Maurer
#> ...1259                               Melanie Magin                                 Annika Sehl
#> ...1260                               Melanie Magin                           Claudia Riesmeyer
#> ...1261                               Melanie Magin                   Kathrin Friederike Müller
#> ...1262                                Klara Raiber                               Dorothée Behr
#> ...1263                                Klara Raiber                                 Lydia Repke
#> ...1264                                 Lydia Repke                     Veronica Benet-Martinez
#> ...1267                       Jansje Van Middendorp                          Maurice Gesthuizen
#> ...1268                          Maurice Gesthuizen                              Peer Scheepers
#> ...1269                          Maurice Gesthuizen                           Gerbert Kraaykamp
#> ...1270                          Maurice Gesthuizen                            Marloes De Lange
#> ...1271                          Maurice Gesthuizen                            Tom Van Der Meer
#> ...1272                          Maurice Gesthuizen                                 Mark Visser
#> ...1273                          Maurice Gesthuizen                           Michael Savelkoul
#> ...1274                          Maurice Gesthuizen                 "Heike Solga" Or "H. Solga"
#> ...1275                          Maurice Gesthuizen                               Jochem Tolsma
#> ...1276                          Maurice Gesthuizen                                 Bram Steijn
#> ...1277                          Maurice Gesthuizen                                 Ariana Need
#>                gs_id
#> ...2    e7zfTqMAAAAJ
#> ...3    e7zfTqMAAAAJ
#> ...4    e7zfTqMAAAAJ
#> ...5    e7zfTqMAAAAJ
#> ...6    e7zfTqMAAAAJ
#> ...7    e7zfTqMAAAAJ
#> ...8    e7zfTqMAAAAJ
#> ...9    e7zfTqMAAAAJ
#> ...10   e7zfTqMAAAAJ
#> ...11   e7zfTqMAAAAJ
#> ...12   e7zfTqMAAAAJ
#> ...13   e7zfTqMAAAAJ
#> ...14   e7zfTqMAAAAJ
#> ...15   e7zfTqMAAAAJ
#> ...16   e7zfTqMAAAAJ
#> ...17   e7zfTqMAAAAJ
#> ...18   e7zfTqMAAAAJ
#> ...19   e7zfTqMAAAAJ
#> ...20   e7zfTqMAAAAJ
#> ...21   e7zfTqMAAAAJ
#> ...22   e7zfTqMAAAAJ
#> ...23   e7zfTqMAAAAJ
#> ...24   e7zfTqMAAAAJ
#> ...25   e7zfTqMAAAAJ
#> ...26   e7zfTqMAAAAJ
#> ...27   e7zfTqMAAAAJ
#> ...28   e7zfTqMAAAAJ
#> ...29   e7zfTqMAAAAJ
#> ...30   e7zfTqMAAAAJ
#> ...31   e7zfTqMAAAAJ
#> ...32   e7zfTqMAAAAJ
#> ...33   e7zfTqMAAAAJ
#> ...34   e7zfTqMAAAAJ
#> ...35   e7zfTqMAAAAJ
#> ...36   e7zfTqMAAAAJ
#> ...37   e7zfTqMAAAAJ
#> ...38   e7zfTqMAAAAJ
#> ...39   e7zfTqMAAAAJ
#> ...40   e7zfTqMAAAAJ
#> ...41   e7zfTqMAAAAJ
#> ...42   e7zfTqMAAAAJ
#> ...43   e7zfTqMAAAAJ
#> ...44   e7zfTqMAAAAJ
#> ...45   e7zfTqMAAAAJ
#> ...46   e7zfTqMAAAAJ
#> ...47   e7zfTqMAAAAJ
#> ...48   e7zfTqMAAAAJ
#> ...49   e7zfTqMAAAAJ
#> ...50   e7zfTqMAAAAJ
#> ...51   e7zfTqMAAAAJ
#> ...52   e7zfTqMAAAAJ
#> ...53   e7zfTqMAAAAJ
#> ...54   e7zfTqMAAAAJ
#> ...55   e7zfTqMAAAAJ
#> ...56   e7zfTqMAAAAJ
#> ...57   e7zfTqMAAAAJ
#> ...58   e7zfTqMAAAAJ
#> ...59   e7zfTqMAAAAJ
#> ...60   e7zfTqMAAAAJ
#> ...61   e7zfTqMAAAAJ
#> ...62   e7zfTqMAAAAJ
#> ...63   e7zfTqMAAAAJ
#> ...64   e7zfTqMAAAAJ
#> ...65   e7zfTqMAAAAJ
#> ...66   e7zfTqMAAAAJ
#> ...67   e7zfTqMAAAAJ
#> ...69   vzBNQ1kAAAAJ
#> ...70   vzBNQ1kAAAAJ
#> ...71   vzBNQ1kAAAAJ
#> ...72   vzBNQ1kAAAAJ
#> ...73   vzBNQ1kAAAAJ
#> ...74   vzBNQ1kAAAAJ
#> ...75   vzBNQ1kAAAAJ
#> ...76   vzBNQ1kAAAAJ
#> ...77   vzBNQ1kAAAAJ
#> ...78   vzBNQ1kAAAAJ
#> ...79   vzBNQ1kAAAAJ
#> ...80   vzBNQ1kAAAAJ
#> ...81   vzBNQ1kAAAAJ
#> ...82   vzBNQ1kAAAAJ
#> ...83   vzBNQ1kAAAAJ
#> ...84   vzBNQ1kAAAAJ
#> ...85   vzBNQ1kAAAAJ
#> ...86   vzBNQ1kAAAAJ
#> ...87   vzBNQ1kAAAAJ
#> ...88   vzBNQ1kAAAAJ
#> ...89   vzBNQ1kAAAAJ
#> ...90   vzBNQ1kAAAAJ
#> ...91   vzBNQ1kAAAAJ
#> ...92   RG54uasAAAAJ
#> ...93   RG54uasAAAAJ
#> ...94   RG54uasAAAAJ
#> ...95   RG54uasAAAAJ
#> ...96   RG54uasAAAAJ
#> ...97   RG54uasAAAAJ
#> ...98   RG54uasAAAAJ
#> ...99   RG54uasAAAAJ
#> ...100  RG54uasAAAAJ
#> ...101  RG54uasAAAAJ
#> ...102  RG54uasAAAAJ
#> ...103  RG54uasAAAAJ
#> ...104  RG54uasAAAAJ
#> ...105  RG54uasAAAAJ
#> ...106  RG54uasAAAAJ
#> ...107  RG54uasAAAAJ
#> ...108  RG54uasAAAAJ
#> ...109  RG54uasAAAAJ
#> ...110  RG54uasAAAAJ
#> ...111  RG54uasAAAAJ
#> ...112  RG54uasAAAAJ
#> ...113  RG54uasAAAAJ
#> ...114  RG54uasAAAAJ
#> ...115  RG54uasAAAAJ
#> ...116  RG54uasAAAAJ
#> ...117  RG54uasAAAAJ
#> ...118  RG54uasAAAAJ
#> ...119  RG54uasAAAAJ
#> ...120  RG54uasAAAAJ
#> ...121  RG54uasAAAAJ
#> ...122  RG54uasAAAAJ
#> ...123  RG54uasAAAAJ
#> ...124  RG54uasAAAAJ
#> ...125  RG54uasAAAAJ
#> ...126  RG54uasAAAAJ
#> ...127  RG54uasAAAAJ
#> ...128  RG54uasAAAAJ
#> ...129  RG54uasAAAAJ
#> ...130  RG54uasAAAAJ
#> ...131  RG54uasAAAAJ
#> ...132  RG54uasAAAAJ
#> ...133  RG54uasAAAAJ
#> ...134  RG54uasAAAAJ
#> ...135  RG54uasAAAAJ
#> ...136  RG54uasAAAAJ
#> ...137  RG54uasAAAAJ
#> ...138  RG54uasAAAAJ
#> ...139  RG54uasAAAAJ
#> ...140  RG54uasAAAAJ
#> ...141  RG54uasAAAAJ
#> ...142  RG54uasAAAAJ
#> ...143  RG54uasAAAAJ
#> ...144  RG54uasAAAAJ
#> ...145  RG54uasAAAAJ
#> ...146  RG54uasAAAAJ
#> ...147  RG54uasAAAAJ
#> ...148  RG54uasAAAAJ
#> ...149  RG54uasAAAAJ
#> ...150  RG54uasAAAAJ
#> ...151  RG54uasAAAAJ
#> ...152  RG54uasAAAAJ
#> ...153  RG54uasAAAAJ
#> ...154  RG54uasAAAAJ
#> ...155  RG54uasAAAAJ
#> ...156  RG54uasAAAAJ
#> ...157  RG54uasAAAAJ
#> ...158  RG54uasAAAAJ
#> ...159  RG54uasAAAAJ
#> ...160  RG54uasAAAAJ
#> ...161  RG54uasAAAAJ
#> ...162  RG54uasAAAAJ
#> ...163  RG54uasAAAAJ
#> ...164  RG54uasAAAAJ
#> ...165  RG54uasAAAAJ
#> ...166  RG54uasAAAAJ
#> ...167  RG54uasAAAAJ
#> ...168  RG54uasAAAAJ
#> ...170  GDHdsXAAAAAJ
#> ...171  GDHdsXAAAAAJ
#> ...172  GDHdsXAAAAAJ
#> ...173  GDHdsXAAAAAJ
#> ...174  GDHdsXAAAAAJ
#> ...175  GDHdsXAAAAAJ
#> ...176  GDHdsXAAAAAJ
#> ...177  GDHdsXAAAAAJ
#> ...178  GDHdsXAAAAAJ
#> ...179  GDHdsXAAAAAJ
#> ...180  GDHdsXAAAAAJ
#> ...181  GDHdsXAAAAAJ
#> ...182  GDHdsXAAAAAJ
#> ...183  GDHdsXAAAAAJ
#> ...184  GDHdsXAAAAAJ
#> ...185  GDHdsXAAAAAJ
#> ...186  GDHdsXAAAAAJ
#> ...187  GDHdsXAAAAAJ
#> ...188  GDHdsXAAAAAJ
#> ...189  GDHdsXAAAAAJ
#> ...190  GDHdsXAAAAAJ
#> ...191  GDHdsXAAAAAJ
#> ...192  GDHdsXAAAAAJ
#> ...193  GDHdsXAAAAAJ
#> ...194  GDHdsXAAAAAJ
#> ...195  GDHdsXAAAAAJ
#> ...196  GDHdsXAAAAAJ
#> ...197  GDHdsXAAAAAJ
#> ...198  GDHdsXAAAAAJ
#> ...199  GDHdsXAAAAAJ
#> ...200  GDHdsXAAAAAJ
#> ...201  GDHdsXAAAAAJ
#> ...202  GDHdsXAAAAAJ
#> ...203  GDHdsXAAAAAJ
#> ...204  GDHdsXAAAAAJ
#> ...205  GDHdsXAAAAAJ
#> ...206  GDHdsXAAAAAJ
#> ...207  GDHdsXAAAAAJ
#> ...208  GDHdsXAAAAAJ
#> ...209  GDHdsXAAAAAJ
#> ...210  GDHdsXAAAAAJ
#> ...211  GDHdsXAAAAAJ
#> ...212  GDHdsXAAAAAJ
#> ...213  GDHdsXAAAAAJ
#> ...214  GDHdsXAAAAAJ
#> ...215  GDHdsXAAAAAJ
#> ...216  GDHdsXAAAAAJ
#> ...217  GDHdsXAAAAAJ
#> ...218  GDHdsXAAAAAJ
#> ...219  GDHdsXAAAAAJ
#> ...220  GDHdsXAAAAAJ
#> ...221  GDHdsXAAAAAJ
#> ...222  GDHdsXAAAAAJ
#> ...223  GDHdsXAAAAAJ
#> ...224  GDHdsXAAAAAJ
#> ...225  GDHdsXAAAAAJ
#> ...226  GDHdsXAAAAAJ
#> ...227  GDHdsXAAAAAJ
#> ...228  GDHdsXAAAAAJ
#> ...229  GDHdsXAAAAAJ
#> ...230  GDHdsXAAAAAJ
#> ...231  GDHdsXAAAAAJ
#> ...232  GDHdsXAAAAAJ
#> ...233  GDHdsXAAAAAJ
#> ...234  GDHdsXAAAAAJ
#> ...235  GDHdsXAAAAAJ
#> ...236  GDHdsXAAAAAJ
#> ...237  GDHdsXAAAAAJ
#> ...238  GDHdsXAAAAAJ
#> ...239  GDHdsXAAAAAJ
#> ...240  GDHdsXAAAAAJ
#> ...241  GDHdsXAAAAAJ
#> ...242  GDHdsXAAAAAJ
#> ...243  n6hiblQAAAAJ
#> ...244  n6hiblQAAAAJ
#> ...245  n6hiblQAAAAJ
#> ...246  n6hiblQAAAAJ
#> ...247  n6hiblQAAAAJ
#> ...248  n6hiblQAAAAJ
#> ...249  n6hiblQAAAAJ
#> ...250  n6hiblQAAAAJ
#> ...251  n6hiblQAAAAJ
#> ...252  n6hiblQAAAAJ
#> ...253  n6hiblQAAAAJ
#> ...254  n6hiblQAAAAJ
#> ...255  n6hiblQAAAAJ
#> ...256  n6hiblQAAAAJ
#> ...257  n6hiblQAAAAJ
#> ...258  n6hiblQAAAAJ
#> ...259  n6hiblQAAAAJ
#> ...260  n6hiblQAAAAJ
#> ...261  n6hiblQAAAAJ
#> ...262  n6hiblQAAAAJ
#> ...263  n6hiblQAAAAJ
#> ...264  n6hiblQAAAAJ
#> ...265  n6hiblQAAAAJ
#> ...266  n6hiblQAAAAJ
#> ...267  n6hiblQAAAAJ
#> ...268  n6hiblQAAAAJ
#> ...269  n6hiblQAAAAJ
#> ...270  n6hiblQAAAAJ
#> ...271  n6hiblQAAAAJ
#> ...272  n6hiblQAAAAJ
#> ...273  n6hiblQAAAAJ
#> ...274  n6hiblQAAAAJ
#> ...275  n6hiblQAAAAJ
#> ...276  n6hiblQAAAAJ
#> ...277  n6hiblQAAAAJ
#> ...278  n6hiblQAAAAJ
#> ...279  n6hiblQAAAAJ
#> ...280  n6hiblQAAAAJ
#> ...281  n6hiblQAAAAJ
#> ...282  n6hiblQAAAAJ
#> ...283  n6hiblQAAAAJ
#> ...284  n6hiblQAAAAJ
#> ...285  n6hiblQAAAAJ
#> ...286  n6hiblQAAAAJ
#> ...287  n6hiblQAAAAJ
#> ...288  n6hiblQAAAAJ
#> ...289  n6hiblQAAAAJ
#> ...290  n6hiblQAAAAJ
#> ...291  n6hiblQAAAAJ
#> ...292  n6hiblQAAAAJ
#> ...293  n6hiblQAAAAJ
#> ...294  n6hiblQAAAAJ
#> ...295  n6hiblQAAAAJ
#> ...296  n6hiblQAAAAJ
#> ...297  n6hiblQAAAAJ
#> ...298  n6hiblQAAAAJ
#> ...299  n6hiblQAAAAJ
#> ...300  n6hiblQAAAAJ
#> ...301  n6hiblQAAAAJ
#> ...302  n6hiblQAAAAJ
#> ...303  n6hiblQAAAAJ
#> ...304  n6hiblQAAAAJ
#> ...305  n6hiblQAAAAJ
#> ...306  n6hiblQAAAAJ
#> ...307  n6hiblQAAAAJ
#> ...308  n6hiblQAAAAJ
#> ...309  n6hiblQAAAAJ
#> ...310  n6hiblQAAAAJ
#> ...311  n6hiblQAAAAJ
#> ...312  n6hiblQAAAAJ
#> ...313  n6hiblQAAAAJ
#> ...314  n6hiblQAAAAJ
#> ...315  n6hiblQAAAAJ
#> ...316  n6hiblQAAAAJ
#> ...317  n6hiblQAAAAJ
#> ...318  n6hiblQAAAAJ
#> ...320  ZvLlx2EAAAAJ
#> ...321  ZvLlx2EAAAAJ
#> ...322  ZvLlx2EAAAAJ
#> ...323  ZvLlx2EAAAAJ
#> ...324  ZvLlx2EAAAAJ
#> ...325  ZvLlx2EAAAAJ
#> ...326  ZvLlx2EAAAAJ
#> ...327  ZvLlx2EAAAAJ
#> ...328  ZvLlx2EAAAAJ
#> ...329  ZvLlx2EAAAAJ
#> ...330  ZvLlx2EAAAAJ
#> ...331  ZvLlx2EAAAAJ
#> ...332  ZvLlx2EAAAAJ
#> ...333  ZvLlx2EAAAAJ
#> ...334  ZvLlx2EAAAAJ
#> ...335  ZvLlx2EAAAAJ
#> ...336  ZvLlx2EAAAAJ
#> ...337  ZvLlx2EAAAAJ
#> ...338  ZvLlx2EAAAAJ
#> ...339  ZvLlx2EAAAAJ
#> ...340  ZvLlx2EAAAAJ
#> ...341  ZvLlx2EAAAAJ
#> ...342  ZvLlx2EAAAAJ
#> ...343  ZvLlx2EAAAAJ
#> ...344  ZvLlx2EAAAAJ
#> ...345  ZvLlx2EAAAAJ
#> ...346  ZvLlx2EAAAAJ
#> ...347  ZvLlx2EAAAAJ
#> ...348  ZvLlx2EAAAAJ
#> ...349  ZvLlx2EAAAAJ
#> ...350  ZvLlx2EAAAAJ
#> ...351  ZvLlx2EAAAAJ
#> ...352  ZvLlx2EAAAAJ
#> ...353  ZvLlx2EAAAAJ
#> ...354  ZvLlx2EAAAAJ
#> ...355  ZvLlx2EAAAAJ
#> ...356  ZvLlx2EAAAAJ
#> ...357  ZvLlx2EAAAAJ
#> ...358  ZvLlx2EAAAAJ
#> ...359  ZvLlx2EAAAAJ
#> ...360  ZvLlx2EAAAAJ
#> ...361  ZvLlx2EAAAAJ
#> ...362  ZvLlx2EAAAAJ
#> ...363  ZvLlx2EAAAAJ
#> ...364  ZvLlx2EAAAAJ
#> ...365  ZvLlx2EAAAAJ
#> ...366  ZvLlx2EAAAAJ
#> ...367  ZvLlx2EAAAAJ
#> ...368  ZvLlx2EAAAAJ
#> ...369  ZvLlx2EAAAAJ
#> ...370  ZvLlx2EAAAAJ
#> ...371  ZvLlx2EAAAAJ
#> ...372  ZvLlx2EAAAAJ
#> ...373  ZvLlx2EAAAAJ
#> ...374  ZvLlx2EAAAAJ
#> ...375  ZvLlx2EAAAAJ
#> ...376  ZvLlx2EAAAAJ
#> ...377  ZvLlx2EAAAAJ
#> ...378  ZvLlx2EAAAAJ
#> ...379  ZvLlx2EAAAAJ
#> ...380  ZvLlx2EAAAAJ
#> ...381  ZvLlx2EAAAAJ
#> ...382  ZvLlx2EAAAAJ
#> ...383  ZvLlx2EAAAAJ
#> ...384  ZvLlx2EAAAAJ
#> ...385  ZvLlx2EAAAAJ
#> ...386  ZvLlx2EAAAAJ
#> ...387  ZvLlx2EAAAAJ
#> ...388  ZvLlx2EAAAAJ
#> ...389  ZvLlx2EAAAAJ
#> ...390  ZvLlx2EAAAAJ
#> ...391  ZvLlx2EAAAAJ
#> ...392  ZvLlx2EAAAAJ
#> ...394  Nx7pDywAAAAJ
#> ...395  Nx7pDywAAAAJ
#> ...396  Nx7pDywAAAAJ
#> ...397  Nx7pDywAAAAJ
#> ...398  Nx7pDywAAAAJ
#> ...399  Nx7pDywAAAAJ
#> ...400  Nx7pDywAAAAJ
#> ...401  Nx7pDywAAAAJ
#> ...402  Nx7pDywAAAAJ
#> ...403  Nx7pDywAAAAJ
#> ...404  Nx7pDywAAAAJ
#> ...405  Nx7pDywAAAAJ
#> ...406  Nx7pDywAAAAJ
#> ...407  Nx7pDywAAAAJ
#> ...408  Nx7pDywAAAAJ
#> ...409  Nx7pDywAAAAJ
#> ...410  Nx7pDywAAAAJ
#> ...411  Nx7pDywAAAAJ
#> ...412  Nx7pDywAAAAJ
#> ...413  Nx7pDywAAAAJ
#> ...414  Nx7pDywAAAAJ
#> ...415  Nx7pDywAAAAJ
#> ...416  Nx7pDywAAAAJ
#> ...417  Nx7pDywAAAAJ
#> ...418  Nx7pDywAAAAJ
#> ...419  Nx7pDywAAAAJ
#> ...420  Nx7pDywAAAAJ
#> ...421  Nx7pDywAAAAJ
#> ...422  Nx7pDywAAAAJ
#> ...423  Nx7pDywAAAAJ
#> ...424  Nx7pDywAAAAJ
#> ...425  Nx7pDywAAAAJ
#> ...426  Nx7pDywAAAAJ
#> ...427  Nx7pDywAAAAJ
#> ...428  Nx7pDywAAAAJ
#> ...429  Nx7pDywAAAAJ
#> ...430  Nx7pDywAAAAJ
#> ...431  Nx7pDywAAAAJ
#> ...432  Nx7pDywAAAAJ
#> ...433  Nx7pDywAAAAJ
#> ...434  Nx7pDywAAAAJ
#> ...435  Nx7pDywAAAAJ
#> ...436  Nx7pDywAAAAJ
#> ...437  Nx7pDywAAAAJ
#> ...438  Nx7pDywAAAAJ
#> ...439  Nx7pDywAAAAJ
#> ...440  Nx7pDywAAAAJ
#> ...441  Nx7pDywAAAAJ
#> ...442  Nx7pDywAAAAJ
#> ...443  Nx7pDywAAAAJ
#> ...444  Nx7pDywAAAAJ
#> ...445  Nx7pDywAAAAJ
#> ...446  Nx7pDywAAAAJ
#> ...447  Nx7pDywAAAAJ
#> ...448  Nx7pDywAAAAJ
#> ...449  Nx7pDywAAAAJ
#> ...450  Nx7pDywAAAAJ
#> ...451  Nx7pDywAAAAJ
#> ...452  Nx7pDywAAAAJ
#> ...453  Nx7pDywAAAAJ
#> ...454  Nx7pDywAAAAJ
#> ...455  Nx7pDywAAAAJ
#> ...456  Nx7pDywAAAAJ
#> ...457  Nx7pDywAAAAJ
#> ...458  Nx7pDywAAAAJ
#> ...459  Nx7pDywAAAAJ
#> ...460  Nx7pDywAAAAJ
#> ...461  Nx7pDywAAAAJ
#> ...462  Nx7pDywAAAAJ
#> ...463  Nx7pDywAAAAJ
#> ...464  Nx7pDywAAAAJ
#> ...465  Nx7pDywAAAAJ
#> ...466  Nx7pDywAAAAJ
#> ...467  Nx7pDywAAAAJ
#> ...468  Nx7pDywAAAAJ
#> ...469  Nx7pDywAAAAJ
#> ...470  Nx7pDywAAAAJ
#> ...471  Nx7pDywAAAAJ
#> ...472  Nx7pDywAAAAJ
#> ...473  Nx7pDywAAAAJ
#> ...474  Nx7pDywAAAAJ
#> ...475  Nx7pDywAAAAJ
#> ...476  Nx7pDywAAAAJ
#> ...477  Nx7pDywAAAAJ
#> ...478  l8aM4jAAAAAJ
#> ...479  l8aM4jAAAAAJ
#> ...480  l8aM4jAAAAAJ
#> ...481  l8aM4jAAAAAJ
#> ...482  l8aM4jAAAAAJ
#> ...483  l8aM4jAAAAAJ
#> ...484  l8aM4jAAAAAJ
#> ...485  l8aM4jAAAAAJ
#> ...486  l8aM4jAAAAAJ
#> ...487  l8aM4jAAAAAJ
#> ...488  l8aM4jAAAAAJ
#> ...489  l8aM4jAAAAAJ
#> ...490  l8aM4jAAAAAJ
#> ...491  l8aM4jAAAAAJ
#> ...492  l8aM4jAAAAAJ
#> ...493  l8aM4jAAAAAJ
#> ...494  l8aM4jAAAAAJ
#> ...495  l8aM4jAAAAAJ
#> ...496  l8aM4jAAAAAJ
#> ...497  l8aM4jAAAAAJ
#> ...498  l8aM4jAAAAAJ
#> ...499  l8aM4jAAAAAJ
#> ...500  l8aM4jAAAAAJ
#> ...501  l8aM4jAAAAAJ
#> ...502  l8aM4jAAAAAJ
#> ...503  l8aM4jAAAAAJ
#> ...504  l8aM4jAAAAAJ
#> ...505  l8aM4jAAAAAJ
#> ...506  l8aM4jAAAAAJ
#> ...507  l8aM4jAAAAAJ
#> ...508  l8aM4jAAAAAJ
#> ...509  l8aM4jAAAAAJ
#> ...510  l8aM4jAAAAAJ
#> ...511  l8aM4jAAAAAJ
#> ...512  l8aM4jAAAAAJ
#> ...513  l8aM4jAAAAAJ
#> ...514  l8aM4jAAAAAJ
#> ...515  l8aM4jAAAAAJ
#> ...516  l8aM4jAAAAAJ
#> ...517  l8aM4jAAAAAJ
#> ...518  l8aM4jAAAAAJ
#> ...519  l8aM4jAAAAAJ
#> ...520  l8aM4jAAAAAJ
#> ...521  l8aM4jAAAAAJ
#> ...522  l8aM4jAAAAAJ
#> ...523  l8aM4jAAAAAJ
#> ...524  l8aM4jAAAAAJ
#> ...525  l8aM4jAAAAAJ
#> ...526  l8aM4jAAAAAJ
#> ...527  l8aM4jAAAAAJ
#> ...528  l8aM4jAAAAAJ
#> ...529  l8aM4jAAAAAJ
#> ...530  l8aM4jAAAAAJ
#> ...531  l8aM4jAAAAAJ
#> ...532  l8aM4jAAAAAJ
#> ...533  l8aM4jAAAAAJ
#> ...534  l8aM4jAAAAAJ
#> ...535  l8aM4jAAAAAJ
#> ...536  l8aM4jAAAAAJ
#> ...537  l8aM4jAAAAAJ
#> ...538  l8aM4jAAAAAJ
#> ...539  l8aM4jAAAAAJ
#> ...540  l8aM4jAAAAAJ
#> ...541  l8aM4jAAAAAJ
#> ...542  l8aM4jAAAAAJ
#> ...543  l8aM4jAAAAAJ
#> ...544  l8aM4jAAAAAJ
#> ...545  l8aM4jAAAAAJ
#> ...546  l8aM4jAAAAAJ
#> ...547  l8aM4jAAAAAJ
#> ...548  iKs_5WkAAAAJ
#> ...549  iKs_5WkAAAAJ
#> ...550  iKs_5WkAAAAJ
#> ...551  iKs_5WkAAAAJ
#> ...552  iKs_5WkAAAAJ
#> ...553  iKs_5WkAAAAJ
#> ...554  iKs_5WkAAAAJ
#> ...555  iKs_5WkAAAAJ
#> ...556  iKs_5WkAAAAJ
#> ...557  iKs_5WkAAAAJ
#> ...558  iKs_5WkAAAAJ
#> ...559  iKs_5WkAAAAJ
#> ...560  iKs_5WkAAAAJ
#> ...561  iKs_5WkAAAAJ
#> ...562  iKs_5WkAAAAJ
#> ...563  iKs_5WkAAAAJ
#> ...564  iKs_5WkAAAAJ
#> ...565  iKs_5WkAAAAJ
#> ...566  iKs_5WkAAAAJ
#> ...567  iKs_5WkAAAAJ
#> ...568  iKs_5WkAAAAJ
#> ...569  iKs_5WkAAAAJ
#> ...570  iKs_5WkAAAAJ
#> ...571  iKs_5WkAAAAJ
#> ...572  iKs_5WkAAAAJ
#> ...573  iKs_5WkAAAAJ
#> ...574  iKs_5WkAAAAJ
#> ...575  iKs_5WkAAAAJ
#> ...576  iKs_5WkAAAAJ
#> ...577  iKs_5WkAAAAJ
#> ...578  iKs_5WkAAAAJ
#> ...579  iKs_5WkAAAAJ
#> ...580  iKs_5WkAAAAJ
#> ...581  iKs_5WkAAAAJ
#> ...582  iKs_5WkAAAAJ
#> ...583  iKs_5WkAAAAJ
#> ...584  iKs_5WkAAAAJ
#> ...585  iKs_5WkAAAAJ
#> ...586  iKs_5WkAAAAJ
#> ...587  iKs_5WkAAAAJ
#> ...588  iKs_5WkAAAAJ
#> ...589  iKs_5WkAAAAJ
#> ...590  iKs_5WkAAAAJ
#> ...591  iKs_5WkAAAAJ
#> ...592  iKs_5WkAAAAJ
#> ...593  iKs_5WkAAAAJ
#> ...594  iKs_5WkAAAAJ
#> ...595  iKs_5WkAAAAJ
#> ...596  iKs_5WkAAAAJ
#> ...597  iKs_5WkAAAAJ
#> ...598  iKs_5WkAAAAJ
#> ...599  iKs_5WkAAAAJ
#> ...600  iKs_5WkAAAAJ
#> ...601  iKs_5WkAAAAJ
#> ...602  iKs_5WkAAAAJ
#> ...603  iKs_5WkAAAAJ
#> ...604  iKs_5WkAAAAJ
#> ...605  iKs_5WkAAAAJ
#> ...606  iKs_5WkAAAAJ
#> ...607  iKs_5WkAAAAJ
#> ...608  iKs_5WkAAAAJ
#> ...609  iKs_5WkAAAAJ
#> ...610  iKs_5WkAAAAJ
#> ...611  iKs_5WkAAAAJ
#> ...612  iKs_5WkAAAAJ
#> ...613  iKs_5WkAAAAJ
#> ...614  iKs_5WkAAAAJ
#> ...615  iKs_5WkAAAAJ
#> ...616  iKs_5WkAAAAJ
#> ...617  iKs_5WkAAAAJ
#> ...618  iKs_5WkAAAAJ
#> ...619  iKs_5WkAAAAJ
#> ...620  iKs_5WkAAAAJ
#> ...621  iKs_5WkAAAAJ
#> ...622  iKs_5WkAAAAJ
#> ...623  iKs_5WkAAAAJ
#> ...624  iKs_5WkAAAAJ
#> ...625  iKs_5WkAAAAJ
#> ...626  iKs_5WkAAAAJ
#> ...627  iKs_5WkAAAAJ
#> ...628  iKs_5WkAAAAJ
#> ...629  iKs_5WkAAAAJ
#> ...630  iKs_5WkAAAAJ
#> ...631  iKs_5WkAAAAJ
#> ...632  iKs_5WkAAAAJ
#> ...633  iKs_5WkAAAAJ
#> ...634  _f3krXUAAAAJ
#> ...635  _f3krXUAAAAJ
#> ...636  _f3krXUAAAAJ
#> ...637  _f3krXUAAAAJ
#> ...638  _f3krXUAAAAJ
#> ...639  _f3krXUAAAAJ
#> ...640  _f3krXUAAAAJ
#> ...641  _f3krXUAAAAJ
#> ...642  _f3krXUAAAAJ
#> ...643  _f3krXUAAAAJ
#> ...644  _f3krXUAAAAJ
#> ...645  _f3krXUAAAAJ
#> ...646  _f3krXUAAAAJ
#> ...647  _f3krXUAAAAJ
#> ...648  _f3krXUAAAAJ
#> ...649  _f3krXUAAAAJ
#> ...650  _f3krXUAAAAJ
#> ...651  _f3krXUAAAAJ
#> ...652  _f3krXUAAAAJ
#> ...653  _f3krXUAAAAJ
#> ...654  _f3krXUAAAAJ
#> ...655  _f3krXUAAAAJ
#> ...656  _f3krXUAAAAJ
#> ...657  _f3krXUAAAAJ
#> ...658  _f3krXUAAAAJ
#> ...659  _f3krXUAAAAJ
#> ...660  _f3krXUAAAAJ
#> ...661  _f3krXUAAAAJ
#> ...662  _f3krXUAAAAJ
#> ...663  _f3krXUAAAAJ
#> ...664  _f3krXUAAAAJ
#> ...665  _f3krXUAAAAJ
#> ...666  _f3krXUAAAAJ
#> ...667  _f3krXUAAAAJ
#> ...668  _f3krXUAAAAJ
#> ...669  _f3krXUAAAAJ
#> ...670  _f3krXUAAAAJ
#> ...671  _f3krXUAAAAJ
#> ...672  _f3krXUAAAAJ
#> ...673  _f3krXUAAAAJ
#> ...674  _f3krXUAAAAJ
#> ...675  _f3krXUAAAAJ
#> ...676  _f3krXUAAAAJ
#> ...677  _f3krXUAAAAJ
#> ...678  _f3krXUAAAAJ
#> ...679  _f3krXUAAAAJ
#> ...680  hPeXxvEAAAAJ
#> ...681  hPeXxvEAAAAJ
#> ...682  hPeXxvEAAAAJ
#> ...683  hPeXxvEAAAAJ
#> ...684  hPeXxvEAAAAJ
#> ...685  hPeXxvEAAAAJ
#> ...686  hPeXxvEAAAAJ
#> ...687  hPeXxvEAAAAJ
#> ...688  hPeXxvEAAAAJ
#> ...689  hPeXxvEAAAAJ
#> ...690  hPeXxvEAAAAJ
#> ...691  hPeXxvEAAAAJ
#> ...692  hPeXxvEAAAAJ
#> ...693  hPeXxvEAAAAJ
#> ...694  hPeXxvEAAAAJ
#> ...695  hPeXxvEAAAAJ
#> ...696  hPeXxvEAAAAJ
#> ...697  hPeXxvEAAAAJ
#> ...698  hPeXxvEAAAAJ
#> ...699  hPeXxvEAAAAJ
#> ...700  hPeXxvEAAAAJ
#> ...701  hPeXxvEAAAAJ
#> ...702  hPeXxvEAAAAJ
#> ...703  hPeXxvEAAAAJ
#> ...704  hPeXxvEAAAAJ
#> ...705  hPeXxvEAAAAJ
#> ...706  hPeXxvEAAAAJ
#> ...707  hPeXxvEAAAAJ
#> ...708  hPeXxvEAAAAJ
#> ...709  hPeXxvEAAAAJ
#> ...710  hPeXxvEAAAAJ
#> ...711  hPeXxvEAAAAJ
#> ...712  hPeXxvEAAAAJ
#> ...713  hPeXxvEAAAAJ
#> ...714  hPeXxvEAAAAJ
#> ...715  hPeXxvEAAAAJ
#> ...716  hPeXxvEAAAAJ
#> ...717  hPeXxvEAAAAJ
#> ...718  hPeXxvEAAAAJ
#> ...719  hPeXxvEAAAAJ
#> ...720  hPeXxvEAAAAJ
#> ...721  hPeXxvEAAAAJ
#> ...722  hPeXxvEAAAAJ
#> ...723  hPeXxvEAAAAJ
#> ...724  hPeXxvEAAAAJ
#> ...725  hPeXxvEAAAAJ
#> ...726  hPeXxvEAAAAJ
#> ...727  hPeXxvEAAAAJ
#> ...728  hPeXxvEAAAAJ
#> ...729  hPeXxvEAAAAJ
#> ...730  hPeXxvEAAAAJ
#> ...731  hPeXxvEAAAAJ
#> ...732  hPeXxvEAAAAJ
#> ...733  hPeXxvEAAAAJ
#> ...734  hPeXxvEAAAAJ
#> ...735  hPeXxvEAAAAJ
#> ...736  hPeXxvEAAAAJ
#> ...737  hPeXxvEAAAAJ
#> ...738  hPeXxvEAAAAJ
#> ...739  hPeXxvEAAAAJ
#> ...740  hPeXxvEAAAAJ
#> ...741  hPeXxvEAAAAJ
#> ...742  hPeXxvEAAAAJ
#> ...743  hPeXxvEAAAAJ
#> ...744  hPeXxvEAAAAJ
#> ...745  hPeXxvEAAAAJ
#> ...746  hPeXxvEAAAAJ
#> ...747  hPeXxvEAAAAJ
#> ...748  hPeXxvEAAAAJ
#> ...749  hPeXxvEAAAAJ
#> ...750  hPeXxvEAAAAJ
#> ...751  hPeXxvEAAAAJ
#> ...752  hPeXxvEAAAAJ
#> ...753  hPeXxvEAAAAJ
#> ...754  hPeXxvEAAAAJ
#> ...755  hPeXxvEAAAAJ
#> ...756  hPeXxvEAAAAJ
#> ...757  hPeXxvEAAAAJ
#> ...758  hPeXxvEAAAAJ
#> ...759  hPeXxvEAAAAJ
#> ...760  hPeXxvEAAAAJ
#> ...761  hPeXxvEAAAAJ
#> ...762  hPeXxvEAAAAJ
#> ...763  hPeXxvEAAAAJ
#> ...764  hPeXxvEAAAAJ
#> ...765  hPeXxvEAAAAJ
#> ...766  cy3Ye6sAAAAJ
#> ...767  cy3Ye6sAAAAJ
#> ...768  cy3Ye6sAAAAJ
#> ...769  cy3Ye6sAAAAJ
#> ...770  cy3Ye6sAAAAJ
#> ...771  cy3Ye6sAAAAJ
#> ...772  cy3Ye6sAAAAJ
#> ...773  cy3Ye6sAAAAJ
#> ...774  cy3Ye6sAAAAJ
#> ...775  cy3Ye6sAAAAJ
#> ...776  cy3Ye6sAAAAJ
#> ...777  cy3Ye6sAAAAJ
#> ...778  cy3Ye6sAAAAJ
#> ...779  cy3Ye6sAAAAJ
#> ...780  cy3Ye6sAAAAJ
#> ...781  cy3Ye6sAAAAJ
#> ...782  cy3Ye6sAAAAJ
#> ...783  cy3Ye6sAAAAJ
#> ...784  cy3Ye6sAAAAJ
#> ...785  cy3Ye6sAAAAJ
#> ...786  cy3Ye6sAAAAJ
#> ...787  cy3Ye6sAAAAJ
#> ...788  cy3Ye6sAAAAJ
#> ...789  cy3Ye6sAAAAJ
#> ...790  cy3Ye6sAAAAJ
#> ...791  cy3Ye6sAAAAJ
#> ...792  cy3Ye6sAAAAJ
#> ...793  cy3Ye6sAAAAJ
#> ...794  cy3Ye6sAAAAJ
#> ...795  cy3Ye6sAAAAJ
#> ...796  cy3Ye6sAAAAJ
#> ...797  cy3Ye6sAAAAJ
#> ...798  cy3Ye6sAAAAJ
#> ...799  cy3Ye6sAAAAJ
#> ...800  cy3Ye6sAAAAJ
#> ...801  cy3Ye6sAAAAJ
#> ...802  cy3Ye6sAAAAJ
#> ...803  cy3Ye6sAAAAJ
#> ...804  cy3Ye6sAAAAJ
#> ...805  cy3Ye6sAAAAJ
#> ...806  cy3Ye6sAAAAJ
#> ...807  cy3Ye6sAAAAJ
#> ...808  cy3Ye6sAAAAJ
#> ...809  cy3Ye6sAAAAJ
#> ...810  cy3Ye6sAAAAJ
#> ...811  cy3Ye6sAAAAJ
#> ...812  cy3Ye6sAAAAJ
#> ...813  cy3Ye6sAAAAJ
#> ...814  cy3Ye6sAAAAJ
#> ...815  cy3Ye6sAAAAJ
#> ...816  cy3Ye6sAAAAJ
#> ...817  cy3Ye6sAAAAJ
#> ...818  cy3Ye6sAAAAJ
#> ...819  cy3Ye6sAAAAJ
#> ...820  cy3Ye6sAAAAJ
#> ...821  cy3Ye6sAAAAJ
#> ...822  cy3Ye6sAAAAJ
#> ...823  cy3Ye6sAAAAJ
#> ...824  cy3Ye6sAAAAJ
#> ...825  cy3Ye6sAAAAJ
#> ...826  cy3Ye6sAAAAJ
#> ...827  cy3Ye6sAAAAJ
#> ...828  cy3Ye6sAAAAJ
#> ...829  cy3Ye6sAAAAJ
#> ...830  cy3Ye6sAAAAJ
#> ...831  cy3Ye6sAAAAJ
#> ...832  cy3Ye6sAAAAJ
#> ...833  Iu23-90AAAAJ
#> ...834  Iu23-90AAAAJ
#> ...835  Iu23-90AAAAJ
#> ...836  Iu23-90AAAAJ
#> ...837  Iu23-90AAAAJ
#> ...838  Iu23-90AAAAJ
#> ...839  Iu23-90AAAAJ
#> ...840  Iu23-90AAAAJ
#> ...841  Iu23-90AAAAJ
#> ...842  Iu23-90AAAAJ
#> ...843  Iu23-90AAAAJ
#> ...844  Iu23-90AAAAJ
#> ...845  Iu23-90AAAAJ
#> ...846  Iu23-90AAAAJ
#> ...847  Iu23-90AAAAJ
#> ...848  Iu23-90AAAAJ
#> ...849  Iu23-90AAAAJ
#> ...850  Iu23-90AAAAJ
#> ...851  Iu23-90AAAAJ
#> ...852  Iu23-90AAAAJ
#> ...853  Iu23-90AAAAJ
#> ...854  Iu23-90AAAAJ
#> ...855  Iu23-90AAAAJ
#> ...856  Iu23-90AAAAJ
#> ...857  Iu23-90AAAAJ
#> ...858  Iu23-90AAAAJ
#> ...859  Iu23-90AAAAJ
#> ...860  Iu23-90AAAAJ
#> ...861  Iu23-90AAAAJ
#> ...862  Iu23-90AAAAJ
#> ...863  Iu23-90AAAAJ
#> ...864  Iu23-90AAAAJ
#> ...865  Iu23-90AAAAJ
#> ...866  Iu23-90AAAAJ
#> ...867  Iu23-90AAAAJ
#> ...868  Iu23-90AAAAJ
#> ...869  Iu23-90AAAAJ
#> ...870  Iu23-90AAAAJ
#> ...871  Iu23-90AAAAJ
#> ...872  Iu23-90AAAAJ
#> ...873  Iu23-90AAAAJ
#> ...874  Iu23-90AAAAJ
#> ...875  Iu23-90AAAAJ
#> ...876  Iu23-90AAAAJ
#> ...877  Iu23-90AAAAJ
#> ...878  Iu23-90AAAAJ
#> ...879  Iu23-90AAAAJ
#> ...880  Iu23-90AAAAJ
#> ...881  Iu23-90AAAAJ
#> ...882  Iu23-90AAAAJ
#> ...883  Iu23-90AAAAJ
#> ...884  Iu23-90AAAAJ
#> ...885  Iu23-90AAAAJ
#> ...886  Iu23-90AAAAJ
#> ...887  Iu23-90AAAAJ
#> ...888  Iu23-90AAAAJ
#> ...889  Iu23-90AAAAJ
#> ...890  Iu23-90AAAAJ
#> ...891  Iu23-90AAAAJ
#> ...892  Iu23-90AAAAJ
#> ...893  Iu23-90AAAAJ
#> ...894  Iu23-90AAAAJ
#> ...895  Iu23-90AAAAJ
#> ...896  Iu23-90AAAAJ
#> ...897  Iu23-90AAAAJ
#> ...898  Iu23-90AAAAJ
#> ...899  Iu23-90AAAAJ
#> ...900  Iu23-90AAAAJ
#> ...901  Iu23-90AAAAJ
#> ...902  Iu23-90AAAAJ
#> ...903  Iu23-90AAAAJ
#> ...904  Iu23-90AAAAJ
#> ...905  Iu23-90AAAAJ
#> ...906  Iu23-90AAAAJ
#> ...907  Iu23-90AAAAJ
#> ...908  Iu23-90AAAAJ
#> ...909  Iu23-90AAAAJ
#> ...910  Iu23-90AAAAJ
#> ...911  Iu23-90AAAAJ
#> ...912  Iu23-90AAAAJ
#> ...913  Iu23-90AAAAJ
#> ...914  Iu23-90AAAAJ
#> ...915  Iu23-90AAAAJ
#> ...916  Iu23-90AAAAJ
#> ...917  Iu23-90AAAAJ
#> ...918  Iu23-90AAAAJ
#> ...919  Iu23-90AAAAJ
#> ...920  Iu23-90AAAAJ
#> ...921  Iu23-90AAAAJ
#> ...922  Iu23-90AAAAJ
#> ...923  Iu23-90AAAAJ
#> ...924  Iu23-90AAAAJ
#> ...925  Iu23-90AAAAJ
#> ...926  Iu23-90AAAAJ
#> ...927  Iu23-90AAAAJ
#> ...928  Iu23-90AAAAJ
#> ...929  w2McVJAAAAAJ
#> ...930  w2McVJAAAAAJ
#> ...931  w2McVJAAAAAJ
#> ...932  w2McVJAAAAAJ
#> ...933  w2McVJAAAAAJ
#> ...934  w2McVJAAAAAJ
#> ...935  w2McVJAAAAAJ
#> ...936  w2McVJAAAAAJ
#> ...937  w2McVJAAAAAJ
#> ...938  w2McVJAAAAAJ
#> ...939  w2McVJAAAAAJ
#> ...940  w2McVJAAAAAJ
#> ...941  w2McVJAAAAAJ
#> ...942  w2McVJAAAAAJ
#> ...943  w2McVJAAAAAJ
#> ...944  w2McVJAAAAAJ
#> ...945  w2McVJAAAAAJ
#> ...946  w2McVJAAAAAJ
#> ...947  w2McVJAAAAAJ
#> ...948  w2McVJAAAAAJ
#> ...949  w2McVJAAAAAJ
#> ...950  w2McVJAAAAAJ
#> ...951  w2McVJAAAAAJ
#> ...952  w2McVJAAAAAJ
#> ...953  w2McVJAAAAAJ
#> ...954  w2McVJAAAAAJ
#> ...955  w2McVJAAAAAJ
#> ...956  w2McVJAAAAAJ
#> ...957  w2McVJAAAAAJ
#> ...958  w2McVJAAAAAJ
#> ...959  w2McVJAAAAAJ
#> ...960  w2McVJAAAAAJ
#> ...961  w2McVJAAAAAJ
#> ...962  w2McVJAAAAAJ
#> ...963  w2McVJAAAAAJ
#> ...964  w2McVJAAAAAJ
#> ...965  w2McVJAAAAAJ
#> ...966  w2McVJAAAAAJ
#> ...967  w2McVJAAAAAJ
#> ...968  w2McVJAAAAAJ
#> ...969  w2McVJAAAAAJ
#> ...970  w2McVJAAAAAJ
#> ...971  w2McVJAAAAAJ
#> ...972  w2McVJAAAAAJ
#> ...973  w2McVJAAAAAJ
#> ...974  w2McVJAAAAAJ
#> ...975  w2McVJAAAAAJ
#> ...976  w2McVJAAAAAJ
#> ...977  w2McVJAAAAAJ
#> ...978  w2McVJAAAAAJ
#> ...979  w2McVJAAAAAJ
#> ...980  w2McVJAAAAAJ
#> ...981  w2McVJAAAAAJ
#> ...982  w2McVJAAAAAJ
#> ...983  w2McVJAAAAAJ
#> ...984  w2McVJAAAAAJ
#> ...985  w2McVJAAAAAJ
#> ...986  w2McVJAAAAAJ
#> ...987  w2McVJAAAAAJ
#> ...988  w2McVJAAAAAJ
#> ...989  w2McVJAAAAAJ
#> ...990  w2McVJAAAAAJ
#> ...991  w2McVJAAAAAJ
#> ...992  w2McVJAAAAAJ
#> ...993  w2McVJAAAAAJ
#> ...994  w2McVJAAAAAJ
#> ...995  w2McVJAAAAAJ
#> ...996  w2McVJAAAAAJ
#> ...997  w2McVJAAAAAJ
#> ...998  w2McVJAAAAAJ
#> ...999  w2McVJAAAAAJ
#> ...1000 w2McVJAAAAAJ
#> ...1001 w2McVJAAAAAJ
#> ...1002 w2McVJAAAAAJ
#> ...1003 w2McVJAAAAAJ
#> ...1004 w2McVJAAAAAJ
#> ...1005 w2McVJAAAAAJ
#> ...1006 w2McVJAAAAAJ
#> ...1007 w2McVJAAAAAJ
#> ...1008 w2McVJAAAAAJ
#> ...1009 w2McVJAAAAAJ
#> ...1010 w2McVJAAAAAJ
#> ...1011 w2McVJAAAAAJ
#> ...1012 w2McVJAAAAAJ
#> ...1013 w2McVJAAAAAJ
#> ...1014 w2McVJAAAAAJ
#> ...1015 w2McVJAAAAAJ
#> ...1016 w2McVJAAAAAJ
#> ...1017 ItITloQAAAAJ
#> ...1018 ItITloQAAAAJ
#> ...1019 ItITloQAAAAJ
#> ...1020 ItITloQAAAAJ
#> ...1021 ItITloQAAAAJ
#> ...1022 ItITloQAAAAJ
#> ...1023 ItITloQAAAAJ
#> ...1024 ItITloQAAAAJ
#> ...1025 ItITloQAAAAJ
#> ...1026 ItITloQAAAAJ
#> ...1027 ItITloQAAAAJ
#> ...1028 ItITloQAAAAJ
#> ...1029 ItITloQAAAAJ
#> ...1030 ItITloQAAAAJ
#> ...1031 ItITloQAAAAJ
#> ...1032 ItITloQAAAAJ
#> ...1033 ItITloQAAAAJ
#> ...1034 ItITloQAAAAJ
#> ...1035 ItITloQAAAAJ
#> ...1036 ItITloQAAAAJ
#> ...1037 ItITloQAAAAJ
#> ...1038 ItITloQAAAAJ
#> ...1039 ItITloQAAAAJ
#> ...1040 ItITloQAAAAJ
#> ...1041 ItITloQAAAAJ
#> ...1042 ItITloQAAAAJ
#> ...1043 ItITloQAAAAJ
#> ...1044 ItITloQAAAAJ
#> ...1045 ItITloQAAAAJ
#> ...1046 ItITloQAAAAJ
#> ...1047 ItITloQAAAAJ
#> ...1048 ItITloQAAAAJ
#> ...1049 ItITloQAAAAJ
#> ...1050 ItITloQAAAAJ
#> ...1051 ItITloQAAAAJ
#> ...1052 ItITloQAAAAJ
#> ...1053 ItITloQAAAAJ
#> ...1054 ItITloQAAAAJ
#> ...1055 ItITloQAAAAJ
#> ...1056 ItITloQAAAAJ
#> ...1057 ItITloQAAAAJ
#> ...1058 ItITloQAAAAJ
#> ...1059 ItITloQAAAAJ
#> ...1060 ItITloQAAAAJ
#> ...1061 ItITloQAAAAJ
#> ...1062 ItITloQAAAAJ
#> ...1063 ItITloQAAAAJ
#> ...1064 ItITloQAAAAJ
#> ...1065 ItITloQAAAAJ
#> ...1066 ItITloQAAAAJ
#> ...1067 ItITloQAAAAJ
#> ...1068 ItITloQAAAAJ
#> ...1069 ItITloQAAAAJ
#> ...1070 ItITloQAAAAJ
#> ...1071 ItITloQAAAAJ
#> ...1072 ItITloQAAAAJ
#> ...1073 ItITloQAAAAJ
#> ...1074 ItITloQAAAAJ
#> ...1075 ItITloQAAAAJ
#> ...1076 ItITloQAAAAJ
#> ...1077 ItITloQAAAAJ
#> ...1078 ItITloQAAAAJ
#> ...1079 ItITloQAAAAJ
#> ...1080 ItITloQAAAAJ
#> ...1081 ItITloQAAAAJ
#> ...1082 ItITloQAAAAJ
#> ...1083 ItITloQAAAAJ
#> ...1084 ItITloQAAAAJ
#> ...1085 ItITloQAAAAJ
#> ...1086 TqKrXnMAAAAJ
#> ...1087 TqKrXnMAAAAJ
#> ...1088 TqKrXnMAAAAJ
#> ...1089 TqKrXnMAAAAJ
#> ...1090 TqKrXnMAAAAJ
#> ...1091 TqKrXnMAAAAJ
#> ...1092 TqKrXnMAAAAJ
#> ...1093 TqKrXnMAAAAJ
#> ...1094 TqKrXnMAAAAJ
#> ...1095 TqKrXnMAAAAJ
#> ...1096 TqKrXnMAAAAJ
#> ...1097 TqKrXnMAAAAJ
#> ...1098 TqKrXnMAAAAJ
#> ...1099 TqKrXnMAAAAJ
#> ...1100 TqKrXnMAAAAJ
#> ...1101 TqKrXnMAAAAJ
#> ...1102 TqKrXnMAAAAJ
#> ...1103 TqKrXnMAAAAJ
#> ...1104 TqKrXnMAAAAJ
#> ...1105 TqKrXnMAAAAJ
#> ...1106 TqKrXnMAAAAJ
#> ...1107 TqKrXnMAAAAJ
#> ...1108 TqKrXnMAAAAJ
#> ...1109 TqKrXnMAAAAJ
#> ...1110 TqKrXnMAAAAJ
#> ...1111 TqKrXnMAAAAJ
#> ...1112 TqKrXnMAAAAJ
#> ...1113 TqKrXnMAAAAJ
#> ...1114 TqKrXnMAAAAJ
#> ...1115 TqKrXnMAAAAJ
#> ...1116 TqKrXnMAAAAJ
#> ...1117 TqKrXnMAAAAJ
#> ...1118 TqKrXnMAAAAJ
#> ...1119 TqKrXnMAAAAJ
#> ...1120 TqKrXnMAAAAJ
#> ...1121 TqKrXnMAAAAJ
#> ...1122 TqKrXnMAAAAJ
#> ...1123 TqKrXnMAAAAJ
#> ...1124 TqKrXnMAAAAJ
#> ...1125 TqKrXnMAAAAJ
#> ...1126 TqKrXnMAAAAJ
#> ...1127 TqKrXnMAAAAJ
#> ...1128 TqKrXnMAAAAJ
#> ...1129 TqKrXnMAAAAJ
#> ...1130 TqKrXnMAAAAJ
#> ...1131 TqKrXnMAAAAJ
#> ...1132 TqKrXnMAAAAJ
#> ...1133 TqKrXnMAAAAJ
#> ...1134 TqKrXnMAAAAJ
#> ...1135 TqKrXnMAAAAJ
#> ...1136 TqKrXnMAAAAJ
#> ...1137 TqKrXnMAAAAJ
#> ...1138 TqKrXnMAAAAJ
#> ...1139 TqKrXnMAAAAJ
#> ...1140 TqKrXnMAAAAJ
#> ...1141 TqKrXnMAAAAJ
#> ...1142 TqKrXnMAAAAJ
#> ...1143 TqKrXnMAAAAJ
#> ...1144 TqKrXnMAAAAJ
#> ...1145 TqKrXnMAAAAJ
#> ...1146 TqKrXnMAAAAJ
#> ...1147 TqKrXnMAAAAJ
#> ...1148 TqKrXnMAAAAJ
#> ...1149 TqKrXnMAAAAJ
#> ...1150 TqKrXnMAAAAJ
#> ...1151 TqKrXnMAAAAJ
#> ...1152 TqKrXnMAAAAJ
#> ...1153 TqKrXnMAAAAJ
#> ...1154 TqKrXnMAAAAJ
#> ...1155 TqKrXnMAAAAJ
#> ...1156 TqKrXnMAAAAJ
#> ...1157 TqKrXnMAAAAJ
#> ...1158 TqKrXnMAAAAJ
#> ...1159 TqKrXnMAAAAJ
#> ...1160 TqKrXnMAAAAJ
#> ...1161 TqKrXnMAAAAJ
#> ...1162 TqKrXnMAAAAJ
#> ...1163 TqKrXnMAAAAJ
#> ...1164 TqKrXnMAAAAJ
#> ...1165 TqKrXnMAAAAJ
#> ...1166 bDPtkIoAAAAJ
#> ...1167 bDPtkIoAAAAJ
#> ...1168 bDPtkIoAAAAJ
#> ...1169 bDPtkIoAAAAJ
#> ...1170 bDPtkIoAAAAJ
#> ...1171 bDPtkIoAAAAJ
#> ...1172 bDPtkIoAAAAJ
#> ...1173 bDPtkIoAAAAJ
#> ...1174 bDPtkIoAAAAJ
#> ...1175 bDPtkIoAAAAJ
#> ...1176 bDPtkIoAAAAJ
#> ...1177 bDPtkIoAAAAJ
#> ...1178 bDPtkIoAAAAJ
#> ...1179 bDPtkIoAAAAJ
#> ...1180 bDPtkIoAAAAJ
#> ...1181 bDPtkIoAAAAJ
#> ...1182 bDPtkIoAAAAJ
#> ...1183 bDPtkIoAAAAJ
#> ...1184 bDPtkIoAAAAJ
#> ...1185 bDPtkIoAAAAJ
#> ...1186 bDPtkIoAAAAJ
#> ...1187 bDPtkIoAAAAJ
#> ...1188 bDPtkIoAAAAJ
#> ...1189 bDPtkIoAAAAJ
#> ...1190 bDPtkIoAAAAJ
#> ...1191 bDPtkIoAAAAJ
#> ...1192 bDPtkIoAAAAJ
#> ...1193 bDPtkIoAAAAJ
#> ...1194 bDPtkIoAAAAJ
#> ...1195 bDPtkIoAAAAJ
#> ...1196 bDPtkIoAAAAJ
#> ...1197 bDPtkIoAAAAJ
#> ...1198 bDPtkIoAAAAJ
#> ...1199 bDPtkIoAAAAJ
#> ...1201 _ukytQYAAAAJ
#> ...1202 VCTvbTkAAAAJ
#> ...1203 VCTvbTkAAAAJ
#> ...1204 VCTvbTkAAAAJ
#> ...1205 VCTvbTkAAAAJ
#> ...1206 VCTvbTkAAAAJ
#> ...1207 VCTvbTkAAAAJ
#> ...1208 VCTvbTkAAAAJ
#> ...1209 VCTvbTkAAAAJ
#> ...1210 VCTvbTkAAAAJ
#> ...1211 VCTvbTkAAAAJ
#> ...1212 VCTvbTkAAAAJ
#> ...1213 VCTvbTkAAAAJ
#> ...1214 VCTvbTkAAAAJ
#> ...1215 VCTvbTkAAAAJ
#> ...1216 VCTvbTkAAAAJ
#> ...1217 VCTvbTkAAAAJ
#> ...1218 VCTvbTkAAAAJ
#> ...1219 VCTvbTkAAAAJ
#> ...1220 VCTvbTkAAAAJ
#> ...1221 VCTvbTkAAAAJ
#> ...1222 VCTvbTkAAAAJ
#> ...1223 VCTvbTkAAAAJ
#> ...1224 VCTvbTkAAAAJ
#> ...1225 VCTvbTkAAAAJ
#> ...1226 VCTvbTkAAAAJ
#> ...1227 VCTvbTkAAAAJ
#> ...1228 VCTvbTkAAAAJ
#> ...1229 VCTvbTkAAAAJ
#> ...1230 VCTvbTkAAAAJ
#> ...1231 VCTvbTkAAAAJ
#> ...1232 VCTvbTkAAAAJ
#> ...1236 lkVq32sAAAAJ
#> ...1237 lkVq32sAAAAJ
#> ...1238 lkVq32sAAAAJ
#> ...1239 lkVq32sAAAAJ
#> ...1240 lkVq32sAAAAJ
#> ...1241 lkVq32sAAAAJ
#> ...1242 lkVq32sAAAAJ
#> ...1243 lkVq32sAAAAJ
#> ...1244 lkVq32sAAAAJ
#> ...1245 lkVq32sAAAAJ
#> ...1246 lkVq32sAAAAJ
#> ...1247 lkVq32sAAAAJ
#> ...1248 lkVq32sAAAAJ
#> ...1249 lkVq32sAAAAJ
#> ...1250 lkVq32sAAAAJ
#> ...1251 lkVq32sAAAAJ
#> ...1252 lkVq32sAAAAJ
#> ...1253 lkVq32sAAAAJ
#> ...1254 lkVq32sAAAAJ
#> ...1255 lkVq32sAAAAJ
#> ...1256 lkVq32sAAAAJ
#> ...1257 lkVq32sAAAAJ
#> ...1258 lkVq32sAAAAJ
#> ...1259 lkVq32sAAAAJ
#> ...1260 lkVq32sAAAAJ
#> ...1261 lkVq32sAAAAJ
#> ...1262 xE65HUcAAAAJ
#> ...1263 xE65HUcAAAAJ
#> ...1264 xE65HUcAAAAJ
#> ...1267 gs0li6MAAAAJ
#> ...1268 gs0li6MAAAAJ
#> ...1269 gs0li6MAAAAJ
#> ...1270 gs0li6MAAAAJ
#> ...1271 gs0li6MAAAAJ
#> ...1272 gs0li6MAAAAJ
#> ...1273 gs0li6MAAAAJ
#> ...1274 gs0li6MAAAAJ
#> ...1275 gs0li6MAAAAJ
#> ...1276 gs0li6MAAAAJ
#> ...1277 gs0li6MAAAAJ
```

<!---
Finally, we want to get the *article* citation history! Notice how we got like ~3K articles? For all of those articles we need in each year how often they were cited. That means a lot of queries to Google Scholar. We need to prevent that we hit the so-called *rate-limit*. This means that our IP will be blocked for requesting access to a webpage because we did it too often too quickly. Luckily, we can randomize our calls by time in a for loop! Do you understand the code below? (Hint: the code annotation kinda gives it away.)


```r
# because we don't wanna 'Rate limit' google scholar, they throw you out if you make to many
# requests, we randomize request time do you understand the code below?
for (i in 1:10) {
    time <- runif(1, 0, 5)
    Sys.sleep(time)
    print(paste(i, ": R slept for", round(time, 1), "seconds"))
}


# for every number from 1 to 10 we draw one number from 0 to 5 from a uniform distribution we put the
# wrapper sys.sleep around it that we put R to sleep for the drawn number
```

So we time-randomize our calls to Google. In this final for loop, we again put the citation history in a list and only put a Google Scholar ID next to it if there is any citation ever on that paper. Notice how we now call columns and rows from `soc_df_publications`. This is because those contain both the publications of staff members *and* the publication ids which we need to gather the citation history of papers. Finally, we `bind_rows()` again to have data frame in long format with year, citation, publication id, and Google Scholar ID. Notice how this will take way too long for this tutorial to finish. For instance, let's say the mean waiting time is 2 seconds per query. That means at 2*3000 papers=6000 seconds, which is longer than 90 minutes. So we already gathered the data for you to continue with. 


there is a bug in get_article_cite_history function if in one year there is no citation. And this happens quit often. 





```r
# get citation history of a scholar-paper
soc_art_cit <- list()
for (i in 1:nrow(soc_df_publications)) {
    Sys.sleep(runif(1, 0, 4))
    tryCatch({
        soc_art_cit[[i]] <- get_article_cite_history(soc_df_publications[i, c("gs_id")], soc_df_publications[i, 
            c("pubid")])
    }, error = function(e) {
        cat("ERROR :", conditionMessage(e), "\n")
    })  # continue on error, but print the error 
    tryCatch({
        if (nrow(soc_art_cit[[i]]) > 0) {
            soc_art_cit[[i]][, c("gs_id")] <- soc_df_publications[i, c("gs_id")]
        }
    }, error = function(e) {
        cat("ERROR :", conditionMessage(e), "\n")
    })  # continue on error, but print the error 
}


soc_art_cit <- bind_rows(soc_art_cit)
```

---> 

Let's save the data we need in for the next tutorial.

<!---I don't see the data in the addfiles folder yet---> 


```r
# save the DFs thus far
save(soc_df_publications, "addfiles/soc_df_publications.rda"))
save(soc_df, "addfiles/soc_df.rda"))
save(soc_df_collabs, "addfiles/soc_df_collabs.rda"))
#save(soc_art_cit, "addfiles/soc_art_cit.rda")) Notice how we did this one for you.
save(soc_staff_cit, "addfiles/soc_staff_cit.rda"))
```

<!---if students did not succeed, give the links to the data in our repository --->


Nicely done, this was the webscraping tutorial for bibliometric data. We gathered useful information about sociology staff: \
- 1.1 who actually is the staff on the RU website? \
- 1.2 staff google scholar profiles (we merged 1.1 and 1.2) \
- 2 publications and total cites per publication \
- 3 collaborators plus their collaborators ("friends-of-friends") \
- 4 publication citation history (cites per year) \
- 5 citation history of scholars themselves (cites per year) \

**Next, we can move on to some cool network visualization.**

---






