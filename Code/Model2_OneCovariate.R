##### Setting up the parameters of the study 

#CONSTANTS
NB_OF_ITERATIONS <- 10000

### Define function for the numerator and denominator of the ratio
logaritmo <- function(beta_zero, beta_one,m,c){
  # This function returns the log of the numerator or denominator of the ratio in the Metropolis Hasting step
  # inputs:
  # 	beta_zero: float
  #	beta_one: float
  #		The parameters of the logistic model  
  # 		beta0 + beta1*x = log(\pi) - log(1 - \pi)
  #	y: array of float
  # 		the data following a Bernouilli distribution, fixed over 
  # returns:
  # 	float
  # 	         log likelihood of the numerator or denominator
  #		
  # 		
  likel <- y*(beta_zero+beta_one*x -log(1+exp(beta_zero+beta_one*x)))-(1-y)*log(1+exp(beta_zero+beta_one*x))
  fbeta <- sum(likel)-0.5*(1/c)*(beta0-m)^2
  return(fbeta)
}
##### Other parameters
# Number of studies
n<-100

# Define the true value of the logistic model, \pi is the proportion of papers with this voxel found with
# beta0+beta1*x = log(\pi) - log(1 - \pi)

# Define true values for beta0 and beta1
beta0<-0.1
beta1 <- 0.5

#Simulate data for the covariate x
x<-rnorm(n,0,1)

# Mean and variance of beta0 and beta 1
# beta0 ~ N(m0,c0) 
m0<-0
c0 <- 10

# beta1 ~ N(m1,c1)
m1 <- 0
c1 <- 10
pi_i <-exp(beta0+beta1*x)/(1+exp(beta0+beta1*x))

# Simulate data for y as a random Bernoulli distribution
y<-rbinom(n,1,pi_i)

chain_beta0 =matrix(0, ncol=NB_OF_ITERATIONS)
chain_beta1 =matrix(0, ncol=NB_OF_ITERATIONS)

# Define the structure for the chains and the starting point
chain_beta0[1]=1
chain_beta1[1]=1


# Define the variance of the proposed beta0 and beta1
u0=0.01
u1= 0.05

##### Metropolis-Hastings algorithm
for(i in 2:NB_OF_ITERATIONS){
  #### Sampling beta0
# Current beta0 takes the first value in the chain
  beta0_c =chain_beta0[i-1]
  beta_1 = chain_beta1[i-1]

# Proposed beta0 comes from a random normal distribution
  beta0_p = rnorm(1, beta0_c, sqrt(u0))

# Calculate the ratio using the function logaritmo evaluated in proposed beta0 (beta_p) and current beta0 (beta_c)
  log_ratio_beta =logaritmo(beta0_p,beta_1,m0,c0)-logaritmo(beta0_c,beta_1,m1,c1)

# Metropolis-Hastings, toss a coin 
  coin=log(runif(1))

# Accept proposed value with probability = min (1, ratio)
  if(coin<min(c(0, log_ratio_beta))){
    chain_beta0[i]=beta0_p
  
  }else{
      chain_beta0[i]=beta0_c
    }

##### Sampling beta_1
  beta_0 =chain_beta0[i]
  beta1_c = chain_beta1[i-1]
  
# Proposed beta01 comes from a random normal distribution
  beta1_p = rnorm(1, beta1_c, sqrt(u1))

# Calculate the ratio using the function "logaritmo" evaluated in proposed beta1 (beta1_p) and current beta1 (beta1_c)
  log_ratio_beta =logaritmo(beta_0,beta1_p,m1,c1)-logaritmo(beta_0,beta1_c,m1,c1)

# Metropolis-Hastings, toss a coin 
  coin=log(runif(1))

# Accept proposed value with probability = min (1, ratio)
  if(coin<min(c(0, log_ratio_beta))){
    chain_beta1[i]=beta1_p
    
  }else{
    chain_beta1[i]=beta1_c
  }
  
  
  
}

##### Visualization

hist(chain_beta0[1,])
abline(v=beta0)

hist(chain_beta1[1,])
abline(v=beta1)
print('Done ! look at Rplots.pdf')

