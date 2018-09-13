library(xts)
interest.rate <- read.csv('YieldCurve.csv', row.names = 'DATE')[,-9]
rate.China <- as.xts(interest.rate)

library('InspectChangepoint')
# threshold <- compute.threshold(3109, 8)
## Informative sparse projection for estimation of changepoints (inspect)
ret <- inspect(t(interest.rate), threshold = compute.threshold(3109, 8))
changepoints <- ret$changepoints 
cp <- changepoints[order(changepoints[,2], decreasing = T),]
events <- xts(row.names(interest.rate[cp[1:10,][,1],]), 
              c(as.Date(row.names(interest.rate[cp[1:10,][,1],]))))

plot(rate.China, main = 'ChinaBond Bond Yield Curve (2006 - 2018)',
     major.ticks = 'year', 
     grid.ticks.on = 'years', col = terrain.colors(8))
addEventLines(events, #srt=180, pos=2, 
              lty = 2, lwd = 2.5, col = heat.colors(1))
