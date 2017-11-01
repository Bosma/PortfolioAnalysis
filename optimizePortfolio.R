library(PortfolioAnalytics)

tickers <- c("VTI", "IEF", "TLT", "VNQ")

source("getSymbols.R")

source("getReturns.R")

portfolio <- portfolio.spec(assets = colnames(returns))
portfolio <- add.constraint(portfolio = portfolio, type = "full_investment")
portfolio <- add.constraint(portfolio = portfolio, type = "long_only")
portfolio <- add.constraint(portfolio = portfolio, type = "box", min = 0, max = 0.8)

min_variance <- add.objective(portfolio = portfolio, type = 'risk', name = 'StdVar')
mean_variance <- add.objective(portfolio = portfolio, type = 'return', name = 'mean')

rets_and_weights <- function(portfolio) {
  opt_portfolio <- optimize.portfolio(R = returns, portfolio = portfolio, trace = TRUE)
  portf_returns <- Return.portfolio(R = returns, 
                                    weights = opt_portfolio$weights,
                                    rebalance_on = "months")
  list(weights = opt_portfolio$weights, returns = portf_returns)
}

min_variance_opt <- rets_and_weights(min_variance)
mean_variance_opt <- rets_and_weights(mean_variance)

opt_comparison <- merge(min_variance_opt$returns, mean_variance_opt$returns, SPY_rets)
names(opt_comparison) <- c("Min. Var", "Mean Var", "SPY")
charts.PerformanceSummary(opt_comparison)
table.AnnualizedReturns(opt_comparison)
