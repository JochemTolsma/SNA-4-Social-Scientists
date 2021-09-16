# (PART) Part 2 EGONETS {-} 

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
<img src="03-Egonets_files/figure-html/unnamed-chunk-1-1.png" alt="A Triad within an egonet" width="672" />
<p class="caption">(\#fig:unnamed-chunk-1)A Triad within an egonet</p>
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
<p class="caption">(\#fig:unnamed-chunk-2)Original Triad census by Davis and Leinhard (1967)</p>
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
<caption>(\#tab:unnamed-chunk-3)Number of confidants in CDN (row %)</caption>
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

From these two sampled social scientists we will use the webscraping techniques described in Chapter \@ref(webintro) to collect 1.5 degree co-author egonetwork^[To be a bit more precise, we only collect the first 20 co-authors listed on the google scholar page of each ego. I assume these are the 'most important'.]. 

See the figures below <!--- insert links---> for a graphical summary of the networks.  




<div class="figure">
<img src="03-Egonets_files/figure-html/unnamed-chunk-5-1.png" alt="1.5 degree co-author egonetwork of JOCHEM TOLSMA" width="672" />
<p class="caption">(\#fig:unnamed-chunk-5)1.5 degree co-author egonetwork of JOCHEM TOLSMA</p>
</div>

<div class="figure">
<img src="03-Egonets_files/figure-html/unnamed-chunk-6-1.png" alt="1.5 degree co-author egonetwork of BAS HOFSTRA" width="672" />
<p class="caption">(\#fig:unnamed-chunk-6)1.5 degree co-author egonetwork of BAS HOFSTRA</p>
</div>

#### density 


Density is defined as all observed relations divided by all possible relations. Look at the examples below. Are you able to calculate the density of the networks yourself? 



<div class="figure">
<img src="test.png" alt="Different densities?" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-8)Different densities?</p>
</div>

The density in Bas' network turns out to be: 0.24. 

The density in Jochem's network turns out to be: 0.23.   

For comparison, if we look at friendship networks among pupils in classrooms, we generally observe a density within the range of .2 and .4.

#### Degree centrality 

Closely related to density is the concept of degree. The number of ingoing (indegree), outgoing (outdegree) or undirected (degree) relations from each node. In real social networks, we generally observe a right-skewed degree distribution (most people have some friends, few people have many friends). 

> Centrality measures, like degree, can be measured at the **node-level**. For the graph as a whole, we may calculate the **average centrality score** but every node-level centrality measure also has its specific **graph-level** analogue. In what follows we focus on node-level centrality scores.  
At the node-level we may calculate the **raw measure** but to facilitate interpretation we will use **normalized measures**. There may be more than one way by which the raw scores can be normalized. If you use an R package to calculate normalized centrality scores (e.g. `igraph`), please be aware of the applied normalization. 
  
People in a network with relatively many degree are called more central and (normalized) degree centrality is formally defined as:  

$$ C_D(v_i) = \frac{deg(v_i) - min(deg(v))}  {max(deg(v)) - min(deg(v))}, $$  

where $C_D(v_i)$ is degree centrality of $v_i$, vertex *i*, and 'deg' stands for 'degree'. $max(deg(v))$ is the maximal observed degree. $min(deg(v))$ is the minimal observed degree. A different normalization approach would be to divide the node degree by the maximum degree (either the theoretical maximum, or the maximal observed degree).

> Suppose you want to compare the degree centrality of all co-authors in Bas' network. Which normalization approach would you take?  
> Suppose you want to compare the degree centrality of Bas in Bas's network with the degree centrality of Jochem in Jochem's network. Which normalization approach would you take.  



#### Closeness centrality

Closely related to degree centrality is (normalized) 'closeness centrality':  

$$ C_C(v_i) = \frac{N}{\sum_{j}d(v_j, v_i)}, $$   

with N the number of nodes and *d* stands for distance.

#### Betweenness centrality  

A final important measure of centrality I would like to discuss is called betweenness. It is defined as:  

$$ C_B(v_i) = \frac{\sigma_{v_j,v_k}(v_i)}{\sum_{j\neq k\neq i}\sigma(v_j,v_k)}, $$ 


where $\sigma(v_j,v_k)$ is the number of shortest paths between vertices *j* and *k*, $\sigma_{v_j,v_k}(v_i)$, are the number of these shortest paths that pass through vertex $v_i$ . One way to normalize this measure is as follows:  

$$ C_{B_{normalized}}(v_i) =  \frac{C_B(v_i) - min(C_B(v))}{max(C_B(v))-min(C_B(v))} $$  

#### Clustering  

Clustering is an interesting concept. We have immediately an intuitive understanding of it, people lump together in separate groups. But how should we go about defining it more formally? 
The **clustering coefficient** for $v_i$ is defined as the observed ties between all direct neighbors of $v_i$ divided by all possible ties between all direct neighbors of $v_i$. Direct neighbours are connected to $v_i$ via an ingoing and/or outgoing relation. For undirected networks, the clustering coefficient is the same as the **transitivity index**: the number of transitive triads divided by all possible transitive triads. For directed graphs not so.  


Bas' transitivity network in his network turns out to be: 0.13. 

Jochem's transitivity in his network turns out to be: 0.15.   




## Consequences  

 - brush off knowledge on dyadic influence processes. 
 - what is the added complexity of egonets?
 
 surprisingly, literature is either on dyadic influence of on influence processes in socionets. 
 <!---  [nice paper](https://www.sciencedirect.com/science/article/pii/S2095809917308056#s0070) with good refs. --->

## Assignment  

- duos. 5-10 min presentation on recent developments in the literature on:  
a. egonets and size  
b. egonets and structure  
c. egonets and composition  
d. egonets and evoluation / stability.   
give for each topic a starting point article. 

---  


# Methods  

Take as starting point material of [last year](https://www.jochemtolsma.nl/courses/egocentric-networks/ego4/) but start with the real LISS dataset to make it more interesting.  

## Before you start  

## Causes  

### Aggregation  

### Disaggregation  

### Micro-macro Model  

#### Multi-level framework  

#### SEM 


## Consequences  

### Macro-micro model  

#### Multi-level framework  

#### SEM 

### Micro-macro-RI-CLPM  



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
