# grab key from: https://www.alphavantage.co/support/#api-key
# then uncomment:
# .alpha_key <- "API_KEY_HERE"
for (i in 1:length(tickers)) {
  ticker <- tickers[i]
  # don't have to get the symbol if we have it already
  if (!(ticker %in% ls())) {
    getSymbols(ticker, src = 'av', adjusted = TRUE, output.size = 'full', api.key = .alpha_key)
    
    # IGOV split isn't accounted for
    if (ticker == "IGOV") {
      IGOV$IGOV.Adjusted["2017-08-31/"] <- IGOV$IGOV.Adjusted["2017-08-31/"] * 2
    }
  }
}

# always have SPY in env for comparison
if (!("SPY" %in% ls())) {
  getSymbols("SPY", src = 'av', adjusted = TRUE, output.size = 'full', api.key = .alpha_key)
}