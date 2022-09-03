try( setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

source('../../settings.R')

data <- read.csv("cre-manhattan.csv", as.is=T)
data$index <- data$index*100


plot.real <- function(){
  plot( range(data$year), 
      range(data$index, na.rm=TRUE),
      type='n',
      xlab='Year',
      ylab='Index (1899=100)', 
      log='')
  abline(h=100, lwd=1, lty=3, col='grey')
  lines(data$year, data$index, lwd=3, lty=3, col=colours[3])
  points(data$year, data$index, lwd=3, col=colours[3], pch=19, cex=2)
  legend('topleft','CRE Prices', lwd=3, col=colours[3], bty='n')
  legend('bottomright','Data: Wheaton et al. (2009)', lwd=1, col='white', bty='n')
}


svg(file='cre-manhattan.svg', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.real()
dev.off()


png(file='cre-manhattan.png', height=500, width=1000)
par(mar=c(2,5,0.3,0.3))
plot.real()
dev.off()

