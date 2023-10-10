# Methods  {#socionetsm}








There are many methods for analyzing the four theoretical dimensions of social networks (i.e., size, composition, structure, evolution). 

If we focus on the explanation of the micro-mechanisms that bring about the structure of a social network, I would say there are two main flavors within the social sciences:  

- Exponential-family Random Graph Models: estimated for example with `ergm` see the [statnet](https://statnet.org/) website.  
- Stochastic Actor Orientated Models: estimated for example with `RSiena` see the [Siena](https://www.stats.ox.ac.uk/~snijders/siena/siena.html) main page.  

For a comparison of the two approaches and some advice on which method to choose see [@Block2019]. 

Ideally, you should try to test your hypotheses with both methods. And if results differ across models, ...well try to understand why they do. 

In what follows I will focus on RSiena and I have several reasons for this:  

1. We can use the micro-mechanism not only to explain the evolution of network structure but also of network; composition. Phrased otherwise, with this method (and the right type of data) it is possible to distinguish between; selection and influence processes  
2. I have way more expertise with RSiena than with ergm;^[naturally this does not mean I have a lot of expertise in RSiena]  
3. I think this book has something to add to the current Tutorials for and introductions to RSiena. 


## Goal

The goal of this chapter is that after reading it you understand the very basics of RSiena and are able to read *and understand* the [manual](https://www.stats.ox.ac.uk/~snijders/siena/RSiena_Manual.pdf) and that you can follow the RSiena tutorials on the [RSiena website](https://www.stats.ox.ac.uk/~snijders/siena/siena.html) (for .rmd style scripts see [here](https://jochemtolsma.github.io/RSiena-scripts/)).  

## Getting started 

Start with clean workspace


```{.r .numberLines}
rm(list = ls())
```

### Custom functions

- `fpackage.check`: Check if packages are installed (and install if not) in R  
- `fsave`: Save to processed data in repository  
- `fload`: To load the files back after an `fsave`  
- `fshowdf`: To print objects (tibbles / data.frame) nicely on screen in .rmd  


```{.r .numberLines}
fpackage.check <- function(packages) {
    lapply(packages, FUN = function(x) {
        if (!require(x, character.only = TRUE)) {
            install.packages(x, dependencies = TRUE)
            library(x, character.only = TRUE)
        }
    })
}

fsave <- function(x, file = NULL, location = "./data/processed/") {
    ifelse(!dir.exists("data"), dir.create("data"), FALSE)
    ifelse(!dir.exists("data/processed"), dir.create("data/processed"), FALSE)
    if (is.null(file))
        file = deparse(substitute(x))
    datename <- substr(gsub("[:-]", "", Sys.time()), 1, 8)
    totalname <- paste(location, datename, file, ".rda", sep = "")
    save(x, file = totalname)  #need to fix if file is reloaded as input name, not as x. 
}

fload <- function(filename) {
    load(filename)
    get(ls()[ls() != "filename"])
}

fshowdf <- function(x, ...) {
    knitr::kable(x, digits = 2, "html", ...) %>%
        kableExtra::kable_styling(bootstrap_options = c("striped", "hover")) %>%
        kableExtra::scroll_box(width = "100%", height = "300px")
}
```

### packages

- `RSiena`: what do you think?
- `RsienaTwoStep`: this packages assesses the ministep assumption of RSiena but is useful for this tutorial  
- `devtools`: to load from github  
- `igraph`: plotting tools. For a tutorial on plotting networks, see \@ref(webintro)



```{.r .numberLines}
packages = c("RSiena", "devtools", "igraph")
fpackage.check(packages)
# devtools::install_github('JochemTolsma/RsienaTwoStep', build_vignettes=TRUE)
packages = c("RsienaTwoStep")
fpackage.check(packages)
```

---  

## The logic of SAOMs

See [@ripley2022manual] paragraph 2.1.

## RSiena as ABM 

RSiena models *the evolution* of network structures and/or the behavior of the social agents. 
It takes the situation of the network observed at $T_1$ as starting point. It estimates the 'rules' for the agents how to change their ties and/or behavior. If the model is specified correctly, these rules (or micro mechanisms) have led the situation at wave $T_1$ to evolve into the situation observed at wave $T_2$. 

I would say these 'rules' are our ***micro theory of action***.  
Please note that our behavior may depend on the situation we are in. Similarly, the 'rules' we discover with RSiena are thus conditional on the situation at wave $T_1$. 

If we know the 'rules' of the social agents, we can also *simulate* future networks. And I think this aspect will help us to understand what the 'rules' of the social agents are and to understand what is estimated by `RSiena`. 

### RSiena's ministep

Before we can start to simulate or understand RSiena we need to know what is meant by the ministep assumption. 

Let us quote the manual 

<p class= "quote"> 
The Stochastic Actor-Oriented Model can be regarded as an agent-based (‘actorbased’) simulation model of the network evolution; where all network changes are decomposed into very small steps, so-called ministeps, in which one actor creates or terminates one outgoing tie. 
...
…it does not necessarily reflect a commitment to or belief in any particular theory of action elaborated in the scientific disciplines.
...
It is assumed that actors change their scores on the dependent variable (tie or behavior) such that they improve their total satisfaction […] with her/his local network neighborhood configuration.
...
Actors only evaluate all possible results in the local network neighborhood configurations that result from one ministep.
</p>

Thus, what does the SAOM of RSiena not do??:  

- No re-activity^[<span style='color: red;'>The no-reactivity assumption has been relaxed in the latest version of RSiena</span>]: The act of re-affirming, making or breaking an outgoing tie does not trigger a response by the involved alter  
- No simultaneity: Changes occur one by one.  
  - Hence also no cooperation;  
  - no coordination;  
  - no negotiation  
- No maximization of total utility:  
    - No altruistic behavior: Individual utility is maximized, not total utility  
- No strategic behavior:  
    - Very finite time horizon. Agent does not predict how his/her future local network neighborhood may change after:  
        - Making another ministep him/herself  
        - A ministep of other agents
    - Hence also no investments

This does not mean that RSiena cannot estimate (or better: 'fit') the evolution of networks/behavior that are the consequences of these more complex 'rules' or micro theories but it does so by assuming actors only make ministeps.^[The goal of the package [`RsienaTwoStep`](https://jochemtolsma.github.io/RsienaTwoStep/index.html) is to provide a method to asses the extent to which results obtained by `RSiena::siena07()` depend on the validity of the ministep assumption.]


## Simulation Logic

1. Sample ego  
2. Construct possible alternative future networks based on all possible ministeps of ego    
3. Calculate how sampled ego evaluates these possible networks  
4. Let the ego pick a network, that is, let agent decide on a tie-change  
5. GOTO 1 (STOPPING RULE: until you think we have made enough ministeps)

### Sample an ego  

Let us first start with a network. We will use the build in network of `RsienaTwoStep`, namely `ts_net1`. 

This is what the adjacency matrix looks like:





```{.r .numberLines}
ts_net1
```

```
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    0    0    0    0    0    0    0    0     0
#>  [2,]    0    0    1    0    0    0    0    0    0     0
#>  [3,]    1    0    0    0    0    1    0    0    0     0
#>  [4,]    0    0    0    0    0    0    0    0    1     0
#>  [5,]    0    0    0    0    0    0    0    0    0     0
#>  [6,]    0    0    0    0    0    0    0    0    1     1
#>  [7,]    1    0    0    0    0    0    0    0    0     0
#>  [8,]    0    0    0    0    0    0    0    0    0     1
#>  [9,]    0    0    0    1    0    0    0    1    0     0
#> [10,]    0    0    0    0    0    0    0    1    1     0
```

Naturally, we can also plot `ts_net1`. 


```{.r .numberLines}
net1g <- graph_from_adjacency_matrix(ts_net1, mode = "directed")
coords <- layout_(net1g, nicely())  #let us keep the layout
par(mar = c(0.1, 0.1, 0.1, 0.1))
{
    plot.igraph(net1g, layout = coords)
    graphics::box()
}
```

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-6-1.png" alt="ts_net1" width="672" />
<p class="caption">(\#fig:unnamed-chunk-6)ts_net1</p>
</div>


So only one actor is allowed to make one ministep. But who? This is determined by the rate function and it may depend on ego-characteristics of our social agents (e.g. male/female) and/or on structural-characteristics of our social agents (e.g. indegree, outdegree). And all this can be estimated within RSiena. More often than note, we simply assume that all actors have an equal chance of being selected to make a ministep.  

For more information on the rate function see \@ref(rp).

Okay, we can thus randomly select/sample an agent. 


```{.r .numberLines}
set.seed(24553253)
ego <- ts_select(net = ts_net1, steps = 1)  #in rsienatwostep two actors may make a change together but here not
ego
```

```
#> [1] 4
```


### Possible networks after ministep  

Let us suppose we want to know what the possible networks are after all possible ministeps of `ego` who is part of `ts_net1`. That is, let us assume that it is ego's turn (ego#: 4) to decide on tie-change. What are the possible networks? 

The function `ts_alternatives_ministep()` returns a list of all possible networks after all possible tie-changes available to an ego given the current network.


```{.r .numberLines}
options <- ts_alternatives_ministep(net = ts_net1, ego = ego)
# options
plots <- lapply(options, graph_from_adjacency_matrix, mode = "directed")
par(mar = c(0, 0, 0, 0) + 0.1)
par(mfrow = c(1, 2))

fplot <- function(x) {
    plot.igraph(x, layout = coords, margin = 0)
    graphics::box()
}

# lapply(plots, fplot)
```


<img src="045-Socionets_files/figure-html/unnamed-chunk-9-1.png" width="672" /><img src="045-Socionets_files/figure-html/unnamed-chunk-9-2.png" width="672" /><img src="045-Socionets_files/figure-html/unnamed-chunk-9-3.png" width="672" /><img src="045-Socionets_files/figure-html/unnamed-chunk-9-4.png" width="672" />

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-10-1.png" alt="Network alternatives after all possible ministeps of ego #4" width="672" />
<p class="caption">(\#fig:unnamed-chunk-10)Network alternatives after all possible ministeps of ego #4</p>
</div>


### Network statistics 

Which option will ego choose? Naturally this will depend on which network characteristics (or statistics), $s_i$ ego finds relevant. Let us suppose that ego bases its decision solely on the number of ties it sends to others and the number of reciprocated ties it has with others. 

Let us count the number of ties ego sends to alters. 


```{.r .numberLines}
ts_degree(net = options[[1]], ego = ego)
# or for all options
lapply(options, ts_degree, ego = ego)
```

```
#> [1] 2
#> [[1]]
#> [1] 2
#> 
#> [[2]]
#> [1] 2
#> 
#> [[3]]
#> [1] 2
#> 
#> [[4]]
#> [1] 1
#> 
#> [[5]]
#> [1] 2
#> 
#> [[6]]
#> [1] 2
#> 
#> [[7]]
#> [1] 2
#> 
#> [[8]]
#> [1] 2
#> 
#> [[9]]
#> [1] 0
#> 
#> [[10]]
#> [1] 2
```

And let us count the number of reciprocated ties


```{.r .numberLines}
lapply(options, ts_recip, ego = ego)
```

```
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 1
#> 
#> [[3]]
#> [1] 1
#> 
#> [[4]]
#> [1] 1
#> 
#> [[5]]
#> [1] 1
#> 
#> [[6]]
#> [1] 1
#> 
#> [[7]]
#> [1] 1
#> 
#> [[8]]
#> [1] 1
#> 
#> [[9]]
#> [1] 0
#> 
#> [[10]]
#> [1] 1
```


In the package `RsienaTwoStep` there are functions for the following network statistics $s$: 

  - degree: `ts_degree()` 
  - reciprocity: `ts_recip()`  
  - outdegree activity: `ts_outAct()` 
  - indegree activity: `ts_inAct()` 
  - outdegree popularity: `ts_outPop()` 
  - indegree popularity: `ts_inPop()`  
  - transitivity: `ts_transTrip()` 
  - mediated transitivity: `ts_transMedTrip()`  
  - transitive reciprocated triplets: `ts_transRecTrip()` 
  - number of three-cycles: `ts_cycle3()`  

<span style='color: red;'>Update: there are quite a lot more. But not very relevant for us at this time.</span>  

See @ripley2022manual (Chapter 12) for the mathematical formulation. Naturally, you are free to define your own network statistics. 

### Evaluation function 

But what evaluation value does ego attach to these network statistics and consequently to the network (in its vicinity) as a whole? Well these are the parameters, $\beta_i$, you will normally estimate with `RSiena::siena07()`. 
Let us suppose the importance for:  

- the statistic 'degree', $\beta_1$, is -1  
- for the statistic 'reciprocity', $\beta_2$, is 1.5. 

So you could calculate the evaluation of the network saved in `options[[4]]` by hand: 

$$f_{i}(x) = \Sigma_k\beta_ks_{ik}(x)  ,$$


with $f_{i}$ the evaluation function for agent $i$. $s_{ik}(x)$ are the network statistics $k$ for network $x$ and actor $i$ and $\beta_k$ the corresponding parameters (or importance).


```{.r .numberLines}
option <- 4
ts_degree(options[[option]], ego = ego) * -1 + ts_recip(options[[option]], ego = ego) * 1.5
```

```
#> [1] 0.5
```

Or you could use the `ts_eval()`. 


```{.r .numberLines}
eval <- ts_eval(net = options[[option]], ego = ego, statistics = list(ts_degree, ts_recip), parameters = c(-1,
    1.5))
eval
```

```
#> [1] 0.5
```
Now, let us calculate the evaluation of all possible networks: 

```{.r .numberLines}
eval <- sapply(options, FUN = ts_eval, ego = ego, statistics = list(ts_degree, ts_recip), parameters = c(-1,
    1.5))
eval
print("network with maximum evaluation score:")
which.max(eval)
```

```
#>  [1] -0.5 -0.5 -0.5  0.5 -0.5 -0.5 -0.5 -0.5  0.0 -0.5
#> [1] "network with maximum evaluation score:"
#> [1] 4
```

### Choice function 

So which option will ego choose? Naturally this will be a stochastic process. But we see that option 4 has the highest evaluation. 
We use McFadden's choice function (for more information see [wiki](https://en.wikipedia.org/wiki/Discrete_choice)), that is let $P_{i,a=2}$ be the probability that ego $i$ chooses network/alternative 2 ($x_{a=2}$). The choice function is then given by:  


$$P_{i,a=2} = \frac{exp(f_i(x_{2}))}{\Sigma_{a=1}^A exp(f_i(x_a))},$$  
<!---
with $s_i$ a vector of the value of each network statistics for network $i$ and $\beta$ is the vector of parameter values. Hence, $\mathbf{s_i}^\mathsf{T}\mathbf{\beta}$ is the value of the evaluation for network $i$.
---> 

Let us force ego to make a decision. 


```{.r .numberLines}
choice <- sample(1:length(eval), size = 1, prob = exp(eval)/sum(exp(eval)))
print("choice:")
choice
# print('network:') options[[choice]]
```

```
#> [1] "choice:"
#> [1] 10
```


If we repeat this process, that is...: 

1. sample agent  
2. construct possible alternative networks  
3. calculate how sampled agent evaluates the possible networks  
4. Let the agent pick a network, that is, let agent decide on a tie-change  
5. GO BACK TO 1 (STOPPING RULE: until you think we have made enough ministeps)

...we have an agent based model.   

### Stopping rule  

But how many ministeps do we allow? Well, normally this is estimated by `siena07` by the `rate` parameter.^[Naturally, it is a bit more complicated than that. In RSiena we have a choice between unconditional and conditional estimation. My description of the stopping rule refers to the unconditional estimation.] If we do not make this rate parameter conditional on actor covariates or on network characteristics, the rate parameter can be interpreted as the average number of ministeps each actor in the network is allowed to make before time is up. Let us suppose the `rate` parameter is 2 . Thus in total the number of possible ministeps will be `nrow(ts_net1) * rate`: 20. For a more detailed - **and more correct** -  interpretation of the rate parameter in `siena07` see \@ref(rf). 

## Simulation example  

Let us now simulate how the network **could** evolve given:^[It is also possible to simulate networks within the `RSiena` package itself. But let us stick with functions from `RsienaTwoStep` for now.]  

- starting point at $T_1$ is `ts_net1` 
- rate is set to 2  
- we as scientists think only network statistics degree and reciprocity are important  
- `RSiena::siena07` has determined the parameters for these statistics are -1 and 1.5 respectively  
- We adhere to the ministep assumption and hence set `p2step` to `c(1,0,0)`




```{.r .numberLines}
rate <- 2
degree <- -1
recip <- 1.5
ts_sims(nsims = 1, net = ts_net1, startvalues = c(rate, degree, recip), statistics = list(ts_degree,
    ts_recip), p2step = c(1, 0, 0), chain = FALSE)  #not that rate parameter is automatically included. 
```

```
#> [1] "nsim: 1"
```

```
#> [[1]]
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    0    0    0    1    1    0    0    0     0
#>  [2,]    0    0    1    0    0    1    0    0    0     0
#>  [3,]    0    0    0    0    1    1    0    0    0     0
#>  [4,]    0    0    0    0    0    1    0    0    1     1
#>  [5,]    0    0    0    0    0    0    0    0    0     0
#>  [6,]    0    0    0    0    0    0    0    0    1     1
#>  [7,]    0    0    0    0    0    0    0    0    0     0
#>  [8,]    0    0    0    0    0    0    0    0    0     0
#>  [9,]    1    0    0    1    0    0    0    0    0     0
#> [10,]    0    0    0    0    0    0    0    1    0     0
```

## Estimation logic  

So now you have some grasp of the logic of RSiena. But how does the estimation work?  

Well, that is quite complicated. But it goes something like this:^['it' refers to estimation via the 'Method of Moments'] 

1. Define model: researcher includes effects  
2. initial parameter values of effects (commonly '0')  
3. simulate an outcome network based on these parameter values  
4. compare the network statistics of the simulated outcome network with the observed outcome network at (i.e. the *target values*)  
    - based on the included effects. Thus the simulated network may contain 10 ties, but the observed network may contain 20 ties. Apparently, with the current parameter values we underestimate the density of the outcome network.  
5. tweak/update parameter values in some smart way  
6. GOTO 3 (BREAK RULE: until parameter values cannot be improved anymore / or reached good fit)  
7. simulate a bunch of outcome networks with the obtained parameter values and compare the *expected values* of statistics of the simulated outcome networks with the *target values* of the actual observed outcome network.  
    - we can assess the fit  
    - estimate SE of the parameters
    
Let us suppose network `s501` developed into `s502`. For more information on these networks see `?s501`. 

To estimate this network with `ts_estim`^[I recommend you to estimate networks following the ministep assumption with the package `RSiena`.], we can do the following: 


```{.r .numberLines}
# we do not calculate SE for now.
ans <- ts_estim(net1 = s501, net2 = s502, statistics = list(ts_degree, ts_recip), p2step = c(1, 0, 0),
    conv = 0.01, phase3 = TRUE, itef3 = 50, verbose = TRUE)
```





Let us have a look at the final results: 


```{.r .numberLines}
ans
```

```
#>            estim        SE
#> rate    5.122247 1.1833275
#> degree -2.258332 0.1371387
#> recip   2.428552 0.2102846
```
How to interpret these numbers??


## Interpretation of parameters {#rp}  

### Rate parameter 

The estimated rate parameter has a nice interpretation: **the estimated rate parameter refers to the expected number of opportunities for change per actor in a time period**. 

Let me try to explain. 

The rate function of actor *i* is denoted:  

$$ \lambda_i(x) $$ 

Suppose we have three actors: *i*, *j* and *k*. And suppose that the rate function is a constant, thus the rate function does not depend on the network structure or attributes of the actors. Thus suppose for example:  

* $\lambda_i=5$   
* $\lambda_j=10$  
* $\lambda_k=15$  

The waiting times of actors *i*, *j* and *k* are exponentially distributed with rate parameter $\lambda$. 
What do these exponential distribution look like?  



```{.r .numberLines}
par(mfrow = c(1, 3))

dist_5 <- rexp(10000, rate = 5)
hist(dist_5, main = "rate = lambda_i = 5", freq = FALSE, xlab = "waiting times", xlim = c(0, 2), ylim = c(0,
    9))
abline(v = 1/5, col = "red")

dist_10 <- rexp(10000, rate = 10)
hist(dist_10, main = "rate= lambda_j = 10", freq = FALSE, xlab = "waiting times", xlim = c(0, 2), ylim = c(0,
    9))
abline(v = 1/10, col = "red")

dist_15 <- rexp(10000, rate = 15)
hist(dist_10, main = "rate = lambda_k = 15", freq = FALSE, xlab = "waiting times", xlim = c(0, 2), ylim = c(0,
    9))
abline(v = 1/15, col = "red")
```

<div class="figure">
<img src="045-Socionets_files/figure-html/dists-1.png" alt="Rate parameters and waiting times" width="672" />
<p class="caption">(\#fig:dists)Rate parameters and waiting times</p>
</div>

We now want to determine who will be allowed to take the next ministep. We thus need to sample a waiting time for each actor. Thus each actor gets a waiting time sampled from the exponential distribution with the specified rate parameter: 


```{.r .numberLines}
set.seed(34641)
waitingtimes <- NA
waitingtimes[1] <- rexp(1, rate = 5)
waitingtimes[2] <- rexp(1, rate = 10)
waitingtimes[3] <- rexp(1, rate = 15)
print(paste("waitingtime_", c("i: ", "j: ", "k: "), round(waitingtimes, 3), sep = ""))
```

```
#> [1] "waitingtime_i: 0.264" "waitingtime_j: 0.414" "waitingtime_k: 0.028"
```

Actor *k* has the shortest waiting time and is allowed to take a ministep. 
In the example above we only took one draw out of each exponential distribution. If we would take many draws the expected value of the waiting time is $\frac{1}{\lambda}$ and these values are added as vertical lines in the figure above. Thus with a higher rate parameter $\lambda$ the shorter the expected waiting time. 


Now let us repeat this process of determining who is allowed to take a ministep a couple of times and keep track of who will make the ministep and the time that has passed: 


```{.r .numberLines}
set.seed(245651)
sam_waitingtimes <- NA
time <- 0
for (ministeps in 1:50) {
    waitingtimes <- NA
    waitingtimes[1] <- rexp(1, rate = 5)
    waitingtimes[2] <- rexp(1, rate = 10)
    waitingtimes[3] <- rexp(1, rate = 15)
    actor <- which(waitingtimes == min(waitingtimes))
    time <- time + waitingtimes[actor]
    sam_waitingtimes[ministeps] <- waitingtimes[actor]
    print(paste("ministep nr.: ", ministeps, sep = ""))
    print(paste("waitingtime_", c("i: ", "j: ", "k: ")[actor], round(waitingtimes, 3)[actor], sep = ""))
    print(paste("time past: ", round(time, 3), sep = ""))
}
```

```
#> [1] "ministep nr.: 1"
#> [1] "waitingtime_i: 0.012"
#> [1] "time past: 0.012"
#> [1] "ministep nr.: 2"
#> [1] "waitingtime_k: 0.003"
#> [1] "time past: 0.014"
#> [1] "ministep nr.: 3"
#> [1] "waitingtime_k: 0.013"
#> [1] "time past: 0.027"
#> [1] "ministep nr.: 4"
#> [1] "waitingtime_i: 0"
#> [1] "time past: 0.027"
#> [1] "ministep nr.: 5"
#> [1] "waitingtime_j: 0.052"
#> [1] "time past: 0.08"
#> [1] "ministep nr.: 6"
#> [1] "waitingtime_j: 0.073"
#> [1] "time past: 0.153"
#> [1] "ministep nr.: 7"
#> [1] "waitingtime_k: 0.054"
#> [1] "time past: 0.207"
#> [1] "ministep nr.: 8"
#> [1] "waitingtime_i: 0.016"
#> [1] "time past: 0.223"
#> [1] "ministep nr.: 9"
#> [1] "waitingtime_k: 0.006"
#> [1] "time past: 0.229"
#> [1] "ministep nr.: 10"
#> [1] "waitingtime_k: 0.019"
#> [1] "time past: 0.248"
#> [1] "ministep nr.: 11"
#> [1] "waitingtime_k: 0.044"
#> [1] "time past: 0.292"
#> [1] "ministep nr.: 12"
#> [1] "waitingtime_k: 0.024"
#> [1] "time past: 0.316"
#> [1] "ministep nr.: 13"
#> [1] "waitingtime_i: 0.022"
#> [1] "time past: 0.338"
#> [1] "ministep nr.: 14"
#> [1] "waitingtime_k: 0.038"
#> [1] "time past: 0.376"
#> [1] "ministep nr.: 15"
#> [1] "waitingtime_i: 0.027"
#> [1] "time past: 0.403"
#> [1] "ministep nr.: 16"
#> [1] "waitingtime_k: 0.002"
#> [1] "time past: 0.405"
#> [1] "ministep nr.: 17"
#> [1] "waitingtime_i: 0.045"
#> [1] "time past: 0.45"
#> [1] "ministep nr.: 18"
#> [1] "waitingtime_k: 0.023"
#> [1] "time past: 0.473"
#> [1] "ministep nr.: 19"
#> [1] "waitingtime_i: 0"
#> [1] "time past: 0.474"
#> [1] "ministep nr.: 20"
#> [1] "waitingtime_i: 0.024"
#> [1] "time past: 0.498"
#> [1] "ministep nr.: 21"
#> [1] "waitingtime_k: 0.013"
#> [1] "time past: 0.511"
#> [1] "ministep nr.: 22"
#> [1] "waitingtime_j: 0.018"
#> [1] "time past: 0.529"
#> [1] "ministep nr.: 23"
#> [1] "waitingtime_j: 0.027"
#> [1] "time past: 0.556"
#> [1] "ministep nr.: 24"
#> [1] "waitingtime_j: 0.061"
#> [1] "time past: 0.617"
#> [1] "ministep nr.: 25"
#> [1] "waitingtime_k: 0.018"
#> [1] "time past: 0.635"
#> [1] "ministep nr.: 26"
#> [1] "waitingtime_j: 0.097"
#> [1] "time past: 0.732"
#> [1] "ministep nr.: 27"
#> [1] "waitingtime_j: 0.007"
#> [1] "time past: 0.739"
#> [1] "ministep nr.: 28"
#> [1] "waitingtime_j: 0.009"
#> [1] "time past: 0.748"
#> [1] "ministep nr.: 29"
#> [1] "waitingtime_k: 0.001"
#> [1] "time past: 0.75"
#> [1] "ministep nr.: 30"
#> [1] "waitingtime_j: 0.009"
#> [1] "time past: 0.759"
#> [1] "ministep nr.: 31"
#> [1] "waitingtime_i: 0.012"
#> [1] "time past: 0.77"
#> [1] "ministep nr.: 32"
#> [1] "waitingtime_i: 0.056"
#> [1] "time past: 0.826"
#> [1] "ministep nr.: 33"
#> [1] "waitingtime_k: 0.031"
#> [1] "time past: 0.857"
#> [1] "ministep nr.: 34"
#> [1] "waitingtime_j: 0.051"
#> [1] "time past: 0.908"
#> [1] "ministep nr.: 35"
#> [1] "waitingtime_k: 0.014"
#> [1] "time past: 0.923"
#> [1] "ministep nr.: 36"
#> [1] "waitingtime_j: 0.021"
#> [1] "time past: 0.943"
#> [1] "ministep nr.: 37"
#> [1] "waitingtime_k: 0.021"
#> [1] "time past: 0.965"
#> [1] "ministep nr.: 38"
#> [1] "waitingtime_k: 0.059"
#> [1] "time past: 1.024"
#> [1] "ministep nr.: 39"
#> [1] "waitingtime_k: 0.029"
#> [1] "time past: 1.053"
#> [1] "ministep nr.: 40"
#> [1] "waitingtime_j: 0.013"
#> [1] "time past: 1.065"
#> [1] "ministep nr.: 41"
#> [1] "waitingtime_j: 0.044"
#> [1] "time past: 1.11"
#> [1] "ministep nr.: 42"
#> [1] "waitingtime_k: 0.069"
#> [1] "time past: 1.178"
#> [1] "ministep nr.: 43"
#> [1] "waitingtime_i: 0.066"
#> [1] "time past: 1.244"
#> [1] "ministep nr.: 44"
#> [1] "waitingtime_j: 0.003"
#> [1] "time past: 1.248"
#> [1] "ministep nr.: 45"
#> [1] "waitingtime_j: 0.01"
#> [1] "time past: 1.258"
#> [1] "ministep nr.: 46"
#> [1] "waitingtime_k: 0.086"
#> [1] "time past: 1.343"
#> [1] "ministep nr.: 47"
#> [1] "waitingtime_k: 0.046"
#> [1] "time past: 1.389"
#> [1] "ministep nr.: 48"
#> [1] "waitingtime_k: 0.031"
#> [1] "time past: 1.42"
#> [1] "ministep nr.: 49"
#> [1] "waitingtime_i: 0.007"
#> [1] "time past: 1.427"
#> [1] "ministep nr.: 50"
#> [1] "waitingtime_j: 0.066"
#> [1] "time past: 1.493"
```
I know you are wondering what the distribution of sampled waiting times look like, don't you? 
Well let's sample some more and plot them. 


```{.r .numberLines}
set.seed(245651)
sam_waitingtimes <- NA
for (ministeps in 1:5000) {
    waitingtimes <- NA
    waitingtimes[1] <- rexp(1, rate = 5)
    waitingtimes[2] <- rexp(1, rate = 10)
    waitingtimes[3] <- rexp(1, rate = 15)
    actor <- which(waitingtimes == min(waitingtimes))
    sam_waitingtimes[ministeps] <- waitingtimes[actor]
}

par(mfrow = c(1, 2))
hist(sam_waitingtimes, freq = FALSE, xlab = "waiting times", main = "sampled waiting times")
abline(v = mean(sam_waitingtimes), col = "red")

hist(rexp(5000, rate = 30), freq = FALSE, xlab = "waiting times", main = "rate=30")
abline(v = 1/30, col = "red")
```

<div class="figure">
<img src="045-Socionets_files/figure-html/dists2-1.png" alt="Distribution of waiting times" width="672" />
<p class="caption">(\#fig:dists2)Distribution of waiting times</p>
</div>
The distribution of the sampled waiting times is plotted in the figure above on the left. As you see this distribution is 'identical' to the exponential distribution with a rate parameter $\lambda$ of 30 (5 + 10 + 15 = 30; which is plotted on the right). And the expected waiting time, plotted in red, is 1/30. This leads us to the explanation of the rate parameter within the RSiena manual: 

<p class= "quote"> 
The time duration until the next opportunity of change is exponentially distributed with parameter:  
$$ \lambda_+(x^0)=\Sigma_i \lambda_i (x^0) $$  
</p>

Remember, the waiting times for each actor *i* are exponentially distributed with parameter $\lambda_i$. The observed time duration until the next ministeps are exponentially distributed with parameter $\lambda_+$. 
  
If an actor has a higher rate parameter, the expected sampled waiting time is shorter. And since the actor with the shortest waiting time will make the ministep, actors with the highest rate parameter have the highest probability to have an opportunity for change. Thus **the larger the rate parameter the more opportunities for change there are within a given time period**.

So how many opportunities for change do we have before the total time exceeds 1? Please have a look above with the example of actors *i*, *j* and *k* with rate parameters of 5, 10 and 15 respectively. We see that after ministep 38 time exceeds 1. Of course this was only one run. We could repeat the simulation a couple of times and keep track of the total ministeps and the ministeps for each actor. Let us plot the number of ministeps for actors *i*, *j* and *k* for 1000 simulations. 


```{.r .numberLines}
set.seed(245651)

results <- list()
for (nsim in 1:1000) {
    time <- 0
    steps_tot <- 0
    steps_i <- 0
    steps_j <- 0
    steps_k <- 0
    actors <- NA
    while (time < 1) {
        steps_tot <- steps_tot + 1
        waitingtimes <- NA
        waitingtimes[1] <- rexp(1, rate = 5)
        waitingtimes[2] <- rexp(1, rate = 10)
        waitingtimes[3] <- rexp(1, rate = 15)
        actor <- which(waitingtimes == min(waitingtimes))
        time <- time + waitingtimes[actor]
        actors[steps_tot] <- actor
    }
    results[[nsim]] <- actors
}

# sum(results[[1]]==1) hist(sapply(results, length))

par(mfrow = c(1, 3))
{
    hist(sapply(results, function(x) {
        sum(x == 1)
    }), xlab = "nsteps", main = "actor i: lambda=5")
    abline(v = mean(sapply(results, function(x) {
        sum(x == 1)
    })), col = "red")
}

{
    hist(sapply(results, function(x) {
        sum(x == 2)
    }), xlab = "nsteps", main = "actor j: lambda=10")
    abline(v = mean(sapply(results, function(x) {
        sum(x == 2)
    })), col = "red")
}

{
    hist(sapply(results, function(x) {
        sum(x == 3)
    }), xlab = "nsteps", main = "actor k: lambda=15")
    abline(v = mean(sapply(results, function(x) {
        sum(x == 3)
    })), col = "red")
}
```

<div class="figure">
<img src="045-Socionets_files/figure-html/dists3-1.png" alt="Relation between rate parameters and numuber of ministeps" width="672" />
<p class="caption">(\#fig:dists3)Relation between rate parameters and numuber of ministeps</p>
</div>


Thus **the larger the rate parameter the more opportunities for change per actor there are within a given time period**. And in RSiena the optimal value for the rate parameter $\lambda_i$ is estimated. And from the figure above we see that the estimated parameter has a nice interpretation: **the estimated rate parameter refers to the expected number of opportunities for change in a time period**. 

### Network statistics 

The evaluation function is defined as: 

$$ f^{net}_i(x) = \Sigma_k \beta^{net}_ks_{ik}^{net}(x) $$
Thus $f^{net}$ is the evaluation function. And it attaches a value/number to the *attractiveness* of the network, $x$. The subscript *i* refers to the agent, thus each agent will get its own value of the evaluation function. $\beta^{net}_k$ refers to our estimated parameters. These are what the results will spit out. And for each network effect *k*, $s^{net}_{ik}$, we will obtain a separate estimate. Each agent evaluates the attractiveness of its local network environment. This is why $s_i$ has a subscript *i*. We as scientists have ideas about which network effects $s^{net}_{ik}$ may play a role in the evaluation of the local networks. Based on the mathematical definition of $s^{net}_{ik}$ the value of statistic *k* will be determined for each of the possible networks that may result after a ministep of agent *i*. Agent *i* is most likely to take a ministep that will result in the network with the highest attractiveness value. The RSiena software will then estimate the parameters $\beta^{net}_k$ for which it is most likely to obtain the network observed at T2 given the network observed at T1. More precisely, to observe a network at T2 with similar network structures as the actual network observed at T2.       

Now, let us suppose that actor *i* has an opportunity for change at that after a ministep three possible networks could occur. Or stated otherwise, the choice set consists of three networks for actor *i*. See below. 


<div class="figure">
<img src="./eva1.PNG" alt="Choice set for actor *i*." width="616" />
<p class="caption">(\#fig:choiceset)Choice set for actor *i*.</p>
</div>

How actor *i* evaluates these networks depends on the $s^{net}_{ik}$ in the evaluation function. Let us suppose only the outdegree effect is part of the evaluation function. Thus: 

$f^{net}_i(x) = \beta^{net}_1s_{i1}^{net}(x)$  

where,   

$s_{i1}^{net}(x) = \Sigma_jx_{ij}$  

and given the networks above:  

- $s_{i1}^{net}(x_a) = 0$  
- $s_{i1}^{net}(x_b) = 1$  
- $s_{i1}^{net}(x_c) = 1$  
  
and hence:  

- $f^{net}_i(x_a) = 0$
- $f^{net}_i(x_b) = \beta^{net}_1$  
- $f^{net}_i(x_c) = \beta^{net}_1$  

The probability that $x_b$ will be chosen is given by:

$$ P(X= x_b) = \frac{exp(f^{net}_i(x_b))}{exp(f^{net}_i(x_a))+exp(f^{net}_i(x_b))+exp(f^{net}_i(x_c))} $$  

For the interpretation is much easier to interpret the ratio of two probabilities: 

$$ \frac{P(X= x_b)}{P(X= x_a)} = \frac{exp(f^{net}_i(x_b))}{exp(f^{net}_i(x_a))} = exp(f^{net}_i(x_b) - f^{net}_i(x_a) ) = exp(\beta^{net}_1)$$

Let us assume that $\beta^{net}_1 = -2$ Thus the probability to observe a tie between *i* and *j* (network $x_b$) is $exp(-2)= 13.5\%$ the probability to observe no tie between *i* and *j* (network $x_a$).  


>Is it possible to deduce the density of the network from this formula? Well let suppose actor *i* would only have options $x_a$ and $x_b$ then the probabilities would need to sum to 1. And thus:  
$$ P(X= x_b) = exp(-2) * P(X= x_a) = 
exp(-2) * (1 - P(X= x_b)) = exp(-2) / (1 + exp(-2)) \approx 0.12 $$  
The density is estimated to be 0.12.  

The interpretation of the parameters thus resembles the interpretation of a logistic regression: if one covariate $c_k$ increases only with one step and the parameter estimate of this covariate is $\beta_k$, the odds $\frac{P_{c_k=1}}{1-P_{c_k=1}} = exp(\beta_k)*\frac{P_{c_k=0}}{1-P_{c_k=0}}$^[ $$P(Y=1) = \frac{exp(\beta_kx_k)}{1+exp(\beta_kx_k)}$$ ]

## RSiena Example  


### Getting started

Start with clean workspace 


```{.r .numberLines}
rm(list = ls())
```


### Goal

We have two goals:  

1. How to make an RSiena object ready to analyze.  
2. Analyze a (very very) simple network evolution model  


### Custom functions  

- `fpackage.check`: Check if packages are installed (and install if not) in R ([source](https://vbaliga.github.io/verify-that-r-packages-are-installed-and-loaded/)).  
- `fsave`: Save to processed data in repository  
- `fload`: To load the files back after an `fsave`  
- `fshowdf`: To print objects (tibbles / data.frame) nicely on screen in .rmd   
- `f_pubnets`: select scholars and construct directed publication network. 


```{.r .numberLines}
fpackage.check <- function(packages) {
    lapply(packages, FUN = function(x) {
        if (!require(x, character.only = TRUE)) {
            install.packages(x, dependencies = TRUE)
            library(x, character.only = TRUE)
        }
    })
}

fsave <- function(x, file = NULL, location = "./data/processed/") {
    ifelse(!dir.exists("data"), dir.create("data"), FALSE)
    ifelse(!dir.exists("data/processed"), dir.create("data/processed"), FALSE)
    if (is.null(file))
        file = deparse(substitute(x))
    datename <- substr(gsub("[:-]", "", Sys.time()), 1, 8)
    totalname <- paste(location, datename, file, ".rda", sep = "")
    save(x, file = totalname)  #need to fix if file is reloaded as input name, not as x. 
}

fload <- function(filename) {
    load(filename)
    get(ls()[ls() != "filename"])
}

fshowdf <- function(x, ...) {
    knitr::kable(x, digits = 2, "html", ...) %>%
        kableExtra::kable_styling(bootstrap_options = c("striped", "hover")) %>%
        kableExtra::scroll_box(width = "100%", height = "300px")
}



# this is the most important one. We created it in the previous script

f_pubnets <- function(df_scholars = df, list_publications = publications, discip = "sociology", affiliation = "RU",
    waves = list(wave1 = c(2018, 2019, 2020), wave2 = c(2021, 2022, 2023))) {

    publications <- list_publications %>%
        bind_rows() %>%
        distinct(title, .keep_all = TRUE)

    df_scholars %>%
        filter(affil1 == affiliation | affil2 == affiliation) %>%
        filter(discipline == discip) -> df_sel

    networklist <- list()
    for (wave in 1:length(waves)) {
        networklist[[wave]] <- matrix(0, nrow = nrow(df_sel), ncol = nrow(df_sel))
    }

    publicationlist <- list()
    for (wave in 1:length(waves)) {
        publicationlist[[wave]] <- publications %>%
            filter(gs_id %in% df_sel$gs_id) %>%
            filter(year %in% waves[[wave]]) %>%
            select(author) %>%
            lapply(str_split, pattern = ",")
    }

    publicationlist2 <- list()
    for (wave in 1:length(waves)) {
        publicationlist2[[wave]] <- publicationlist[[wave]]$author %>%
            # lowercase
        lapply(tolower) %>%
            # Removing diacritics
        lapply(stri_trans_general, id = "latin-ascii") %>%
            # only last name
        lapply(word, start = -1, sep = " ") %>%
            # only last last name
        lapply(word, start = -1, sep = "-")
    }

    for (wave in 1:length(waves)) {
        # let us remove all publications with only one author
        remove <- which(sapply(publicationlist2[[wave]], FUN = function(x) length(x) == 1) == TRUE)
        publicationlist2[[wave]] <- publicationlist2[[wave]][-remove]
    }

    for (wave in 1:length(waves)) {
        pubs <- publicationlist2[[wave]]
        for (ego in 1:nrow(df_sel)) {
            # which ego?
            lastname_ego <- df_sel$lastname[ego]
            # for all publications
            for (pub in 1:length(pubs)) {
                # only continue if ego is author of pub
                if (lastname_ego %in% pubs[[pub]]) {
                  aut_pot <- which.max(pubs[[pub]] %in% lastname_ego)
                  # only continue if ego is first author of pub
                  if (aut_pot == 1) {
                    # check all alters/co-authors
                    for (alter in 1:nrow(df_sel)) {
                      # which alter
                      lastname_alter <- df_sel$lastname[alter]
                      if (lastname_alter %in% pubs[[pub]]) {
                        networklist[[wave]][ego, alter] <- networklist[[wave]][ego, alter] + 1
                      }
                    }
                  }
                }
            }
        }
    }
    return(list(df = df_sel, network = networklist))
}
```



### packages

- `RSiena`: what do you think? :-)



```{.r .numberLines}
packages = c("RSiena", "tidyverse", "stringdist", "stringi")

fpackage.check(packages)
```

### input 

We base the example on the co-author networks of sociologists and political scientists in the Netherlands. You will scrape this data yourself in later chapters. You can download the end products below: 



`<a href="data:application/octet-stream;base64,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" download="20230621df_complete.rda">Download 20230621df_complete.rda</a>`{=html}. 


Save file in correct directory: './data/processed'. 


```{.r .numberLines}
df <- fload("./data/processed/20230621df_complete.rda")
publications <- fload("./data/processed/20230621list_publications_jt.rda")
```


### RU - sociology 

Let us for now focus only on the sociologists of the Radboud University


```{.r .numberLines}
output <- f_pubnets(df_scholars = df, list_publications = publications, discip = "sociology", affiliation = "RU",
    waves = list(wave1 = c(2018, 2019, 2020), wave2 = c(2021, 2022, 2023)))

df_soc <- output[[1]]
df_network <- output[[2]]
```

## Step 1: define data

### dependent variable  


```{.r .numberLines}
# let us check the number of waves
length(df_network)
```

```
#> [1] 2
```

```{.r .numberLines}
wave1 <- df_network[[1]]
wave2 <- df_network[[2]]
# let us put the diagonal to zero
diag(wave1) <- 0
diag(wave2) <- 0
# we want a binary tie (not a weighted tie)
wave1[wave1 > 1] <- 1
wave2[wave2 > 1] <- 1
# put the nets in an array
net_soc_array <- array(data = c(wave1, wave2), dim = c(dim(wave1), 2))
# dependent
net <- sienaDependent(net_soc_array)
```

### independent variables


```{.r .numberLines}
# gender
gender <- as.numeric(df_soc$gender == "female")
gender <- coCovar(gender)
```

Note that you can and must define a lot more relevant independent variables to build a theoretical plausible model.  

### combine variables into RSiena data object

```{.r .numberLines}
mydata <- sienaDataCreate(net, gender)
```

## Step 2: create effects structure


```{.r .numberLines}
myeff <- getEffects(mydata)
# effectsDocumentation(myeff)
```


## Step 3: get initial description


```{.r .numberLines}
ifelse(!dir.exists("results"), dir.create("results"), FALSE)
```

```
#> [1] FALSE
```

```{.r .numberLines}
print01Report(mydata, modelname = "./results/soc_init")
```

**And have a look at it!!**

![](results/soc_init.txt){#id .class width=100% height=200px}

What do we learn from this file?  

## Step 4: specify model  

This should be both empirically and theoretically motivated. 
Most importantly, hopefully you have already thought about this step when you formulated your hypotheses.  


```{.r .numberLines}
myeff <- includeEffects(myeff, isolateNet, inPop, outAct)  #we know that quite a lot of staff has not published with someone else
```

```
#>   effectName            include fix   test  initialValue parm
#> 1 indegree - popularity TRUE    FALSE FALSE          0   0   
#> 2 outdegree - activity  TRUE    FALSE FALSE          0   0   
#> 3 network-isolate       TRUE    FALSE FALSE          0   0
```

```{.r .numberLines}
myeff <- includeEffects(myeff, sameX, egoX, altX, interaction1 = "gender")
```

```
#>   effectName   include fix   test  initialValue parm
#> 1 gender alter TRUE    FALSE FALSE          0   0   
#> 2 gender ego   TRUE    FALSE FALSE          0   0   
#> 3 same gender  TRUE    FALSE FALSE          0   0
```
What structural effects would we normally want to include? 

## Step5 estimate


```{.r .numberLines}
myAlgorithm <- sienaAlgorithmCreate(projname = "soc_init")
ansM1 <- siena07(myAlgorithm, data = mydata, effects = myeff, returnDeps = TRUE)
# if necessary estimate again!  ansM1 <- siena07(myAlgorithm, data = mydata, effects = myeff,
# prevAns = ansM1, returnDeps=TRUE)
ansM1
```




```
#> Estimates, standard errors and convergence t-ratios
#> 
#>                                 Estimate   Standard   Convergence 
#>                                              Error      t-ratio   
#> 
#> Rate parameters: 
#>   0       Rate parameter         4.1024  ( 1.0245   )             
#> 
#> Other parameters: 
#>   1. eval outdegree (density)   -3.0197  ( 0.5269   )    0.0153   
#>   2. eval reciprocity            1.6435  ( 0.4275   )   -0.0419   
#>   3. eval indegree - popularity  0.2214  ( 0.0602   )    0.0040   
#>   4. eval outdegree - activity   0.0963  ( 0.0781   )    0.0171   
#>   5. eval network-isolate        2.1063  ( 1.0425   )   -0.0133   
#>   6. eval gender alter          -0.4043  ( 0.3000   )   -0.0325   
#>   7. eval gender ego             0.4457  ( 0.3063   )    0.0102   
#>   8. eval same gender            0.1380  ( 0.2652   )    0.0283   
#> 
#> Overall maximum convergence ratio:    0.0801 
#> 
#> 
#> Total of 2753 iteration steps.
```


## Step 6: GOF

Here, scripts are shown that can be used to present violin plots representing how well the simulations of our SIENA models capture the distribution of features of the dependent variable(s) (i.e., networks and 'behavior') that were not directly modeled, but for which a good fit between model and data is desirable. 

Background reading: Lospinoso & Snijders [-@Lospinoso2019].

### Background


The goal of GOF-testing is to ensure that our estimated SIENA model accurately represents the observed data of the dependent variable, based on so-called *auxiliary* statistics, such as the distribution of outdegrees, indegrees, reciprocity, triadic configurations, geodesic distances, behavior traits, edgewise similarity, etc. This list is not exhaustive and should be tailored to the specific research question.

The assessment of fit involves comparing observed network features to their expected values in the estimated distribution of networks, derived from a large number of simulations (saved when `returnDeps=TRUE` in the `siena07`-call). If the assessment reveals a poor fit, it becomes necessary to propose model elaborations to improve the fit between the model and data.

Although one might possess theoretical notions about remediation, the complex nature of networks introduces a vast array of potential effects to consider (as shown by the large list of effects in the RSiena manual). In many instances, relying solely on theory and experience is insufficient to confidently propose the effects that ought to be incorporated for better model fit. Also, experimenting with various model specifications can be time-consuming.

`RSiena` provides a computationally efficient predictor for assessing the fit if the model were to be extended by specific additional effects. This estimator can be evaluated using only ingredients calculated already for the method-of-moments estimation of the restricted model (thus, testing an effect without estimating it, by setting `test=TRUE` and `fix=TRUE` in the `includeEffects`-call). 


The results can be plotted which then produce violin plots, which present the distribution of the statistic as a combination of a box plot and a smooth approximation to the density (by a kernel density estimate), with the observed values superimposed.

The *p*-values for `sienaGOF` compare, in the space of outcomes of the auxiliary statistic, the position of the observed data to the cloud of points formed by the simulated data sets that correspond to the estimated model. This comparison is with respect to the ‘distance’ from the center of
the cloud of points, where ‘distance’ is between quotation marks because it is the Mahalanobis distance, which takes into account the correlations and different variances of the components of the auxiliary statistic.

A very small value of *p* indicates poor fit. The customary value of *p* = 0.05 may be used as a threshold determining whether the
fit is adequate, but this threshold is of even less importance here than it is in the case of regular hypothesis testing.  Concluding, if p = 0, then with respect to the auxiliary statistic the fit is poor; it might be rather poor or extremely poor, and you do not know how extreme it is.

For more info, we refer to the article by Lospinoso & Snijders [-@Lospinoso2019] and the RSiena manual section 5.14.  

### Define GOF-auilliary  

Now we define some functions from `sienaGOF-auxiliary`.


```{.r .numberLines}
# see here: ?'sienaGOF-auxiliary'

# The geodesic distribution is not available from within RSiena, and therefore is copied from the
# help page of sienaGOF-auxiliary:

# GeodesicDistribution calculates the distribution of non-directed geodesic distances; see
# ?sna::geodist The default for \code{levls} reflects the usual phenomenon that geodesic distances
# larger than 5 do not differ appreciably with respect to interpretation.  Note that the levels of
# the result are named; these names are used in the \code{plot} method.
GeodesicDistribution <- function(i, data, sims, period, groupName, varName, levls = c(1:5, Inf), cumulative = TRUE,
    ...) {
    x <- networkExtraction(i, data, sims, period, groupName, varName)
    require(sna)
    a <- sna::geodist(symmetrize(x))$gdist
    if (cumulative) {
        gdi <- sapply(levls, function(i) {
            sum(a <= i)
        })
    } else {
        gdi <- sapply(levls, function(i) {
            sum(a == i)
        })
    }
    names(gdi) <- as.character(levls)
    gdi
}

# The following function is taken from the help page for sienaTest

testall <- function(ans) {
    for (i in which(ans$test)) {
        sct <- score.Test(ans, i)
        cat(ans$requestedEffects$effectName[i], "\n")
        print(sct)
    }
    invisible(score.Test(ans))
}
```


### apply sienaGOF  

Now, we can go to applying `sienaGOF` to our data. 
Goodness-of-fit tests based on various auxiliary statistics:


```{.r .numberLines}
gofi0 <- sienaGOF(ansM1, IndegreeDistribution, verbose = FALSE, join = TRUE, varName = "net")
gofo0 <- sienaGOF(ansM1, OutdegreeDistribution, verbose = FALSE, join = TRUE, levls = c(0:10, 15, 20),
    varName = "net")
gof0.gd <- sienaGOF(ansM1, GeodesicDistribution, cumulative = FALSE, verbose = FALSE, join = TRUE, varName = "net")
```







#### indegree distribution


```{.r .numberLines}
# to check the indegree distribution of the outcome network ourselves:
table(colSums(wave2))
```

```
#> 
#>  0  1  2  4  5  6  7  9 
#> 26  8  7  1  1  2  1  1
```



```{.r .numberLines}
plot(gofi0, main = "")
```

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-41-1.png" alt="Goodness of Fit of Indegree Distribution" width="672" />
<p class="caption">(\#fig:unnamed-chunk-41)Goodness of Fit of Indegree Distribution</p>
</div>

The redline are the values of the outcome network `wave2`. We thus see that in our outcome network `wave2` 26 scholars do not have an indegree. An additional 8 scholars (34-26) have 1 indegree, etc.. Our simulated networks thus underestimate the number of scholars with 0 indegree but overestimates the number of scholars with 3,4,5 and 6 indegrees. However, according to the statistic the probability observe the actual observed network given the population of simulated networks is not smaller than p<0.05. We conclude our model is able to 'predict' the actual distribution of the observed netwerk. 

#### outdegree distribution


```{.r .numberLines}
plot(gofo0, main = "")
```

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-42-1.png" alt="Goodness of Fit of Outdegree Distribution" width="672" />
<p class="caption">(\#fig:unnamed-chunk-42)Goodness of Fit of Outdegree Distribution</p>
</div>

The outdegree is an almost perfect fit. Together with the above, we however must be able to include statistics or covariates that take into account that these outdegree are apparantly send to specific others.  

#### geodesic distances


```{.r .numberLines}
plot(gof0.gd, main = "")
```

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-43-1.png" alt="Goodness of Fit of Geodesic Distribution" width="672" />
<p class="caption">(\#fig:unnamed-chunk-43)Goodness of Fit of Geodesic Distribution</p>
</div>

### Step 7: Relative Influence

Background reading: Indlekofer & Brander [(-@indlekofer2013)].


Until now, the interpretation of estimated effects in our SIENA models has been limited to testing their statistical significance, which determines whether an effect plays a role in the evolution of the network (using t-statistics). But we do not yet know how these effects fare against each other with respect to how important they are for actor decision probabilities

There are four issues when extrapolating the size of estimated parameters to their relative importance in SIENA models:

1. *Explanatory statistics have different scales* (e.g., one micro-step may increase the number of reciprocated ties by at most 1 but may result in up to 2(*N*-2) new transitive triplets).

2. *Explanatory variables are often correlated*, making it difficult to establish causality (e.g., a tie bridging a two-path may yield a new transitive triplet, while at the same time, a reciprocated tie).

3. *Multiple and complex choice sets exist*, where network effects influence the probabilities of several alternative choices, and these effects are themselves influenced by a combination of several effects. This interdependence makes it challenging to assess the individual contribution of each effect to actor decisions.

4. *The data undergoes substantial unobserved changes over time*, and the size of parameter estimates is strongly dependent on the structure of the evolving network data. The absence of certain network configurations can render specific effects irrelevant in decision-making processes at certain points in time (e.g., if an ego has no incoming ties, he has no opportunity to reciprocate a tie, making that the `reciprocity` effect cannot influence his decision).

To compare the relative importance of effects within a model, among different models, or across different datasets, we require a measure that specifically focuses on the extent to which effects influence actor decision probabilities.

This is where the concept of 'Relative Importance' (RI) measures comes into play. This measure reflects the extent that estimated model parameters affect change probabilities in network decision probabilities. They should be interpreted as the influence of effects on network changes relative to one another. The importance of an effect is estimated based on the extent to which network micro-steps would have differed if this effect were to be omitted. Probabilities for tie changes from the perspective of each actor are calculated using the fitted model parameters. Subsequently, each parameter is fixed to 0 and the change probabilities are recalculated. The influence of an effect on network (or: behavior) micro-steps is evaluated based on the magnitude of the difference in the distribution of change probabilities with the particular effect present versus absent. These differences are normalized so that their sum is 1 for each actor, and subsequently averaged across actors. 


For more info, we refer to the article by Indlekofer & Brandes [-@indlekofer2013] and the RSiena manual section 13.5.1. 


Let us applying `sienaRI` to our data.


```{.r .numberLines}
RI <- sienaRI(data = mydata, ans = ansM1)
```

And plot the results.


```{.r .numberLines}
plot(RI, addPieChart = TRUE, legendColumns = 3)
```

<div class="figure">
<img src="045-Socionets_files/figure-html/unnamed-chunk-45-1.png" alt="Relative Influence Plots" width="672" />
<p class="caption">(\#fig:unnamed-chunk-45)Relative Influence Plots</p>
</div>
The top row refers to the relative influence of effects at $T_1$, wave1, tho bottom row at $T_2$, wave 2. 
The bar charts display the relative influence of effects for individual actors. The last bar chart in each row, as well as the pie chart, display the relative influenced aggregated to all actors.   
What do we conclude. We can compare the relative influence at the two time points. At wave1 the relative importance of network-isolate played a role for most actors, but no longer at wave2. The indegree-popularity is more important at wave2.  
We can also compare the relative influence between actors. We observe that for many actors reciprocity does not play a role in their decisions. This make sense as many actors do not have a tie to reciprocate. 


----
