# (PART) EGONETS {-} 

# Theory  






We already introduced egonets in section \@ref(types). We defined an egonet as the **set of ties surrounding sampled individual units.** [cf. @marsden1990]. Thus we have an ego with ties to one or more alters. Suppose that after we have identified the alters of ego, we asked ego the following follow-up question: 


<p class= "quote">
How close are these people to each other?  
1.very close  
2.not close, but not total strangers to each other either   
3.total strangers to each other  
4.I don’t know
</p> 

In this situation we also have information on ties between ego's alters and, subsequently, we may observe triads between our alters. In the figure below I have made the <span style='color: #00FF00;'>triad green</span>.   


<div class="figure">
<img src="03-Egonets_files/figure-html/triads-1.png" alt="A Triad within an egonet" width="672" />
<p class="caption">(\#fig:triads)A Triad within an egonet</p>
</div>
Let us discuss TRIADS in some more detail first, before we move on with our discussion on Egonets. 

## Network Structures (TRIAD) {#triad}

Let us start with all possible triad configurations if we have a (binary) undirected tie. See Figure \@ref(fig:ut).


<div class="figure">
<img src="slide7.png" alt="undirected triad configurations" width="30%" />
<p class="caption">(\#fig:ut)undirected triad configurations</p>
</div>



We observe an *unconnected* triad, a triad with a *connected pair*, an *open triad* and a *closed triad*. The open triad is also called a 'forbidden triad' and actor *i* in such a triad is said to hold a 'brokerage position'.

>How many isomorphs can you think of for a triad with one *connected pair*?  

We only have three nodes but network structures become complex quite quickly. See Figure \@ref(fig:mut) for the many possible configurations for triads when we consider two different type of undirected ties (i.e. multiplexity). 

<div class="figure">
<img src="slide8.png" alt="Multiplex, undirected triad configurations" width="100%" />
<p class="caption">(\#fig:mut)Multiplex, undirected triad configurations</p>
</div>


By now, I am a bit tired of drawing all these nodes and relations. Luckily, the net is full of pictures of the possible directed triad configurations. I stole this one from an online workshop on Social Network Analysis for Anthropologists [here](https://eehh-stanford.github.io/SNA-workshop/).

<div class="figure">
<img src="new-triad-census.png" alt="Directed triad configurations" width="100%" />
<p class="caption">(\#fig:dt)Directed triad configurations</p>
</div>

These triads all have unique names: 

* last digit: number of dyads without ties  
* second digit: number of dyads with one tie  
* first digit: number of dyads with two ties (mutual dyads)  
* specific subtype:  
  - C: cyclic
  - D: downward  
  - U: upward  
  - T: transitive

This triad census has been developed by @davis1967 and their original picture in the paper is too cool not to show here:

<div class="figure">
<img src="Capture.png" alt="Original Triad census by Davis and Leinhard (1967)" width="100%" />
<p class="caption">(\#fig:triadold)Original Triad census by Davis and Leinhard (1967)</p>
</div>

Suppose we are trying to come up with an explanation for why we observe transitive triads (030T) in our network. We must realize that a transitive dyad may be the outcome of different evolution processes. See Figure \@ref(fig:evo).

<div class="figure">
<img src="slide9.png" alt="Different pathways to a transitive triad." width="100%" />
<p class="caption">(\#fig:evo)Different pathways to a transitive triad.</p>
</div>
That is, if we assume that each tie is made subsequently, thus not two tie are created at the same time.^[Otherwise there would be a third pathway directly from the situation on the left to the end state, the transitive triad, on the right.] The reason why *i* closes the triad, may be very different from the reason why *k* closes the triad. It all depends on the social relation under consideration. The take home message is that we need longitudinal data if we would like to disentangle specific explanations.   

> See Figure \@ref(fig:evo). Do you think both pathways are just as likely for (a) 'friendship relations', (b) 'who kicks whom relations' and (c) 'who explains social network analysis to whom? relations'? 

I could not find a nice picture of all possible directed triad configurations for two relations simultaneously. If you have time on your hands, please make one for me! 😀 

So, let us go back to egonets. 

## Type of explanations

If social scientists seek explanations for why we observe specific social networks the explanations generally refer to four aspects, or 'theoretical dimensions', of social networks, namely:

1.  **size**: the number of nodes in the network
2.  **structure**: the relations in the network
3.  **composition**: characteristics of the nodes in the network
4.  **evolution**: change in size, structure and/or composition
    i.  network growth
    ii. tie evolution: structure --\> structure
    iii. node evolution: node attributes --\> node attributes
    iv. influence: structure --\> node attributes
    v.  selection: node attributes --\> structure
  
Where 1, 2 and 3 belong to the *causes* of social networks, evolution processes belong the the *consequences* of social networks.

## Causes  

### Size  

A dyad is by definition constituted by just two nodes. The size of an egonet may vary.  

In section \@ref(types) we introduced the egonet formed by our 'Best Friend Forevers' (BFF). Naturally, we don't have many BFFs. Perhaps it is even a bad example because don't you have at most only one BFF by definition? That said, my daughter (6 years old) claims that all her classmates are BFFs. Anyways. It turns out that if we ask a random sample of adults the following question... 

<p class= "quote"> 
From time to time, most people discuss important matters with other people. Looking back over the last six months—who are the people with whom you discussed matters important to you? 
</p>

...that there are not many people naming more than five persons.^[In many surveys respondents are not even given the opportunity to give more than five persons.] For example, have a look at the table below. Data is from a dataset called CrimeNL [@crimenl]. 

<table class=" lightable-classic table table-striped table-hover table-condensed table-responsive" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-1)Number of confidants in CDN (row %)</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Zero </th>
   <th style="text-align:center;"> One </th>
   <th style="text-align:center;"> Two </th>
   <th style="text-align:center;"> Three </th>
   <th style="text-align:center;"> Four </th>
   <th style="text-align:center;"> Five </th>
   <th style="text-align:center;"> Mean </th>
   <th style="text-align:center;"> SD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> All confidants </td>
   <td style="text-align:center;"> 17.71 </td>
   <td style="text-align:center;"> 31.48 </td>
   <td style="text-align:center;"> 23.71 </td>
   <td style="text-align:center;"> 14.45 </td>
   <td style="text-align:center;"> 6.65 </td>
   <td style="text-align:center;"> 6.00 </td>
   <td style="text-align:center;"> 1.79 </td>
   <td style="text-align:center;"> 1.39 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Higher educated confidants </td>
   <td style="text-align:center;"> 39.91 </td>
   <td style="text-align:center;"> 31.53 </td>
   <td style="text-align:center;"> 15.26 </td>
   <td style="text-align:center;"> 7.69 </td>
   <td style="text-align:center;"> 3.50 </td>
   <td style="text-align:center;"> 2.11 </td>
   <td style="text-align:center;"> 1.10 </td>
   <td style="text-align:center;"> 1.23 </td>
  </tr>
</tbody>
</table>
*Source: CrimeNL*  
N=3.834 (own calculations)  
  
  
The network of our so-called confidants is called the Core-Discussion-Network (CDN). 

Our CDN network thus commonly consists of maximum 5 confidants. The same holds true if we would ask about our loved ones. 

#### Dunbar's number {#cc}

How would we get to know people with whom you form meaningful relations. That is, the people with whom you form stable social relations with and of whom you know how everyone is connected to one another. Perhaps we could use the following question:   

<p class= "quote"> 
Who would you not feel embarrassed about joining uninvited for a drink if you happened to bump into them in a bar? 
</p>

My answer would definitely depend on whether it was asked to me before or after corona. 😉  

Let try a different question: 

<p class= "quote">
Who do you send a Christmas card? 
</p>

Mind you, this question to tap into your meaningful relations was constructed before e-cards existed. 

According to Robin Dunbar most people are able to maintain stable social relations with approximately 100-200 people, with 150 being a typical number and it is hence known as Dunbar's number [@dunbar2010many; @dunbar2015structure]. 

According to Dunbar each *layer* of our social network has a typical size, where the size of each layer increasing as emotional closeness decreases: 

- loved ones: 5  
- good friends: 15
- friends: 50
- meaningful contacts: 150
- acquaintances: 500
- people you can recognize: 1500

#### online 'friends' 

Many people are active on online social networks like FaceBook, Instagram, Strava or what have you. According to this [site](www.statista.com), approximately 40% of U.S Facebook users in the United States (in 2016) had between 0-200 friends, 38% 200-500 friends and 21% 500+ friends. 
There are several crucial differences between the connections we have online versus offline. First of all, it does not cost many resources to make and maintain an online friendship. It may require some social media skills though, which I found out the hard way. After having joined FB at a time when youngster were already moving on to other online communities, it annoyed me to see all kind of uninteresting stories of distant relatives about their cats. I consequently decided to unfriend these persons. This was not appreciated by some other relatives. It turned out I should simply have hidden their content from my timeline. There apparently is a social norm not to unfriend people on FB.   
We already discussed that selection processes should be seen as distinct from deselection processes. I would argue that especially with respect to online social relations within the selection part we need to distinguish processes explaining sending friendship invitations and accepting/declining friendship invitations. 
But notwithstanding these differences, online social networks consist of a series of embedded layers just as offline personal social networks. 

#### weak ties

Social network analysts have struggled how to measure weaker social network relationships, and, by extension, extended social network size for quite a while. We discuss the scaling-up method in more detail here \@ref(su).  


### Composition  

**to do**

- Homophily  
- relation to social capital literature

### Structure   

In this section we will discuss several network measures. In this chapter we focus on egonets but many measures are also relevant for complete networks!  

To illustrate some different ways how we could describe egonets we will use egonets based on co-authorships. We start with randomly sampling two social scientists from the total pool of all social scientists. Currently rolling a dice...and who did we sample...: 

- Bas Hofstra  
- Jochem Tolsma  

From these two sampled social scientists we will use the webscraping techniques described in Chapter \@ref(webintro) to collect 1.5 degree co-author egonetwork.^[To be a bit more precise, we only collect the first 20 co-authors listed on the google scholar page of each ego. I assume these are the 'most important'.] 

See the figures \@ref(fig:jt) and \@ref(fig:bh ) below for a graphical summary of the networks.  




<div class="figure">
<img src="03-Egonets_files/figure-html/jt-1.png" alt="1.5 degree co-author egonetwork of JOCHEM TOLSMA" width="672" />
<p class="caption">(\#fig:jt)1.5 degree co-author egonetwork of JOCHEM TOLSMA</p>
</div>

<div class="figure">
<img src="03-Egonets_files/figure-html/bh-1.png" alt="1.5 degree co-author egonetwork of BAS HOFSTRA" width="672" />
<p class="caption">(\#fig:bh)1.5 degree co-author egonetwork of BAS HOFSTRA</p>
</div>

#### Density {-}


Density is defined as all observed relations divided by all possible relations. Look at the examples below. Are you able to calculate the density of the networks yourself? 



<div class="figure">
<img src="test.png" alt="Different densities?" width="100%" />
<p class="caption">(\#fig:densities)Different densities?</p>
</div>

The density in Bas' network turns out to be: 0.24. 

The density in Jochem's network turns out to be: 0.23.   

For comparison, if we look at friendship networks among pupils in classrooms, we generally observe a density within the range of .2 and .4.

#### Degree centrality {-}

Closely related to density is the concept of degree. The number of ingoing (indegree), outgoing (outdegree) or undirected (degree) relations from each node. In real social networks, we generally observe a right-skewed degree distribution (most people have some friends, few people have many friends). 

> Centrality measures, like degree, can be measured at the **node-level**. For the graph as a whole, we may calculate the **average centrality score** but every node-level centrality measure also has its specific **graph-level** analogue. In what follows we focus on node-level centrality scores.  
At the node-level we may calculate the **raw measure** but to facilitate interpretation we will use **normalized measures**. There may be more than one way by which the raw scores can be normalized. If you use an R package to calculate normalized centrality scores (e.g. `igraph`), please be aware of the applied normalization. 
  
People in a network with relatively many degree are called more central and (normalized) degree centrality is formally defined as:  

$$ C_D(v_i) = \frac{deg(v_i) - min(deg(v))}  {max(deg(v)) - min(deg(v))}, $$  

where $C_D(v_i)$ is degree centrality of $v_i$, vertex *i*, and 'deg' stands for 'degree'. $max(deg(v))$ is the maximal observed degree. $min(deg(v))$ is the minimal observed degree. A different normalization approach would be to divide the node degree by the maximum degree (either the theoretical maximum, or the maximal observed degree).

> Suppose you want to compare the degree centrality of all co-authors in Bas' network. Which normalization approach would you take?  
> Suppose you want to compare the degree centrality of Bas in Bas's network with the degree centrality of Jochem in Jochem's network. Which normalization approach would you take.  



#### Closeness centrality {-}

Closely related to degree centrality is (normalized) 'closeness centrality':  

$$ C_C(v_i) = \frac{N}{\sum_{j}d(v_j, v_i)}, $$   

with N the number of nodes and *d* stands for distance.

#### Betweenness centrality {-}  

A final important measure of centrality I would like to discuss is called betweenness. It is defined as:  

$$ C_B(v_i) = \frac{\sigma_{v_j,v_k}(v_i)}{\sum_{j\neq k\neq i}\sigma(v_j,v_k)}, $$ 


where $\sigma(v_j,v_k)$ is the number of shortest paths between vertices *j* and *k*, $\sigma_{v_j,v_k}(v_i)$, are the number of these shortest paths that pass through vertex $v_i$ . One way to normalize this measure is as follows:  

$$ C_{B_{normalized}}(v_i) =  \frac{C_B(v_i) - min(C_B(v))}{max(C_B(v))-min(C_B(v))} $$  

#### Clustering {-}  

Clustering is an interesting concept. We have immediately an intuitive understanding of it, people lump together in separate groups. But how should we go about defining it more formally? 
The **clustering coefficient** for $v_i$ is defined as the observed ties between all direct neighbors of $v_i$ divided by all possible ties between all direct neighbors of $v_i$. Direct neighbours are connected to $v_i$ via an ingoing and/or outgoing relation. For undirected networks, the clustering coefficient is the same as the **transitivity index**: the number of transitive triads divided by all possible transitive triads. For directed graphs not so.  


Bas' transitivity network in his network turns out to be: 0.13. 

Jochem's transitivity in his network turns out to be: 0.15.   


### Stability  

**TO DO: upload lecture**

## Consequences  

Please brush off your knowledge on dyadic influence processes (see section \@ref(influence)). 
What is the added complexity of egonets? Phrased otherwise, why would some egonets exert more influence than other egonets?   

1. The size of egonets may differ (i.e. node set).   
2. The structure of egonets may differ (i.e. tie set).  
3. The composition of egonetes may differ (i.e. attribute set).  
4. The evolution (stability) of egonets may differ. 

Surprisingly, there is relatively little literature on influence processes going on in egonets. The literature is mainly concerned with dyadic influence process or on influence processes going on in socionets. We also need to be aware that the debate on the consequences of egonets is dominated by researchers interest in the topic of social capital. 

My definition of social capital is...: 

<p class= "quote">
**Social capital** is the extent to which our egocentric networks gives us access to different forms of 'capital' or resources which we may use to our own benefit. 
</p>

Please compare my definition with Nan Lin's definition: 

<p class= "quote">
The resources embedded in a social structure that are accessed and/or mobilized in purposive actions. [@lin2002social].
</p>

Social capital is one of the most heavily disputed concepts in the social sciences. For more definitions see [socialcapitalresearch.com](https://www.socialcapitalresearch.com/literature/definition/). 

The literature on how egonets may influence our opinions and attitudes is sparse. We will discuss egonet influence processes during class and I will upload a lecture with my take on this asap.  

**TO DO: upload lecture**

 <!---  [nice paper](https://www.sciencedirect.com/science/article/pii/S2095809917308056#s0070) with good refs. --->

## Assignment  

Please prepare a short (5-10 min.) presentation on recent developments in the literature that deals with causes for egonets. More specifically pick one topic:  

a. egonets and size (i.e. node set). Start with @paik2013social.   
b. egonets and structure (i.e. tie set). Start with @adamic2003friends.    
c. egonets and composition (i.e. attribute set)  Start with @hofstra2017sources.  
d. egonets and evolution / stability. Start with @small2015stable.     


---  


# Methods  

<style>

.button1 {
  background-color: #f44336; /* Red */ 
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button1:hover {
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}

.button1 {border-radius: 12px;}

.button1 {width: 100%;}
</style>


<script>
function myFunction() {

            var btn = document.getElementById("myButton");
            //to make it fancier
            if (btn.value == "Click to hide code") {
                btn.value = "Click to show code";
                btn.innerHTML = "Click to show code";
            }
            else {
                btn.value = "Click to hide code";
                btn.innerHTML = "Click to hide code";
            }
            //this is what you're looking for
            var x = document.getElementById("myDIV");
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }

</script>


## Causes  

<!---
see @duijn1999multilevel
---> 

## Consequences  

In this part we we start with estimating a micro-macro model. See Figure \@ref(fig:mm) which I adapted from @bennink2016micro for the basic idea. We have to realize that our data has a hierarchical structure: observations (confidants/ties) at the lowest-level (level-one, micro-level, tie-level or confidant-level) are nested in a higher level (level-two, macro-level, network-level or ego-level) and that these observations at the confidant-level are interdependent. <span style='color: red;'>We need to take these interdependencies into account.</span>  
Moreover, if we wish to relate characteristics of our CDN to characteristics of our egos - and yes that is our wish in this section -, our dependent variable is at the macro-level and we 'have to' estimate a micro-macro model. Please read @croon2007predicting and @bennink2016micro.^[If in contrast we would wish to explain ego-characteristics to characteristics of the ties/confidants we could estimate a more traditional macro-micro multi-level model [@duijn1999multilevel]]       

<div class="figure">
<img src="micro-macro1.PNG" alt="Basic micro-macro model" width="480" />
<p class="caption">(\#fig:mm)Basic micro-macro model</p>
</div>
*note:* Adapted from @bennink2016micro




In chapter \@ref(methods) we investigated how spouses influence each others political opinion. In this chapter we continue our discussion but now with respect to our confidants. Suppose we want to investigate how our confidants influence our political opinions. Unfortunately, not many surveys that map the Core Discussion Network include name interpreter questions on the political opinions of the named confidants. However, one of the most important determinant for someone's political opinion is his/her educational attainment.  
There are several theoretical reasons why the educational attainment of our confidants would impact our own opinions. To mention just a few:  

- Education of alter is 'a proxy' of alter's opinions and alter's opinions may influence our opinions.  
- Alters with different educational levels have different life experiences and the life experiences of our alters may influence our opinions.  
- Alters with different educational levels have different knowledge on topics, sharing knowledge on these topics may influence our opinions.  

## Research questions {#rq}

This leads to the following research question:  

1. To what extent does the educational level of our confidants influence our political opinions?  
2. To what extent does the impact of the educational level of our confidants on our political opinion depend on:  
  a. ego characteristics (e.g. educational level)?  
  b. characteristics of our Core Discussion Network as a whole (e.g size)?  
  c. other characteristics of our confidants (e.g age or gender)?  

For each ego (at each time point) we may have information on one to five confidants. As already stated above, these observations are interdependent and we need to take this into account.   Naturally, we also need to be aware that our own educational-level (and political opinion) will influence with whom we discuss important matters. Thus, <span style='color: red;'>we need to take into account selection effects</span>.  

## Data 

We will use the data from the LISS panel.  

<a href="https://www.lissdata.nl/">
  <img src="lisslogo_0.png">
  </a>

More concretely, we will use:  

- 11 waves (2008-2014, 2016-2019)  
- Filter on respondents older than 25. 

We have already constructed a dataset for you guys and gals to work with which contains information on more than 13000 respondents. Don't forget it is a panel data set. This means we have more observations for the same respondent (and his/her CDN) over time. 

Please download this data file to your working directory.





[liss_cdn](addfiles\liss_cdn.Rdata)\

### Variables  

Variables of interest and value labels:

**Ego-level**:  

-   ego_id
-   educ  
-   gender  
-   age
-   eu: opinion of ego on eu_integration: 0 = eu integration has gone too far / 4 = eu 
-   eu_integration: 0 = eu integration has gone too far / 4 = eu integration should go further
-   immigrants: 0 = immigrants should adjust / 4 immigrants can retain their own culture.
-   euthanasia: 1 = euthanasia should be forbidden / 5 euthanasia should be permitted
-   income_diff: 1 differences in income should increase / 5 differences in income should decrease

**confidant-level**:  

- educ_alter**x** 
- gender_alter**x**  
- age_alter**x** 

The **x** refers to the x-mentioned confidant (1-5). 

In the wide dataset each variable ends with "**.y**" where **.y** refers to the survey wave. Thus `educ_alter4.9` refers to the educational level in years of the fourth mentioned confidant in survey_wave 9 (i.e. 2017). 


For the original variables in Dutch see below: 

<p class= "quote"> 
**EU integratie** 

> De Europese integratie is te ver gegaan.  
>  
>  1 Helemaal oneens  
>  2 Oneens   
>  3 Niet eens, niet oneens  
>  4 Eens  
>  5 Helemaal eens  

</p>


<p class= "quote"> **opleiding**  

> Hoogste opleiding met diploma  
> 1 basisonderwijs  
> 2 vmbo  
> 3 havo/vwo  
> 4 mbo  
> 5 hbo  
> 6 wo  
> 7 anders  
> 8 (Nog) geen onderwijs afgerond  
> 9 Volgt nog geen onderwijs  
> Hierbij hebben wij opleiding gecategoriseerd in drie groepen:  
> 1. Laag: basisonderwijs en vmbo  
> 2. Midden: havo/vwo en mbo  
> 3. Hoog: hbo en wo  
> We nemen enkel mensen van 25 jaar en ouder mee. Van hen verwachten we dat ze klaar zijn met hun onderwijscarriere. 

</p>


### Preperation 


```r
#### clean the environment ####.
rm(list=ls())

#### packages ####.
require(tidyverse)
require(lavaan)

##### Data input ###.
load('addfiles/liss_cdn.Rdata')

liss_l <- liss_cdn[[1]]
liss_w <- liss_cdn[[2]]
```

Let us for now focus on the last wave. Thus wave 2019 (wave 11). 

In the literature two approaches are discussed to estimate a micro-macro model, a persons as variables approach and a multi-level approach. The persons as variables approach is - I hope - easiest to implement and for that we need the data in wide format (one row for each respondent). The idea is that the alter scores load on a latent variable at the ego-level. This latent variable has a random component at the ego-level (cf. random intercept in multi-level models). In a basic model with continous manifest variables at the micro-level, the latent variable at the macro-level is the (biased corrected) mean.

## Disaggregation method

But first let us estimate the wrong models. We will start with a disaggregation approach. We need to disaggregate our data so that each row refers to a specific combination of ego, survey_wave and alter. 


```r
#we need to disaggregate our data. thus each ego, wave, alter per row. 
liss_ll <- rbind(liss_l,liss_l,liss_l,liss_l,liss_l)
liss_ll$index_alter <- rep(1:5, each=length(liss_l[,1]))
liss_ll$educ_alter <- NA

liss_ll$educ_alter <- ifelse(liss_ll$index_alter == 1, liss_ll$educ_alter1, liss_ll$educ_alter)
liss_ll$educ_alter <- ifelse(liss_ll$index_alter == 2, liss_ll$educ_alter2, liss_ll$educ_alter)
liss_ll$educ_alter <- ifelse(liss_ll$index_alter == 3, liss_ll$educ_alter3, liss_ll$educ_alter)
liss_ll$educ_alter <- ifelse(liss_ll$index_alter == 4, liss_ll$educ_alter4, liss_ll$educ_alter)
liss_ll$educ_alter <- ifelse(liss_ll$index_alter == 5, liss_ll$educ_alter5, liss_ll$educ_alter)

liss_ll_sel <- liss_ll %>% filter(survey_wave==11)

model1 <- '
  euthanasia ~ educ_alter
  euthanasia ~ 1
  euthanasia ~~ euthanasia
  '



fit1 <- lavaan(model1, data = liss_ll_sel)
summary(fit1)
```

```
## lavaan 0.6-9 ended normally after 9 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                         3
##                                                       
##                                                   Used       Total
##   Number of observations                         10923       29925
##                                                                   
## Model Test User Model:
##                                                       
##   Test statistic                                 0.000
##   Degrees of freedom                                 0
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Expected
##   Information saturated (h1) model          Structured
## 
## Regressions:
##                    Estimate  Std.Err  z-value  P(>|z|)
##   euthanasia ~                                        
##     educ_alter        0.009    0.003    2.726    0.006
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .euthanasia        4.335    0.042  102.363    0.000
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .euthanasia        0.921    0.012   73.902    0.000
```

## Aggregation method

We could also try to aggregate our confidant data. This means we calculate the mean educational level of our confidants solely based on the available data in the observed scores. 


```r
liss_l <- liss_l %>% mutate(educ_alter_mean = rowMeans(cbind(educ_alter1, educ_alter2, educ_alter3, educ_alter4,educ_alter5), na.rm = TRUE)) #calculate the mean educational level of the alters. 

liss_l_sel <- liss_l %>% filter(survey_wave==11)

model1 <- '
  euthanasia ~ educ_alter_mean
  euthanasia ~ 1
  euthanasia ~~ euthanasia
  '

fit2 <- lavaan(model1, data = liss_l_sel, missing = "fiml")
summary(fit2)
```

```
## lavaan 0.6-9 ended normally after 12 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                         3
##                                                       
##                                                   Used       Total
##   Number of observations                          3743        5985
##   Number of missing patterns                         2            
##                                                                   
## Model Test User Model:
##                                                       
##   Test statistic                                 0.000
##   Degrees of freedom                                 0
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Observed
##   Observed information based on                Hessian
## 
## Regressions:
##                    Estimate  Std.Err  z-value  P(>|z|)
##   euthanasia ~                                        
##     educ_alter_men    0.016    0.008    2.020    0.043
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .euthanasia        4.244    0.098   43.513    0.000
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .euthanasia        0.934    0.023   41.207    0.000
```

## Micro-macro model  

Finally, let us estimate a better model. We will not use the observed mean value of the educational levels of the confidants for each ego but will calculate a bias corrected mean. 


```r
liss_l_sel <- liss_l %>% filter(survey_wave==11)

model <- "
  #latent variable
  FX =~ 1*educ_alter1
  FX =~ 1*educ_alter2
  FX =~ 1*educ_alter3
  FX =~ 1*educ_alter4
  FX =~ 1*educ_alter5
  
  #variances
  educ_alter1 ~~ b*educ_alter1
  educ_alter2 ~~ b*educ_alter2
  educ_alter3 ~~ b*educ_alter3
  educ_alter4 ~~ b*educ_alter4
  educ_alter5 ~~ b*educ_alter5
  
  
  FX ~~ FX
  euthanasia ~~ euthanasia
  
  #regression model
  euthanasia ~ FX
  euthanasia ~ 1
  
  #intercepts/means
  educ_alter1 ~ e*1
  educ_alter2 ~ e*1
  educ_alter3 ~ e*1
  educ_alter4 ~ e*1
  educ_alter5 ~ e*1
"


fit3 <- lavaan(model, data = liss_l_sel, missing = "fiml", fixed.x = FALSE)
summary(fit3)
```

```
## lavaan 0.6-9 ended normally after 22 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                        14
##   Number of equality constraints                     8
##                                                       
##                                                   Used       Total
##   Number of observations                          4922        5985
##   Number of missing patterns                        50            
##                                                                   
## Model Test User Model:
##                                                       
##   Test statistic                                46.488
##   Degrees of freedom                                21
##   P-value (Chi-square)                           0.001
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Observed
##   Observed information based on                Hessian
## 
## Latent Variables:
##                    Estimate  Std.Err  z-value  P(>|z|)
##   FX =~                                               
##     educ_alter1       1.000                           
##     educ_alter2       1.000                           
##     educ_alter3       1.000                           
##     educ_alter4       1.000                           
##     educ_alter5       1.000                           
## 
## Regressions:
##                    Estimate  Std.Err  z-value  P(>|z|)
##   euthanasia ~                                        
##     FX                0.032    0.015    2.083    0.037
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .euthanasia        4.423    0.015  303.122    0.000
##    .educ_altr1 (e)   12.487    0.034  370.005    0.000
##    .educ_altr2 (e)   12.487    0.034  370.005    0.000
##    .educ_altr3 (e)   12.487    0.034  370.005    0.000
##    .educ_altr4 (e)   12.487    0.034  370.005    0.000
##    .educ_altr5 (e)   12.487    0.034  370.005    0.000
##     FX                0.000                           
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)
##    .educ_altr1 (b)    5.438    0.083   65.318    0.000
##    .educ_altr2 (b)    5.438    0.083   65.318    0.000
##    .educ_altr3 (b)    5.438    0.083   65.318    0.000
##    .educ_altr4 (b)    5.438    0.083   65.318    0.000
##    .educ_altr5 (b)    5.438    0.083   65.318    0.000
##     FX                2.322    0.099   23.418    0.000
##    .euthanasia        0.972    0.020   47.642    0.000
```


## Random Intercept Cross-Lagged Micro-Macro Model RI-CLP-MM  

Of course we want to take into account selection effects. That is, ego's opinion may also affect the educational level of his/her confidants. Luckily, you are very familiar by now with the RI-CLPM (if not, see section \@ref(modelling-strategy). Let us try to combine the micro-macro model with a RI-CLPM (let's call it an RI-CLP-MM). 

To illustrate I only use four waves: 6-9. 

### Measurement model 

We need to calculate the bias corrected means for each wave. I prefer to do that in a two-step procedure. 


```r
myModel <- '

FX6 =~ 1*educ_alter1.6 + 1*educ_alter2.6 + 1*educ_alter3.6 + 1*educ_alter4.6 + 1*educ_alter5.6   
FX7 =~ 1*educ_alter1.7 + 1*educ_alter2.7 + 1*educ_alter3.7 + 1*educ_alter4.7 + 1*educ_alter5.7   
FX8 =~ 1*educ_alter1.8 + 1*educ_alter2.8 + 1*educ_alter3.8 + 1*educ_alter4.8 + 1*educ_alter5.8   
FX9 =~ 1*educ_alter1.9 + 1*educ_alter2.9 + 1*educ_alter3.9 + 1*educ_alter4.9 + 1*educ_alter5.9   

#variances of latent variables
FX6 ~~ FX6
FX7 ~~ FX7
FX8 ~~ FX8
FX9 ~~ FX9

#constrained variances of manifest variables
educ_alter1.6 ~~ a*educ_alter1.6
educ_alter2.6 ~~ a*educ_alter2.6
educ_alter3.6 ~~ a*educ_alter3.6
educ_alter4.6 ~~ a*educ_alter4.6
educ_alter5.6 ~~ a*educ_alter5.6

educ_alter1.7 ~~ b*educ_alter1.7
educ_alter2.7 ~~ b*educ_alter2.7
educ_alter3.7 ~~ b*educ_alter3.7
educ_alter4.7 ~~ b*educ_alter4.7
educ_alter5.7 ~~ b*educ_alter5.7

educ_alter1.8 ~~ c*educ_alter1.8
educ_alter2.8 ~~ c*educ_alter2.8
educ_alter3.8 ~~ c*educ_alter3.8
educ_alter4.8 ~~ c*educ_alter4.8
educ_alter5.8 ~~ c*educ_alter5.8

educ_alter1.9 ~~ d*educ_alter1.9
educ_alter2.9 ~~ d*educ_alter2.9
educ_alter3.9 ~~ d*educ_alter3.9
educ_alter4.9 ~~ d*educ_alter4.9
educ_alter5.9 ~~ d*educ_alter5.9



#contrained intercepts of the manifest variables (structural changes are picked up by the latent variables)
educ_alter1.6 ~ e*1
educ_alter2.6 ~ e*1
educ_alter3.6 ~ e*1
educ_alter4.6 ~ e*1
educ_alter5.6 ~ e*1

educ_alter1.7 ~ e*1
educ_alter2.7 ~ e*1
educ_alter3.7 ~ e*1
educ_alter4.7 ~ e*1
educ_alter5.7 ~ e*1

educ_alter1.8 ~ e*1
educ_alter2.8 ~ e*1
educ_alter3.8 ~ e*1
educ_alter4.8 ~ e*1
educ_alter5.8 ~ e*1

educ_alter1.9 ~ e*1
educ_alter2.9 ~ e*1
educ_alter3.9 ~ e*1
educ_alter4.9 ~ e*1
educ_alter5.9 ~ e*1



#free the means of the latent variables

FX7 ~ 1
FX8 ~ 1
FX9 ~ 1
'

fit <- lavaan(myModel, data = liss_w, missing = 'ML', fixed.x=FALSE, meanstructure = T)
summary(fit, standardized = T)
```

```
## lavaan 0.6-9 ended normally after 38 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                        47
##   Number of equality constraints                    35
##                                                       
##                                                   Used       Total
##   Number of observations                          6582       13018
##   Number of missing patterns                      1740            
##                                                                   
## Model Test User Model:
##                                                        
##   Test statistic                              13075.965
##   Degrees of freedom                                218
##   P-value (Chi-square)                            0.000
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Observed
##   Observed information based on                Hessian
## 
## Latent Variables:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   FX6 =~                                                                
##     educ_alter1.6     1.000                               1.482    0.538
##     educ_alter2.6     1.000                               1.482    0.538
##     educ_alter3.6     1.000                               1.482    0.538
##     educ_alter4.6     1.000                               1.482    0.538
##     educ_alter5.6     1.000                               1.482    0.538
##   FX7 =~                                                                
##     educ_alter1.7     1.000                               1.508    0.543
##     educ_alter2.7     1.000                               1.508    0.543
##     educ_alter3.7     1.000                               1.508    0.543
##     educ_alter4.7     1.000                               1.508    0.543
##     educ_alter5.7     1.000                               1.508    0.543
##   FX8 =~                                                                
##     educ_alter1.8     1.000                               1.546    0.557
##     educ_alter2.8     1.000                               1.546    0.557
##     educ_alter3.8     1.000                               1.546    0.557
##     educ_alter4.8     1.000                               1.546    0.557
##     educ_alter5.8     1.000                               1.546    0.557
##   FX9 =~                                                                
##     educ_alter1.9     1.000                               1.538    0.557
##     educ_alter2.9     1.000                               1.538    0.557
##     educ_alter3.9     1.000                               1.538    0.557
##     educ_alter4.9     1.000                               1.538    0.557
##     educ_alter5.9     1.000                               1.538    0.557
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##    .edc_ltr1.6 (e)   12.167    0.031  393.604    0.000   12.167    4.421
##    .edc_ltr2.6 (e)   12.167    0.031  393.604    0.000   12.167    4.421
##    .edc_ltr3.6 (e)   12.167    0.031  393.604    0.000   12.167    4.421
##    .edc_ltr4.6 (e)   12.167    0.031  393.604    0.000   12.167    4.421
##    .edc_ltr5.6 (e)   12.167    0.031  393.604    0.000   12.167    4.421
##    .edc_ltr1.7 (e)   12.167    0.031  393.604    0.000   12.167    4.386
##    .edc_ltr2.7 (e)   12.167    0.031  393.604    0.000   12.167    4.386
##    .edc_ltr3.7 (e)   12.167    0.031  393.604    0.000   12.167    4.386
##    .edc_ltr4.7 (e)   12.167    0.031  393.604    0.000   12.167    4.386
##    .edc_ltr5.7 (e)   12.167    0.031  393.604    0.000   12.167    4.386
##    .edc_ltr1.8 (e)   12.167    0.031  393.604    0.000   12.167    4.381
##    .edc_ltr2.8 (e)   12.167    0.031  393.604    0.000   12.167    4.381
##    .edc_ltr3.8 (e)   12.167    0.031  393.604    0.000   12.167    4.381
##    .edc_ltr4.8 (e)   12.167    0.031  393.604    0.000   12.167    4.381
##    .edc_ltr5.8 (e)   12.167    0.031  393.604    0.000   12.167    4.381
##    .edc_ltr1.9 (e)   12.167    0.031  393.604    0.000   12.167    4.406
##    .edc_ltr2.9 (e)   12.167    0.031  393.604    0.000   12.167    4.406
##    .edc_ltr3.9 (e)   12.167    0.031  393.604    0.000   12.167    4.406
##    .edc_ltr4.9 (e)   12.167    0.031  393.604    0.000   12.167    4.406
##    .edc_ltr5.9 (e)   12.167    0.031  393.604    0.000   12.167    4.406
##     FX7               0.057    0.043    1.343    0.179    0.038    0.038
##     FX8               0.199    0.044    4.472    0.000    0.129    0.129
##     FX9               0.248    0.045    5.520    0.000    0.161    0.161
##     FX6               0.000                               0.000    0.000
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##     FX6               2.195    0.089   24.725    0.000    1.000    1.000
##     FX7               2.273    0.085   26.832    0.000    1.000    1.000
##     FX8               2.390    0.093   25.606    0.000    1.000    1.000
##     FX9               2.366    0.095   24.867    0.000    1.000    1.000
##    .edc_ltr1.6 (a)    5.378    0.077   70.264    0.000    5.378    0.710
##    .edc_ltr2.6 (a)    5.378    0.077   70.264    0.000    5.378    0.710
##    .edc_ltr3.6 (a)    5.378    0.077   70.264    0.000    5.378    0.710
##    .edc_ltr4.6 (a)    5.378    0.077   70.264    0.000    5.378    0.710
##    .edc_ltr5.6 (a)    5.378    0.077   70.264    0.000    5.378    0.710
##    .edc_ltr1.7 (b)    5.423    0.072   75.373    0.000    5.423    0.705
##    .edc_ltr2.7 (b)    5.423    0.072   75.373    0.000    5.423    0.705
##    .edc_ltr3.7 (b)    5.423    0.072   75.373    0.000    5.423    0.705
##    .edc_ltr4.7 (b)    5.423    0.072   75.373    0.000    5.423    0.705
##    .edc_ltr5.7 (b)    5.423    0.072   75.373    0.000    5.423    0.705
##    .edc_ltr1.8 (c)    5.325    0.076   69.669    0.000    5.325    0.690
##    .edc_ltr2.8 (c)    5.325    0.076   69.669    0.000    5.325    0.690
##    .edc_ltr3.8 (c)    5.325    0.076   69.669    0.000    5.325    0.690
##    .edc_ltr4.8 (c)    5.325    0.076   69.669    0.000    5.325    0.690
##    .edc_ltr5.8 (c)    5.325    0.076   69.669    0.000    5.325    0.690
##    .edc_ltr1.9 (d)    5.259    0.078   67.621    0.000    5.259    0.690
##    .edc_ltr2.9 (d)    5.259    0.078   67.621    0.000    5.259    0.690
##    .edc_ltr3.9 (d)    5.259    0.078   67.621    0.000    5.259    0.690
##    .edc_ltr4.9 (d)    5.259    0.078   67.621    0.000    5.259    0.690
##    .edc_ltr5.9 (d)    5.259    0.078   67.621    0.000    5.259    0.690
```
We will extract the predicted values of the CFA and add them to our dataset `liss_w`. 
Let's have a look at the constructed variables. 


```r
liss_w <- data.frame(liss_w, predict(fit))
summary(liss_w$FX6)
summary(liss_w$FX7)
summary(liss_w$FX8)
summary(liss_w$FX9)
var(liss_w$FX6, na.rm=T)
var(liss_w$FX7, na.rm=T)
var(liss_w$FX8, na.rm=T)
var(liss_w$FX9, na.rm=T)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  -4.139  -0.483   0.000   0.000   0.262   2.573    6436 
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  -4.156  -0.600   0.057   0.057   0.583   2.613    6436 
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  -4.601  -0.331   0.199   0.199   0.499   2.713    6436 
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  -4.196  -0.099   0.248   0.248   0.446   2.730    6436 
## [1] 0.7675647
## [1] 0.9217957
## [1] 0.8511977
## [1] 0.795766
```

We thus observe an upward trend in the educational-level of the confidants of ego in subsequent waves. This could either be due to egos replacing lower educated confidants with higher educated confidants, due to the same confidants obtaining higher educational degrees over time or due to sample selection and that in subsequent waves more egos participate who happen to have higher educated confidants.^[The trends in the reported mean values are between-ego trends not within-ego trends!]  

### The structural model 


```r
RICLPM <- '
  # Create between components (random intercepts)
  RIx =~ 1*FX6 + 1*FX7 + 1*FX8 + 1*FX9 
  RIy =~ 1*euthanasia.6 + 1*euthanasia.7 + 1*euthanasia.8 + 1*euthanasia.9
  
  # Create within-person centered variables
  wx6 =~ 1*FX6
  wx7 =~ 1*FX7
  wx8 =~ 1*FX8 
  wx9 =~ 1*FX9
  
  wy6 =~ 1*euthanasia.6
  wy7 =~ 1*euthanasia.7
  wy8 =~ 1*euthanasia.8
  wy9 =~ 1*euthanasia.9
  
  # Estimate the lagged effects between the within-person centered variables.
  wx7 ~ a*wx6 + b*wy6
  wx8 ~ a*wx7 + b*wy7
  wx9 ~ a*wx8 + b*wy8
  
  wy7 ~ c*wx6 + d*wy6
  wy8 ~ c*wx7 + d*wy7
  wy9 ~ c*wx8 + d*wy8
  
  # Estimate the (residual) covariance between the within-person centered variables
  wx6 ~~ wy6
  wx7 ~~ wy7
  wx8 ~~ wy8
  wx9 ~~ wy9
  
  # Estimate the variance and covariance of the random intercepts. 
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate the (residual) variance of the within-person centered variables.
  wx6 ~~ wx6
  wy6 ~~ wy6
  wx7 ~~ wx7
  wy7 ~~ wy7 
  wx8 ~~ wx8 
  wy8 ~~ wy8 
  wx9 ~~ wx9 
  wy9 ~~ wy9 

  #include intercepts 
  FX6 ~ 1
  FX7 ~ 1
  FX8 ~ 1
  FX9 ~ 1
  
  euthanasia.6 ~ 1
  euthanasia.7 ~ 1
  euthanasia.8 ~ 1
  euthanasia.9 ~ 1
  
'  

fit5 <- lavaan(RICLPM, data=liss_w, missing = "fiml.x", meanstructure = T )
summary(fit5, standardized = T)
```

```
## lavaan 0.6-9 ended normally after 43 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                        35
##   Number of equality constraints                     8
##                                                       
##                                                   Used       Total
##   Number of observations                          7199       13018
##   Number of missing patterns                        31            
##                                                                   
## Model Test User Model:
##                                                       
##   Test statistic                               118.791
##   Degrees of freedom                                17
##   P-value (Chi-square)                           0.000
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Observed
##   Observed information based on                Hessian
## 
## Latent Variables:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   RIx =~                                                                
##     FX6               1.000                               0.616    0.691
##     FX7               1.000                               0.616    0.649
##     FX8               1.000                               0.616    0.667
##     FX9               1.000                               0.616    0.699
##   RIy =~                                                                
##     euthanasia.6      1.000                               0.863    0.888
##     euthanasia.7      1.000                               0.863    0.883
##     euthanasia.8      1.000                               0.863    0.885
##     euthanasia.9      1.000                               0.863    0.873
##   wx6 =~                                                                
##     FX6               1.000                               0.645    0.723
##   wx7 =~                                                                
##     FX7               1.000                               0.721    0.760
##   wx8 =~                                                                
##     FX8               1.000                               0.688    0.745
##   wx9 =~                                                                
##     FX9               1.000                               0.630    0.715
##   wy6 =~                                                                
##     euthanasia.6      1.000                               0.446    0.459
##   wy7 =~                                                                
##     euthanasia.7      1.000                               0.458    0.469
##   wy8 =~                                                                
##     euthanasia.8      1.000                               0.455    0.466
##   wy9 =~                                                                
##     euthanasia.9      1.000                               0.482    0.487
## 
## Regressions:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   wx7 ~                                                                 
##     wx6        (a)    0.209    0.013   15.988    0.000    0.187    0.187
##     wy6        (b)   -0.006    0.020   -0.292    0.770   -0.004   -0.004
##   wx8 ~                                                                 
##     wx7        (a)    0.209    0.013   15.988    0.000    0.219    0.219
##     wy7        (b)   -0.006    0.020   -0.292    0.770   -0.004   -0.004
##   wx9 ~                                                                 
##     wx8        (a)    0.209    0.013   15.988    0.000    0.228    0.228
##     wy8        (b)   -0.006    0.020   -0.292    0.770   -0.004   -0.004
##   wy7 ~                                                                 
##     wx6        (c)    0.006    0.010    0.614    0.539    0.009    0.009
##     wy6        (d)    0.075    0.017    4.324    0.000    0.073    0.073
##   wy8 ~                                                                 
##     wx7        (c)    0.006    0.010    0.614    0.539    0.010    0.010
##     wy7        (d)    0.075    0.017    4.324    0.000    0.076    0.076
##   wy9 ~                                                                 
##     wx8        (c)    0.006    0.010    0.614    0.539    0.009    0.009
##     wy8        (d)    0.075    0.017    4.324    0.000    0.071    0.071
## 
## Covariances:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   wx6 ~~                                                                
##     wy6              -0.005    0.006   -0.825    0.409   -0.018   -0.018
##  .wx7 ~~                                                                
##    .wy7              -0.011    0.007   -1.581    0.114   -0.035   -0.035
##  .wx8 ~~                                                                
##    .wy8              -0.005    0.007   -0.728    0.467   -0.016   -0.016
##  .wx9 ~~                                                                
##    .wy9               0.002    0.006    0.335    0.738    0.006    0.006
##   RIx ~~                                                                
##     RIy               0.033    0.009    3.766    0.000    0.062    0.062
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##    .FX6              -0.000    0.011   -0.003    0.997   -0.000   -0.000
##    .FX7               0.057    0.012    4.868    0.000    0.057    0.060
##    .FX8               0.199    0.011   17.451    0.000    0.199    0.215
##    .FX9               0.248    0.011   22.852    0.000    0.248    0.282
##    .euthanasia.6      4.411    0.013  350.507    0.000    4.411    4.542
##    .euthanasia.7      4.431    0.013  349.557    0.000    4.431    4.536
##    .euthanasia.8      4.444    0.013  354.901    0.000    4.444    4.556
##    .euthanasia.9      4.411    0.013  341.314    0.000    4.411    4.464
##     RIx               0.000                               0.000    0.000
##     RIy               0.000                               0.000    0.000
##     wx6               0.000                               0.000    0.000
##    .wx7               0.000                               0.000    0.000
##    .wx8               0.000                               0.000    0.000
##    .wx9               0.000                               0.000    0.000
##     wy6               0.000                               0.000    0.000
##    .wy7               0.000                               0.000    0.000
##    .wy8               0.000                               0.000    0.000
##    .wy9               0.000                               0.000    0.000
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##     RIx               0.380    0.010   36.770    0.000    1.000    1.000
##     RIy               0.744    0.015   50.581    0.000    1.000    1.000
##     wx6               0.416    0.010   41.960    0.000    1.000    1.000
##     wy6               0.199    0.006   31.333    0.000    1.000    1.000
##    .wx7               0.502    0.011   44.278    0.000    0.965    0.965
##    .wy7               0.209    0.007   30.909    0.000    0.995    0.995
##    .wx8               0.451    0.011   42.848    0.000    0.952    0.952
##    .wy8               0.206    0.007   30.201    0.000    0.994    0.994
##    .wx9               0.377    0.008   45.519    0.000    0.948    0.948
##    .wy9               0.231    0.007   35.362    0.000    0.995    0.995
##    .FX6               0.000                               0.000    0.000
##    .FX7               0.000                               0.000    0.000
##    .FX8               0.000                               0.000    0.000
##    .FX9               0.000                               0.000    0.000
##    .euthanasia.6      0.000                               0.000    0.000
##    .euthanasia.7      0.000                               0.000    0.000
##    .euthanasia.8      0.000                               0.000    0.000
##    .euthanasia.9      0.000                               0.000    0.000
```

### Include ego's educational level

First construct a variable educ for ego. We take the educational level in years at wave 6, if missing we will take the score of wave 7, etc. We thus consider the educational level of ego as a time invariant variable.
We want to:  

-  include the educational level of ego as predictor for the random intercept referring to ego's opinion towards euthanasia  
-  include the educational level of ego as predictor for the random intercept referring to ego's educational level of the CDN  

Before looking at the 'hidden code' please try to:  
- construct the educational variable for ego  
- estimate the RI-CLPM  
- think of how and why parameter estimates will change  

<button class=button1 onclick="myFunction()" id="myButton" value="Click To Open Instructions">Only click button after 5 minutes!</button>

<div style="display:none;" id="myDIV">


```r
liss_w <- liss_w %>%
  mutate(educ = educ.6, 
         educ = ifelse(is.na(educ), educ.7, educ),
         educ = ifelse(is.na(educ), educ.8, educ),
         educ = ifelse(is.na(educ), educ.9, educ),
         )
```



```r
RICLPM <- '
  # Create between components (random intercepts)
  RIx =~ 1*FX6 + 1*FX7 + 1*FX8 + 1*FX9 
  RIy =~ 1*euthanasia.6 + 1*euthanasia.7 + 1*euthanasia.8 + 1*euthanasia.9
  
  RIx ~ educ
  RIy ~ educ
  
  # Create within-person centered variables
  wx6 =~ 1*FX6
  wx7 =~ 1*FX7
  wx8 =~ 1*FX8 
  wx9 =~ 1*FX9
  
  wy6 =~ 1*euthanasia.6
  wy7 =~ 1*euthanasia.7
  wy8 =~ 1*euthanasia.8
  wy9 =~ 1*euthanasia.9
  
  # Estimate the lagged effects between the within-person centered variables.
  wx7 ~ a*wx6 + b*wy6
  wx8 ~ a*wx7 + b*wy7
  wx9 ~ a*wx8 + b*wy8
  
  wy7 ~ c*wx6 + d*wy6
  wy8 ~ c*wx7 + d*wy7
  wy9 ~ c*wx8 + d*wy8
  
  # Estimate the (residual) covariance between the within-person centered variables
  wx6 ~~ wy6
  wx7 ~~ wy7
  wx8 ~~ wy8
  wx9 ~~ wy9
  
  # Estimate the variance and covariance of the random intercepts. 
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate the (residual) variance of the within-person centered variables.
  wx6 ~~ wx6
  wy6 ~~ wy6
  wx7 ~~ wx7
  wy7 ~~ wy7 
  wx8 ~~ wx8 
  wy8 ~~ wy8 
  wx9 ~~ wx9 
  wy9 ~~ wy9 

  #include intercepts 
  FX6 ~ 1
  FX7 ~ 1
  FX8 ~ 1
  FX9 ~ 1
  
  euthanasia.6 ~ 1
  euthanasia.7 ~ 1
  euthanasia.8 ~ 1
  euthanasia.9 ~ 1
  
'  

fit6 <- lavaan(RICLPM, data=liss_w, missing = "fiml.x", meanstructure = T )
summary(fit6, standardized = T)
```

```
## lavaan 0.6-9 ended normally after 56 iterations
## 
##   Estimator                                         ML
##   Optimization method                           NLMINB
##   Number of model parameters                        37
##   Number of equality constraints                     8
##                                                       
##                                                   Used       Total
##   Number of observations                          8167       13018
##   Number of missing patterns                        55            
##                                                                   
## Model Test User Model:
##                                                       
##   Test statistic                               168.715
##   Degrees of freedom                                23
##   P-value (Chi-square)                           0.000
## 
## Parameter Estimates:
## 
##   Standard errors                             Standard
##   Information                                 Observed
##   Observed information based on                Hessian
## 
## Latent Variables:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   RIx =~                                                                
##     FX6               1.000                               0.622    0.695
##     FX7               1.000                               0.622    0.659
##     FX8               1.000                               0.622    0.673
##     FX9               1.000                               0.622    0.700
##   RIy =~                                                                
##     euthanasia.6      1.000                               0.863    0.889
##     euthanasia.7      1.000                               0.863    0.883
##     euthanasia.8      1.000                               0.863    0.885
##     euthanasia.9      1.000                               0.863    0.873
##   wx6 =~                                                                
##     FX6               1.000                               0.643    0.719
##   wx7 =~                                                                
##     FX7               1.000                               0.710    0.752
##   wx8 =~                                                                
##     FX8               1.000                               0.683    0.739
##   wx9 =~                                                                
##     FX9               1.000                               0.634    0.714
##   wy6 =~                                                                
##     euthanasia.6      1.000                               0.446    0.459
##   wy7 =~                                                                
##     euthanasia.7      1.000                               0.459    0.469
##   wy8 =~                                                                
##     euthanasia.8      1.000                               0.455    0.466
##   wy9 =~                                                                
##     euthanasia.9      1.000                               0.482    0.487
## 
## Regressions:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   RIx ~                                                                 
##     educ              0.132    0.003   44.336    0.000    0.213    0.571
##   RIy ~                                                                 
##     educ              0.016    0.004    3.676    0.000    0.018    0.049
##   wx7 ~                                                                 
##     wx6        (a)    0.196    0.013   15.606    0.000    0.178    0.178
##     wy6        (b)   -0.007    0.020   -0.372    0.710   -0.005   -0.005
##   wx8 ~                                                                 
##     wx7        (a)    0.196    0.013   15.606    0.000    0.204    0.204
##     wy7        (b)   -0.007    0.020   -0.372    0.710   -0.005   -0.005
##   wx9 ~                                                                 
##     wx8        (a)    0.196    0.013   15.606    0.000    0.211    0.211
##     wy8        (b)   -0.007    0.020   -0.372    0.710   -0.005   -0.005
##   wy7 ~                                                                 
##     wx6        (c)    0.005    0.010    0.560    0.575    0.008    0.008
##     wy6        (d)    0.075    0.017    4.335    0.000    0.073    0.073
##   wy8 ~                                                                 
##     wx7        (c)    0.005    0.010    0.560    0.575    0.009    0.009
##     wy7        (d)    0.075    0.017    4.335    0.000    0.076    0.076
##   wy9 ~                                                                 
##     wx8        (c)    0.005    0.010    0.560    0.575    0.008    0.008
##     wy8        (d)    0.075    0.017    4.335    0.000    0.071    0.071
## 
## Covariances:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##   wx6 ~~                                                                
##     wy6              -0.006    0.006   -0.922    0.357   -0.020   -0.020
##  .wx7 ~~                                                                
##    .wy7              -0.011    0.007   -1.551    0.121   -0.034   -0.034
##  .wx8 ~~                                                                
##    .wy8              -0.006    0.007   -0.863    0.388   -0.019   -0.019
##  .wx9 ~~                                                                
##    .wy9               0.002    0.006    0.284    0.777    0.005    0.005
##  .RIx ~~                                                                
##    .RIy               0.021    0.008    2.722    0.006    0.048    0.048
## 
## Intercepts:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##    .FX6              -1.631    0.038  -42.753    0.000   -1.631   -1.823
##    .FX7              -1.574    0.038  -41.068    0.000   -1.574   -1.668
##    .FX8              -1.432    0.038  -37.441    0.000   -1.432   -1.551
##    .FX9              -1.382    0.038  -36.266    0.000   -1.382   -1.557
##    .euthanasia.6      4.221    0.053   79.084    0.000    4.221    4.346
##    .euthanasia.7      4.240    0.053   79.339    0.000    4.240    4.339
##    .euthanasia.8      4.253    0.054   79.473    0.000    4.253    4.359
##    .euthanasia.9      4.220    0.054   78.666    0.000    4.220    4.270
##    .RIx               0.000                               0.000    0.000
##    .RIy               0.000                               0.000    0.000
##     wx6               0.000                               0.000    0.000
##    .wx7               0.000                               0.000    0.000
##    .wx8               0.000                               0.000    0.000
##    .wx9               0.000                               0.000    0.000
##     wy6               0.000                               0.000    0.000
##    .wy7               0.000                               0.000    0.000
##    .wy8               0.000                               0.000    0.000
##    .wy9               0.000                               0.000    0.000
## 
## Variances:
##                    Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
##    .RIx               0.260    0.008   31.467    0.000    0.674    0.674
##    .RIy               0.743    0.015   50.574    0.000    0.998    0.998
##     wx6               0.414    0.009   43.574    0.000    1.000    1.000
##     wy6               0.199    0.006   31.334    0.000    1.000    1.000
##    .wx7               0.488    0.011   45.412    0.000    0.968    0.968
##    .wy7               0.209    0.007   30.914    0.000    0.995    0.995
##    .wx8               0.447    0.010   44.045    0.000    0.958    0.958
##    .wy8               0.206    0.007   30.208    0.000    0.994    0.994
##    .wx9               0.384    0.008   46.782    0.000    0.955    0.955
##    .wy9               0.231    0.007   35.361    0.000    0.995    0.995
##    .FX6               0.000                               0.000    0.000
##    .FX7               0.000                               0.000    0.000
##    .FX8               0.000                               0.000    0.000
##    .FX9               0.000                               0.000    0.000
##    .euthanasia.6      0.000                               0.000    0.000
##    .euthanasia.7      0.000                               0.000    0.000
##    .euthanasia.8      0.000                               0.000    0.000
##    .euthanasia.9      0.000                               0.000    0.000
```

</div>

## Assignment  

1. Please give an interpretation of the most important parameter estimates of the micro-macro models (including the RI-CLP-MM).  
    a. Does the educational level of our confidants influence our opinion towards euthanasia?  
    b. Do you observe selection effects and how can they be explained?  
2. Try to answer the formulated research questions \@ref(rq)
    - you could try to combine the different opinions of ego in one latent variable to increase power.  
    - try to see if the influence of the educational level of the CDN depends on the size of the CDN (I would recommend taking a multi-group perspective) or on ego's educational level in years (I would recommend introducing an interaction effect)  
    - to check whether influence processes depend on other characteristics of the alters is definitely not easy. The method is described in @bennink2016micro but this is too difficult and not feasible in lavaan (perhaps in a two-step approach). You have to try to be creative. 



---  

# Data  

## Sampling  

## Ethical considerations  

## Measurement

### Scaling up {#su}
Let us go back on the Dunbar's number. What social relationships are beyond the 150 “active” relationships in Dunbar’s number? This is something that is often defined as the extended social network [@hofstra2021beyond] or the acquaintanceship network [@diprete2011segregation]. This layer encapsulates all former social ties — from the core to the active social ties — and it includes even the weakest social relationships. It is surprisingly difficult to measure those weaker ties. Imagine that you would have to recall all of your weaker social relationships. How many weaker ties would you be able to recall? Ten, 50, 100, or perhaps even 500? And in the unlikely case that you would be able to recall 500 social relationships, would you have time to write down in a questionnaire who these persons are? Social network analysts have struggled how to measure weaker social network relationships, and, by extension, extended social network size for quite a while. Scientists have used wildly varied approaches to measure extended network size: by asking respondents who they know from random phonebook pages, by counting the number of Christmas cards people send out see \@ref(cc), or by summing up different network roles (e.g., how many accountants do you now?). More recently, scientists have started to gather data unobtrusively from social media where people themselves curated hundreds of their social ties in a list (Twitter followers, instagram follows, and so forth, see Part IV). The sizes of extended social networks obviously vary by the chosen methods to measure those networks. There are estimates up until network sizes of 5,520 [@freeman1989estimating]].

Yet, for ego networks there have been methodological advances how to measure extended network size with surveys in a relatively standardised way: the network scale-up method (hereafter NSUM) [@killworth1998social; @killworth1998estimation; @mccormick2010many]. How does the NSUM work? Consider that there is a population of size N. You could ask respondents how many randomly drawn others n they know in that population. As N increases, however, the likelihood that two random person know one another becomes lower, and with a population N in the millions (like in many countries), that likelihood becomes extremely small. This problem can be tackled, however, by asking respondents how many others they know with a given characteristic. For instance, the NSUM asks “How many people do you know named Bas?” This is more informative than asking which of the ~18.7K Bas’s a respondent knows in the Netherlands. Now we know the fraction of Bas’s a respondent knows in a population. Say I know one Bas. This implies that I know 1/18700 of all Bas’s! If we assume that this fraction applies similarly to all other friend-categories in my network we can extrapolate the fraction the Dutch population:

$$\frac{1}{18,700}\cdot17 million\approx909$$

According to this logic, I know 909 people. When you average this for a set of categories the estimated network size increases in accuracy — e.g., people named Bas, people attending university, and so forth. If we put this in an equation [see @bernard2010counting; @mccormick2010many], it looks like:

$$Basic\;scale-up\;estimator_i = \frac{\Sigma_{k=1}^Ky_{ik}}{\Sigma_{k=1}^KN_{k}}$$

where $y_{ik}$ is the total number of people an individual $i$ claims to know in category $k$, $N_k$ is the size of the category $k$, and $N$ is the size of the entire population. Note that for each category k, you do need to know the population size. The NSUM often starts with relatively similar definitions on what constitutes a relationship. This is important to set a substantive network boundary (what are substantively meaningful connections to consider?) and a methodological boundary. One such network tie definition that scholars have used is, “contacts whom individuals know on a first name basis, such they would have a friendly chat if they were to meet randomly” [cf. @mccarty2001comparing: 29; @diprete2011segregation: 1242; @hofstra2021beyond: 1277]. Note, however, that one may choose another boundary that then influences how small (if asking for more “know” conditions) or large (if releasing “know” conditions) network size estimates will be. Practically, in surveys you could ask respondents how may people they know in a given context in a given year (say, the Netherlands in 2020) on a first name basis such that they would chat with if they were to meet randomly and ask for a battery of items how many people like that they know...

* named Bas  
* named Jochem  
* currently attending university  
* owning a Tesla  
* and so forth…  

You could ask these questions open where respondents fill in a number or with interval censoring where you help respondents answer (e.g., 0, 1-2, 3-5, 6-10, etc.). If you then apply the logic above you have estimated the extended network size with the basic scale-up estimator. The NSUM was originally developed to estimate sizes of hard-to-reach populations — populations for which it is hard to estimate how many there are in a population — such as, for instance, persons who inject drugs. You can use the same logic: if you have calculated an extended social network size of a respondent, you can divide the number of people one reports to know of the unknown population (e.g., how many people do you know who inject drugs?) by the extended network size. If you average that over many respondents and multiply it by the total population size, you know the size of the unknown population. Let’s say I report to know 2 people who inject drugs, have an extended network size of 700 (estimated by the basic scale-up estimator above) in a population of 17 million. This may mean that there are (2/700)*17million=48.5K persons in the total population who inject drugs. Important to remember, therefore, is that there are subpopulations of known size (e.g., people named Bas) and subpopulations of unknown size (e.g., persons who inject drugs) and this can be utilised in the NSUM. The interdependence between social agents in populations can thus be utilised to address many problems.

The basic scale-up estimator above has three issues (it’s called “basic” for a reason): recall errors, transmission biases, and barrier effects. Recall errors are when respondents err in providing estimate for how many people they know in a category; transmission biases are when people are unaware that they know persons in a category (e.g., unaware that someone is attending university); and barrier effects occur when the categories relate to characteristics of respondents (e.g., a Dutch majority respondent may know more Bas’s than a first-generation migrant). There are statistical techniques to account for those issues, though we do not detail those in this chapter. [For an in-depth overview of those techniques, see @mccormick2010many and @maltiel2015estimating.]


---  
