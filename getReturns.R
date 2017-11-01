# merge all the (adjusted) prices into one object
prices <- do.call("merge", lapply(tickers, function(ticker) { Ad(get(ticker)) }))
# for some reason there are 0 values, change them to na, then remove all na values
prices[prices == 0] <- NA
prices <- na.omit(prices)

# calculate the returns of each series
returns <- na.omit(Return.calculate(prices))

# get rets of SPY
SPY_rets <- na.omit(Return.calculate(Ad(SPY)))
