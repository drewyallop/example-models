data {
  int<lower=0> N; 
  int<lower=1,upper=85> county[N];
  vector[N] x;
  vector[N] y;
} 
parameters {
  vector[85] a;
  real beta;
  real<lower=0,upper=100> sigma_a;
  real<lower=0,upper=100> sigma_y;
  real mu_a;
} 
transformed parameters {
  vector[N] y_hat;

  for (i in 1:N)
    y_hat[i] <- beta * x[i] + a[county[i]];
}
model {
  beta ~ normal(0, 1);
  mu_a ~ normal(0, 1);
  a ~ normal (mu_a, sigma_a);

  y ~ normal(y_hat, sigma_y);
}