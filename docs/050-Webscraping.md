# (PART) Webscraping  {-} 

<!--- put the dataframes in a kable and then use a scrollbox. you can also have captions. works best. see last part of script ---> 

# Webscraping for Social Scientists {#webintro}

<!---I think I have run into the rate limit. to be able to build the book, I have set eval=FALSE globally--->




## Chapter overview
<p class= "quote">
"[The] technological revolution in mobile, Web, and Internet communications has the potential to revolutionize our understanding of ourselves and how we interact. Merton was right: Social science has still not found its Kepler. But three hundred years after Alexander Pope argued that the proper study of mankind should lie not in the heavens but in ourselves, we have finally found our telescope. Let the revolution begin..." [@watts2011everything: 266]
</p>

Watts' already-famous quote predicts a revolution in the social sciences. He and others [see also @lazer2009social] essentially argue that social science will be revolutionized by the unprecedented use of of the social internet. Given that people overwhelmingly adopted internet technologies and given that many of the platforms that offer these technologies automatically archive all kinds of behavior [@spiro2016research] such as clicks, messages, social media relationships, and so forth, there may be a treasure trove of data on the internet that social scientists can use for their research on social processes. In this chapter, we discuss some of the promises and pitfalls of webscraping so-called "digital trace" data [@golder2014digital] on the internet for social network analysis. We are then going to discuss some different techniques that are often used for webscraping. Note that the fast-pace nature of the internet inherently means that by the time you read this text, some of the things we discuss will be outdated. (Which can be argued to be one of the pitfalls of social science research with webscraping!) We are also getting our hands dirty with a hands-on example of digital trace data that we are going to collect ourselves. So by the end of this chapter, you will be familiar with some of the unique opportunities and difficulties of webscraped (social network) data, have a birds-eye perspective on the different techniques for scraping the web for your own research, have knowledge on the ethics surrounding webscraping, and have more in-depth experience on one specific package for webscraping bibliometric data in `R`. In short, you will have firsthand knowledge on the current state-of-the-art in sociological data collection. There are really good, exhaustive resources for webscraping and computational sociology. See, for instance, the book by Robert Ackland [@ackland2013web]. Yet, to get up to speed for this chapter, you can read the first chapter of Bas Hofstra's dissertation [@hofstra2017online], Golder and Macy's Annual Review of Sociology article [@golder2014digital], and Lazer and colleagues' Science article [@lazer2009social]. A very nice introduction to the field of computational social science can be found in Salganik's text book [@salganik2019bit]. An overview with recent applications is written by Edelman and colleagues [@edelmann2020computational].

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

One of the key advantages of scraping data from the internet is that it is relatively easy to collect sociologically interesting network data. This may sound like a surprising thing to note in a book on social network analyses. But imagine a world without the internet, and then imagine that you are a social scientist interested in *weak tie* dynamics. What toolset do you have available to collect data on and then study those weak ties? You would probably think about qualitative interviews or collecting survey data. For the purpose of studying weak ties, however, both of these methods of data collection suffer from some some weaknesses. For instance, it is incredibly hard for respondents to recall those social ties that are weakly related. So asking about weak ties will likely not yield very reliable and valid results if you not somehow account for that. That is, respondents will mostly acquiesce to naming those ties that they met recently or which are relatively stronger. (There are some techniques to circumvent some of these issues, but those have their own drawbacks too [see @hofstra2021beyond]. And those techniques are suited mostly to ego networks and not full social networks.) Many surveys are also restricted, in that respondents can only name five social ties. It is possible to collect sociometric data of entire contexts in surveys, for instance by presenting respondents with a class-roster or department-roster and asking them who their trustees, friends, etc. This book even devotes an entire section to such data. Yet, such a design is pretty expensive to set up -- i.e., you may be limited to a fixed set of network contexts -- and may be quite taxing to respondents.

In contrast, an inherent feature of many places on the social internet is that individuals curate themselves who their connections are over a long time-span (e.g., friendships on Facebook) or leave many traces of interactions (e.g., mentioning someone on Twitter). Sometimes networks online are even pushed towards (triadic) network closure by recommendation systems on platforms like Facebook or Instagram. With some creativity on the scientists' part, such data are relatively easy and cheap to collect. This may often lead to large and complete networks that are not restricted by relationship type (e.g., strong or weak), social context (e.g., family or school friends), respondent recall (acquiesce to strong ties), or social desirability bias (e.g., only nominating the popular kid in a class). An exemplary paper that circumvents some of the "regular" biases of social network research mentioned above is @hofstra2017sources or @wimmer2010beyond who analyze segregation among weak ties by means of Facebook data. The benefits mentioned here for the analyses of social networks are also prime reasons as to why much research using digital traces incorporates some type of social network analysis.

##### **Dynamics** {-}  

A second advantage of digital trace data is that these data are often *time-stamped* (and sometimes geo-stamped). This means that the the researcher knows exactly when (and where) the digital trace -- e.g., the social interaction on Twitter -- occurred. So the researcher can potentially perform some sort of longitudinal analyses so as to come closer to causal estimates in inferential statistical models. In the context of webscraped social networks this is particularly useful so as to separate selection from influence in larger social networks. Gathering such longitudinal sociometric data for many social foci (e.g., school classes) is difficult (yet, definitely not impossible!), whereas collecting time-stamped social interactions on the internet may be somewhat easier. Note also that social network data collected in, for instance, school classes often puts the same time-stamp on a given network (e.g., the time that class was surveyed), whereas networks online may contain more-detailed time-stamps. These time-stamped (network) data can in some cases be considered relational events [@butts2008relational].

##### **Signals** {-}  

A third advantage of webscraped data is that it can potentially capture behavioral and/or attitudinal signals that are otherwise hard to come by. Say you want to know about social network dynamics among drug traders. Those drug traders probably won't indicate in a survey that they are engaged in such illicit activities. Scraping data from the so-called "dark web" may be one of the only ways to study networks among drug traders [see @norbutas2018offline who does just that] apart from stitching together police reports which are likely to be confidential. Furthermore, survey respondents may be a bit hesitant to write about their own attitudes that are perceived to be socially undesirable (like severe ethnic prejudice). In that case, one may collect digital trace data on Twitter, where you can observe and then operationalize ethnic prejudice happening in real time. Not all online behaviors and/or attitudes are accurate proxies for offline attitudes/behavior of interest and are very particular to online settings. Therefore, the researcher must be aware, theorize, and ideally empirically show where and how their online data proxies their behavior-of-interest offline.

##### **Size** {-}  

Finally, and we discuss why this is both a blessing and a curse (see below), webscraping can lead to data that can contain a lot of observations (into the many millions!) or variables. Note that this is in and of itself not an advantage. More data are not always better data if they are biased. Yet, the sheer size of webscraped data -- under appropriate sampling! -- may make it easier to observe relationships between the variables of interest when they are small in magnitude. Such small effects may in smaller samples be swamped by random variability [cf. @golder2014digital: 132] This does not mean one can go look into their big dataset for random relationships between variables, these relationships should be problematized and theorized first (just like any other problem-driven, hypothesis-testing social science study). 

### Pitfalls

##### **Sampling** {-}

Scientists using digital trace data should think carefully about their target population vis-a-vis their sampling frame and realized sample. This is something that is not unique to digital trace data. Yet, it is easy to be so impressed by the sheer data size in studies using digital trace data that questions about generalizability of results sometimes tend to get overshadowed. That is not to say that it doesn't tell us anything informative, just that we do not necessarily know to what target population such results generalize. All types of selectivity can crawl into the data. For instance, if you want to study Facebook/Instagram/TikTok, you should be aware that such platforms tend to get disproportionately populated by certain demographics. If among 5 million Twitter users those in geographical region *a* display some behavior *y* more so than those in region *b*, it does not necessarily mean that regions *a* and *b* differ in *y*. It may be that Twitter is perceived to be a particularly good platform in *a* to display *y*, whereas in *b* people are indifferent to display *y* on Twitter or elsewhere. Selection into Twitter thus plays an important role in this example. This may happen for many digital trace data sources: biased selection into certain platforms, biased selection into privacy settings which can obscure what you can observe, biased selection into what people display online, and so forth. Ideally, you would have some anchor data set from which you know that it generalizes to a given target population and link that to some source of digital trace data. On the other end, one could attempt to study an entire *population* such that you are pretty certain that you can generalize your results to that population. 

##### **Size** {-}

Like we described above, data size is an advantage of digital trace data, yet simultaneously it is also a pitfall. Huge numbers of observations (again, into the many if not hundreds of millions) may be pretty difficult to manipulate and analyze. In some cases, the data become so large that it is necessary to move to computing clusters because your laptop's memory cannot handle it anymore. Dependent on what type of data you analyze you thus might need to adjust your data workflow. Not many educational programs prepare students for storing, manipulating, and analyzing large data sets, and this requires slightly different programming/statistical skills than what we're used to. It may be a solution to sample from these huge data sets, such that you, say, only analyze a random sample of 5%. Yet, sampling from social networks is especially hard because of the interdependent nature of networks; some of the inherently clustered structure of networks is lost when you only draw a subset of agents from the network.
<!--- do I say this last thing right? --->

##### **Data structure** {-}

This point relates to the point above. Webscraped digital trace data is usually structured very differently compared to the "flat" data files social scientists are used to working with. Usually, we open a dataset with columns (variables) and rows (observations). Webscraped data is usually stored in nested structured such as XML or JSON or contains text data. Therefore, additional manipulation is needed before we arrive at the data formats that standard statistical packages can read/analyze. Sometimes the networks-of-interest are stored in text data, for instance if you're interested in letter-writing relationships. Hence, if you want to manipulate and analyze these data at scale, some form of programming becomes nearly unavoidable. (Luckily, we provide hands-on tools and examples in this book!)

##### **Unobserved variables** {-}

Finally, webscraped digital trace data often do not contain the detailed demographic information that surveys (often) do provide. And this information often contains the key (control) variables in social science analyses. Imagine you scraped all customer reviews on the Etsy website because you want study how women and men reviewers judge the products of women and men creators differently. That is an important research question because it may show how gender dynamics in reviewing may (re)produce inequality between women and men creators. Yet, how do we know which reviewers are women or men? These labels do not come with the scraped data and some additional manipulation is needed. You could, for instance, attempt to predict whether a reviewer is a women or men by their first name. This is because first names are signals that relate strongly to gender. Yet, not every reviewer provides their first name but only a rather uninformative screenname. Furthermore, naming habits also vary between countries and the data do not inform you from which countries these reviewers originate. And what about age? What about income? Hence, there could be many factors related to the outcome you intend to study that are not readily available in digital trace data. This again requires some creativity on the researchers side, for instance by matching survey data with digital trace data, enrich data with other data sources, and so forth.

## Where does this lead us?

So if we sum up what we have learned thus far, what are the overarching benefits of webscraped digital trace data compared to more-traditional data sources? We can think of at least three of those:
* (1) New tests of old social science hypotheses made possible by the availability of digital footprint data;
* (2) Tests of newly derived social science hypotheses made possible by the availability of digital footprint data;
* (3) Tests of new theories about "the internet" as social phenomenon by itself.

Note that these three points are not mutually exclusive: a newly derived social science hypothesis might just as well be about the internet as social phenomenon by itself. Yet, for analytic purposes it is convenient to list these three as separate. An interesting example related to point (1) is the question whether social networks are "small-worlds" -- i.e., highly clustered yet having a short average path length. A popular adage derives from this feature of social networks: individuals are all separated by approximately six degrees. This was traditionally studied by considering letter chains. Now one could study this with the entire Facebook network, and so one could actually test this hypothesis at much larger and complete scale than before (see XXX). With respect to point (2): you could derive new hypotheses about the conversational nature of massive collaborative projects by scraping and then studying all Wikipedia edits (something that was hard to study before). More recently, a lot of studies emerged on the role of fake news and echo chambers with respect to individual attitudes and polarization, which relates to point (3): how the internet as social phenomenon by itself can influence behavior/attitudes. The strongest computational social science papers leverage the strengths of digital trace data but simultaneously account for (or at the very least acknowledge) some of its weaknesses as we list above.
<!--- nice assignment to let students find studies and let them find weaknesses/strengths compared to what we write above --->


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

Now that we learned about computational social science, webscraped digital trace data, and some of its techniques, it is time to get our hands dirty ourselves. In what follows is a short tutorial on webscraping where we will be collecting data from webpages on the internet. We will use the specific use-case of sociology staff at Radboud University. What do they publish? Where? And with whom do they collaborate? We assume you followed the R tutorial in this book, or that you otherwise have at least some experience with coding in R. In the rest of this tutorial, we will switch between base R and Tidyverse (just a bit), whatever is most convenient. (Note that this will happen sometimes if you become an applied computational sociologist.)

What are we are going to scrape specifically? This is a social network book so we're obviously going to scrape social networks. Specifically, the social network of co-authors on the scientific papers of Radboud University's Department of Sociology Staff. Co-authors on a paper are the set of scholars who publish a scientific paper together in a journal. Who do sociology staff publish with? And are those co-authors connected with one another too? Are these social networks clustered in some way? To get at such data we need several things: a list of RU's sociology staff, a repository with their publication,s and the meta-information (titles, authors, etc.) of those publications. Substantively, this is key to look at things like how often scholars are cited or how social network dynamics in science work. (Not there is a whole body of research on the so-called "Sociology of Science" or the "Science of Science". Because scientists are particularly good at documenting things, sociology/science of science type-of-work is some of the earliest work that you can label computational social science.)

In the remainder of this chapter, we thus provide a tutorial in which we explain the packages needed to do what we write above. We will shortly describe the `scholar` and other packages in R, the data sources, and the (network) data structures you encounter and how to deal with them. Yet, there are many ways code-wise or data-wise with which you use to do very similar things like we do in this tutorial.

### Staging your script

* Open a new R-script (via file --\> new --\> RScript (or simply hit *Ctrl+Shift+N* or *Cmd+Shift+N* if you work on Mac)
* Before you start scraping and analyzing, take all the precautionary steps noted in \@ref(tutorial)

So for this tutorial, your starting script will look something like this:


```r
######################################### Title: Webscraping in R Author: Bas Hofstra Version:
######################################### 29-07-2021

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
# Note we're doing something different here. We're installing a *latest* version directly from
# GitHub This is because the released version of this packages contains some errors!
devtools::install_github("jkeirstead/scholar")

require(scholar)

# define workdirectory, note the double backslashes if you're on windows setwd('/yourpathhere)'
```

### Getting "anchor" data

A first step is to get the "anchor" data. The anchor data are the first data we scrape with which we then link to further data sources. Our goal is to get to know (i) who the Radboud University Department of Sociology staff is, (ii) what they publish with respect to scientific work, and (iii) who they collaborate with. So that means at least three data sources we need to collect from somewhere. What would be a nice starting (read: anchor) point be? First, we have to know who is on the sociology staff. Let's check out [the Radboud sociology website](https://www.ru.nl/sociology/). There is lots of intriguing information, but not on who is who. There is, however, a specific link to the [research staff](https://www.ru.nl/sociology/research/staff/). Here we do see a nice list on who is on the sociology staff! How do we get that data? It is actually quite simple, the package `xml2` has a very nice function `html_read()` which simply extracts the source html of a webpage:



```r
# Let's first get the staff page read_html is a function that simply extracts html webpages and
# puts them in xml format
soc_staff <- read_html("https://www.ru.nl/sociology/research/staff/")
```


```r
head(soc_staff)
```

```
#> $node
#> <pointer: 0x00000000272dee00>
#> 
#> $doc
#> <pointer: 0x00000000106beae0>
```

That looks kinda weird. What type of object did we store it by putting the html into `soc_staff`?

```r
class(soc_staff)
```

```
#> [1] "xml_document" "xml_node"
```

So it is is stored in something that R calls an XML object. Remember when we talked about that in the text above? Extensible Markup Language, XML, is a nested data structure where in each next sublayer of that structure new information is stored. Not important for now what that means specifically. But it is important to extract the relevant table that we saw on the sociology staff website. How do we do that? Go to the [https://www.ru.nl/sociology/research/staff/]("googlechromes://www.ru.nl/sociology/research/staff/") in Google Chrome and then press "Inspect" on the webpage (right click--\>Inspect). You should see something like the screenshot below, right?

<div class="figure">
<img src="inspect.PNG" alt="Inspect element" width="100%" />
<p class="caption">(\#fig:inspect)Inspect element</p>
</div>

Look at the screenshot below, you should be able to see something like this. In the html code we extracted from the Radboud website, we need to go to one of the nodes first. If you move your cursor over "body" in the html code on the right-hand side of your screen, the entire "body" of the page should become some shade of blue. This means that the elements encapsulated in the "body" node captures everything that turned blue. This is essentially the nested data structure we mentioned above.

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
# 'view page source' and you see that everything AFTER /td in the 'body' of the page seems to be
# the table we do need
soc_staff <- soc_staff %>%
    rvest::html_nodes("body") %>%
    xml2::xml_find_all("//td") %>%
    rvest::html_text()
```



> Question: What happens in the code above? Why do we specify search for 'body' and '//td'? 

Let us check out what happened to the soc_staff object now:




```r
soc_staff  # looks much better!!
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-6)Sociology staff</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> x </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Staff: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Methods of research and statistics </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Poverty en social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sports and policy sociology </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Culture and nationalism </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Health, family and work </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PhD: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Integration and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hendriks, I.P. (Inge) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Resistance to refugees and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Linders, N. (Nik) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Populism, gender, masculinity and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Meijeren, M. (Maikel) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Social capital, volunteer work and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wiertsema, S. (Sara) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Inequality in sports and physical activity, school-to-work transition and employment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> External PhD: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Betkó, drs. J.G. (János) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Social assistance benefit, poverty, reintegration, RCT and social experiment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Home administration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vis, E. (Elize) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Healthcare, labour market, healthcare professions and training, health and social capital </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Guest researchers: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sterkens, dr. C.J.A. (Carl) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Religious conflicts, cohesion, religion and the philosophy of life </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vermeer, dr. P.A.D.M. (Paul) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Socialization processes, secularisation, religion and the philosophy of life </td>
  </tr>
</tbody>
</table></div>

So it looks much nicer but does not seem to be in the entirely correct order. We have odd rows and even rows: odd rows are names, even rows have the expertise of staff. We need to get a bit creative to put the data in a nicer format. The `%%` operator gives a "remainder" of integers (whole numbers). So 10/2=5 with no remainder, but 11/2=5 with a remainder of 1. This means that we can derive odd or even with a function with that operator. Remember functions from \@ref(tutorial)?

```r
fodd <- function(x) x%%2 != 0
feven <- function(x) x%%2 == 0
```

> Question: Do you understand what this function does?

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
# Do you understand why we need the nstaf? What it does?
soc_names <- soc_staff[fodd(1:nstaf)]  # in the 1 until 94st number, get the odd elements
head(soc_names)
```

```
#> [1] "Staff:"                           "Batenburg, prof. dr. R. (Ronald)"
#> [3] "Begall, dr. K.H. (Katia)"         "Bekhuis, dr. H. (Hidde)"         
#> [5] "Berg, dr. L. van den (Lonneke)"   "Blommaert, dr. L. (Lieselotte)"
```

And how about people's expertise?

```r
soc_experts <- soc_staff[feven(1:nstaf)]  # in the 1 until 94st number, get the even elements
head(soc_experts)
```

```
#> [1] "Expertise:"                                                                                    
#> [2] "Healthcare, labour market and healthcare professions and training"                             
#> [3] "Family, life course, labour market participation, division of household tasks and gender norms"
#> [4] "Welfare state, nationalism and sports"                                                         
#> [5] "Family, life course and transition to adulthood"                                               
#> [6] "Discrimination and inequality on the labour market"
```

Finally, can we merge those two vectors?

```r
soc_df <- data.frame(cbind(soc_names, soc_experts))  # columnbind those and we have a DF for soc staff!
```

How does that look?

```r
soc_df  # pretty nice!
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-13)Sociology staff cleaner</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Staff: </td>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PhD: </td>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hendriks, I.P. (Inge) MSc </td>
   <td style="text-align:left;"> Resistance to refugees and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Linders, N. (Nik) MSc </td>
   <td style="text-align:left;"> Populism, gender, masculinity and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Meijeren, M. (Maikel) MSc </td>
   <td style="text-align:left;"> Social capital, volunteer work and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wiertsema, S. (Sara) MSc </td>
   <td style="text-align:left;"> Inequality in sports and physical activity, school-to-work transition and employment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> External PhD: </td>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Betkó, drs. J.G. (János) </td>
   <td style="text-align:left;"> Social assistance benefit, poverty, reintegration, RCT and social experiment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vis, E. (Elize) MSc </td>
   <td style="text-align:left;"> Healthcare, labour market, healthcare professions and training, health and social capital </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Guest researchers: </td>
   <td style="text-align:left;"> Expertise: </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sterkens, dr. C.J.A. (Carl) </td>
   <td style="text-align:left;"> Religious conflicts, cohesion, religion and the philosophy of life </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vermeer, dr. P.A.D.M. (Paul) </td>
   <td style="text-align:left;"> Socialization processes, secularisation, religion and the philosophy of life </td>
  </tr>
</tbody>
</table></div>

That looks much better! Now we only need to remove the redundant rows that state "expertise", "staff," and so forth.


```r
# inspect again, and remove the rows we don't need (check for yourself to be certain!)

delrows <- which(soc_df$soc_names == "Staff:" | soc_df$soc_names == "PhD:" | soc_df$soc_names == "External PhD:" |
    soc_df$soc_names == "Guest researchers:" | soc_df$soc_names == "Other researchers:")

soc_df <- soc_df[-delrows, ]
```

Let's check it out

```r
soc_df  # even better
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-16)Sociology staff even cleaner</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> Hendriks, I.P. (Inge) MSc </td>
   <td style="text-align:left;"> Resistance to refugees and social cohesion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> Linders, N. (Nik) MSc </td>
   <td style="text-align:left;"> Populism, gender, masculinity and sexuality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> Meijeren, M. (Maikel) MSc </td>
   <td style="text-align:left;"> Social capital, volunteer work and diversity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> Wiertsema, S. (Sara) MSc </td>
   <td style="text-align:left;"> Inequality in sports and physical activity, school-to-work transition and employment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> Betkó, drs. J.G. (János) </td>
   <td style="text-align:left;"> Social assistance benefit, poverty, reintegration, RCT and social experiment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> Vis, E. (Elize) MSc </td>
   <td style="text-align:left;"> Healthcare, labour market, healthcare professions and training, health and social capital </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> Sterkens, dr. C.J.A. (Carl) </td>
   <td style="text-align:left;"> Religious conflicts, cohesion, religion and the philosophy of life </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> Vermeer, dr. P.A.D.M. (Paul) </td>
   <td style="text-align:left;"> Socialization processes, secularisation, religion and the philosophy of life </td>
  </tr>
</tbody>
</table></div>

Now we have a nice relatively clean dataset with all sociology staff and their expterise. But there is yet some work to do before we can move on. We need to do some data cleaning. Ideally, we have staff their first and last names in clean columns. So the last name seems easy, everything before the comma. Do you understand the code below? `gsub` is a function that remove something and replaces it with something else. In the code below it replaces everything that's behind a comma with nothing in the column `soc_names` in the data frame `soc_df`.  

The first name is trickier, we need some more difficult *expressions* to extract first names from this string. It's not necessary for now to exactly know how the expressions below work, but if you want to get into it, here's [a nice resource](https://r4ds.had.co.nz/strings.html). The important part of the code below is that it extracts everything that's in between the brackets.


```r
# Last name seems to be everything before the comma
soc_df$last_name <- gsub(",.*$", "", soc_df$soc_names)

# first name is everything between brackets
soc_df$first_name <- str_extract_all(soc_df$soc_names, "(?<=\\().+?(?=\\))", simplify = TRUE)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-18)Sociology staff cleaner yet</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> last_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> first_name </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
   <td style="text-align:left;"> Batenburg </td>
   <td style="text-align:left;"> Ronald </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
   <td style="text-align:left;"> Begall </td>
   <td style="text-align:left;"> Katia </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
   <td style="text-align:left;"> Bekhuis </td>
   <td style="text-align:left;"> Hidde </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
   <td style="text-align:left;"> Berg </td>
   <td style="text-align:left;"> Lonneke </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
   <td style="text-align:left;"> Blommaert </td>
   <td style="text-align:left;"> Lieselotte </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
   <td style="text-align:left;"> Damman </td>
   <td style="text-align:left;"> Marleen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
   <td style="text-align:left;"> Eisinga </td>
   <td style="text-align:left;"> Rob </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
   <td style="text-align:left;"> Gesthuizen </td>
   <td style="text-align:left;"> Maurice </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
   <td style="text-align:left;"> Glas </td>
   <td style="text-align:left;"> Saskia </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
   <td style="text-align:left;"> Hek </td>
   <td style="text-align:left;"> Margriet </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
   <td style="text-align:left;"> Hoekman </td>
   <td style="text-align:left;"> Remco </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
   <td style="text-align:left;"> Hofstra </td>
   <td style="text-align:left;"> Bas </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
   <td style="text-align:left;"> Kraaykamp </td>
   <td style="text-align:left;"> Gerbert </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
   <td style="text-align:left;"> Meuleman </td>
   <td style="text-align:left;"> Roza </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
   <td style="text-align:left;"> Savelkoul </td>
   <td style="text-align:left;"> Michael </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
   <td style="text-align:left;"> Scheepers </td>
   <td style="text-align:left;"> Peer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
   <td style="text-align:left;"> Spierings </td>
   <td style="text-align:left;"> Niels </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
   <td style="text-align:left;"> Tolsma </td>
   <td style="text-align:left;"> Jochem </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
   <td style="text-align:left;"> Verbakel </td>
   <td style="text-align:left;"> Ellen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
   <td style="text-align:left;"> Visser </td>
   <td style="text-align:left;"> Mark </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
   <td style="text-align:left;"> Wolbers </td>
   <td style="text-align:left;"> Maarten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
   <td style="text-align:left;"> Bussemakers </td>
   <td style="text-align:left;"> Carlijn </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
   <td style="text-align:left;"> Franken </td>
   <td style="text-align:left;"> Rob </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
   <td style="text-align:left;"> Firat </td>
   <td style="text-align:left;"> Mustafa </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
   <td style="text-align:left;"> Geurts </td>
   <td style="text-align:left;"> Nella </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> Hendriks, I.P. (Inge) MSc </td>
   <td style="text-align:left;"> Resistance to refugees and social cohesion </td>
   <td style="text-align:left;"> Hendriks </td>
   <td style="text-align:left;"> Inge </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
   <td style="text-align:left;"> Jeroense </td>
   <td style="text-align:left;"> Thijmen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> Linders, N. (Nik) MSc </td>
   <td style="text-align:left;"> Populism, gender, masculinity and sexuality </td>
   <td style="text-align:left;"> Linders </td>
   <td style="text-align:left;"> Nik </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
   <td style="text-align:left;"> Loh </td>
   <td style="text-align:left;"> Renae </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> Meijeren, M. (Maikel) MSc </td>
   <td style="text-align:left;"> Social capital, volunteer work and diversity </td>
   <td style="text-align:left;"> Meijeren </td>
   <td style="text-align:left;"> Maikel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
   <td style="text-align:left;"> Mensvoort </td>
   <td style="text-align:left;"> Carly </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
   <td style="text-align:left;"> Müller </td>
   <td style="text-align:left;"> Katrin </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
   <td style="text-align:left;"> Raiber </td>
   <td style="text-align:left;"> Klara </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
   <td style="text-align:left;"> Ramaekers </td>
   <td style="text-align:left;"> Marlou </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> Wiertsema, S. (Sara) MSc </td>
   <td style="text-align:left;"> Inequality in sports and physical activity, school-to-work transition and employment </td>
   <td style="text-align:left;"> Wiertsema </td>
   <td style="text-align:left;"> Sara </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> Betkó, drs. J.G. (János) </td>
   <td style="text-align:left;"> Social assistance benefit, poverty, reintegration, RCT and social experiment </td>
   <td style="text-align:left;"> Betkó </td>
   <td style="text-align:left;"> János </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
   <td style="text-align:left;"> Houten </td>
   <td style="text-align:left;"> Jasper </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Jansje </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> Vis, E. (Elize) MSc </td>
   <td style="text-align:left;"> Healthcare, labour market, healthcare professions and training, health and social capital </td>
   <td style="text-align:left;"> Vis </td>
   <td style="text-align:left;"> Elize </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
   <td style="text-align:left;"> Weber </td>
   <td style="text-align:left;"> Tijmen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> Sterkens, dr. C.J.A. (Carl) </td>
   <td style="text-align:left;"> Religious conflicts, cohesion, religion and the philosophy of life </td>
   <td style="text-align:left;"> Sterkens </td>
   <td style="text-align:left;"> Carl </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> Vermeer, dr. P.A.D.M. (Paul) </td>
   <td style="text-align:left;"> Socialization processes, secularisation, religion and the philosophy of life </td>
   <td style="text-align:left;"> Vermeer </td>
   <td style="text-align:left;"> Paul </td>
  </tr>
</tbody>
</table></div>
So we need yet to do some manual cleaning, one name seemed to be inconsistent with how the other names were listed on the webpage. As data get bigger, this becomes impossible to do manually and we simply have to accept this as noise. 


```r
soc_df$last_name <- gsub(" J. \\(Jansje\\) van MSc", "", soc_df$last_name)
soc_df$first_name <- tolower(soc_df$first_name)  # everything to lower!
soc_df$last_name <- tolower(soc_df$last_name)
```

Not quite there yet. To be sure, we'll trim some white space in the variables we know created. This means we remove spaces before and after strings. Usually, with a much larger dataset which you cannot immediately observe, you can further clean the data by removing weird characters.


```r
# trimws looses all spacing before and after (if you specify 'both') a character string
soc_df$last_name <- trimws(soc_df$last_name, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$first_name <- trimws(soc_df$first_name, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$soc_experts <- trimws(soc_df$soc_experts, which = c("both"), whitespace = "[ \t\r\n]")
soc_df$soc_names <- trimws(soc_df$soc_names, which = c("both"), whitespace = "[ \t\r\n]")
```

Finally, because we're quite sure that all these staff are in some way affiliated with Radboud University (why would they otherwise be on the Radboud website?), we simply create a variable that contains a character string "radboud university" for all.


```r
# set affiliation to radboud, comes in handy for querying google scholar
soc_df$affiliation <- "radboud university"
```

How do the data look?

```r
soc_df
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-23)Sociology staff cleanest?</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> last_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> first_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> affiliation </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
   <td style="text-align:left;"> batenburg </td>
   <td style="text-align:left;"> ronald </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
   <td style="text-align:left;"> begall </td>
   <td style="text-align:left;"> katia </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
   <td style="text-align:left;"> bekhuis </td>
   <td style="text-align:left;"> hidde </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
   <td style="text-align:left;"> berg </td>
   <td style="text-align:left;"> lonneke </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
   <td style="text-align:left;"> blommaert </td>
   <td style="text-align:left;"> lieselotte </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
   <td style="text-align:left;"> damman </td>
   <td style="text-align:left;"> marleen </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
   <td style="text-align:left;"> eisinga </td>
   <td style="text-align:left;"> rob </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
   <td style="text-align:left;"> gesthuizen </td>
   <td style="text-align:left;"> maurice </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
   <td style="text-align:left;"> glas </td>
   <td style="text-align:left;"> saskia </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
   <td style="text-align:left;"> hek </td>
   <td style="text-align:left;"> margriet </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
   <td style="text-align:left;"> hoekman </td>
   <td style="text-align:left;"> remco </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
   <td style="text-align:left;"> hofstra </td>
   <td style="text-align:left;"> bas </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
   <td style="text-align:left;"> kraaykamp </td>
   <td style="text-align:left;"> gerbert </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
   <td style="text-align:left;"> meuleman </td>
   <td style="text-align:left;"> roza </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
   <td style="text-align:left;"> savelkoul </td>
   <td style="text-align:left;"> michael </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
   <td style="text-align:left;"> scheepers </td>
   <td style="text-align:left;"> peer </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
   <td style="text-align:left;"> spierings </td>
   <td style="text-align:left;"> niels </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
   <td style="text-align:left;"> tolsma </td>
   <td style="text-align:left;"> jochem </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
   <td style="text-align:left;"> verbakel </td>
   <td style="text-align:left;"> ellen </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
   <td style="text-align:left;"> visser </td>
   <td style="text-align:left;"> mark </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
   <td style="text-align:left;"> wolbers </td>
   <td style="text-align:left;"> maarten </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
   <td style="text-align:left;"> bussemakers </td>
   <td style="text-align:left;"> carlijn </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
   <td style="text-align:left;"> franken </td>
   <td style="text-align:left;"> rob </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
   <td style="text-align:left;"> firat </td>
   <td style="text-align:left;"> mustafa </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
   <td style="text-align:left;"> geurts </td>
   <td style="text-align:left;"> nella </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> Hendriks, I.P. (Inge) MSc </td>
   <td style="text-align:left;"> Resistance to refugees and social cohesion </td>
   <td style="text-align:left;"> hendriks </td>
   <td style="text-align:left;"> inge </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
   <td style="text-align:left;"> jeroense </td>
   <td style="text-align:left;"> thijmen </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> Linders, N. (Nik) MSc </td>
   <td style="text-align:left;"> Populism, gender, masculinity and sexuality </td>
   <td style="text-align:left;"> linders </td>
   <td style="text-align:left;"> nik </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
   <td style="text-align:left;"> loh </td>
   <td style="text-align:left;"> renae </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> Meijeren, M. (Maikel) MSc </td>
   <td style="text-align:left;"> Social capital, volunteer work and diversity </td>
   <td style="text-align:left;"> meijeren </td>
   <td style="text-align:left;"> maikel </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
   <td style="text-align:left;"> mensvoort </td>
   <td style="text-align:left;"> carly </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
   <td style="text-align:left;"> müller </td>
   <td style="text-align:left;"> katrin </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
   <td style="text-align:left;"> raiber </td>
   <td style="text-align:left;"> klara </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
   <td style="text-align:left;"> ramaekers </td>
   <td style="text-align:left;"> marlou </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> Wiertsema, S. (Sara) MSc </td>
   <td style="text-align:left;"> Inequality in sports and physical activity, school-to-work transition and employment </td>
   <td style="text-align:left;"> wiertsema </td>
   <td style="text-align:left;"> sara </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> Betkó, drs. J.G. (János) </td>
   <td style="text-align:left;"> Social assistance benefit, poverty, reintegration, RCT and social experiment </td>
   <td style="text-align:left;"> betkó </td>
   <td style="text-align:left;"> jános </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
   <td style="text-align:left;"> houten </td>
   <td style="text-align:left;"> jasper </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
   <td style="text-align:left;"> middendorp </td>
   <td style="text-align:left;"> jansje </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> Vis, E. (Elize) MSc </td>
   <td style="text-align:left;"> Healthcare, labour market, healthcare professions and training, health and social capital </td>
   <td style="text-align:left;"> vis </td>
   <td style="text-align:left;"> elize </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
   <td style="text-align:left;"> weber </td>
   <td style="text-align:left;"> tijmen </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> Sterkens, dr. C.J.A. (Carl) </td>
   <td style="text-align:left;"> Religious conflicts, cohesion, religion and the philosophy of life </td>
   <td style="text-align:left;"> sterkens </td>
   <td style="text-align:left;"> carl </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> Vermeer, dr. P.A.D.M. (Paul) </td>
   <td style="text-align:left;"> Socialization processes, secularisation, religion and the philosophy of life </td>
   <td style="text-align:left;"> vermeer </td>
   <td style="text-align:left;"> paul </td>
   <td style="text-align:left;"> radboud university </td>
  </tr>
</tbody>
</table></div>

<!---do you see it goes wrong for Ellen! ---> 
<!--- bh: no?  ---> 





Pretty good, so I think we can move on to the next section.

### Google Scholar Profiles and Publications

What we now have is a data frame of sociology staff members. So we successfully gathered the anchor data set we can move on with. Next, we need to find out whether these staff have a Google Scholar profile. I imagine you have accessed [Google Scholar](www.scholar.google.com) many times during your studies for finding scientists or publications. The nice thing about Google Scholar is that it lists collaborators, publications, and citations on profiles. So what we first need to do is look for Google Scholar profiles among sociology staff. Luckily, we cleaned first and last names and have their affiliation. That makes looking them up much easier. So we need to do this for every person in our data frame. Before we query Google Scholar, we first need to go back to the neat trick of *for loops* (remember them from the \@ref(tutorial)?). Can you follow the code below? We can thus do all kinds of things automatically in a for loop.



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
# # or do something more complicated p <- rnorm(10, 0, 1) # draw 10 normally distributed numbers
# with mean 0 and SD 1 (so z-scores, essentially) plot(density(p)) # relatively, normal, right?  u
# <- 0 # make an element we can fill up in the loop below for (i in 1:10) { u[i] <- p[i]*p[i] # get
# p-squared for every i-th element in vector p print(u[i]) # and print that squared element }
```

Now that we know how to implement for loops in our workflow, we can utilize them to do slightly more complicated stuff. We want to know the identifying *link* on Google Scholar for each sociology staff member. We first set an empty identifier in our data frame so that we can "fill up" that data column later.

```r
soc_df$gs_id <- ""  # we set an empty identifier
```

So let's move on with attempting to find Google Scholar profiles. The package `scholar` has a range of very nice functions! What type of functions does `scholar` have? Take a look by `?scholar` or `??scholar`. It includes all kinds of interesting functions like comparing scholars' careers, getting scholar citations, getting profiles, and so forth. Using `get_scholar_id` seems appropriate to find out what the profile ID is of Jochem's Google Scholar page. If you write `get_scholar_id` and then click `ctrl` or `cmd` together with your right mouse button, you can actually see precisely what the function does (it's quite complicated!). Note that this package does not use an API, but simple wrote code to extract Google Scholar pages from the internet. They then wrapped the code in much simpler functions for you to use.  The function `get_scholar_id` needs a last name, first name, and affiliation. Luckily, we already found those on the Radboud University website! So we can fill in those. Let's try it for one staff member first.


```r
source("addfiles/function_fix.R")  # Put the function_fix.R in your working directory, we need this first line.
get_scholar_id_fix(last_name = "tolsma", first_name = "jochem", affiliation = "radboud university")
```

```
#> [1] "Iu23-90AAAAJ"
```

We now know that Jochem's Scholar ID is "Iu23-90AAAAJ". That's very convenient, because now we can use the package `scholar` again to extract a range of useful other information from his Google Scholar profile. Let's try it out on his profile first. Notice the nice function `get_profiles`. We simply have to input his Google Scholar ID and it shows everything on the profile.


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
#> [1] 2285
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
#> [17] "Thomas Feliciani"   "Andreas Flache"     "Ariana Need"        "René Veenstra"
```

A lot of useful information! Next up, Jochem's publications. Notice how not everything is in a nice data frame format yet, we'll get to that later.


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
#> 10                                                                                    Does intergenerational social mobility affect antagonistic attitudes towards ethnic minorities?
#> 11                                  Explaining participation differentials in Dutch higher education: the impact of subjective success probabilities on level choice and field choice
#> 12                                                      The impact of adolescents' classroom and neighborhood ethnic diversity on same-and cross-ethnic friendships within classrooms
#> 13             Neighbourhood ethnic composition and voting for the radical right in The Netherlands. The role of perceived neighbourhood threat and interethnic neighbourhood contact
#> 14        Losing Wallets, Retaining Trust? The Relationship Between Ethnic Heterogeneity and Trusting Coethnic and Non-coethnic Neighbours and Non-neighbours to Return a Lost Wallet
#> 15                                                                                          At which geographic scale does ethnic diversity affect intra-neighborhood social capital?
#> 16                                                Educational expansion and field of study: trends in the intergenerational transmission of educational inequality in the Netherlands
#> 17                                                                                                             The NEtherlands Longitudinal Lifecourse Study (NELLS, Panel): Codebook
#> 18                                                                       Bringing the beneficiary closer: Explanations for volunteering time in Dutch private development initiatives
#> 19    Onderwijs als nieuwe sociale scheidslijn? De gevolgen van onderwijsexpansie voor sociale mobiliteit, de waarde van diploma’s en het relatieve belang van opleiding in Nederland
#> 20                                                                                                                                                         Naar een open samenleving?
#> 21                                                                              Explaining monetary donations to international development organisations: A factorial survey approach
#> 22                                                                                          Social origin and occupational success at labour market entry in The Netherlands, 1931–80
#> 23                                                                                                  How friends’ involvement in crime affects the risk of offending and victimization
#> 24                                                                                      How, when and where can spatial segregation induce opinion polarization? Two competing models
#> 25                     Perceptions as the crucial link? The mediating role of neighborhood perceptions in the relationship between the neighborhood context and neighborhood cohesion
#> 26                                                                                                                                                                 VU Research Portal
#> 27 Ethnic hostility among ethnic majority and minority groups in the Netherlands: An investigation into the impact of social mobility experiences, the local living environment and …
#> 28                                                                                         Explaining natives' interethnic friendship and contact with colleagues in European regions
#> 29                                                                                      Netherlands Longitudinal Lifecourse Study-NELLS Panel Wave 1 2009 and Wave 2 2013-version 1.1
#> 30                                                                                                Trust and contact in diverse neighbourhoods: An interplay of four ethnicity effects
#> 31                                                      Combating hooliganism in the Netherlands: An evaluation of measures to combat hooliganism with longitudinal registration data
#> 32    De onderwijskansen van allochtone en autochtone Nederlanders vergeleken: Een cohort-design [Ethnic inequality of educational opportunities in the Netherlands: A cohort design]
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
#> 10                                          J Tolsma, ND De Graaf, L Quillian
#> 11                                                J Tolsma, A Need, U De Jong
#> 12                               A Munniksma, P Scheepers, TH Stark, J Tolsma
#> 13                                           M Savelkoul, J Laméris, J Tolsma
#> 14                                                 J Tolsma, TWG van der Meer
#> 15                                           R Sluiter, J Tolsma, P Scheepers
#> 16                                         G Kraaykamp, J Tolsma, MHJ Wolbers
#> 17                J Tolsma, GLM Kraaykamp, PM de Graaf, M Kalmijn, CWS Monden
#> 18                                           S Kinsbergen, J Tolsma, S Ruiter
#> 19                                                      J Tolsma, MHJ Wolbers
#> 20                                                      J Tolsma, MHJ Wolbers
#> 21                                                     S Kinsbergen, J Tolsma
#> 22                                                      J Tolsma, MHJ Wolbers
#> 23                                   JJ Rokven, G de Boer, J Tolsma, S Ruiter
#> 24                                            T Feliciani, A Flache, J Tolsma
#> 25                                               J Laméris, JR Hipp, J Tolsma
#> 26                   S Ruiter, J Tolsma, M De Hoon, H Elffers, P Van der Laan
#> 27                                                                   J Tolsma
#> 28                                         M Savelkoul, J Tolsma, P Scheepers
#> 29                 J Tolsma, GLM Kraaykamp, PM De Graaf, M Kalmijn, CM Monden
#> 30                                                 J Tolsma, TWG Van der Meer
#> 31                                     D Schaap, M Postma, L Jansen, J Tolsma
#> 32                                          J Tolsma, MTA Coenders, M Lubbers
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
#> 10                                                 The British Journal of Sociology
#> 11                                                     European Sociological Review
#> 12                                               Journal of Research on Adolescence
#> 13                                                     European Sociological Review
#> 14                                                       Social Indicators Research
#> 15                                                          Social science research
#> 16                                        British Journal of Sociology of Education
#> 17             Nijmegen; Tilburg; Amsterdam: Radboud University Nijmegen; Tilburg …
#> 18                                         Nonprofit and Voluntary Sector Quarterly
#> 19                                                                                 
#> 20                                                                                 
#> 21                                                          Social science research
#> 22                                                                 Acta Sociologica
#> 23                                                  European journal of criminology
#> 24                                                                                 
#> 25                                                          Social science research
#> 26                                                                                 
#> 27                                                [Sl]: sn [ICS dissertation series
#> 28                                          Journal of Ethnic and Migration Studies
#> 29                                                     DANS. DOI: https://doi. org/
#> 30                                                          Social science research
#> 31                                 European Journal on Criminal Policy and Research
#> 32                                                                                 
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
#> 1                                                        40 (1), 459-478   434 2014
#> 2                                                        27 (6), 741-758   289 2011
#> 3                                                                 44 (3)   268 2009
#> 4                                                        27 (3), 291-306   120 2011
#> 5                                                        24 (2), 215-230   120 2008
#> 6                                                          35 (1), 51-61   107 2013
#> 7                                                         8 (2), 117-134    75 2012
#> 8                                                        38 (5), 793-813    70 2012
#> 9                                                        23 (3), 325-339    68 2007
#> 10                                                       60 (2), 257-277    63 2009
#> 11                                                       26 (2), 235-252    62 2010
#> 12                                                         27 (1), 20-33    43 2017
#> 13                                                       33 (2), 209-224    37 2017
#> 14                                                                          35 2016
#> 15                                                             54, 80-95    33 2015
#> 16                                                     34 (5-6), 888-906    32 2013
#> 17                                                                          31 2014
#> 18                                                         42 (1), 59-83    29 2013
#> 19                                                                          28 2010
#> 20                                                                          26 2010
#> 21                                                     42 (6), 1571-1586    24 2013
#> 22                                                       57 (3), 253-269    22 2014
#> 23                                                       14 (6), 697-719    19 2017
#> 24                                                                          19 2017
#> 25                                                             72, 53-68    17 2018
#> 26                                                                          17 2011
#> 27                                                                  155]    17 2009
#> 28                                                       41 (5), 683-709    15 2015
#> 29                                               /10.17026/dans-25n-2xjv    14 2014
#> 30                                                            73, 92-106    13 2018
#> 31                                                         21 (1), 83-97    13 2015
#> 32                                                                          13 2007
#> 33                                                             63, 80-94    11 2018
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
#> 10                                           10446633547221929964 2osOgNQ5qMEC
#> 11 18143881066769803140,18233438384904663264,12975380653095517868 Tyk-4Ss8FVUC
#> 12                                           18309594979069207516 maZDTaKrznsC
#> 13                       4894344398065441656,17805961515959316077 ldfaerwXgEUC
#> 14                                            2251620908592189324 BqipwSGYUEgC
#> 15                                            7670225499012303854 e5wmG9Sq2KIC
#> 16                                            2401615506068930127 7PzlFSSx8tAC
#> 17                                            8792123396141403739 xtRiw3GOFMkC
#> 18                                            2112276567018030922 _FxGoFyzp5QC
#> 19                                           16059273116934807949 YsMSGLbcyi4C
#> 20                                            2539524527836644253 Y0pCki6q_DkC
#> 21                                           10149692484122806616 aqlVkmm33-oC
#> 22                                            8248470043986462984 M3ejUd6NZC8C
#> 23                                           13322468554278639475 vV6vV6tmYwMC
#> 24                                            6880814424039971499 g5m5HwL7SMYC
#> 25                                           16357054384393453824 D03iK_w7-QYC
#> 26                                            5199682358769198644 KlAtU1dfN6UC
#> 27                                           10378332126833599949 IjCSPb-OGe4C
#> 28                                           18182577779862774305 -f6ydRqryjwC
#> 29                        9375222806902931665,3745616990512837825 mB3voiENLucC
#> 30                                            8349908030823257502 pyW8ca7W8N0C
#> 31                                            9528443224826780083 ZeXyd9-uunAC
#> 32                                              41511425553822262 zYLM7Y9cAGgC
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
#> 11 2018   268
#> 12 2019   297
#> 13 2020   303
#> 14 2021   253
```

And now most importantly, Jochem's collaborators, and the collaborators of those collaborators (note the `n_deep = 1`, can you find out what that does?). So essentially a "one-step-further-than-Jochem" network. 


```r
jochem_coauthors <- get_coauthors("Iu23-90AAAAJ", n_coauthors = 50, n_deep = 1)  # Jochem's collaborators and their co-authors!
```

```r
jochem_coauthors
```
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-34)Sociology staff cleanest?</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> author </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> coauthors </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Peer Scheepers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marcel Coenders </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Sara Kinsbergen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Christiaan Monden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Lincoln Quillian </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Marloes De Lange </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Thomas Feliciani </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Andreas Flache </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Ariana Need </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> René Veenstra </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Paul Dekker </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Peer Scheepers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Wouter Van Der Brug </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Erika Van Elsas </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Sarah L. De Lange </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Eefje Steenvoorden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Armen Hakhverdian </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Eelco Harteveld </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Erik Van Ingen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Huib Pellikaan </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Ben Pelzer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jan W. Van Deth </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Jaco Dagevos </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Sonja Zmerli </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Loes Aaldering </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
   <td style="text-align:left;"> Tim Reeskens </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Marloes De Lange </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Wout Ultee </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Mark Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Emer Smyth </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Walter Müller </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Renze Kolster </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Tanja Traag </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Don Westerheijden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Muja Ardita </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Nicole Tieben </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Andries De Grip </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Richard Layte </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
   <td style="text-align:left;"> Selina Mccoy </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Tim Huijts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maarten Hj Wolbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Christiaan Monden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Levels </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Wout Ultee </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 77 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Roza Meuleman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 79 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Mark Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 80 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Koen Van Eijck </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Margriet Van Hek </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 82 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Stéfanie André </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 84 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Jesper Jelle Rözer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Niels Blom </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 90 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 92 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 93 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 94 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 95 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 97 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 98 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 99 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Hans De Witte </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Maurice Vergeer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Karin M Van Der Pal-De Bruin </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 102 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Agnieszka Kanas </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 103 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 104 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Ruben Konig </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 105 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Pytrik Schafraad </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 106 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Frans Van Der Slik </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 107 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Mark Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 108 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Paula Thijs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 109 </td>
   <td style="text-align:left;"> Peer Scheepers </td>
   <td style="text-align:left;"> Ben Pelzer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Peer Scheepers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 114 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Dietlind Stolle </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 118 </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Miles Hewstone </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 122 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Wim Bernasco </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 124 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 125 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 126 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 127 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Shane D Johnson </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 128 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Daniel Birks </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 129 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Michael Townsley </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 130 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Marieke Van De Rakt </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 131 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 132 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Jean-Louis Van Gelder </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Gentry White </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 134 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Frank Weerman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 135 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 137 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Marcel Coenders </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Scott Baum </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 139 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Lieven J.r. Pauwels </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 140 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> Marleen Weulen Kranenbarg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 141 </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
   <td style="text-align:left;"> René Bekkers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 145 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Peer Scheepers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 146 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Marcel Coenders </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 147 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mérove Gijsberts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 148 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Eva Jaspers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 149 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roza Meuleman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 150 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 151 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Rob Eisinga </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 154 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 155 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Tim Immerzeel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 156 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Niels Spierings </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 157 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jaak Billiet </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 158 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Mark Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 159 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Maurice Vergeer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 160 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Roos Van Der Zwan </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 161 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Claudia Diehl </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 162 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Nella Geurts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 163 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Jeanette A.j. Renema </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 164 </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
   <td style="text-align:left;"> Hilde Coffe </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 168 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Peer Scheepers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 169 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 170 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Marloes De Lange </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 171 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tom Van Der Meer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Mark Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 173 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 174 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> "Heike Solga" Or "H. Solga" </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 175 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Bram Steijn </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ariana Need </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 180 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Tim Huijts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 181 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Stéfanie André </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 182 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jasper Van Houten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Geert Driessen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 184 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Beate Volker </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 185 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> William M. Van Der Veld </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 186 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Jan Paul Heisig </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 187 </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> J.c. Vrooman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 194 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 195 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 196 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Paul Nieuwbeerta </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 197 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Ariana Need </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 198 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Stijn Ruiter </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 199 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Geoffrey Evans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 200 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Anthony F Heath </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 201 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Manfred Te Grotenhuis </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 202 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Giedo Jansen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 203 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Herman G. Van De Werfhorst </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 204 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Jonathan Kelley </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 205 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Christiaan Monden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 206 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Marcel Lubbers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 207 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> René Bekkers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 208 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 209 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 210 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Eva Jaspers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 211 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 212 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Lincoln Quillian </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> Nan Dirk De Graaf </td>
   <td style="text-align:left;"> Jacques  A. Hagenaars </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 217 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Anke Munniksma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 218 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> René Veenstra </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 219 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 220 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Josh Pasek </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 221 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Trevor Tompson </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 222 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 223 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> J. Ashwin Rambaran, Ph.d. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 224 </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
   <td style="text-align:left;"> Ioana Van Deurzen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 234 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Paul M. De Graaf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 235 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Kène Henkens </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 236 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Frank Van Tubergen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 237 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 238 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Aart C. Liefbroer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 239 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Wilfred Uunk </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 240 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Christiaan Monden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 241 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Marleen Damman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 242 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Katya Ivanova </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 243 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Anne-Rigt Poortman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 244 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Harry Bg Ganzeboom </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 245 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Jornt J. Mandemakers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 246 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 247 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Ruud Luijkx </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 248 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Jaap Dronkers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 249 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Marjolein Broese Van Groenou </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 250 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Tanja Van Der Lippe </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Erik Van Ingen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 252 </td>
   <td style="text-align:left;"> Matthijs Kalmijn </td>
   <td style="text-align:left;"> Nells - Netherlands Longitudinal Lif... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 256 </td>
   <td style="text-align:left;"> Lincoln Quillian </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 266 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Michael Macy </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 267 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Michael Mäs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 268 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Tobias H. Stark </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 269 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Rainer Hegselmann </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 270 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> René Veenstra </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 271 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Rafael Wittek </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 272 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Guillaume Deffuant </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 273 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Dirk Helbing </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 274 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Anke Munniksma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 275 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Károly Takács </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 276 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> James A Kitts </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 277 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Maykel Verkuyten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 278 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Nigel Gilbert </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 279 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Maxi San Miguel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 280 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Rosaria Conte </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 281 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Andrzej Nowak </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 282 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Josep M. Pujol </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 283 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> André Grow </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 284 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Werner Raub </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> Andreas Flache </td>
   <td style="text-align:left;"> Rene Torenvlied </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 292 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Ormel, Johan (Hans) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 293 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Frank Verhulst </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 294 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Siegwart Lindenberg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 295 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Jan Kornelis Dijkstra </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 296 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Tineke Oldehinkel </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 297 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Gijs Huitsing </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 298 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Christina Salmivalli </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 299 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Wilma Vollebergh </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 300 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Christian Steglich </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 301 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Tina Kretschmer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 302 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Jelle Sijtsema </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 303 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Miranda Sentse </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 304 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Rozemarijn Van Der Ploeg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 305 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Sijmen A Reijneveld </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 306 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Catharina A. Hartman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 307 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Miia Sainio </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 308 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Beau Oldenburg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 309 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Marijtje A.j. Van Duijn </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 310 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Henning Tiemeier </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 311 </td>
   <td style="text-align:left;"> René Veenstra </td>
   <td style="text-align:left;"> Antonius Cillessen </td>
  </tr>
</tbody>
</table></div>
Notice, however, that we could easily plot Jochem's collaboration network already! This is thus a one-deeper network where we plot the co-authors of Jochem and who they collaborate with, there is some overlap, but not always.

<!---this one bugs. have set eval=FALSE---> 
<!---works for me!---> 


```r
plot_coauthors(get_coauthors("Iu23-90AAAAJ", n_coauthors = 20, n_deep = 1), size_labels = 2)  # Doesn't look like much yet, but we'll make it prettier later.
```

<img src="050-Webscraping_files/figure-html/unnamed-chunk-35-1.png" width="672" />

So let's gather these data, but now for *all* sociology staff simultaneously! For this, we use the for loop again. The for loop I make below is a bit more complicated, but follows the same logic as before. For each row (i) in `soc_df`, we attempt to query Google Scholar on the basis of the first name, last name, and affiliation listed in that row in the data frame. We use some handy subsetting, e.g., `soc_df[i, 3]` means we input `last_name=` with the last name (which is the third column) found in the i-th row in the data frame. The same goes for first name and affiliation. We fill up `gs_id` in the data frame with the Google Scholar IDs we'll hopefully find. The `for (i in nrow(soc_df))` simply means we let i run for however many rows the data frame has. Finally, the `tryCatch({})` function makes that we can continue the loop even though we may encounter errors for a given row. Here, that probably means that not every row (i.e., sociology staff member) can be found on Google Scholar. We print the error, but continue the for loop with the `tryCatch({})` function. In the final rows of the code below. We simply drop those rows that we cannot identify on Google Scholar.

<!---why did you set eval=FALSE? does not take too long. Don't forget we cache everything---> 
<!---if you use eval=FALSE. Don't forget to save the objects and load them in next script (with echo=FALSE)--->


```r
# because we don't wanna 'Rate limit' google scholar, they throw you out if you make to many
# requests, we randomize request time do you understand the code below?
for (i in 1:10) {
    time <- runif(1, 0, 5)
    Sys.sleep(time)
    print(paste(i, ": R slept for", round(time, 1), "seconds"))
}
# for every number from 1 to 10 we draw one number from 0 to 5 from a uniform distribution we put
# the wrapper sys.sleep around it that we put R to sleep for the drawn number
```


```r
# Look throught get_scholar_id_fix(last_name, first_name, affiliation) 
# if we can find google scholar profiles of sociology staff!
for (i in 1:nrow(soc_df)) {
  
  time <- runif(1, 0, 5)
  Sys.sleep(time)
  
  tryCatch({
     soc_df[i,c("gs_id")] <- get_scholar_id_fix(last_name = soc_df[i, 3], # so search on last_name of staff (third column)
                                             first_name = soc_df[i,4],  # search on first_name of staff (fourth column)
                                             affiliation = soc_df[i,5]) # search on affiliation of each staff (fifth column)

    }, error=function(e){cat("ERROR :", conditionMessage(e), "\n")}) # continue on error, but print the error
  }

# remove those without pubs from the df
# seems we're left with about 34 sociology staff members!
soc_df <- soc_df[!soc_df$gs_id == "", ]
soc_df
```





<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-40)Sociology staff with Scholar IDs</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> last_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> first_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> affiliation </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> gs_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
   <td style="text-align:left;"> Batenburg </td>
   <td style="text-align:left;"> Ronald </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
   <td style="text-align:left;"> Begall </td>
   <td style="text-align:left;"> Katia </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
   <td style="text-align:left;"> Bekhuis </td>
   <td style="text-align:left;"> Hidde </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
   <td style="text-align:left;"> Berg </td>
   <td style="text-align:left;"> Lonneke </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
   <td style="text-align:left;"> Blommaert </td>
   <td style="text-align:left;"> Lieselotte </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
   <td style="text-align:left;"> Damman </td>
   <td style="text-align:left;"> Marleen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
   <td style="text-align:left;"> Eisinga </td>
   <td style="text-align:left;"> Rob </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
   <td style="text-align:left;"> Gesthuizen </td>
   <td style="text-align:left;"> Maurice </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
   <td style="text-align:left;"> Glas </td>
   <td style="text-align:left;"> Saskia </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
   <td style="text-align:left;"> Hek </td>
   <td style="text-align:left;"> Margriet </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
   <td style="text-align:left;"> Hoekman </td>
   <td style="text-align:left;"> Remco </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
   <td style="text-align:left;"> Hofstra </td>
   <td style="text-align:left;"> Bas </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
   <td style="text-align:left;"> Kraaykamp </td>
   <td style="text-align:left;"> Gerbert </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
   <td style="text-align:left;"> Meuleman </td>
   <td style="text-align:left;"> Roza </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
   <td style="text-align:left;"> Savelkoul </td>
   <td style="text-align:left;"> Michael </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
   <td style="text-align:left;"> Scheepers </td>
   <td style="text-align:left;"> Peer </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
   <td style="text-align:left;"> Spierings </td>
   <td style="text-align:left;"> Niels </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
   <td style="text-align:left;"> Tolsma </td>
   <td style="text-align:left;"> Jochem </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
   <td style="text-align:left;"> Verbakel </td>
   <td style="text-align:left;"> Ellen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
   <td style="text-align:left;"> Visser </td>
   <td style="text-align:left;"> Mark </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
   <td style="text-align:left;"> Wolbers </td>
   <td style="text-align:left;"> Maarten </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
   <td style="text-align:left;"> Bussemakers </td>
   <td style="text-align:left;"> Carlijn </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
   <td style="text-align:left;"> Franken </td>
   <td style="text-align:left;"> Rob </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
   <td style="text-align:left;"> Firat </td>
   <td style="text-align:left;"> Mustafa </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
   <td style="text-align:left;"> Geurts </td>
   <td style="text-align:left;"> Nella </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
   <td style="text-align:left;"> Jeroense </td>
   <td style="text-align:left;"> Thijmen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> izq-KNUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
   <td style="text-align:left;"> Loh </td>
   <td style="text-align:left;"> Renae </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> tFaMPOQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
   <td style="text-align:left;"> Mensvoort </td>
   <td style="text-align:left;"> Carly </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
   <td style="text-align:left;"> Müller </td>
   <td style="text-align:left;"> Katrin </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
   <td style="text-align:left;"> Raiber </td>
   <td style="text-align:left;"> Klara </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> xE65HUcAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
   <td style="text-align:left;"> Ramaekers </td>
   <td style="text-align:left;"> Marlou </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> fp99JAQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
   <td style="text-align:left;"> Houten </td>
   <td style="text-align:left;"> Jasper </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
   <td style="text-align:left;"> Middendorp </td>
   <td style="text-align:left;"> Jansje </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
   <td style="text-align:left;"> Weber </td>
   <td style="text-align:left;"> Tijmen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
</tbody>
</table></div>

It works! So what is left to do is to get the data we already extracted for Jochem (citation, publications, and so forth), but now for all sociology staff. For that, we need a bunch of for loops. Let's first gather the profiles and publications. We store those in a `list()` which is an object in which you can store multiple data frames, vectors, matrices, and so forth. This is particularly good for for loops because you can store information that is -- at first sight -- not necessarily compatible. For instance, matrices of different length. Note that we bind a Google Scholar ID to the publications too which is important to be able match to the `soc_df` later on. 


```r
soc_list_profiles <- list()  # first we create an empty list that we then fill up with the for loop
soc_list_publications <- list()

for (i in 1:nrow(soc_df)) {

    time <- runif(1, 0, 5)
    Sys.sleep(time)

    # note how you call different elements in a list '[[]]', fill in the i-th element
    soc_list_profiles[[i]] <- get_profile(soc_df[i, c("gs_id")])  # Note how we call row i (remember how to call rows in a DF/Matrix) and then the associated scholar id
    soc_list_publications[[i]] <- get_publications(soc_df[i, c("gs_id")])
    soc_list_publications[[i]][, c("gs_id")] <- soc_df[i, c("gs_id")]  # note that we again attach an id
    # so both functions here call the entire profile and pubs for an author, based on google
    # scholar ids

}
# Notice how fast the data blow up! The 34 RU sociology scholars publish ~3000 papers
soc_df_publications <- bind_rows(soc_list_publications)
```





<!---this really goes too fast for students---> 
<!--- this better? -->

Note how `soc_list_profiles` contains all Google Scholar profile information in a list of 34 elements. We need to do some relatively involved data handling to attach the Google Scholar profiles in `soc_list_profiles` to the `soc_df`. That is, we want some information from `soc_list_profiles` to be attached to `soc_df`. Specifically, we want several things we want from the profiles: `id`, `name` (as reported on Scholar), `affiliation`, `tot_cites`, `h_index`, `i10index`, `fields`, and `homepage`.

Some profile elements can contain more than one row. For instance, co-authors are stored in long format per profile that do not easily merge to a data frame where each staff member is a row. For instance, say Bas has two co-authors; one needs to first concatonate those co-authors before you can merge them in one row for Bas. So we need to get only the profile elements that have a single element per profile element (e.g., `total_cites`). Seems these are the first 8 elements in a list element. So we need to get those out of the lists and store those in a new dataframe. This involves several steps:

*     We first `unlist` the 1 tot 8-th elements in a list element
*     We then make it a data frame
*     Then *transpose* the data such that each row contains 8 columns. 
*     We then use the function `bind_rows()` to simply make a data frame from the list elements. 
*     We then merge it to `soc_df`. So what we end up with is a sociology staff data frame with much more information than before: citations, indices, expertise listed on Google Scholar, and so forth.

Note how we can do this at once, or all separately (I commented out the code that does the same as the next three rows). Which has your preference?


```r
soc_profiles_df <- list()
for (i in 1:length(soc_list_profiles)) {
    # soc_profiles_df[[i]] <- data.frame(t(unlist(soc_list_profiles[[i]][1:8]))) #some annyoing
    # data handling
    soc_profiles_df[[i]] <- unlist(soc_list_profiles[[i]][1:8])
    soc_profiles_df[[i]] <- data.frame(soc_profiles_df[[i]])
    soc_profiles_df[[i]] <- t(soc_profiles_df[[i]])

}
soc_profiles_df <- bind_rows(soc_profiles_df)
soc_df <- left_join(soc_df, soc_profiles_df, by = c(gs_id = "id"))  # merge data with soc_df
soc_df  # notice all the new information we were able to get from the scholar profiles!
```





Let's see whether we 

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-47)Sociology staff with Scholar info</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_names </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> soc_experts </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> last_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> first_name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> affiliation.x </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> gs_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> affiliation.y </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> total_cites </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> h_index </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> i10_index </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> fields </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> homepage </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Batenburg, prof. dr. R. (Ronald) </td>
   <td style="text-align:left;"> Healthcare, labour market and healthcare professions and training </td>
   <td style="text-align:left;"> Batenburg </td>
   <td style="text-align:left;"> Ronald </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
   <td style="text-align:left;"> Ronald Batenburg </td>
   <td style="text-align:left;"> Programmaleider NIVEL en bijzonder hoogleraar Radboud Universiteit Nijmegen </td>
   <td style="text-align:left;"> 3608 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:left;"> verified email at nivel.nl - homepage </td>
   <td style="text-align:left;"> https://www.nivel.nl/nl/ronald-batenburg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Begall, dr. K.H. (Katia) </td>
   <td style="text-align:left;"> Family, life course, labour market participation, division of household tasks and gender norms </td>
   <td style="text-align:left;"> Begall </td>
   <td style="text-align:left;"> Katia </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
   <td style="text-align:left;"> Katia Begall </td>
   <td style="text-align:left;"> Radboud University Nijmegen </td>
   <td style="text-align:left;"> 936 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bekhuis, dr. H. (Hidde) </td>
   <td style="text-align:left;"> Welfare state, nationalism and sports </td>
   <td style="text-align:left;"> Bekhuis </td>
   <td style="text-align:left;"> Hidde </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
   <td style="text-align:left;"> Hidde Bekhuis </td>
   <td style="text-align:left;"> Post Doc Sociology, Radboud University Nijmegen </td>
   <td style="text-align:left;"> 348 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Berg, dr. L. van den (Lonneke) </td>
   <td style="text-align:left;"> Family, life course and transition to adulthood </td>
   <td style="text-align:left;"> Berg </td>
   <td style="text-align:left;"> Lonneke </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
   <td style="text-align:left;"> Lonneke van den Berg </td>
   <td style="text-align:left;"> Radboud University </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/personen/berg-l-van-den-lonneke/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Blommaert, dr. L. (Lieselotte) </td>
   <td style="text-align:left;"> Discrimination and inequality on the labour market </td>
   <td style="text-align:left;"> Blommaert </td>
   <td style="text-align:left;"> Lieselotte </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
   <td style="text-align:left;"> Lieselotte Blommaert </td>
   <td style="text-align:left;"> Sociology/Social Cultural Research, Radboud University, Nijmegen, the </td>
   <td style="text-align:left;"> 317 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.ru.nl/english/people/blommaert-e/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Damman, dr. M. (Marleen) </td>
   <td style="text-align:left;"> Labour market, life course, older workers, retirement and solo self-employed </td>
   <td style="text-align:left;"> Damman </td>
   <td style="text-align:left;"> Marleen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
   <td style="text-align:left;"> Marleen Damman </td>
   <td style="text-align:left;"> Assistant Professor, Utrecht University </td>
   <td style="text-align:left;"> 515 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> verified email at uu.nl - homepage </td>
   <td style="text-align:left;"> https://www.uu.nl/staff/MDamman </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eisinga, prof. dr. R.N. (Rob) </td>
   <td style="text-align:left;"> Methods of research and statistics </td>
   <td style="text-align:left;"> Eisinga </td>
   <td style="text-align:left;"> Rob </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
   <td style="text-align:left;"> Rob Eisinga </td>
   <td style="text-align:left;"> Professor social science research methods, Radboud University Nijmegen </td>
   <td style="text-align:left;"> 4994 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 77 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://robeisinga.ruhosting.nl/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gesthuizen, dr. M.J.W. (Maurice) </td>
   <td style="text-align:left;"> Poverty en social cohesion </td>
   <td style="text-align:left;"> Gesthuizen </td>
   <td style="text-align:left;"> Maurice </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
   <td style="text-align:left;"> Maurice Gesthuizen </td>
   <td style="text-align:left;"> Sociology, Radboud University Nijmegen, the Netherland - Assistant Professor </td>
   <td style="text-align:left;"> 2425 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.ru.nl/methodenentechnieken/methoden-technieken/medewerkers/vm_medewerkers/maurice_gesthuizen/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glas, dr. S. (Saskia) </td>
   <td style="text-align:left;"> Islam, gender attitudes and sexuality </td>
   <td style="text-align:left;"> Glas </td>
   <td style="text-align:left;"> Saskia </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
   <td style="text-align:left;"> Saskia Glas </td>
   <td style="text-align:left;"> PhD student, Radboud University </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hek, dr. M. van (Margriet) </td>
   <td style="text-align:left;"> Educational inequality, gender inequality, organizational sociology and culture </td>
   <td style="text-align:left;"> Hek </td>
   <td style="text-align:left;"> Margriet </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
   <td style="text-align:left;"> Margriet van Hek </td>
   <td style="text-align:left;"> Radboud University </td>
   <td style="text-align:left;"> 262 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hoekman, dr. R. H. A.(Remco) </td>
   <td style="text-align:left;"> Sports and policy sociology </td>
   <td style="text-align:left;"> Hoekman </td>
   <td style="text-align:left;"> Remco </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
   <td style="text-align:left;"> Remco Hoekman </td>
   <td style="text-align:left;"> Director, Mulier Institute / Senior researcher, Radboud University </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> verified email at mulierinstituut.nl - homepage </td>
   <td style="text-align:left;"> https://www.mulierinstituut.nl/over-mulier/medewerkers/remco-hoekman/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofstra, dr. B. (Bas) </td>
   <td style="text-align:left;"> Diversity, inequality and innovation </td>
   <td style="text-align:left;"> Hofstra </td>
   <td style="text-align:left;"> Bas </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
   <td style="text-align:left;"> Bas Hofstra </td>
   <td style="text-align:left;"> Assistant Professor, Radboud University </td>
   <td style="text-align:left;"> 384 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.bashofstra.com/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kraaykamp, prof. dr. G.L.M. (Gerbert) </td>
   <td style="text-align:left;"> Educational inequality, culture and health </td>
   <td style="text-align:left;"> Kraaykamp </td>
   <td style="text-align:left;"> Gerbert </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
   <td style="text-align:left;"> Gerbert Kraaykamp </td>
   <td style="text-align:left;"> Professor of Sociology, Radboud Universiteit Nijmegen </td>
   <td style="text-align:left;"> 7724 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 98 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/english/people/kraaykamp-g/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Meuleman, dr. (Roza) </td>
   <td style="text-align:left;"> Culture and nationalism </td>
   <td style="text-align:left;"> Meuleman </td>
   <td style="text-align:left;"> Roza </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
   <td style="text-align:left;"> Roza Meuleman </td>
   <td style="text-align:left;"> Assistant Professor - Sociology - Radboud University Nijmegen </td>
   <td style="text-align:left;"> 214 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Savelkoul, dr. M.J. (Michael) </td>
   <td style="text-align:left;"> Ethnic diversity, prejudice and social cohesion </td>
   <td style="text-align:left;"> Savelkoul </td>
   <td style="text-align:left;"> Michael </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
   <td style="text-align:left;"> Michael Savelkoul </td>
   <td style="text-align:left;"> Assistant Professor - Sociology, Radboud University Nijmegen, the Netherlands </td>
   <td style="text-align:left;"> 580 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheepers, prof. dr. P.L.H. (Peer) </td>
   <td style="text-align:left;"> Comparative research, social cohesion and diversity </td>
   <td style="text-align:left;"> Scheepers </td>
   <td style="text-align:left;"> Peer </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
   <td style="text-align:left;"> peer scheepers </td>
   <td style="text-align:left;"> hoogleraar methodologie, faculteit der sociale wetenschappen radboud universiteit </td>
   <td style="text-align:left;"> 14399 </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:left;"> 180 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Spierings, dr. C.H.B.M. (Niels) </td>
   <td style="text-align:left;"> Islam, gender, populism, social media, Middle East and migration </td>
   <td style="text-align:left;"> Spierings </td>
   <td style="text-align:left;"> Niels </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
   <td style="text-align:left;"> Niels Spierings </td>
   <td style="text-align:left;"> Associate Professor of Sociology, Radboud University </td>
   <td style="text-align:left;"> 1662 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/english/people/spierings-c/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tolsma, dr. J. (Jochem) </td>
   <td style="text-align:left;"> Inequality, criminology and ethnic diversity </td>
   <td style="text-align:left;"> Tolsma </td>
   <td style="text-align:left;"> Jochem </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
   <td style="text-align:left;"> Jochem Tolsma </td>
   <td style="text-align:left;"> Professor, Radboud University Nijmegen / University of Groningen </td>
   <td style="text-align:left;"> 2260 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.jochemtolsma.nl/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Verbakel, prof. dr. C.M.C. (Ellen)
                                Head of the department </td>
   <td style="text-align:left;"> Health, family and work </td>
   <td style="text-align:left;"> Verbakel </td>
   <td style="text-align:left;"> Ellen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
   <td style="text-align:left;"> Ellen Verbakel </td>
   <td style="text-align:left;"> Professor of Sociology, Department of Sociology, Radboud University Nijmegen </td>
   <td style="text-align:left;"> 1474 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.ellenverbakel.nl/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Visser, dr. M. (Mark) </td>
   <td style="text-align:left;"> Older workers, radicalism and social cohesion </td>
   <td style="text-align:left;"> Visser </td>
   <td style="text-align:left;"> Mark </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
   <td style="text-align:left;"> Mark Visser </td>
   <td style="text-align:left;"> Assistant Professor, Radboud University </td>
   <td style="text-align:left;"> 381 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.researchgate.net/profile/Mark_Visser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wolbers, prof. dr. M.H.J. (Maarten) </td>
   <td style="text-align:left;"> Educational inequality and labour market inequality </td>
   <td style="text-align:left;"> Wolbers </td>
   <td style="text-align:left;"> Maarten </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
   <td style="text-align:left;"> Maarten HJ Wolbers </td>
   <td style="text-align:left;"> Professor of Sociology, Radboud University, Nijmegen </td>
   <td style="text-align:left;"> 3624 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://www.socsci.ru.nl/maartenw/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bussemakers, C. (Carlijn) MSc </td>
   <td style="text-align:left;"> Adverse youth experiences and social inequality </td>
   <td style="text-align:left;"> Bussemakers </td>
   <td style="text-align:left;"> Carlijn </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
   <td style="text-align:left;"> Carlijn Bussemakers </td>
   <td style="text-align:left;"> Department of Sociology, Radboud University </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Franken, R. (Rob) MSc </td>
   <td style="text-align:left;"> Sport networks and motivation for sustainable sports participation </td>
   <td style="text-align:left;"> Franken </td>
   <td style="text-align:left;"> Rob </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
   <td style="text-align:left;"> Rob JM Franken </td>
   <td style="text-align:left;"> Unknown affiliation </td>
   <td style="text-align:left;"> 1219 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> no verified email </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Firat, M. (Mustafa) MSc </td>
   <td style="text-align:left;"> Social inequality, older workers, life course and retirement </td>
   <td style="text-align:left;"> Firat </td>
   <td style="text-align:left;"> Mustafa </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
   <td style="text-align:left;"> mustafa Inc </td>
   <td style="text-align:left;"> firat university </td>
   <td style="text-align:left;"> 5298 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 173 </td>
   <td style="text-align:left;"> verified email at firat.edu.tr </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Geurts, P.G. (Nella) MSc </td>
   <td style="text-align:left;"> Integration and migration </td>
   <td style="text-align:left;"> Geurts </td>
   <td style="text-align:left;"> Nella </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
   <td style="text-align:left;"> Nella Geurts </td>
   <td style="text-align:left;"> Department of Sociology, Radboud University </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Jeroense, T.M.G. (Thijmen) MSc </td>
   <td style="text-align:left;"> Political participation, segregation, opinion polarization and voting behaviour </td>
   <td style="text-align:left;"> Jeroense </td>
   <td style="text-align:left;"> Thijmen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> izq-KNUAAAAJ </td>
   <td style="text-align:left;"> Thijmen Jeroense </td>
   <td style="text-align:left;"> PhD candidate, Radboud University Nijmegen </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/personen/jeroense-t/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Loh, S.M. (Renae) MSc </td>
   <td style="text-align:left;"> Educational sociology, social stratification, gender inequality and information communication technology (ICT) </td>
   <td style="text-align:left;"> Loh </td>
   <td style="text-align:left;"> Renae </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> tFaMPOQAAAAJ </td>
   <td style="text-align:left;"> Renae Sze Ming Loh </td>
   <td style="text-align:left;"> PhD candidate, Radboud University </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> http://renaeloh.com/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mensvoort, C.A. van (Carly) MSc </td>
   <td style="text-align:left;"> Gender, leadership and social norms </td>
   <td style="text-align:left;"> Mensvoort </td>
   <td style="text-align:left;"> Carly </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
   <td style="text-align:left;"> Carly van Mensvoort </td>
   <td style="text-align:left;"> Radboud University </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/english/people/mensvoort-c-van/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Müller, K. (Katrin) MSc </td>
   <td style="text-align:left;"> Opinions about discrimination, migration and inequality </td>
   <td style="text-align:left;"> Müller </td>
   <td style="text-align:left;"> Katrin </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
   <td style="text-align:left;"> Kathrin Friederike Müller </td>
   <td style="text-align:left;"> Post-Doc, Universtität Rostock/CAIS NRW </td>
   <td style="text-align:left;"> 201 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> verified email at uni-rostock.de - homepage </td>
   <td style="text-align:left;"> https://www.imf.uni-rostock.de/institut/mitarbeiterinnen/lehrende/dr-kathrin-friederike-mueller/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Raiber, K. (Klara) MSc </td>
   <td style="text-align:left;"> Informal care, employment, social inequality and gender </td>
   <td style="text-align:left;"> Raiber </td>
   <td style="text-align:left;"> Klara </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> xE65HUcAAAAJ </td>
   <td style="text-align:left;"> Klara Raiber </td>
   <td style="text-align:left;"> PhD candidate, Radboud University Nijmegen </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> verified email at maw.ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.ru.nl/english/people/raiber-k/ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ramaekers, M.J.M. (Marlou) MSc </td>
   <td style="text-align:left;"> Prosocial behaviour and family </td>
   <td style="text-align:left;"> Ramaekers </td>
   <td style="text-align:left;"> Marlou </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> fp99JAQAAAAJ </td>
   <td style="text-align:left;"> Marlou Ramaekers </td>
   <td style="text-align:left;"> PhD Candidate, Radboud University </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Houten, J. (Jasper) van MSc </td>
   <td style="text-align:left;"> Sports </td>
   <td style="text-align:left;"> Houten </td>
   <td style="text-align:left;"> Jasper </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
   <td style="text-align:left;"> Jasper van Houten </td>
   <td style="text-align:left;"> PhD Candidate, HAN Institute of Sport and Exercise Studies (Hogeschool van Arnhem en Nijmegen </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> verified email at ru.nl - homepage </td>
   <td style="text-align:left;"> https://www.researchgate.net/profile/Jasper_Houten </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Middendorp J. (Jansje) van MSc </td>
   <td style="text-align:left;"> Home administration </td>
   <td style="text-align:left;"> Middendorp </td>
   <td style="text-align:left;"> Jansje </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
   <td style="text-align:left;"> Jansje van Middendorp </td>
   <td style="text-align:left;"> Buitenpromovendus Radboud Universiteit </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> verified email at ru.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weber, T. (Tijmen) MSc </td>
   <td style="text-align:left;"> International student mobility and the internationalization of higher education </td>
   <td style="text-align:left;"> Weber </td>
   <td style="text-align:left;"> Tijmen </td>
   <td style="text-align:left;"> radboud university </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
   <td style="text-align:left;"> Tijmen Weber </td>
   <td style="text-align:left;"> Lecturer Statistics and Research, HAN University of Applied Sciences </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> verified email at han.nl </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table></div>

So we have papers and profiles. Remember how we got Jochem's citation history? We want that for each staff member too. Yet again, we use a for loop. We first store the citation history in a list. But notice the `if` statement! We only continue the for loop for that i-th element if some statement is `TRUE`. Here, we attempt to find out if the i-th element, the citation history of the staff member, has a length than is larger than 0. Some staff members are never cited (which happens all the time if papers are only just published), and so for these staff members that is no list element that contains information. We only attach a Google Scholar ID for those staff members that are cited at least once. We bind the rows again and end up with a data frame in *long format*: three columns with years, cites, and Google Scholar ID. Therefore, there is more than one row per staff member.


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
# Note how we use some complicated code to make a nice table you can scroll through in this book,
# you could just write 'soc_staff_cit' in your own code Also, no names yet! You could merge the
# names of scholars to gs_id here.
scroll_box(knitr::kable(soc_staff_cit, booktabs = TRUE, caption = "Sociology staff citation by time"),
    height = "300px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; "><table>
<caption>(\#tab:unnamed-chunk-51)Sociology staff citation by time</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> year </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> cites </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> gs_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2001 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 186 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 219 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 257 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 336 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 307 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 358 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 314 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 335 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 183 </td>
   <td style="text-align:left;"> UK7nVSEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;"> e7zfTqMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:left;"> Q4saWX8AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> vzBNQ1kAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:left;"> RG54uasAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:left;"> MEv-V_YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1991 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1992 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1993 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1994 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1995 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1996 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1997 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1998 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2001 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 184 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 277 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 345 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 411 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 441 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 527 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 495 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 591 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 447 </td>
   <td style="text-align:left;"> GDHdsXAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 200 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 231 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 252 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 237 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 206 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 210 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 186 </td>
   <td style="text-align:left;"> n6hiblQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> ZMc0j2YAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:left;"> ZvLlx2EAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:left;"> LsMimOEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 162 </td>
   <td style="text-align:left;"> Nx7pDywAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1997 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1998 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2001 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 126 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 176 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 205 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 246 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 303 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 363 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 460 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 474 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 512 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 614 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 581 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 655 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 621 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 662 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 440 </td>
   <td style="text-align:left;"> l8aM4jAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> iKs_5WkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:left;"> _f3krXUAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1994 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1995 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1996 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1997 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1998 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2001 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 253 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 336 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 439 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 515 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 511 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 622 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 767 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 782 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 935 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 1129 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1076 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1182 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1206 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1163 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 1235 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 863 </td>
   <td style="text-align:left;"> hPeXxvEAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 141 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 223 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 285 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 346 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 287 </td>
   <td style="text-align:left;"> cy3Ye6sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 204 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 228 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 223 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 267 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 297 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 305 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 228 </td>
   <td style="text-align:left;"> Iu23-90AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 229 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 312 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 220 </td>
   <td style="text-align:left;"> w2McVJAAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:left;"> ItITloQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2001 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 148 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 196 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 129 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 222 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 236 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 305 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 301 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 295 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 308 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 299 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 259 </td>
   <td style="text-align:left;"> TqKrXnMAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> bDPtkIoAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:left;"> p3IwtT4AAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2007 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 314 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 750 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 922 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 1100 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 1461 </td>
   <td style="text-align:left;"> _ukytQYAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> VCTvbTkAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> tFaMPOQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:left;"> tFaMPOQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:left;"> tFaMPOQAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> z6iMs-UAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> lkVq32sAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> iR4UIwwAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> gs0li6MAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> KfLALRIAAAAJ </td>
  </tr>
</tbody>
</table></div>



Next, we get the collaborators. Note that on Google Scholar, people add co-authors manually. Unfortunately, we can only scrape the first *twenty* with the `scholar` package. Some scholars have more co-authors listed, but for that you would need to "click" on "VIEW ALL" on Google Scholar. The `scholar` package does not do that for us. However, you could take a look at the underlying code of `get_coathors` and attempts to do that yourself. Because scholars add their own co-authors, it is a directed tie. For instance, I could list Albert Einstein as my co-author, but Albert probably doesn't reciprocate that tie. The for loop should be clear by now. We get collaborators for a given Google Scholar ID, 20 of them, with a depth of at most 1. We then `bind_rows` again, and remove those staff members that did not list any collaborator.


```r
source("addfiles/fcollabs.R")  # Put the function_fix.R in your working directory, we need this first line.
```
<!--- fixed the overlap issue, hier verder --->


```r
# first the soc collaborators note how we already build a function (fcollabs()) for you you need to
# input a google scholar id and a 1 (if you want to find collabs) or 0 (only extracting names)
# fcollabs --> you can check it out if you're interested
soc_collabs <- list()
for (i in 1:nrow(soc_df)) {

    time <- runif(1, 0, 5)
    Sys.sleep(time)

    soc_collabs[[i]] <- fcollabs(soc_df[i, c("gs_id")], 1)

}
soc_collabs <- bind_rows(soc_collabs)  # bind rows, get the unique ones!
soc_collabs_unique <- unique(soc_collabs[, 3])  # so 149 unique collaborators for RU staff?
soc_collabs_unique <- soc_collabs_unique[!is.na(soc_collabs_unique)]

#------------------------------------------------------------------------

# then the names of those collaborators plus THEIR collaborators understand that we don't have
# names of them yet from the code above?
collabs_1deep <- list()
for (i in 1:length(soc_collabs_unique)) {

    time <- runif(1, 0, 3)
    Sys.sleep(time)

    if (!soc_collabs_unique[i] %in% soc_df$gs_id) {
        collabs_1deep[[i]] <- fcollabs(soc_collabs_unique[i], 1)

    }
}
collabs_1deep <- bind_rows(collabs_1deep)
collabs_1deep_unique <- unique(collabs_1deep[, 1])
collabs_1deep_unique <- collabs_1deep_unique[!is.na(collabs_1deep_unique)]

#------------------------------------------------------------------------

# names of the collaborators of collaborators
collabs_1deep_names <- list()
for (i in 1:length(collabs_1deep_unique)) {

    if (!collabs_1deep_unique[i] %in% unique(collabs_1deep[, 2]) & !collabs_1deep_unique[i] %in% soc_df$gs_id) {
        # note the if not in...and in...

        time <- runif(1, 0, 3)
        Sys.sleep(time)

        collabs_1deep_names[[i]] <- fcollabs(collabs_1deep_unique[i], 0)

    }
}
collabs_1deep_names <- bind_rows(collabs_1deep_names)
```







```r
# scroll_box(knitr::kable(soc_df_collabs, booktabs = TRUE) , height='300px')
```

<!---
Finally, we want to get the *article* citation history! Notice how we got like ~3K articles? For all of those articles we need in each year how often they were cited. That means a lot of queries to Google Scholar. We need to prevent that we hit the so-called *rate-limit*. This means that our IP will be blocked for requesting access to a webpage because we did it too often too quickly. Luckily, we can randomize our calls by time in a for loop! Do you understand the code below? (Hint: the code annotation kinda gives it away.)



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

Let's save the data we may use in for the next tutorial.

<!---I don't see the data in the addfiles folder yet---> 


```r
# save the DFs thus far
save(soc_df_publications, "addfiles/soc_df_publications.rda")
save(soc_df, "addfiles/soc_df.rda")
save(soc_df_collabs, "addfiles/soc_df_collabs.rda")
# save(soc_art_cit, 'addfiles/soc_art_cit.rda')) Notice how we did this one for you.
save(soc_staff_cit, "addfiles/soc_staff_cit.rda")
```

<!---if students did not succeed, give the links to the data in our repository --->


By just eyeballing the data there are two suspicous outliers: Muller and Firat and Franken have suspiciously many citations for PhD candidates. By looking up their Google Scholar profiles, we find that both have the wrong Google Scholar ID attached to them (common names error). So we deleted them from the data. The rest seems to have worked fine: less than 5% data corruption in this webscraping effort as there were 45 records in sociology staff directory.



Nicely done, this was the webscraping tutorial for bibliometric data. We gathered useful information about sociology staff: \
- 1.1 who actually is the staff on the RU website? \
- 1.2 staff google scholar profiles (we merged 1.1 and 1.2) \
- 2 publications and total cites per publication \
- 3 collaborators plus their collaborators ("friends-of-friends") \
- 4 publication citation history (cites per year) \
- 5 citation history of scholars themselves (cites per year) \

**With this, you can move on to some potentially very cool network visualization!**

---  
