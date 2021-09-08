# (PART) Part 4 Webscraping  {-} 

<!--- put the dataframes in a kable and then use a scrollbox. you can also have captions. works best. see last part of script ---> 

# Webscraping for Sociologists {#webintro}

Latest Version: 08-09-2021

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
> :   The process by which you collect data from the internet. This can entail different routes: manual data collection, automated data collection via code, use of application programming interfaces, and so forth.

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

```
#> $node
#> <pointer: 0x000000002260a350>
#> 
#> $doc
#> <pointer: 0x0000000013568680>
```

That looks kinda weird. What type of object did we store it by putting the html into `soc_staff`?

```r
class(soc_staff)
```

```
#> [1] "xml_document" "xml_node"
```

So it is is stored in something that's called an xml object. Not important for now what that is. But it is important to extract the relevant table that we saw on the sociology staff website. How do we do that? Go to the [https://www.ru.nl/sociology/research/staff/]("googlechromes://www.ru.nl/sociology/research/staff/") in Google Chrome and then press "Inspect" on the webpage (right click--\>Inspect).

<div class="figure">
<img src="inspect.PNG" alt="Inspect element" width="100%" />
<p class="caption">(\#fig:inspect)Inspect element</p>
</div>

Look at the screenshot below, you should be able to see something like this. In the html code we extracted from the Radboud website, we need to go to one of the nodes first. If you move your cursor over "body" in the html code on the right-hand side of your screen, the entire "body" of the page should become some shade of blue. This means that the elements encapsulated in the "body" node captures everything that turned blue.

<div class="figure">
<img src="inspect_body.PNG" alt="Website 'body' node" width="100%" />
<p class="caption">(\#fig:inspectbody)Website 'body' node</p>
</div>

Next, we need to look at the specific elements on the page that we need to extract. Somewhat by informed trial and error, looking for the correct code, we can select the elements we want. In the screenshot below, you see that the "td" elements actually are the ones we need. So we need code that looks for the node "body" and the "td" elements in the xml object and then extract those elements in it. Note that you can click on the arrows once you are in the "Inspect" mode in the web browser to trial-and-error to get at the correct elements.

<div class="figure">
<img src="inspect_td.PNG" alt="Element 'td' on website" width="100%" />
<p class="caption">(\#fig:inspecttd)Element 'td' on website</p>
</div>

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
soc_staff  # looks much better!
```

```
#>  [1] "Staff:"                                                                                                                                                            
#>  [2] "Expertise:"                                                                                                                                                        
#>  [3] "Batenburg, prof. dr. R. (Ronald)"                                                                                                                                  
#>  [4] "Healthcare, labour market and healthcare professions and training"                                                                                                 
#>  [5] "Begall, dr. K.H. (Katia)"                                                                                                                                          
#>  [6] "Family, life course, labour market participation, division of household tasks and gender norms"                                                                    
#>  [7] "Bekhuis, dr. H. (Hidde)"                                                                                                                                           
#>  [8] "Welfare state, nationalism and sports"                                                                                                                             
#>  [9] "Berg, dr. L. van den (Lonneke)"                                                                                                                                    
#> [10] "Family, life course and transition to adulthood"                                                                                                                   
#> [11] "Blommaert, dr. L. (Lieselotte)"                                                                                                                                    
#> [12] "Discrimination and inequality on the labour market"                                                                                                                
#> [13] "Damman, dr. M. (Marleen)"                                                                                                                                          
#> [14] "Labour market, life course, older workers, retirement and solo self-employed"                                                                                      
#> [15] "Eisinga, prof. dr. R.N. (Rob)"                                                                                                                                     
#> [16] "Methods of research and statistics"                                                                                                                                
#> [17] "Gesthuizen, dr. M.J.W. (Maurice)"                                                                                                                                  
#> [18] "\r\n                                Poverty en social cohesion\r\n                              "                                                                  
#> [19] "Glas, dr. S. (Saskia)"                                                                                                                                             
#> [20] "Islam, gender attitudes and sexuality"                                                                                                                             
#> [21] "Hek, dr. M. van (Margriet)"                                                                                                                                        
#> [22] "Educational inequality, gender inequality, organizational sociology and culture"                                                                                   
#> [23] "Hoekman, dr. R. H. A.(Remco)"                                                                                                                                      
#> [24] "Sports and policy sociology"                                                                                                                                       
#> [25] "Hofstra, dr. B. (Bas)"                                                                                                                                             
#> [26] "Diversity, inequality and innovation"                                                                                                                              
#> [27] "Kraaykamp, prof. dr. G.L.M. (Gerbert)"                                                                                                                             
#> [28] "Educational inequality, culture and health"                                                                                                                        
#> [29] "Meuleman, dr. (Roza)"                                                                                                                                              
#> [30] "Culture and nationalism"                                                                                                                                           
#> [31] "Savelkoul, dr. M.J. (Michael)"                                                                                                                                     
#> [32] "Ethnic diversity, prejudice and social cohesion"                                                                                                                   
#> [33] "Scheepers, prof. dr. P.L.H. (Peer)"                                                                                                                                
#> [34] "Comparative research, social cohesion and diversity"                                                                                                               
#> [35] "Spierings, dr. C.H.B.M. (Niels)"                                                                                                                                   
#> [36] "Islam, gender, populism, social media, Middle East and migration"                                                                                                  
#> [37] "Tolsma, dr. J. (Jochem)"                                                                                                                                           
#> [38] "Inequality, criminology and ethnic diversity"                                                                                                                      
#> [39] "\r\n                                Verbakel, prof. dr. C.M.C. (Ellen)\r\n                                Head of the department\r\n                              "
#> [40] "Health, family and work"                                                                                                                                           
#> [41] "Visser, dr. M. (Mark)"                                                                                                                                             
#> [42] "Older workers, radicalism and social cohesion"                                                                                                                     
#> [43] "Wolbers, prof. dr. M.H.J. (Maarten)"                                                                                                                               
#> [44] "Educational inequality and labour market inequality"                                                                                                               
#> [45] "PhD:"                                                                                                                                                              
#> [46] "Expertise:"                                                                                                                                                        
#> [47] "Bussemakers, C. (Carlijn) MSc"                                                                                                                                     
#> [48] "Adverse youth experiences and social inequality"                                                                                                                   
#> [49] "Franken, R. (Rob) MSc"                                                                                                                                             
#> [50] "Sport networks and motivation for sustainable sports participation"                                                                                                
#> [51] "Firat, M. (Mustafa) MSc"                                                                                                                                           
#> [52] "Social inequality, older workers, life course and retirement"                                                                                                      
#> [53] "Geurts, P.G. (Nella) MSc"                                                                                                                                          
#> [54] "Integration and migration"                                                                                                                                         
#> [55] "Hendriks, I.P. (Inge) MSc"                                                                                                                                         
#> [56] "Resistance to refugees and social cohesion"                                                                                                                        
#> [57] "Jeroense, T.M.G. (Thijmen) MSc"                                                                                                                                    
#> [58] "Political participation, segregation, opinion polarization and voting behaviour"                                                                                   
#> [59] "Linders, N. (Nik) MSc"                                                                                                                                             
#> [60] "Populism, gender, masculinity and sexuality"                                                                                                                       
#> [61] "Loh, S.M. (Renae) MSc"                                                                                                                                             
#> [62] "Educational sociology, social stratification, gender inequality and information communication technology (ICT)"                                                    
#> [63] "Meijeren, M. (Maikel) MSc"                                                                                                                                         
#> [64] "Social capital, volunteer work and diversity"                                                                                                                      
#> [65] "Mensvoort, C.A. van (Carly) MSc"                                                                                                                                   
#> [66] "Gender, leadership and social norms"                                                                                                                               
#> [67] "Müller, K. (Katrin) MSc"                                                                                                                                           
#> [68] "Opinions about discrimination, migration and inequality"                                                                                                           
#> [69] "Raiber, K. (Klara) MSc"                                                                                                                                            
#> [70] "Informal care, employment, social inequality and gender"                                                                                                           
#> [71] "Ramaekers, M.J.M. (Marlou) MSc"                                                                                                                                    
#> [72] "Prosocial behaviour and family"                                                                                                                                    
#> [73] "Wiertsema, S. (Sara) MSc"                                                                                                                                          
#> [74] "Inequality in sports and physical activity, school-to-work transition and employment"                                                                              
#> [75] "External PhD:"                                                                                                                                                     
#> [76] "Expertise:"                                                                                                                                                        
#> [77] "Betkó, drs. J.G. (János)"                                                                                                                                          
#> [78] "Social assistance benefit, poverty, reintegration, RCT and social experiment"                                                                                      
#> [79] "Houten, J. (Jasper) van MSc"                                                                                                                                       
#> [80] "Sports"                                                                                                                                                            
#> [81] "Middendorp J. (Jansje) van MSc"                                                                                                                                    
#> [82] "Home administration"                                                                                                                                               
#> [83] "Vis, E. (Elize) MSc"                                                                                                                                               
#> [84] "Healthcare, labour market, healthcare professions and training, health and social capital"                                                                         
#> [85] "Weber, T. (Tijmen) MSc"                                                                                                                                            
#> [86] "International student mobility and the internationalization of higher education"                                                                                   
#> [87] "Guest researchers:"                                                                                                                                                
#> [88] "Expertise:"                                                                                                                                                        
#> [89] "Sterkens, dr. C.J.A. (Carl)"                                                                                                                                       
#> [90] "Religious conflicts, cohesion, religion and the philosophy of life"                                                                                                
#> [91] "Vermeer, dr. P.A.D.M. (Paul)"                                                                                                                                      
#> [92] "Socialization processes, secularisation, religion and the philosophy of life"
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
knitr::kable(soc_df, booktabs = TRUE)  #add scrollbox
```



|soc_names                                                                                  |soc_experts                                                                                                    |
|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
|Staff:                                                                                     |Expertise:                                                                                                     |
|Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |
|Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |
|Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |
|Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |
|Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |
|Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |
|Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |
|Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |
|Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |
|Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |
|Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |
|Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |
|Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |
|Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |
|Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |
|Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |
|Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |
|Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |
|Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |
|Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |
|Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |
|PhD:                                                                                       |Expertise:                                                                                                     |
|Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |
|Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |
|Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |
|Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |
|Hendriks, I.P. (Inge) MSc                                                                  |Resistance to refugees and social cohesion                                                                     |
|Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |
|Linders, N. (Nik) MSc                                                                      |Populism, gender, masculinity and sexuality                                                                    |
|Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |
|Meijeren, M. (Maikel) MSc                                                                  |Social capital, volunteer work and diversity                                                                   |
|Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |
|Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |
|Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |
|Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |
|Wiertsema, S. (Sara) MSc                                                                   |Inequality in sports and physical activity, school-to-work transition and employment                           |
|External PhD:                                                                              |Expertise:                                                                                                     |
|Betkó, drs. J.G. (János)                                                                   |Social assistance benefit, poverty, reintegration, RCT and social experiment                                   |
|Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |
|Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |
|Vis, E. (Elize) MSc                                                                        |Healthcare, labour market, healthcare professions and training, health and social capital                      |
|Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |
|Guest researchers:                                                                         |Expertise:                                                                                                     |
|Sterkens, dr. C.J.A. (Carl)                                                                |Religious conflicts, cohesion, religion and the philosophy of life                                             |
|Vermeer, dr. P.A.D.M. (Paul)                                                               |Socialization processes, secularisation, religion and the philosophy of life                                   |

That looks much better! Now we only need to remove the redundant rows that state "expertise", "staff," and so forth.


```r
# inspect again, and remove the rows we don't need (check for yourself to be certain!)


delrows <- which(soc_df$soc_names == "Staff:" | soc_df$soc_names == "PhD:" | soc_df$soc_names == "External PhD:" | 
    soc_df$soc_names == "Guest researchers:")

soc_df <- soc_df[-delrows, ]

knitr::kable(soc_df, booktabs = TRUE)  #add scrollbox
```



|   |soc_names                                                                                  |soc_experts                                                                                                    |
|:--|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
|2  |Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |
|3  |Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |
|4  |Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |
|5  |Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |
|6  |Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |
|7  |Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |
|8  |Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |
|9  |Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |
|10 |Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |
|11 |Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |
|12 |Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |
|13 |Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |
|14 |Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |
|15 |Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |
|16 |Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |
|17 |Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |
|18 |Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |
|19 |Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |
|20 |Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |
|21 |Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |
|22 |Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |
|24 |Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |
|25 |Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |
|26 |Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |
|27 |Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |
|28 |Hendriks, I.P. (Inge) MSc                                                                  |Resistance to refugees and social cohesion                                                                     |
|29 |Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |
|30 |Linders, N. (Nik) MSc                                                                      |Populism, gender, masculinity and sexuality                                                                    |
|31 |Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |
|32 |Meijeren, M. (Maikel) MSc                                                                  |Social capital, volunteer work and diversity                                                                   |
|33 |Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |
|34 |Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |
|35 |Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |
|36 |Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |
|37 |Wiertsema, S. (Sara) MSc                                                                   |Inequality in sports and physical activity, school-to-work transition and employment                           |
|39 |Betkó, drs. J.G. (János)                                                                   |Social assistance benefit, poverty, reintegration, RCT and social experiment                                   |
|40 |Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |
|41 |Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |
|42 |Vis, E. (Elize) MSc                                                                        |Healthcare, labour market, healthcare professions and training, health and social capital                      |
|43 |Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |
|45 |Sterkens, dr. C.J.A. (Carl)                                                                |Religious conflicts, cohesion, religion and the philosophy of life                                             |
|46 |Vermeer, dr. P.A.D.M. (Paul)                                                               |Socialization processes, secularisation, religion and the philosophy of life                                   |

Now we have a nice relatively clean dataset with all sociology staff and their expterise. But there is yet some work to do before we can move on. We need to do some data cleaning. Ideally, we have staff their first and last names in clean columns. So the last name seems easy, everything before the comma. Do you understand the code below? `gsub` is a function that remove something and replaces it with something else. In the code below it replaces everything that's behind a comma with nothing in the column `soc_names` in the data frame `soc_df`.  

The first name is trickier, we need some more difficult *expressions* to extract first names from this string. It's not necessary for now to exactly know how the expressions below work, but if you want to get into it, here's [a nice resource](https://r4ds.had.co.nz/strings.html). The important part of the code below is that it extracts everything that's in between the brackets.


```r
# Last name seems to be everything before the comma
soc_df$last_name <- gsub(",.*$", "", soc_df$soc_names)

# first name is everything between brackets
soc_df$first_name <- str_extract_all(soc_df$soc_names, "(?<=\\().+?(?=\\))", simplify = TRUE)

knitr::kable(soc_df, booktabs = TRUE)
```



|   |soc_names                                                                                  |soc_experts                                                                                                    |last_name                      |first_name |
|:--|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|:------------------------------|:----------|
|2  |Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |Batenburg                      |Ronald     |
|3  |Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |Begall                         |Katia      |
|4  |Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |Bekhuis                        |Hidde      |
|5  |Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |Berg                           |Lonneke    |
|6  |Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |Blommaert                      |Lieselotte |
|7  |Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |Damman                         |Marleen    |
|8  |Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |Eisinga                        |Rob        |
|9  |Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |Gesthuizen                     |Maurice    |
|10 |Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |Glas                           |Saskia     |
|11 |Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |Hek                            |Margriet   |
|12 |Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |Hoekman                        |Remco      |
|13 |Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |Hofstra                        |Bas        |
|14 |Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |Kraaykamp                      |Gerbert    |
|15 |Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |Meuleman                       |Roza       |
|16 |Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |Savelkoul                      |Michael    |
|17 |Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |Scheepers                      |Peer       |
|18 |Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |Spierings                      |Niels      |
|19 |Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |Tolsma                         |Jochem     |
|20 |Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |Verbakel                       |Ellen      |
|21 |Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |Visser                         |Mark       |
|22 |Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |Wolbers                        |Maarten    |
|24 |Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |Bussemakers                    |Carlijn    |
|25 |Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |Franken                        |Rob        |
|26 |Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |Firat                          |Mustafa    |
|27 |Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |Geurts                         |Nella      |
|28 |Hendriks, I.P. (Inge) MSc                                                                  |Resistance to refugees and social cohesion                                                                     |Hendriks                       |Inge       |
|29 |Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |Jeroense                       |Thijmen    |
|30 |Linders, N. (Nik) MSc                                                                      |Populism, gender, masculinity and sexuality                                                                    |Linders                        |Nik        |
|31 |Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |Loh                            |Renae      |
|32 |Meijeren, M. (Maikel) MSc                                                                  |Social capital, volunteer work and diversity                                                                   |Meijeren                       |Maikel     |
|33 |Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |Mensvoort                      |Carly      |
|34 |Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |Müller                         |Katrin     |
|35 |Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |Raiber                         |Klara      |
|36 |Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |Ramaekers                      |Marlou     |
|37 |Wiertsema, S. (Sara) MSc                                                                   |Inequality in sports and physical activity, school-to-work transition and employment                           |Wiertsema                      |Sara       |
|39 |Betkó, drs. J.G. (János)                                                                   |Social assistance benefit, poverty, reintegration, RCT and social experiment                                   |Betkó                          |János      |
|40 |Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |Houten                         |Jasper     |
|41 |Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |Middendorp J. (Jansje) van MSc |Jansje     |
|42 |Vis, E. (Elize) MSc                                                                        |Healthcare, labour market, healthcare professions and training, health and social capital                      |Vis                            |Elize      |
|43 |Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |Weber                          |Tijmen     |
|45 |Sterkens, dr. C.J.A. (Carl)                                                                |Religious conflicts, cohesion, religion and the philosophy of life                                             |Sterkens                       |Carl       |
|46 |Vermeer, dr. P.A.D.M. (Paul)                                                               |Socialization processes, secularisation, religion and the philosophy of life                                   |Vermeer                        |Paul       |

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
knitr::kable(soc_df, booktabs = TRUE)
```



|   |soc_names                                                                                  |soc_experts                                                                                                    |last_name   |first_name |affiliation        |
|:--|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|:-----------|:----------|:------------------|
|2  |Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |Batenburg   |Ronald     |radboud university |
|3  |Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |Begall      |Katia      |radboud university |
|4  |Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |Bekhuis     |Hidde      |radboud university |
|5  |Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |Berg        |Lonneke    |radboud university |
|6  |Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |Blommaert   |Lieselotte |radboud university |
|7  |Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |Damman      |Marleen    |radboud university |
|8  |Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |Eisinga     |Rob        |radboud university |
|9  |Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |Gesthuizen  |Maurice    |radboud university |
|10 |Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |Glas        |Saskia     |radboud university |
|11 |Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |Hek         |Margriet   |radboud university |
|12 |Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |Hoekman     |Remco      |radboud university |
|13 |Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |Hofstra     |Bas        |radboud university |
|14 |Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |Kraaykamp   |Gerbert    |radboud university |
|15 |Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |Meuleman    |Roza       |radboud university |
|16 |Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |Savelkoul   |Michael    |radboud university |
|17 |Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |Scheepers   |Peer       |radboud university |
|18 |Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |Spierings   |Niels      |radboud university |
|19 |Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |Tolsma      |Jochem     |radboud university |
|20 |Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |Verbakel    |Ellen      |radboud university |
|21 |Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |Visser      |Mark       |radboud university |
|22 |Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |Wolbers     |Maarten    |radboud university |
|24 |Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |Bussemakers |Carlijn    |radboud university |
|25 |Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |Franken     |Rob        |radboud university |
|26 |Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |Firat       |Mustafa    |radboud university |
|27 |Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |Geurts      |Nella      |radboud university |
|28 |Hendriks, I.P. (Inge) MSc                                                                  |Resistance to refugees and social cohesion                                                                     |Hendriks    |Inge       |radboud university |
|29 |Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |Jeroense    |Thijmen    |radboud university |
|30 |Linders, N. (Nik) MSc                                                                      |Populism, gender, masculinity and sexuality                                                                    |Linders     |Nik        |radboud university |
|31 |Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |Loh         |Renae      |radboud university |
|32 |Meijeren, M. (Maikel) MSc                                                                  |Social capital, volunteer work and diversity                                                                   |Meijeren    |Maikel     |radboud university |
|33 |Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |Mensvoort   |Carly      |radboud university |
|34 |Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |Müller      |Katrin     |radboud university |
|35 |Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |Raiber      |Klara      |radboud university |
|36 |Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |Ramaekers   |Marlou     |radboud university |
|37 |Wiertsema, S. (Sara) MSc                                                                   |Inequality in sports and physical activity, school-to-work transition and employment                           |Wiertsema   |Sara       |radboud university |
|39 |Betkó, drs. J.G. (János)                                                                   |Social assistance benefit, poverty, reintegration, RCT and social experiment                                   |Betkó       |János      |radboud university |
|40 |Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |Houten      |Jasper     |radboud university |
|41 |Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |Middendorp  |Jansje     |radboud university |
|42 |Vis, E. (Elize) MSc                                                                        |Healthcare, labour market, healthcare professions and training, health and social capital                      |Vis         |Elize      |radboud university |
|43 |Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |Weber       |Tijmen     |radboud university |
|45 |Sterkens, dr. C.J.A. (Carl)                                                                |Religious conflicts, cohesion, religion and the philosophy of life                                             |Sterkens    |Carl       |radboud university |
|46 |Vermeer, dr. P.A.D.M. (Paul)                                                               |Socialization processes, secularisation, religion and the philosophy of life                                   |Vermeer     |Paul       |radboud university |
<!---do you see it goes wrong for Ellen! ---> 






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
knitr::kable(soc_df, booktabs = TRUE)
```



|   |soc_names                                                                                  |soc_experts                                                                                                    |last_name   |first_name |affiliation        |gs_id        |
|:--|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|:-----------|:----------|:------------------|:------------|
|2  |Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |Batenburg   |Ronald     |radboud university |UK7nVSEAAAAJ |
|3  |Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |Begall      |Katia      |radboud university |e7zfTqMAAAAJ |
|4  |Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |Bekhuis     |Hidde      |radboud university |Q4saWX8AAAAJ |
|5  |Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |Berg        |Lonneke    |radboud university |vzBNQ1kAAAAJ |
|6  |Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |Blommaert   |Lieselotte |radboud university |RG54uasAAAAJ |
|7  |Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |Damman      |Marleen    |radboud university |MEv-V_YAAAAJ |
|8  |Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |Eisinga     |Rob        |radboud university |GDHdsXAAAAAJ |
|9  |Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |Gesthuizen  |Maurice    |radboud university |n6hiblQAAAAJ |
|10 |Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |Glas        |Saskia     |radboud university |ZMc0j2YAAAAJ |
|11 |Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |Hek         |Margriet   |radboud university |ZvLlx2EAAAAJ |
|12 |Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |Hoekman     |Remco      |radboud university |LsMimOEAAAAJ |
|13 |Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |Hofstra     |Bas        |radboud university |Nx7pDywAAAAJ |
|14 |Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |Kraaykamp   |Gerbert    |radboud university |l8aM4jAAAAAJ |
|15 |Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |Meuleman    |Roza       |radboud university |iKs_5WkAAAAJ |
|16 |Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |Savelkoul   |Michael    |radboud university |_f3krXUAAAAJ |
|17 |Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |Scheepers   |Peer       |radboud university |hPeXxvEAAAAJ |
|18 |Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |Spierings   |Niels      |radboud university |cy3Ye6sAAAAJ |
|19 |Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |Tolsma      |Jochem     |radboud university |Iu23-90AAAAJ |
|20 |Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |Verbakel    |Ellen      |radboud university |w2McVJAAAAAJ |
|21 |Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |Visser      |Mark       |radboud university |ItITloQAAAAJ |
|22 |Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |Wolbers     |Maarten    |radboud university |TqKrXnMAAAAJ |
|24 |Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |Bussemakers |Carlijn    |radboud university |bDPtkIoAAAAJ |
|25 |Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |Franken     |Rob        |radboud university |p3IwtT4AAAAJ |
|26 |Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |Firat       |Mustafa    |radboud university |_ukytQYAAAAJ |
|27 |Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |Geurts      |Nella      |radboud university |VCTvbTkAAAAJ |
|29 |Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |Jeroense    |Thijmen    |radboud university |izq-KNUAAAAJ |
|31 |Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |Loh         |Renae      |radboud university |tFaMPOQAAAAJ |
|33 |Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |Mensvoort   |Carly      |radboud university |z6iMs-UAAAAJ |
|34 |Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |Müller      |Katrin     |radboud university |lkVq32sAAAAJ |
|35 |Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |Raiber      |Klara      |radboud university |xE65HUcAAAAJ |
|36 |Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |Ramaekers   |Marlou     |radboud university |fp99JAQAAAAJ |
|40 |Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |Houten      |Jasper     |radboud university |iR4UIwwAAAAJ |
|41 |Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |Middendorp  |Jansje     |radboud university |gs0li6MAAAAJ |
|43 |Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |Weber       |Tijmen     |radboud university |KfLALRIAAAAJ |

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
knitr::kable(soc_df, booktabs = TRUE)
```



|soc_names                                                                                  |soc_experts                                                                                                    |last_name   |first_name |affiliation.x      |gs_id        |name                      |affiliation.y                                                                                 |total_cites |h_index |i10_index |fields                                          |homepage                                                                                                 |
|:------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|:-----------|:----------|:------------------|:------------|:-------------------------|:---------------------------------------------------------------------------------------------|:-----------|:-------|:---------|:-----------------------------------------------|:--------------------------------------------------------------------------------------------------------|
|Batenburg, prof. dr. R. (Ronald)                                                           |Healthcare, labour market and healthcare professions and training                                              |Batenburg   |Ronald     |radboud university |UK7nVSEAAAAJ |Ronald Batenburg          |Programmaleider NIVEL en bijzonder hoogleraar Radboud Universiteit Nijmegen                   |3608        |30      |87        |verified email at nivel.nl - homepage           |https://www.nivel.nl/nl/ronald-batenburg                                                                 |
|Begall, dr. K.H. (Katia)                                                                   |Family, life course, labour market participation, division of household tasks and gender norms                 |Begall      |Katia      |radboud university |e7zfTqMAAAAJ |Katia Begall              |Radboud University Nijmegen                                                                   |936         |9       |9         |verified email at maw.ru.nl                     |NA                                                                                                       |
|Bekhuis, dr. H. (Hidde)                                                                    |Welfare state, nationalism and sports                                                                          |Bekhuis     |Hidde      |radboud university |Q4saWX8AAAAJ |Hidde Bekhuis             |Post Doc Sociology, Radboud University Nijmegen                                               |348         |8       |7         |verified email at ru.nl                         |NA                                                                                                       |
|Berg, dr. L. van den (Lonneke)                                                             |Family, life course and transition to adulthood                                                                |Berg        |Lonneke    |radboud university |vzBNQ1kAAAAJ |Lonneke van den Berg      |Radboud University                                                                            |34          |3       |2         |verified email at maw.ru.nl - homepage          |https://www.ru.nl/personen/berg-l-van-den-lonneke/                                                       |
|Blommaert, dr. L. (Lieselotte)                                                             |Discrimination and inequality on the labour market                                                             |Blommaert   |Lieselotte |radboud university |RG54uasAAAAJ |Lieselotte Blommaert      |Sociology/Social Cultural Research, Radboud University, Nijmegen, the                         |317         |7       |7         |verified email at ru.nl - homepage              |http://www.ru.nl/english/people/blommaert-e/                                                             |
|Damman, dr. M. (Marleen)                                                                   |Labour market, life course, older workers, retirement and solo self-employed                                   |Damman      |Marleen    |radboud university |MEv-V_YAAAAJ |Marleen Damman            |Assistant Professor, Utrecht University                                                       |515         |10      |12        |verified email at uu.nl - homepage              |https://www.uu.nl/staff/MDamman                                                                          |
|Eisinga, prof. dr. R.N. (Rob)                                                              |Methods of research and statistics                                                                             |Eisinga     |Rob        |radboud university |GDHdsXAAAAAJ |Rob Eisinga               |Professor social science research methods, Radboud University Nijmegen                        |4994        |33      |77        |verified email at ru.nl - homepage              |http://robeisinga.ruhosting.nl/                                                                          |
|Gesthuizen, dr. M.J.W. (Maurice)                                                           |Poverty en social cohesion                                                                                     |Gesthuizen  |Maurice    |radboud university |n6hiblQAAAAJ |Maurice Gesthuizen        |Sociology, Radboud University Nijmegen, the Netherland - Assistant Professor                  |2425        |24      |41        |verified email at maw.ru.nl - homepage          |http://www.ru.nl/methodenentechnieken/methoden-technieken/medewerkers/vm_medewerkers/maurice_gesthuizen/ |
|Glas, dr. S. (Saskia)                                                                      |Islam, gender attitudes and sexuality                                                                          |Glas        |Saskia     |radboud university |ZMc0j2YAAAAJ |Saskia Glas               |PhD student, Radboud University                                                               |70          |4       |2         |verified email at ru.nl                         |NA                                                                                                       |
|Hek, dr. M. van (Margriet)                                                                 |Educational inequality, gender inequality, organizational sociology and culture                                |Hek         |Margriet   |radboud university |ZvLlx2EAAAAJ |Margriet van Hek          |Radboud University                                                                            |262         |8       |7         |verified email at maw.ru.nl                     |NA                                                                                                       |
|Hoekman, dr. R. H. A.(Remco)                                                               |Sports and policy sociology                                                                                    |Hoekman     |Remco      |radboud university |LsMimOEAAAAJ |Remco Hoekman             |Director, Mulier Institute / Senior researcher, Radboud University                            |610         |12      |15        |verified email at mulierinstituut.nl - homepage |https://www.mulierinstituut.nl/over-mulier/medewerkers/remco-hoekman/                                    |
|Hofstra, dr. B. (Bas)                                                                      |Diversity, inequality and innovation                                                                           |Hofstra     |Bas        |radboud university |Nx7pDywAAAAJ |Bas Hofstra               |Assistant Professor, Radboud University                                                       |384         |7       |7         |verified email at ru.nl - homepage              |http://www.bashofstra.com/                                                                               |
|Kraaykamp, prof. dr. G.L.M. (Gerbert)                                                      |Educational inequality, culture and health                                                                     |Kraaykamp   |Gerbert    |radboud university |l8aM4jAAAAAJ |Gerbert Kraaykamp         |Professor of Sociology, Radboud Universiteit Nijmegen                                         |7724        |46      |98        |verified email at maw.ru.nl - homepage          |https://www.ru.nl/english/people/kraaykamp-g/                                                            |
|Meuleman, dr. (Roza)                                                                       |Culture and nationalism                                                                                        |Meuleman    |Roza       |radboud university |iKs_5WkAAAAJ |Roza Meuleman             |Assistant Professor - Sociology - Radboud University Nijmegen                                 |214         |8       |6         |verified email at ru.nl                         |NA                                                                                                       |
|Savelkoul, dr. M.J. (Michael)                                                              |Ethnic diversity, prejudice and social cohesion                                                                |Savelkoul   |Michael    |radboud university |_f3krXUAAAAJ |Michael Savelkoul         |Assistant Professor - Sociology, Radboud University Nijmegen, the Netherlands                 |580         |8       |7         |verified email at maw.ru.nl                     |NA                                                                                                       |
|Scheepers, prof. dr. P.L.H. (Peer)                                                         |Comparative research, social cohesion and diversity                                                            |Scheepers   |Peer       |radboud university |hPeXxvEAAAAJ |peer scheepers            |hoogleraar methodologie, faculteit der sociale wetenschappen radboud universiteit             |14399       |61      |180       |verified email at maw.ru.nl                     |NA                                                                                                       |
|Spierings, dr. C.H.B.M. (Niels)                                                            |Islam, gender, populism, social media, Middle East and migration                                               |Spierings   |Niels      |radboud university |cy3Ye6sAAAAJ |Niels Spierings           |Associate Professor of Sociology, Radboud University                                          |1662        |22      |33        |verified email at ru.nl - homepage              |https://www.ru.nl/english/people/spierings-c/                                                            |
|Tolsma, dr. J. (Jochem)                                                                    |Inequality, criminology and ethnic diversity                                                                   |Tolsma      |Jochem     |radboud university |Iu23-90AAAAJ |Jochem Tolsma             |Professor, Radboud University Nijmegen / University of Groningen                              |2260        |22      |33        |verified email at ru.nl - homepage              |http://www.jochemtolsma.nl/                                                                              |
|Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department |Health, family and work                                                                                        |Verbakel    |Ellen      |radboud university |w2McVJAAAAAJ |Ellen Verbakel            |Professor of Sociology, Department of Sociology, Radboud University Nijmegen                  |1474        |24      |32        |verified email at maw.ru.nl - homepage          |http://www.ellenverbakel.nl/                                                                             |
|Visser, dr. M. (Mark)                                                                      |Older workers, radicalism and social cohesion                                                                  |Visser      |Mark       |radboud university |ItITloQAAAAJ |Mark Visser               |Assistant Professor, Radboud University                                                       |381         |9       |8         |verified email at ru.nl - homepage              |https://www.researchgate.net/profile/Mark_Visser                                                         |
|Wolbers, prof. dr. M.H.J. (Maarten)                                                        |Educational inequality and labour market inequality                                                            |Wolbers     |Maarten    |radboud university |TqKrXnMAAAAJ |Maarten HJ Wolbers        |Professor of Sociology, Radboud University, Nijmegen                                          |3624        |29      |58        |verified email at ru.nl - homepage              |http://www.socsci.ru.nl/maartenw/                                                                        |
|Bussemakers, C. (Carlijn) MSc                                                              |Adverse youth experiences and social inequality                                                                |Bussemakers |Carlijn    |radboud university |bDPtkIoAAAAJ |Carlijn Bussemakers       |Department of Sociology, Radboud University                                                   |37          |3       |1         |verified email at maw.ru.nl                     |NA                                                                                                       |
|Franken, R. (Rob) MSc                                                                      |Sport networks and motivation for sustainable sports participation                                             |Franken     |Rob        |radboud university |p3IwtT4AAAAJ |Rob JM Franken            |Unknown affiliation                                                                           |1219        |11      |12        |no verified email                               |NA                                                                                                       |
|Firat, M. (Mustafa) MSc                                                                    |Social inequality, older workers, life course and retirement                                                   |Firat       |Mustafa    |radboud university |_ukytQYAAAAJ |mustafa Inc               |firat university                                                                              |5298        |34      |173       |verified email at firat.edu.tr                  |NA                                                                                                       |
|Geurts, P.G. (Nella) MSc                                                                   |Integration and migration                                                                                      |Geurts      |Nella      |radboud university |VCTvbTkAAAAJ |Nella Geurts              |Department of Sociology, Radboud University                                                   |32          |3       |1         |verified email at ru.nl                         |NA                                                                                                       |
|Jeroense, T.M.G. (Thijmen) MSc                                                             |Political participation, segregation, opinion polarization and voting behaviour                                |Jeroense    |Thijmen    |radboud university |izq-KNUAAAAJ |Thijmen Jeroense          |PhD candidate, Radboud University Nijmegen                                                    |1           |1       |0         |verified email at ru.nl - homepage              |https://www.ru.nl/personen/jeroense-t/                                                                   |
|Loh, S.M. (Renae) MSc                                                                      |Educational sociology, social stratification, gender inequality and information communication technology (ICT) |Loh         |Renae      |radboud university |tFaMPOQAAAAJ |Renae Sze Ming Loh        |PhD candidate, Radboud University                                                             |70          |2       |2         |verified email at ru.nl - homepage              |http://renaeloh.com/                                                                                     |
|Mensvoort, C.A. van (Carly) MSc                                                            |Gender, leadership and social norms                                                                            |Mensvoort   |Carly      |radboud university |z6iMs-UAAAAJ |Carly van Mensvoort       |Radboud University                                                                            |35          |2       |2         |verified email at ru.nl - homepage              |https://www.ru.nl/english/people/mensvoort-c-van/                                                        |
|Müller, K. (Katrin) MSc                                                                    |Opinions about discrimination, migration and inequality                                                        |Müller      |Katrin     |radboud university |lkVq32sAAAAJ |Kathrin Friederike Müller |Post-Doc, Universtität Rostock/CAIS NRW                                                       |201         |9       |9         |verified email at uni-rostock.de - homepage     |https://www.imf.uni-rostock.de/institut/mitarbeiterinnen/lehrende/dr-kathrin-friederike-mueller/         |
|Raiber, K. (Klara) MSc                                                                     |Informal care, employment, social inequality and gender                                                        |Raiber      |Klara      |radboud university |xE65HUcAAAAJ |Klara Raiber              |PhD candidate, Radboud University Nijmegen                                                    |4           |1       |0         |verified email at maw.ru.nl - homepage          |https://www.ru.nl/english/people/raiber-k/                                                               |
|Ramaekers, M.J.M. (Marlou) MSc                                                             |Prosocial behaviour and family                                                                                 |Ramaekers   |Marlou     |radboud university |fp99JAQAAAAJ |Marlou Ramaekers          |PhD Candidate, Radboud University                                                             |NA          |NA      |NA        |verified email at ru.nl                         |NA                                                                                                       |
|Houten, J. (Jasper) van MSc                                                                |Sports                                                                                                         |Houten      |Jasper     |radboud university |iR4UIwwAAAAJ |Jasper van Houten         |PhD Candidate, HAN Institute of Sport and Exercise Studies (Hogeschool van Arnhem en Nijmegen |31          |4       |1         |verified email at ru.nl - homepage              |https://www.researchgate.net/profile/Jasper_Houten                                                       |
|Middendorp J. (Jansje) van MSc                                                             |Home administration                                                                                            |Middendorp  |Jansje     |radboud university |gs0li6MAAAAJ |Jansje van Middendorp     |Buitenpromovendus Radboud Universiteit                                                        |3           |1       |0         |verified email at ru.nl                         |NA                                                                                                       |
|Weber, T. (Tijmen) MSc                                                                     |International student mobility and the internationalization of higher education                                |Weber       |Tijmen     |radboud university |KfLALRIAAAAJ |Tijmen Weber              |Lecturer Statistics and Research, HAN University of Applied Sciences                          |42          |2       |2         |verified email at han.nl                        |NA                                                                                                       |


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
knitr::kable(soc_staff_cit, booktabs = TRUE)
```



| year| cites|gs_id        |
|----:|-----:|:------------|
| 1999|    14|UK7nVSEAAAAJ |
| 2000|    25|UK7nVSEAAAAJ |
| 2001|    21|UK7nVSEAAAAJ |
| 2002|    18|UK7nVSEAAAAJ |
| 2003|    35|UK7nVSEAAAAJ |
| 2004|    24|UK7nVSEAAAAJ |
| 2005|    53|UK7nVSEAAAAJ |
| 2006|    64|UK7nVSEAAAAJ |
| 2007|    52|UK7nVSEAAAAJ |
| 2008|    80|UK7nVSEAAAAJ |
| 2009|   115|UK7nVSEAAAAJ |
| 2010|   134|UK7nVSEAAAAJ |
| 2011|   158|UK7nVSEAAAAJ |
| 2012|   186|UK7nVSEAAAAJ |
| 2013|   219|UK7nVSEAAAAJ |
| 2014|   207|UK7nVSEAAAAJ |
| 2015|   257|UK7nVSEAAAAJ |
| 2016|   336|UK7nVSEAAAAJ |
| 2017|   307|UK7nVSEAAAAJ |
| 2018|   358|UK7nVSEAAAAJ |
| 2019|   314|UK7nVSEAAAAJ |
| 2020|   335|UK7nVSEAAAAJ |
| 2021|   183|UK7nVSEAAAAJ |
| 2008|     5|e7zfTqMAAAAJ |
| 2009|    18|e7zfTqMAAAAJ |
| 2010|    28|e7zfTqMAAAAJ |
| 2011|    29|e7zfTqMAAAAJ |
| 2012|    32|e7zfTqMAAAAJ |
| 2013|    48|e7zfTqMAAAAJ |
| 2014|    51|e7zfTqMAAAAJ |
| 2015|    61|e7zfTqMAAAAJ |
| 2016|    77|e7zfTqMAAAAJ |
| 2017|   120|e7zfTqMAAAAJ |
| 2018|    99|e7zfTqMAAAAJ |
| 2019|   119|e7zfTqMAAAAJ |
| 2020|   137|e7zfTqMAAAAJ |
| 2021|   102|e7zfTqMAAAAJ |
| 2008|     1|Q4saWX8AAAAJ |
| 2009|     4|Q4saWX8AAAAJ |
| 2010|     7|Q4saWX8AAAAJ |
| 2011|     7|Q4saWX8AAAAJ |
| 2012|    17|Q4saWX8AAAAJ |
| 2013|    22|Q4saWX8AAAAJ |
| 2014|    36|Q4saWX8AAAAJ |
| 2015|    29|Q4saWX8AAAAJ |
| 2016|    37|Q4saWX8AAAAJ |
| 2017|    25|Q4saWX8AAAAJ |
| 2018|    33|Q4saWX8AAAAJ |
| 2019|    50|Q4saWX8AAAAJ |
| 2020|    40|Q4saWX8AAAAJ |
| 2021|    32|Q4saWX8AAAAJ |
| 2018|     1|vzBNQ1kAAAAJ |
| 2019|     6|vzBNQ1kAAAAJ |
| 2020|     9|vzBNQ1kAAAAJ |
| 2021|    15|vzBNQ1kAAAAJ |
| 2012|     3|RG54uasAAAAJ |
| 2013|     3|RG54uasAAAAJ |
| 2014|     8|RG54uasAAAAJ |
| 2015|    24|RG54uasAAAAJ |
| 2016|    19|RG54uasAAAAJ |
| 2017|    34|RG54uasAAAAJ |
| 2018|    41|RG54uasAAAAJ |
| 2019|    58|RG54uasAAAAJ |
| 2020|    72|RG54uasAAAAJ |
| 2021|    51|RG54uasAAAAJ |
| 2011|     2|MEv-V_YAAAAJ |
| 2012|     7|MEv-V_YAAAAJ |
| 2013|    15|MEv-V_YAAAAJ |
| 2014|    19|MEv-V_YAAAAJ |
| 2015|    30|MEv-V_YAAAAJ |
| 2016|    60|MEv-V_YAAAAJ |
| 2017|    65|MEv-V_YAAAAJ |
| 2018|    78|MEv-V_YAAAAJ |
| 2019|    88|MEv-V_YAAAAJ |
| 2020|    85|MEv-V_YAAAAJ |
| 2021|    60|MEv-V_YAAAAJ |
| 1991|    18|GDHdsXAAAAAJ |
| 1992|    13|GDHdsXAAAAAJ |
| 1993|    14|GDHdsXAAAAAJ |
| 1994|    41|GDHdsXAAAAAJ |
| 1995|    38|GDHdsXAAAAAJ |
| 1996|    37|GDHdsXAAAAAJ |
| 1997|    26|GDHdsXAAAAAJ |
| 1998|    24|GDHdsXAAAAAJ |
| 1999|    36|GDHdsXAAAAAJ |
| 2000|    47|GDHdsXAAAAAJ |
| 2001|    50|GDHdsXAAAAAJ |
| 2002|    44|GDHdsXAAAAAJ |
| 2003|    42|GDHdsXAAAAAJ |
| 2004|    35|GDHdsXAAAAAJ |
| 2005|    48|GDHdsXAAAAAJ |
| 2006|    63|GDHdsXAAAAAJ |
| 2007|    58|GDHdsXAAAAAJ |
| 2008|    83|GDHdsXAAAAAJ |
| 2009|   120|GDHdsXAAAAAJ |
| 2010|    98|GDHdsXAAAAAJ |
| 2011|   104|GDHdsXAAAAAJ |
| 2012|   143|GDHdsXAAAAAJ |
| 2013|   184|GDHdsXAAAAAJ |
| 2014|   277|GDHdsXAAAAAJ |
| 2015|   345|GDHdsXAAAAAJ |
| 2016|   411|GDHdsXAAAAAJ |
| 2017|   441|GDHdsXAAAAAJ |
| 2018|   527|GDHdsXAAAAAJ |
| 2019|   495|GDHdsXAAAAAJ |
| 2020|   591|GDHdsXAAAAAJ |
| 2021|   447|GDHdsXAAAAAJ |
| 2005|    10|n6hiblQAAAAJ |
| 2006|    19|n6hiblQAAAAJ |
| 2007|    28|n6hiblQAAAAJ |
| 2008|    47|n6hiblQAAAAJ |
| 2009|    54|n6hiblQAAAAJ |
| 2010|    67|n6hiblQAAAAJ |
| 2011|   128|n6hiblQAAAAJ |
| 2012|   121|n6hiblQAAAAJ |
| 2013|   175|n6hiblQAAAAJ |
| 2014|   200|n6hiblQAAAAJ |
| 2015|   231|n6hiblQAAAAJ |
| 2016|   252|n6hiblQAAAAJ |
| 2017|   237|n6hiblQAAAAJ |
| 2018|   206|n6hiblQAAAAJ |
| 2019|   208|n6hiblQAAAAJ |
| 2020|   210|n6hiblQAAAAJ |
| 2021|   186|n6hiblQAAAAJ |
| 2018|     2|ZMc0j2YAAAAJ |
| 2019|    13|ZMc0j2YAAAAJ |
| 2020|    29|ZMc0j2YAAAAJ |
| 2021|    26|ZMc0j2YAAAAJ |
| 2014|     3|ZvLlx2EAAAAJ |
| 2015|     4|ZvLlx2EAAAAJ |
| 2016|    19|ZvLlx2EAAAAJ |
| 2017|    15|ZvLlx2EAAAAJ |
| 2018|    31|ZvLlx2EAAAAJ |
| 2019|    55|ZvLlx2EAAAAJ |
| 2020|    78|ZvLlx2EAAAAJ |
| 2021|    55|ZvLlx2EAAAAJ |
| 2010|     4|LsMimOEAAAAJ |
| 2011|     7|LsMimOEAAAAJ |
| 2012|    12|LsMimOEAAAAJ |
| 2013|    24|LsMimOEAAAAJ |
| 2014|    40|LsMimOEAAAAJ |
| 2015|    36|LsMimOEAAAAJ |
| 2016|    53|LsMimOEAAAAJ |
| 2017|    76|LsMimOEAAAAJ |
| 2018|    81|LsMimOEAAAAJ |
| 2019|    49|LsMimOEAAAAJ |
| 2020|   122|LsMimOEAAAAJ |
| 2021|    98|LsMimOEAAAAJ |
| 2014|     2|Nx7pDywAAAAJ |
| 2015|     2|Nx7pDywAAAAJ |
| 2016|    15|Nx7pDywAAAAJ |
| 2017|    25|Nx7pDywAAAAJ |
| 2018|    33|Nx7pDywAAAAJ |
| 2019|    28|Nx7pDywAAAAJ |
| 2020|   105|Nx7pDywAAAAJ |
| 2021|   162|Nx7pDywAAAAJ |
| 1997|    22|l8aM4jAAAAAJ |
| 1998|    19|l8aM4jAAAAAJ |
| 1999|    31|l8aM4jAAAAAJ |
| 2000|    49|l8aM4jAAAAAJ |
| 2001|    77|l8aM4jAAAAAJ |
| 2002|    87|l8aM4jAAAAAJ |
| 2003|    98|l8aM4jAAAAAJ |
| 2004|   116|l8aM4jAAAAAJ |
| 2005|   126|l8aM4jAAAAAJ |
| 2006|   176|l8aM4jAAAAAJ |
| 2007|   205|l8aM4jAAAAAJ |
| 2008|   256|l8aM4jAAAAAJ |
| 2009|   246|l8aM4jAAAAAJ |
| 2010|   303|l8aM4jAAAAAJ |
| 2011|   360|l8aM4jAAAAAJ |
| 2012|   363|l8aM4jAAAAAJ |
| 2013|   460|l8aM4jAAAAAJ |
| 2014|   474|l8aM4jAAAAAJ |
| 2015|   512|l8aM4jAAAAAJ |
| 2016|   614|l8aM4jAAAAAJ |
| 2017|   581|l8aM4jAAAAAJ |
| 2018|   655|l8aM4jAAAAAJ |
| 2019|   621|l8aM4jAAAAAJ |
| 2020|   662|l8aM4jAAAAAJ |
| 2021|   440|l8aM4jAAAAAJ |
| 2012|     1|iKs_5WkAAAAJ |
| 2013|     5|iKs_5WkAAAAJ |
| 2014|    14|iKs_5WkAAAAJ |
| 2015|    19|iKs_5WkAAAAJ |
| 2016|    23|iKs_5WkAAAAJ |
| 2017|    30|iKs_5WkAAAAJ |
| 2018|    31|iKs_5WkAAAAJ |
| 2019|    39|iKs_5WkAAAAJ |
| 2020|    23|iKs_5WkAAAAJ |
| 2021|    20|iKs_5WkAAAAJ |
| 2011|    10|_f3krXUAAAAJ |
| 2012|    24|_f3krXUAAAAJ |
| 2013|    32|_f3krXUAAAAJ |
| 2014|    51|_f3krXUAAAAJ |
| 2015|    67|_f3krXUAAAAJ |
| 2016|    54|_f3krXUAAAAJ |
| 2017|    63|_f3krXUAAAAJ |
| 2018|    80|_f3krXUAAAAJ |
| 2019|    64|_f3krXUAAAAJ |
| 2020|    70|_f3krXUAAAAJ |
| 2021|    54|_f3krXUAAAAJ |
| 1994|    60|hPeXxvEAAAAJ |
| 1995|    35|hPeXxvEAAAAJ |
| 1996|    39|hPeXxvEAAAAJ |
| 1997|    33|hPeXxvEAAAAJ |
| 1998|    35|hPeXxvEAAAAJ |
| 1999|    47|hPeXxvEAAAAJ |
| 2000|    74|hPeXxvEAAAAJ |
| 2001|   122|hPeXxvEAAAAJ |
| 2002|   107|hPeXxvEAAAAJ |
| 2003|   153|hPeXxvEAAAAJ |
| 2004|   170|hPeXxvEAAAAJ |
| 2005|   180|hPeXxvEAAAAJ |
| 2006|   253|hPeXxvEAAAAJ |
| 2007|   336|hPeXxvEAAAAJ |
| 2008|   439|hPeXxvEAAAAJ |
| 2009|   515|hPeXxvEAAAAJ |
| 2010|   511|hPeXxvEAAAAJ |
| 2011|   622|hPeXxvEAAAAJ |
| 2012|   767|hPeXxvEAAAAJ |
| 2013|   782|hPeXxvEAAAAJ |
| 2014|   935|hPeXxvEAAAAJ |
| 2015|  1129|hPeXxvEAAAAJ |
| 2016|  1076|hPeXxvEAAAAJ |
| 2017|  1182|hPeXxvEAAAAJ |
| 2018|  1206|hPeXxvEAAAAJ |
| 2019|  1163|hPeXxvEAAAAJ |
| 2020|  1235|hPeXxvEAAAAJ |
| 2021|   863|hPeXxvEAAAAJ |
| 2011|    12|cy3Ye6sAAAAJ |
| 2012|    21|cy3Ye6sAAAAJ |
| 2013|    42|cy3Ye6sAAAAJ |
| 2014|    55|cy3Ye6sAAAAJ |
| 2015|    74|cy3Ye6sAAAAJ |
| 2016|   141|cy3Ye6sAAAAJ |
| 2017|   140|cy3Ye6sAAAAJ |
| 2018|   223|cy3Ye6sAAAAJ |
| 2019|   285|cy3Ye6sAAAAJ |
| 2020|   346|cy3Ye6sAAAAJ |
| 2021|   287|cy3Ye6sAAAAJ |
| 2008|    12|Iu23-90AAAAJ |
| 2009|    21|Iu23-90AAAAJ |
| 2010|    26|Iu23-90AAAAJ |
| 2011|    79|Iu23-90AAAAJ |
| 2012|    79|Iu23-90AAAAJ |
| 2013|   116|Iu23-90AAAAJ |
| 2014|   151|Iu23-90AAAAJ |
| 2015|   204|Iu23-90AAAAJ |
| 2016|   228|Iu23-90AAAAJ |
| 2017|   223|Iu23-90AAAAJ |
| 2018|   267|Iu23-90AAAAJ |
| 2019|   297|Iu23-90AAAAJ |
| 2020|   305|Iu23-90AAAAJ |
| 2021|   228|Iu23-90AAAAJ |
| 2007|     7|w2McVJAAAAAJ |
| 2008|     3|w2McVJAAAAAJ |
| 2009|    14|w2McVJAAAAAJ |
| 2010|    19|w2McVJAAAAAJ |
| 2011|    19|w2McVJAAAAAJ |
| 2012|    19|w2McVJAAAAAJ |
| 2013|    51|w2McVJAAAAAJ |
| 2014|    50|w2McVJAAAAAJ |
| 2015|    76|w2McVJAAAAAJ |
| 2016|   113|w2McVJAAAAAJ |
| 2017|   138|w2McVJAAAAAJ |
| 2018|   175|w2McVJAAAAAJ |
| 2019|   229|w2McVJAAAAAJ |
| 2020|   312|w2McVJAAAAAJ |
| 2021|   220|w2McVJAAAAAJ |
| 2012|     1|ItITloQAAAAJ |
| 2013|     5|ItITloQAAAAJ |
| 2014|    12|ItITloQAAAAJ |
| 2015|    15|ItITloQAAAAJ |
| 2016|    38|ItITloQAAAAJ |
| 2017|    38|ItITloQAAAAJ |
| 2018|    57|ItITloQAAAAJ |
| 2019|    71|ItITloQAAAAJ |
| 2020|    74|ItITloQAAAAJ |
| 2021|    60|ItITloQAAAAJ |
| 1999|    11|TqKrXnMAAAAJ |
| 2000|    17|TqKrXnMAAAAJ |
| 2001|    28|TqKrXnMAAAAJ |
| 2002|    33|TqKrXnMAAAAJ |
| 2003|    44|TqKrXnMAAAAJ |
| 2004|    41|TqKrXnMAAAAJ |
| 2005|    61|TqKrXnMAAAAJ |
| 2006|    64|TqKrXnMAAAAJ |
| 2007|    83|TqKrXnMAAAAJ |
| 2008|   109|TqKrXnMAAAAJ |
| 2009|   102|TqKrXnMAAAAJ |
| 2010|   148|TqKrXnMAAAAJ |
| 2011|   196|TqKrXnMAAAAJ |
| 2012|   129|TqKrXnMAAAAJ |
| 2013|   222|TqKrXnMAAAAJ |
| 2014|   236|TqKrXnMAAAAJ |
| 2015|   251|TqKrXnMAAAAJ |
| 2016|   305|TqKrXnMAAAAJ |
| 2017|   301|TqKrXnMAAAAJ |
| 2018|   295|TqKrXnMAAAAJ |
| 2019|   308|TqKrXnMAAAAJ |
| 2020|   299|TqKrXnMAAAAJ |
| 2021|   259|TqKrXnMAAAAJ |
| 2017|     1|bDPtkIoAAAAJ |
| 2018|     4|bDPtkIoAAAAJ |
| 2019|     8|bDPtkIoAAAAJ |
| 2020|    13|bDPtkIoAAAAJ |
| 2021|    10|bDPtkIoAAAAJ |
| 2003|    12|p3IwtT4AAAAJ |
| 2004|    26|p3IwtT4AAAAJ |
| 2005|    35|p3IwtT4AAAAJ |
| 2006|    39|p3IwtT4AAAAJ |
| 2007|    76|p3IwtT4AAAAJ |
| 2008|    54|p3IwtT4AAAAJ |
| 2009|    78|p3IwtT4AAAAJ |
| 2010|    75|p3IwtT4AAAAJ |
| 2011|    81|p3IwtT4AAAAJ |
| 2012|    92|p3IwtT4AAAAJ |
| 2013|    74|p3IwtT4AAAAJ |
| 2014|    87|p3IwtT4AAAAJ |
| 2015|    75|p3IwtT4AAAAJ |
| 2016|    85|p3IwtT4AAAAJ |
| 2017|    62|p3IwtT4AAAAJ |
| 2018|    73|p3IwtT4AAAAJ |
| 2019|    65|p3IwtT4AAAAJ |
| 2020|    70|p3IwtT4AAAAJ |
| 2021|    49|p3IwtT4AAAAJ |
| 2005|    17|_ukytQYAAAAJ |
| 2006|    19|_ukytQYAAAAJ |
| 2007|    34|_ukytQYAAAAJ |
| 2008|    73|_ukytQYAAAAJ |
| 2009|    56|_ukytQYAAAAJ |
| 2010|    82|_ukytQYAAAAJ |
| 2011|    40|_ukytQYAAAAJ |
| 2012|    59|_ukytQYAAAAJ |
| 2013|    60|_ukytQYAAAAJ |
| 2014|    87|_ukytQYAAAAJ |
| 2015|    73|_ukytQYAAAAJ |
| 2016|    89|_ukytQYAAAAJ |
| 2017|   314|_ukytQYAAAAJ |
| 2018|   750|_ukytQYAAAAJ |
| 2019|   922|_ukytQYAAAAJ |
| 2020|  1100|_ukytQYAAAAJ |
| 2021|  1461|_ukytQYAAAAJ |
| 2017|     4|VCTvbTkAAAAJ |
| 2018|     4|VCTvbTkAAAAJ |
| 2019|     7|VCTvbTkAAAAJ |
| 2020|     5|VCTvbTkAAAAJ |
| 2021|    12|VCTvbTkAAAAJ |
| 2019|    10|tFaMPOQAAAAJ |
| 2020|    29|tFaMPOQAAAAJ |
| 2021|    31|tFaMPOQAAAAJ |
| 2016|     4|z6iMs-UAAAAJ |
| 2017|     9|z6iMs-UAAAAJ |
| 2018|     6|z6iMs-UAAAAJ |
| 2019|     6|z6iMs-UAAAAJ |
| 2020|     6|z6iMs-UAAAAJ |
| 2021|     3|z6iMs-UAAAAJ |
| 2010|     6|lkVq32sAAAAJ |
| 2011|     3|lkVq32sAAAAJ |
| 2012|    12|lkVq32sAAAAJ |
| 2013|     8|lkVq32sAAAAJ |
| 2014|    27|lkVq32sAAAAJ |
| 2015|    10|lkVq32sAAAAJ |
| 2016|    15|lkVq32sAAAAJ |
| 2017|    11|lkVq32sAAAAJ |
| 2018|    13|lkVq32sAAAAJ |
| 2019|    33|lkVq32sAAAAJ |
| 2020|    39|lkVq32sAAAAJ |
| 2021|    17|lkVq32sAAAAJ |
| 2013|     1|iR4UIwwAAAAJ |
| 2014|     1|iR4UIwwAAAAJ |
| 2015|     2|iR4UIwwAAAAJ |
| 2016|     4|iR4UIwwAAAAJ |
| 2017|     4|iR4UIwwAAAAJ |
| 2018|     3|iR4UIwwAAAAJ |
| 2019|     3|iR4UIwwAAAAJ |
| 2020|     6|iR4UIwwAAAAJ |
| 2021|     7|iR4UIwwAAAAJ |
| 2019|     1|gs0li6MAAAAJ |
| 2020|     0|gs0li6MAAAAJ |
| 2021|     2|gs0li6MAAAAJ |
| 2017|     3|KfLALRIAAAAJ |
| 2018|     4|KfLALRIAAAAJ |
| 2019|    10|KfLALRIAAAAJ |
| 2020|    11|KfLALRIAAAAJ |
| 2021|    11|KfLALRIAAAAJ |




<!---should you not explain somewhere that in google scholar you have to add you coauthors manually---> 
<!---why only 10? And which 10. should you not ... --->
<!---I think this goes wrong, you end up looking for some coauthors multiple times. A clumsy way to clean would be to select only first 10 appearences of name in first column. But much better to check during collection. see if authors are already in a unique author vector and if so skip. ---> 

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
scroll_box(knitr::kable(soc_df_collabs, booktabs = TRUE) , height="300px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> author </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> coauthors </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> gs_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> ...2 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...3 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...4 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...5 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Tanturri Maria Letizia </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...6 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...7 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...8 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...9 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...10 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Katya Ivanova </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...11 </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Laura Den Dulk </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...12 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Hans-Peter Blossfeld </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...13 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Nicola Barban </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...14 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Felix Tropf </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...15 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Harold Snieder </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...16 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Nicoletta Balbo </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...17 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...18 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Tanturri Maria Letizia </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...19 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...20 </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> Francesco C. Billari </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...21 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Melinda C. Mills </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...22 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Rafael Wittek </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...23 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...24 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Andreas Baierl </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...25 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Lea Ellwardt </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...26 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...27 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Lindsay Richards </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...28 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Alexi Gugushvili </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...29 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Aleksi Karhula </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...30 </td>
   <td style="text-align:left;"> Patrick Präg </td>
   <td style="text-align:left;"> Kieron Barclay </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...31 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Arnstein Aassve </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...32 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Tanturri Maria Letizia </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...33 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Daniele Vignoli </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...34 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Stefano Mazzuco </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...35 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Ariane Pailhé </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...36 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Anne Solaz </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...37 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Marco Le Moglie </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...38 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Dominique Anxo </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...39 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Gianni Betti </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...40 </td>
   <td style="text-align:left;"> Letizia Mencarini </td>
   <td style="text-align:left;"> Giulia Fuochi </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...41 </td>
   <td style="text-align:left;"> Tanturri Maria Letizia </td>
   <td style="text-align:left;"> Chiara Seghieri </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...42 </td>
   <td style="text-align:left;"> Tanturri Maria Letizia </td>
   <td style="text-align:left;"> Cheti Nicoletti </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...43 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Donald Treiman </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...44 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...45 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...46 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...47 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Ineke Nagel </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...48 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...49 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...50 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...51 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...52 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...53 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...54 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Nikki Van Gerwen </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...55 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Jelle Lössbroek </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...56 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Zoltán Lippényi </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...57 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...58 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Marie Evertsson </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...59 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...60 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...61 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Anne Roeters </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...62 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Laura Den Dulk </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...63 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Yvonne Kops </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...64 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...65 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...66 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Jan Skopek </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...67 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Tally Katz-Gerro </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...69 </td>
   <td style="text-align:left;"> Lonneke Van Den Berg </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...70 </td>
   <td style="text-align:left;"> Lonneke Van Den Berg </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...71 </td>
   <td style="text-align:left;"> Lonneke Van Den Berg </td>
   <td style="text-align:left;"> Ruben Van Gaalen </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...72 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Jan Skopek </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...73 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Marcel Raab </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...74 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...75 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Sebastian Pink </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...76 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Clemens Lechner </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...77 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Liliya Leopold </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...78 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Thijs Bol </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...79 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Hans-Peter Blossfeld </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...80 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Florian Schulz </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...81 </td>
   <td style="text-align:left;"> Thomas Leopold </td>
   <td style="text-align:left;"> Dragana Stojmenovska </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...82 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...83 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Kène Henkens </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...84 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...85 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...86 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Aart C. Liefbroer </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...87 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Wilfred Uunk </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...88 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...89 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Marleen Damman </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...90 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...91 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Katya Ivanova </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...92 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...93 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...94 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...95 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...96 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Muja Ardita </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...97 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...98 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...99 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...100 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...101 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Anete Butkēviča </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...102 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Ineke Maas </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...103 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...104 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...105 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...106 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...107 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Borja Martinovic </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...108 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...109 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Jan O. Jonsson </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...110 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Frank Kalter </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...111 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...112 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...113 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...114 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...115 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...116 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...117 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...118 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...119 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...120 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...121 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...122 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...123 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...124 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...125 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...126 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...127 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...128 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...129 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...130 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...131 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...132 </td>
   <td style="text-align:left;"> Muja Ardita </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...133 </td>
   <td style="text-align:left;"> Muja Ardita </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...134 </td>
   <td style="text-align:left;"> Muja Ardita </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...135 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Wim Bernasco </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...136 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...137 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...138 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...139 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...140 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Shane D Johnson </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...141 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Daniel Birks </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...142 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Michael Townsley </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...143 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Marieke Van De Rakt </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...144 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...145 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Yvonne Kops </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...146 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...147 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...148 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Jan Skopek </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...149 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Tally Katz-Gerro </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...150 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Benschop, Y </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...151 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> M Thunnissen </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...152 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Charlotte Holgersson </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...153 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Laura Berger </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...154 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Joke Leenders </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...155 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Jennifer Anne De Vries </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...156 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Inge Bleijenbergh </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...157 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Professor Elisabeth Kelan </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...158 </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> Patrizia Zanoni </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...159 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...160 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...161 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...162 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...163 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...164 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...165 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...166 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...167 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...168 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...170 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...171 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...172 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...173 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...174 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Philip Hans Franses </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...175 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...176 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...177 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...178 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Sophie Bolt </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...179 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Dr. Ing. Peter O. Gerrits, Senior Anatom... </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...180 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...181 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...182 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...183 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...184 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...185 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...186 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...187 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...188 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...189 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...190 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...191 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...192 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...193 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rense Nieuwenhuis </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...194 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...195 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...196 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Alexander W. Schmidt-Catran </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...197 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...198 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rik Linssen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...199 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...200 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...201 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> I. Van Der Weijden </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...202 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Mike Dent </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...203 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Ewan Ferlie </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...204 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Professor Rune Todnem By </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...205 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Geert Driessen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...206 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Rosemary Deem </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...207 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> M Thunnissen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...208 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Peter Sleegers </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...209 </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> Jeroen Huisman </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...210 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...211 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Machteld Ouwens </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...212 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Ausiàs Cebolla </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...213 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> J.m.a.m. Janssens </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...214 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...215 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Rosa Banos </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...216 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Hanna Konttinen </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...217 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Juan Ramón Barrada </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...218 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Marieke W. Verheijden </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...219 </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> Judith Homberg </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...220 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...221 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...222 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Paul Ketelaar </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...223 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...224 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Rense Nieuwenhuis </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...225 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...226 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...227 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Esther Rozendaal </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...228 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Gabi Schaap </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...229 </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> Alexander W. Schmidt-Catran </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...230 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Scholte Rhj </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...231 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Ad A Vermulst </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...232 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Roy Otten </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...233 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Wim Meeus </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...234 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Regina Van Den Eijnden </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...235 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Marloes Kleinjan </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...236 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Geertjan Overbeek </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...237 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...238 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Isabela Granic </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...239 </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> Emmanuel Kuntsche </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...240 </td>
   <td style="text-align:left;"> Dr. Ing. Peter O. Gerrits, Senior Anatomist </td>
   <td style="text-align:left;"> Richard W Horobin </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...241 </td>
   <td style="text-align:left;"> Dr. Ing. Peter O. Gerrits, Senior Anatomist </td>
   <td style="text-align:left;"> Sophie Bolt </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...242 </td>
   <td style="text-align:left;"> Dr. Ing. Peter O. Gerrits, Senior Anatomist </td>
   <td style="text-align:left;"> Van Der Want </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...243 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...244 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...245 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...246 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...247 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...248 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...249 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...250 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...251 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...252 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...253 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...254 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...255 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...256 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...257 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...258 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...259 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...260 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...261 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...262 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...263 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...264 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...265 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...266 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...267 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...268 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...269 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...270 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...271 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...272 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...273 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Paul Dekker </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...274 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...275 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Wouter Van Der Brug </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...276 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...277 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...278 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Erika Van Elsas </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...279 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...280 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...281 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Eefje Steenvoorden </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...282 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Armen Hakhverdian </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...283 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...284 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...285 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...286 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...287 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...288 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...289 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marijn Scholte </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...290 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Anette Eva Fasang </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...291 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Jasper Van Houten </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...292 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...293 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...294 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...295 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...296 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...297 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Dietlind Stolle </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...298 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...299 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...300 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...301 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...302 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...303 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...304 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...305 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...306 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...307 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...308 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...309 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Victor Bekkers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...310 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Lars Tummers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...311 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> J. Edelenbos </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...312 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Peter Leisink </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...313 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Erik Hans Klijn </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...314 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Ben S. Kuipers </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...315 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Kea Gartje Tijdens </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...316 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...317 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Mirko Noordegraaf </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...318 </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Sandra Groeneveld </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...320 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...321 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...322 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...323 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...324 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...325 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...326 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...327 </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...328 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...329 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...330 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...331 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...332 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...333 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...334 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...335 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...336 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...337 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...338 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...339 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...340 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...341 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...342 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...343 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...344 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...345 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...346 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...347 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...348 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Yvonne Kops </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...349 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...350 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...351 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Jan Skopek </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...352 </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Tally Katz-Gerro </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...353 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Anne Mcdaniel </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...354 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Emily Hannum </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...355 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Hyunjoon Park </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...356 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Dennis J. Condron </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...357 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Vincent J. Roscigno </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...358 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Ben Dalton </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...359 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Emilio A. Parrado </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...360 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Elizabeth Stearns </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...361 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...362 </td>
   <td style="text-align:left;"> Claudia Buchmann </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...363 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...364 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Nikki Van Gerwen </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...365 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Jelle Lössbroek </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...366 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Zoltán Lippényi </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...367 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...368 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Marie Evertsson </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...369 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...370 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...371 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Anne Roeters </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...372 </td>
   <td style="text-align:left;"> Leonie Van Breeschoten </td>
   <td style="text-align:left;"> Laura Den Dulk </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...373 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Sebastian Bergold </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...374 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Tobias Richter </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...375 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Olga Kunina-Habenicht </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...376 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Elmar Souvignier </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...377 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Linda Wirthwein </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...378 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Silke Hertel </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...379 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Andrei Cimpian </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...380 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Jörn R. Sparfeldt </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...381 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Martin Brunner </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...382 </td>
   <td style="text-align:left;"> Anke Heyder </td>
   <td style="text-align:left;"> Anna Südkamp </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...383 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Jannick Demanet </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...384 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Dimitri Van Maele </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...385 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Stevens Peter A. J. </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...386 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Simon Boone </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...387 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Lore Van Praag </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...388 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Jo Tondeur </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...389 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Ann Buysse </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...390 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Martin Valcke </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...391 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Pb Forsyth </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...392 </td>
   <td style="text-align:left;"> Mieke Van Houtte </td>
   <td style="text-align:left;"> Paul Enzlin </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...394 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...395 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...396 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...397 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Sebastian Munoz-Najar Galvez </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...398 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Bryan He </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...399 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...400 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...401 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...402 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Niek C. De Schipper </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...403 </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...404 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...405 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Amber Ronteltap </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...406 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Maarten Ter Huurne </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...407 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...408 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Lukas Norbutas </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...409 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...410 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Michał Bojanowski </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...411 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Karen Cook </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...412 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...413 </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Wojtek Przepiorka </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...414 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Ineke Maas </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...415 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...416 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...417 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...418 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...419 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Borja Martinovic </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...420 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...421 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Jan O. Jonsson </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...422 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Frank Kalter </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...423 </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...424 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...425 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Reuben J Thomas </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...426 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Christopher D Manning </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...427 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> James Moody </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...428 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Linus Dahlander </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...429 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Daniel Ramage </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...430 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> David Diehl </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...431 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Jure Leskovec </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...432 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Craig M. Rawlings </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...433 </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Xiaolin Shi </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...434 </td>
   <td style="text-align:left;"> Sebastian Munoz-Najar Galvez </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...435 </td>
   <td style="text-align:left;"> Sebastian Munoz-Najar Galvez </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...436 </td>
   <td style="text-align:left;"> Sebastian Munoz-Najar Galvez </td>
   <td style="text-align:left;"> Raphael H. Heiberger </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...437 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Christopher D Manning </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...438 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> James H. Martin </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...439 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Jiwei Li </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...440 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Andrew Ng </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...441 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Jure Leskovec </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...442 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Nathanael Chambers </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...443 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Rion Snow </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...444 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Kadri Hacioglu </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...445 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Daniel Gildea </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...446 </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Michelle Gregory </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...447 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Steven Skiena </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...448 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Bryan Perozzi </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...449 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> William Yang Wang </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...450 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Rami Al-Rfou </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...451 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> H. Andrew Schwartz </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...452 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Haochen Chen </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...453 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Daniel Mcfarland </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...454 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Sebastian Munoz-Najar Galvez </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...455 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...456 </td>
   <td style="text-align:left;"> Vivek Kulkarni </td>
   <td style="text-align:left;"> Dan Jurafsky </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...457 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Cliff Lampe </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...458 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Charles Steinfield </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...459 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Danah Boyd </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...460 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Jessica Vitak </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...461 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Rebecca Gray, Phd </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...462 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Donghee Yvette Wohn </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...463 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Jennifer Gibbs </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...464 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Rebecca Heino </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...465 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Jeffrey T. Hancock </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...466 </td>
   <td style="text-align:left;"> Nicole B. Ellison </td>
   <td style="text-align:left;"> Mary Madden </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...467 </td>
   <td style="text-align:left;"> Niek C. De Schipper </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...468 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Werner Raub </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...469 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Rense Corten </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...470 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Arnout Van De Rijt </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...471 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Jeroen Weesie </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...472 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Chris Snijders </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...473 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Vincenz Frey </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...474 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Davide Barrera </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...475 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Maarten Ter Huurne </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...476 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Amber Ronteltap </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...477 </td>
   <td style="text-align:left;"> Vincent Buskens </td>
   <td style="text-align:left;"> Nynke Van Miltenburg </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...478 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...479 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...480 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...481 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...482 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...483 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...484 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...485 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...486 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...487 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...488 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...489 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...490 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...491 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...492 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...493 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Geoffrey Evans </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...494 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Anthony F Heath </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...495 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...496 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Giedo Jansen </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...497 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...498 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...499 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...500 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...501 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...502 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...503 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...504 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...505 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...506 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...507 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Donald Treiman </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...508 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...509 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Kène Henkens </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...510 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...511 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...512 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Aart C. Liefbroer </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...513 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Wilfred Uunk </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...514 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...515 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Marleen Damman </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...516 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...517 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Katya Ivanova </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...518 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...519 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...520 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...521 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...522 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...523 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...524 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...525 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...526 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...527 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...528 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...529 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...530 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...531 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...532 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...533 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...534 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...535 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...536 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...537 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...538 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...539 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...540 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...541 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...542 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...543 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...544 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...545 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...546 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...547 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...548 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...549 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...550 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...551 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...552 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...553 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...554 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...555 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...556 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...557 </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...558 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...559 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...560 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...561 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...562 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...563 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...564 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...565 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...566 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...567 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...568 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...569 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...570 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...571 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...572 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...573 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...574 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...575 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...576 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...577 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...578 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...579 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Caroline Dewilde </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...580 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...581 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...582 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Peter M Kruyen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...583 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Mara A. Yerkes </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...584 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Janna Besamusca </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...585 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Fenella Fleischmann </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...586 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...587 </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> E.p.w.a. Jansen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...588 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Alan Warde </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...589 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Brian Longhurst </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...590 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Andrew Miles </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...591 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Susan Halford </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...592 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Gaynor Bagnall </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...593 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Fiona Devine </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...594 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Yaojun Li </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...595 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> David Wright </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...596 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Johs. Hjellbrekke </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...597 </td>
   <td style="text-align:left;"> Mike Savage </td>
   <td style="text-align:left;"> Sam Friedman </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...598 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...599 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...600 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...601 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...602 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...603 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...604 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...605 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...606 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...607 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...608 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...609 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...610 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...611 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...612 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...613 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...614 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...615 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...616 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...617 </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> Jellie Sierksma </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...618 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...619 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...620 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...621 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...622 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Muja Ardita </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...623 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...624 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...625 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Marieke Van Den Brink </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...626 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...627 </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Anete Butkēviča </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...628 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...629 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Verena Seibel </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...630 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...631 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Troels Fage Hedegaard </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...632 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...633 </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
   <td style="text-align:left;"> Nan Jiang </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...634 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...635 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...636 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...637 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...638 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Dietlind Stolle </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...639 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...640 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...641 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...642 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...643 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...644 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...645 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...646 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...647 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...648 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...649 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...650 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...651 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...652 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...653 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...654 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...655 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...656 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...657 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...658 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...659 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...660 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...661 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...662 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...663 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...664 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...665 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...666 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...667 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...668 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...669 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...670 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Ed Cairns </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...671 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Alberto Voci </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...672 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Richard J. Crisp </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...673 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Jared Kenworthy </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...674 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Rhiannon N. Turner </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...675 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Mark Rubin </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...676 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Hermann Swart </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...677 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Oliver Christ </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...678 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Steven Vertovec </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...679 </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Jake Harwood </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...680 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...681 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...682 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...683 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...684 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...685 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...686 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...687 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...688 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...689 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...690 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...691 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...692 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...693 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...694 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...695 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...696 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...697 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...698 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...699 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...700 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...701 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...702 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...703 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Christine Teelken </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...704 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Philip Hans Franses </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...705 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Tatjana Van Strien </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...706 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Ruben Konig </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...707 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Rutger Engels </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...708 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Sophie Bolt </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...709 </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Dr. Ing. Peter O. Gerrits, Senior Anatom... </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...710 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Ben Pelzer </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...711 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...712 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...713 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rense Nieuwenhuis </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...714 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...715 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...716 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Alexander W. Schmidt-Catran </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...717 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...718 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Rik Linssen </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...719 </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...720 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...721 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...722 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...723 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...724 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...725 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...726 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...727 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...728 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...729 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...730 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Paul Dekker </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...731 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...732 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Wouter Van Der Brug </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...733 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...734 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...735 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Erika Van Elsas </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...736 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...737 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...738 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Eefje Steenvoorden </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...739 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Armen Hakhverdian </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...740 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...741 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...742 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...743 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...744 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Dietlind Stolle </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...745 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...746 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Bart Meuleman </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...747 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Marc Swyngedouw </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...748 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Eldad Davidov </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...749 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...750 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Peter Schmidt </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...751 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Ineke Stoop </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...752 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...753 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Jan Cieciuch </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...754 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...755 </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...756 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Nele De Cuyper </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...757 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Anja Van Den Broeck </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...758 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Elfi Baillien </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...759 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Guy Notelaers </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...760 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Maarten Vansteenkiste </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...761 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Magnus Sverke </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...762 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Wilmar Schaufeli </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...763 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Katharina Näswall </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...764 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Bert Schreurs </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...765 </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...766 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Kristof Jacobs </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...767 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...768 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...769 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...770 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...771 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...772 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Mieke Verloo </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...773 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...774 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...775 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...776 </td>
   <td style="text-align:left;"> Kristof Jacobs </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...777 </td>
   <td style="text-align:left;"> Kristof Jacobs </td>
   <td style="text-align:left;"> Simon Otjes </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...778 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Donald Treiman </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...779 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...780 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...781 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...782 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Ineke Nagel </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...783 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...784 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...785 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...786 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...787 </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...788 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Anja Steinbach </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...789 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Gisela Trommsdorff </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...790 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Josef Brüderl </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...791 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Johannes Huinink </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...792 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...793 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...794 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...795 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...796 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...797 </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> Sabine Walper </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...798 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...799 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...800 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...801 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...802 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...803 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Rory Coulter </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...804 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Philipp M. Lersch </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...805 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Sergi Vidal </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...806 </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> Ann Berrington </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...807 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...808 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Ayse Gunduz Hosgor </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...809 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Hyunjoon Park </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...810 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Mieke Verloo </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...811 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...812 </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> Pieter Hooimeijer </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...813 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...814 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...815 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...816 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...817 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...818 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...819 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...820 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...821 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...822 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...823 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Wouter Van Der Brug </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...824 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Matthijs Rooduijn </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...825 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Tjitske Akkerman </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...826 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...827 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Huib Pellikaan </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...828 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Meindert Fennema </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...829 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Liza Mügge (Née Liza Nell) </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...830 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Caterina Froio </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...831 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Eelco Harteveld </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...832 </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Cas Mudde </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...833 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...834 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...835 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...836 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...837 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...838 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...839 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...840 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...841 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...842 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...843 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Paul Dekker </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...844 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...845 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Wouter Van Der Brug </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...846 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...847 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...848 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Erika Van Elsas </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...849 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...850 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...851 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Eefje Steenvoorden </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...852 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Armen Hakhverdian </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...853 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...854 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...855 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...856 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...857 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...858 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...859 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...860 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...861 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...862 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...863 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...864 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...865 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...866 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...867 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...868 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...869 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...870 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...871 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...872 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...873 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...874 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...875 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...876 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...877 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...878 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...879 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...880 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...881 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...882 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...883 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...884 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...885 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...886 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...887 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Dietlind Stolle </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...888 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Miles Hewstone </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...889 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Wim Bernasco </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...890 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...891 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...892 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...893 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...894 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Shane D Johnson </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...895 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Daniel Birks </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...896 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Michael Townsley </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...897 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Marieke Van De Rakt </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...898 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...899 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...900 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...901 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...902 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...903 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...904 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...905 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...906 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...907 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...908 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...909 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...910 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...911 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...912 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...913 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...914 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...915 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...916 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...917 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...918 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...919 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...920 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...921 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...922 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...923 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...924 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Geoffrey Evans </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...925 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Anthony F Heath </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...926 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...927 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Giedo Jansen </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...928 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...929 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...930 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...931 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...932 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...933 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...934 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...935 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...936 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...937 </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...938 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...939 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...940 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...941 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...942 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...943 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...944 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...945 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...946 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...947 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Donald Treiman </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...948 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...949 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...950 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...951 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...952 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...953 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...954 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...955 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...956 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...957 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...958 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...959 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Kène Henkens </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...960 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...961 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...962 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Aart C. Liefbroer </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...963 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Wilfred Uunk </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...964 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...965 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Marleen Damman </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...966 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...967 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Katya Ivanova </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...968 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...969 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...970 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Ineke Maas </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...971 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...972 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...973 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...974 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...975 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Tim Immerzeel </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...976 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...977 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...978 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...979 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...980 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...981 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...982 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...983 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...984 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...985 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...986 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...987 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...988 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...989 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Richard Breen </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...990 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Loek Halman </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...991 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Ruud Muffels </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...992 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Walter Müller </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...993 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Anna Manzoni </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...994 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...995 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Hans-Peter Blossfeld </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...996 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...997 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...998 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...999 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1000 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1001 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1002 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1003 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1004 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1005 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1006 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1007 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1008 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1009 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1010 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1011 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1012 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1013 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1014 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1015 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1016 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1017 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1018 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1019 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1020 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1021 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1022 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1023 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marijn Scholte </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1024 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Anette Eva Fasang </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1025 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Jasper Van Houten </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1026 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1027 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1028 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1029 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1030 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1031 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1032 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1033 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1034 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1035 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1036 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1037 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1038 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1039 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1040 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1041 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1042 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1043 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1044 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1045 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1046 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1047 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1048 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1049 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1050 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1051 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1052 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1053 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1054 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1055 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1056 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1057 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1058 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1059 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1060 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1061 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1062 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1063 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1064 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1065 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1066 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1067 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1068 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1069 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Ineke Maas </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1070 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1071 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1072 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1073 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1074 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Tim Immerzeel </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1075 </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1076 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1077 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1078 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1079 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1080 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1081 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1082 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1083 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1084 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1085 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1086 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1087 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1088 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1089 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1090 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1091 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1092 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1093 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1094 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1095 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1096 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1097 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1098 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1099 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1100 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1101 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1102 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1103 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1104 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1105 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1106 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1107 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1108 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1109 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1110 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1111 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1112 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1113 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1114 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1115 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1116 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1117 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1118 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1119 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1120 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1121 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1122 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1123 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1124 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1125 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1126 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1127 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1128 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1129 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1130 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1131 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1132 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1133 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1134 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1135 </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> Donald Treiman </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1136 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1137 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1138 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1139 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1140 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1141 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1142 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Marijn Scholte </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1143 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Anette Eva Fasang </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1144 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Jasper Van Houten </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1145 </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1146 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Juho Härkönen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1147 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1148 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1149 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Bram Lancee </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1150 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1151 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Maarten Vink </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1152 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Stéfanie André </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1153 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1154 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1155 </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1156 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1157 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1158 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Richard Breen </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1159 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Loek Halman </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1160 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Ruud Muffels </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1161 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Walter Müller </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1162 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Anna Manzoni </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1163 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1164 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Hans-Peter Blossfeld </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1165 </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
   <td style="text-align:left;"> Inge Sieben </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1166 </td>
   <td style="text-align:left;"> Carlijn Bussemakers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1167 </td>
   <td style="text-align:left;"> Carlijn Bussemakers </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1168 </td>
   <td style="text-align:left;"> Carlijn Bussemakers </td>
   <td style="text-align:left;"> Kars Van Oosterhout </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1169 </td>
   <td style="text-align:left;"> Carlijn Bussemakers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1170 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1171 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1172 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1173 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1174 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1175 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1176 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1177 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1178 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1179 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1180 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Kristof Jacobs </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1181 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1182 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1183 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1184 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1185 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1186 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Mieke Verloo </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1187 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1188 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1189 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1190 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1191 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1192 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1193 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1194 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1195 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1196 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1197 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1198 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1199 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1201 </td>
   <td style="text-align:left;"> Mustafa Inc </td>
   <td style="text-align:left;"> Fairouz Tchier </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1202 </td>
   <td style="text-align:left;"> Nella Geurts </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1203 </td>
   <td style="text-align:left;"> Nella Geurts </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1204 </td>
   <td style="text-align:left;"> Nella Geurts </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1205 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1206 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1207 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1208 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1209 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1210 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1211 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1212 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1213 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1214 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1215 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Kristof Jacobs </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1216 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1217 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Bernhard Nauck </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1218 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Lucinda Platt </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1219 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sait Bayrakdar </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1220 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Efe Kerem Sozeri </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1221 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Mieke Verloo </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1222 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Jeroen Smits </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1223 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1224 </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1225 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Francien Th. M. Van Driel </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1226 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Ruerd Ruben </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1227 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Melissa Siegel </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1228 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Hein De Haas </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1229 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Karin Willemse </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1230 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Lothar Smith </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1231 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Marianne H. Marchand </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1232 </td>
   <td style="text-align:left;"> Tine Davids </td>
   <td style="text-align:left;"> Lau Schulpen </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1236 </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Margreth Lünenborg </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1237 </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Claudia Riesmeyer </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1238 </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1239 </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Stephanie Geise </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1240 </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1241 </td>
   <td style="text-align:left;"> Margreth Lünenborg </td>
   <td style="text-align:left;"> Elfriede Fürsich </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1242 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Alessio Cornia </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1243 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Rasmus Kleis Nielsen </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1244 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Teresa Naab </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1245 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Dr. Stephan Weichert </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1246 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Felix M. Simon </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1247 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Claudia Riesmeyer </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1248 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Richard Fletcher </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1249 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1250 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1251 </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> Lucas Graves </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1252 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Pascal Jürgens </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1253 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Stefan Geiss </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1254 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Joerg Hassler </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1255 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Uta Russmann </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1256 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Olaf Jandura </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1257 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Marcus Maurer </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1258 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Peter Maurer </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1259 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Annika Sehl </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1260 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Claudia Riesmeyer </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1261 </td>
   <td style="text-align:left;"> Melanie Magin </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1262 </td>
   <td style="text-align:left;"> Klara Raiber </td>
   <td style="text-align:left;"> Dorothée Behr </td>
   <td style="text-align:left;"> xE65HUcAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1263 </td>
   <td style="text-align:left;"> Klara Raiber </td>
   <td style="text-align:left;"> Lydia Repke </td>
   <td style="text-align:left;"> xE65HUcAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1264 </td>
   <td style="text-align:left;"> Lydia Repke </td>
   <td style="text-align:left;"> Veronica Benet-Martinez </td>
   <td style="text-align:left;"> xE65HUcAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1267 </td>
   <td style="text-align:left;"> Jansje Van Middendorp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1268 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1269 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1270 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1271 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1272 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1273 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1274 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1275 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1276 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ...1277 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
</tbody>
</table></div>

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






