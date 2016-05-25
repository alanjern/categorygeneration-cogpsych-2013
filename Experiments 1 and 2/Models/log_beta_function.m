function b = log_beta_function(a)

b = sum(log(gamma(a))) - log(gamma(sum(a)));
