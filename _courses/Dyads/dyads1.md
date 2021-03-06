---
title: Causes of Dyads (theory)
author: Jochem Tolsma
date: '2020-08-31'
slug: dyads1
categories:
  - Social Networks
  - R
  - dyads
tags: []
linktitle: Dyads-Causes-Theory
summary: ~
lastmod: '2020-08-31T09:26:45+02:00'
toc: yes
type: book
weight: 10
---






## General Theoretical Framework

In this section, I would like to introduce a General Theoretical Framework (or micro-macro model) which can be used to explain more or less any social phenomena you are interested in. The GTF can thus also be used to explain the emergence of social networks, and thus also to explain the emergence of dyads, and thus also to explain educational intermarriage. 
{{< vimeo id="453716704" autoplay="true" title="Dyads" >}}  

For slides, see {{% staticref "files/multilevel-framework.pdf" "newtab" %}}here{{% /staticref %}}. 

For more background reading on the multi-level framework (aka "Coleman-boat", "Coleman-bathtub", "micro-macro models") see:  
- Coleman, J.S. (1990). *Foundations of Social Theory.* Cambridge, MA: Harvard University Press.  
- Raub, W. Buskens, V. & Van Assen, M.A. (2011). Mircro-macro links and microfoundations in sociology. *The Journal of Mathematical Sociology, 35*(1-3), 1-25. [**Especially paragraph 4.4**]  

The GTF is a framework, is not a theory from which you can deduce hypotheses. Before we can do that, we need to fill in the blanks. That is, we need to make the social contexts (bridge assumptions) explicit. We need a Theory of Action. We need to think of the interdependencies and how they impact the aggregation mechanism.  
So, let's get started...
  
## Social context effects  
**Characteristics of the social context** in which people are embedded (the marco- and meso-level) may impact people's preferences and resources.  
Example 1: The level of economic inequality impacts how financial resources are unequally distributed across educational groups within society. Hypo1: In countries with more wealth inequality, the difference between educational groups in economic resources is larger.  
Example 2: Societal norms may impact your own views and opinions and thus preferences. Hypo2: In countries with more equal gender norms, men's (women's) preferences for a partner with a higher education are stronger (weaker).

## The special role of restrictions  
**Restrictions** also refer to macro-level characteristics but restrictions do not directly impact preferences and resources (i.e. choice input) but instead influence, or *constrain* how these preferences and resources lead to choice-output; we have a constrained choice model. Restrictions - in studies on the emergence of social networks - impact the *choice-set*, the relevant choice-options that a person has.  
If I would like to marry a grizzly bear but if there are no grizzly bears around which I can marry, I cannot act upon my preferences (commonly the example is about Eskimos but that may be considered more politically incorrect). This is called a *structural restriction*. A more realistic example would be the distribution of educational degrees within society, which depend on educational expansion and inequality of educational opportunities.  
Next, to structural restrictions we may also have *normative restrictions*, the formal and informal rules of institutions. A formal normative restriction would be a *law* that forbids me to marry a grizzly bear. An informal normative restriction would be a *social norm*, e.g. my parents who disapprove of my preference to marry a grizzly bear.  
Please note that social norms may thus impact my preferences directly (a social context effect) and indirectly (act as a restriction). 
Example1: Preferences for a partner with a similar educational level are more likely to lead to educational homogamy, if educational degrees are more evenly distributed across men and women. 

## Theory of Action  

Persons have **preferences** for a partner with a specific educational-level. Commonly, people prefer higher-educated partners (because of instrumental motives) and people have homomphilic preferences. Preferences may differ between persons with different educational levels and between men and women.  
Persons also have **resources** (i.e. economic, cultural, cognitive, social resources) that may affect the search behavior of persons. 
Example1: persons with more economic resources have more options to meet different people and may thus select a partner from a larger choice-set. People with more ICT-skills may be better in finding a partner online.  
Hypo1: persons with more resources are more likely to marry a partner that meet their preferences.  

{{% alert warning %}}
We would like to apply the GTF to explain the emergence of social networks. The networks we observe are the result of people making and breaking social relations. Consequently, a theory of action to explain decision about social relations should explain not only decisions about making new relations (i.e. selection) but also about decision whether or not to maintain or break existing relations (i.e. selection).  
Concretely, if we want to explain the degree of intermarriage within society, we need to take into account both who is marrying whom *and* who is divorcing whom! Consider the following example. For some people the saying 'opposite attracts' may hold true and they may be unaware of or ignore the social norm not to intermarry. But once married the couple may face unanticipated sanctions of violating the social norm, they may be ostracized. Being faced with this unanticipated consequence of their marriage decision, the couple may subsequently decide to divorce. In this example, the social norm thus not influences the selection process (more precisely, does not moderate the impact of preferences on marriage decisions) but it does influence the deselection process.  
Our Theory of Action assumes a cost benefit evaluation of some sort, in line with Rational Action Theory. However, social scientists' view on human's rationality is different than the view of classical economists. Social scientists speak of restricted or bounded rationality; people are not always able to have or process all relevant information to make accurate and correct cost-benefit evaluations. We make questimates about the costs involved in our decision and about the likelihood that our behavior will yield the desired goal. 
{{% /alert %}}
  
## Transformation rules  

We now almost have all ingredients to explain (or predict) the degree of intermarriage in society. We 'only' need the aggregation mechanisms. We thereby need to know how the marriage market functions.   
Let us assume the following: 

- Someone takes the initiative. This is determined by chance. 
- The initial choice-set is formed by 5 random partners of the opposite sex (no assumptions about search behavior). Possible partners who are already married are removed from the initial choice-set. The possible partners that remain constitute the (final) choice set.  
- Persons may prefer a partner with a higher education. These preferences may differ between educational levels and between the sexes.
- Persons choose a partner from their choice set (not marrying is not an option). Possible partners with a higher education have a larger chance to be chosen. How important a partner's education is, depends on the preference of the one taking the initiative. 
- The persons who is being proposed to always accepts. 
- We observe no divorces. 
- Resources do not play any role (e.g the higher educated do not have a larger choice set)
- Educational degrees are either 'high' or 'low'. 

With the above marriage-market model we have a limited number of ingredients that impact the observed degree of educational intermarriage:  

- gender composition within society  
- the distribution of educational degrees in  society  
- preferences  
- the number of marriage proposals

{{% alert warning %}}
I hope you see that marriage choices are interdependent. If I marry person A, you no longer can marry person A. 
These interdependencies make it difficult to predict the macro-level dependent variable, degree of educational homogamy. 
{{% /alert %}}
  

Given the market model above, can you predict who will marry whom?  
Suppose...
1. **%_men=50**: We have an equal gender distribution in society (50% men, 50% women; range: 1-99).  
2. **_men_EducHigh=50**: 50% of our male population is higher educated and 50% is lower educated (range: 1-99).  
3. **_women_EducHigh=50**: 50% of our female population is higher educated and 50% is lower educated (range: 1-99).  
4. **pref_men_EH=0**: Higher educated men do not have any preference with respect to the educational level of their partner. (range: 0-10)
4. **pref_men_EL=0**: Lower educated men do not have any preference with respect to the educational level of their partner. (range: 0-10)
4. **pref_women_EH=0**: Higher educated women do not have any preference with respect to the educational level of their partner. (range: 0-10)
4. **pref_women_EL=0**: Lower educated women do not have any preference with respect to the educational level of their partner. (range: 0-10)

Did you make a guess?? Press update to see if you were correct. 
Play around with (agent-based simulation) model below.  


<embed src="https://jtolsma.shinyapps.io/marriagemarket/" style="width:100%; height: 50vw;">

Go to app [here](https://jtolsma.shinyapps.io/marriagemarket/)


{{% alert note %}}
After having watched the video and after heaving read this page, you should be able to:  
- Understand and summarize the building blocks of the multi-level framework which can be used to explain the emergence of social networks.  
  - macro-level (independent) variable(s)  
    - social conditions  
    - restrictions  
  - bridge assumptions (also called social context effects)  
  - Theory of Action  
    - preferences
    - resources
    - choice-set
    - choice-input
    - choice-output
  - Transformation rules (also called aggregation mechanism)
    - social interdependencies
    - unintended/unforeseen consequences of micro-level behavior
  - macro-level (dependent) variable
- Provide examples of all building blocks in the context of explaining the emergence of dyads 
{{% /alert %}}
  
