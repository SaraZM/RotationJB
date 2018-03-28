n<-100
# Define the true value of beta0
beta0<-0.1
# Mean and variance of beta0 beta0 ~ N(m0,c0)
m0<-0
v0 <- 10
pi_i <-exp(mean)/(1+exp(mean))
# Simulate data for y as a random Bernoulli distribution
y<-rbinom(n,1,pi_i)
iter=2000
chain_beta0 =matrix(0, ncol=iter)
chain_beta0[1]=1


### Define function for the numerator and denominator
logaritmo <- function(beta){
  likel <- y*(beta-log(1+exp(beta)))-(1-y)*log(1+exp(beta))
  fbeta <- sum(likel)-0.5*(1/var)*(beta-mean)^2
  return(fbeta)
}
# Define the variance of the proposed beta0
u=0.01
#########
for(i in 2:iter){
# Current beta0 takes the first value in the chain
  beta0_c=chain_beta0[i-1]
# Proposed beta0 comes from a random normal distribution
  beta0_p=rnorm(1, beta0_c, sqrt(u))
# Calculate the ratio using the function logaritmo evaluated in proposed beta0 and current beta0
  log_ratio_beta =logaritmo(beta0_p)-logaritmo(beta0_c)
# Metropolis-Hastings, toss a coin 
  coin=log(runif(1))
# Accept proposed value with prob. = min (1, ratio)
  if(coin<min(c(0, log_ratio_beta))){
    chain_beta0[i]=beta0_p

  }else{
  chain_beta0[i]=beta0_c  
  }
}

hist(chain_beta0[1,])
abline(v=0.1)
