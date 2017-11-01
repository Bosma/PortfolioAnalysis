require(PerformanceAnalytics)
require(quantmod)

symbols <- list(
  list("IEF", 22),
  list("IGOV", 16),
  list("TLT", 15),
  list("VEU", 10),
  list("VNQ", 5),
  list("VTI", 32)
)

# fetch the tickers and weights from above symbols object
tickers <- unlist(lapply(symbols, `[[`, 1))
weights <- unlist(lapply(symbols, `[[`, 2)) / 100

source("getSymbols.R")

source("getReturns.R")

returns <- returns["2013-08-13/"]

# calculate the return of the portfolio with weights and rebalancing monthly
portf_returns <- Return.portfolio(R = returns, weights = weights, rebalance_on = "months")

# analyze (with comparison to SPY)
compare <- na.omit(merge(portf_returns, SPY_rets))
names(compare) <- c("Our Portfolio", "SPY")
charts.PerformanceSummary(compare)
table.AnnualizedReturns(compare)
