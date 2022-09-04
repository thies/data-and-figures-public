try( setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

source('../../settings.R')

data <- read.csv("cre-manhattan.csv", as.is=T)
data$index <- data$index*100
data$index <- data$index/data$index[data$year==1999]*100

msci <- read.csv('msci-ipd-new-york-offices.csv', as.is=TRUE)
msci$capital.gains.real <- msci$capital.gains.real/msci$capital.gains.real[1]*100
msci$total.returns.real <- msci$total.returns.real/msci$total.returns.real[1]*100

plot.real <- function(){
  plot( range(c(data$year, msci$year)), 
      range(c(data$index, msci$capital.gains.real), na.rm=TRUE),
      type='n',
      xlab='Year',
      ylab='Index (1999=100)', 
      log='y')
  abline(h=100, lwd=1, lty=3, col='grey')
  lines(data$year, data$index, lwd=3, lty=3, col=colours[3])
  lines(msci$year, msci$capital.gains.real, lwd=3, col=colours[3])
  #lines(msci$year, msci$total.returns.real, lwd=3, col=colours[6])
  points(data$year, data$index, lwd=3, col=colours[3], pch=19, cex=2)
  legend('topleft','CRE Prices', lwd=3, col=colours[3], bty='n')
  legend('bottomright','Data: 1899–1999 Wheaton et al. (2009), 1999–2020 MSCI/IPD', lwd=1, col='white', bty='n')
}

svg(file='cre-manhattan.svg', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.real()
dev.off()

png(file='cre-manhattan.png', height=500, width=1000)
par(mar=c(2,5,0.3,0.3))
plot.real()
dev.off()

