try( setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

source('../../settings.R')

data <- read.csv("case-shiller-hpi.csv", as.is=T)



plot.real <- function(){
  plot( range(data$year), 
      range(data$hpi.real, na.rm=TRUE),
      type='n',
      xlab='Year',
      ylab='Index (1890=100)', 
      log='')
  abline(h=100, lwd=1, lty=3, col='grey')
  lines(data$year, data$hpi.real, lwd=3, col=colours[3])
  legend('topleft','House Prices', lwd=3, col=colours[3], bty='n')
  legend('bottomright','Data: Robert Shiller (2022)', lwd=1, col='white', bty='n')
}


svg(file='case-shiller-hpi.svg', height=4, width=8)
par(mar=c(2,4,0.2,0.2))
plot.real()
dev.off()


png(file='case-shiller-hpi.png', height=500, width=1000)
par(mar=c(2,5,0.3,0.3))
plot.real()
dev.off()

