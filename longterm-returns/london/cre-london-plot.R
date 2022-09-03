try( setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

source('../../settings.R')

data <- read.csv("cre-london.csv", as.is=T)

for(i in 2:ncol(data)){
  data[,i] <- as.numeric(data[,i])
  data[,i] <- data[,i]/data[data$year==1947,i] * 100
}

plot.real <- function(){
  plot( range(data$year), 
      range(c(data$total.return.index.real, data$price.index.real), na.rm=TRUE),
      type='n',
      xlab='Year',
      ylab='Index (1947=100)', 
      log='y')
  abline(h=100, lwd=1, lty=3, col='grey')
  abline(v=1981, lwd=1, lty=3, col='grey')
  lines(data$year, data$price.index.real, lwd=3, col=colours[3])
  lines(data$year, data$total.return.index.real, lwd=3, col=colours[6])
  legend('topleft',c('Total Returns', 'Capital Gains'), lwd=3, col=colours[c(6,3)], bty='n')
  legend('bottomright','Data: 1920–1980 Scott (1996), 1981–2021 IPD/MSCI', lwd=1, col='white', bty='n')
}

plot.nominal <- function(){
               plot( range(data$year), 
                   range(c(data$total.return.index.nominal, data$price.index.nominal), na.rm=TRUE),
                   type='n',
                   xlab='Year',
                   ylab='Index (1947=100)', 
                   log='y')
                abline(h=100, lwd=1, lty=3, col='grey')
                abline(v=1981, lwd=1, lty=3, col='grey')
                lines(data$year, data$price.index.nominal, lwd=3, col=colours[3])
                lines(data$year, data$total.return.index.nominal, lwd=3, col=colours[6])
                legend('topleft',c('Total Returns', 'Capital Gains'), lwd=3, col=colours[c(6,3)], bty='n')
                legend('bottomright','Data: 1920–1980 Scott (1996), 1981–2021 IPD/MSCI', lwd=1, col='white', bty='n')
}

svg(file='cre-london-nominal.svg', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.nominal()
dev.off()

svg(file='cre-london-real.svg', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.real()
dev.off()

png(file='cre-london-nominal.png', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.nominal()
dev.off()

png(file='cre-london-real.png', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.real()
dev.off()



