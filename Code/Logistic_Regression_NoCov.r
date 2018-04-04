##### Setting up the parameters of the study

# CONSTANTS
NB_OF_ITERATION <- 5000

##### Define function for the numerator and denominator
logaritmo <- function(beta, y){
  # This function returns the log of the numerator of the ratio in the Metropolis Hasting step
  # inputs:
  # 	beta: float
  #		The parameter of the logistic model  
  # 		beta0 = log(\pi) - log(1 - \pi)
  #	y: array of float
  # 		the data following a Bernouilli distribution, fixed over 
  # returns:
  # 	float
  # 		log likelihood of ...
  # 		
  likel <- y*(beta-log(1+exp(beta)))-(1-y)*log(1+exp(beta))
  fbeta <- sum(likel)-0.5*(1/c0)*(beta-m0)^2
  return(fbeta)
}

# number of studies
n <- 100

# Define the true value of the logistic model, \pi is the proportion of papers with this voxel found
# with beta0 = log(\pi) - log(1 - \pi) 
beta0 <- 10

# Mean and variance of beta0, with beta0 ~ N(m0,c0)
m0 <- 0
c0 <- 100
pi_i <- exp(beta0)/(1+exp(beta0))

# Simulate data for y as a random Bernoulli distribution
y <- rbinom(n,1,pi_i)
chain_beta0 = matrix(0, ncol=NB_OF_ITERATION)
chain_beta0[1] = 1

# Define the variance of the proposed beta0
u = 0.01

##### MH algorithm
for(i in 2:NB_OF_ITERATION){
# Current beta0 takes the first value in the chain
  beta0_c=chain_beta0[i-1]

# Proposed beta0 comes from a random normal distribution
  beta0_p=rnorm(1, beta0_c, sqrt(u))

# Calculate the ratio using the function logaritmo evaluated in proposed beta0 and current beta0
  log_ratio_beta = logaritmo(beta0_p, y)-logaritmo(beta0_c, y)

# Metropolis-Hastings, toss a coin 
  coin=log(runif(1))

# Accept proposed value with prob. = min (1, ratio)
  if(coin < min(c(0, log_ratio_beta))){
    chain_beta0[i] = beta0_p

  }else{
  chain_beta0[i] = beta0_c  
  }
}

##### Visualization

hist(chain_beta0[1,])
abline(v = beta0)
print('Done ! look at Rplots.pdf')
