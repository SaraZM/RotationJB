n<-100
#x<-rnorm(n,0,1)
beta0<-0.1
#beta1<-1.2
mean<-0
var <- 10
#+beta1*x
prob<-exp(mean)/(1+exp(mean))
y<-rbinom(n,1,prob)
iter=2000
chain_beta =matrix(0, ncol=iter)
chain_beta[1]=1


### Define function for beta_c and beta_p
logaritmo <- function(beta){
  likel<-0
  for (i in 1:n){
    logs <- y[i]*(beta-log(1+exp(beta)))-(1-y[i])*log(1+exp(beta))
    likel <- logs+likel
  }
  fbeta <- likel-0.5*(1/var)*(beta-mean)^2
  return(fbeta)
}

#b0 ~ dnorm(0, sd=100)
u=0.01
#########
for(i in 2:iter){
  beta_c=chain_beta[i-1]
  beta_p=rnorm(1, beta_c, sqrt(u))
  #beta_p=exp(log_beta_p)
  
  log_ratio_beta =logaritmo(beta_p)-logaritmo(beta_c)
  coin=log(runif(1))

  if(coin<min(c(0, log_ratio_beta))){
    chain_beta[i]=beta_p

  }else{
  chain_beta[i]=beta_c  
  }
}
