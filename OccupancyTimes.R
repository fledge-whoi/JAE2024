
occ_f <- read.table("...OccupancyF.txt")
occ_m <- read.table("...OccupancyM.txt")

states = c("PB", "SB", "FB", "PSB", "PFB", "NB")
states2 <- c("Breeding", "Non_breeding")
perso = c("Shy", "Bold")


#Data was obtained in matlab

##########################################
##### MALES

pie_data <- data.frame(
  perso = rep(perso, each=length(states[-1])),
  state = rep(states[-1], length(perso)),
  proportion = occ_m[c(1:5, 8:12),1]
  )


colors <- c(
  rgb(38/255, 190/255, 195/255, 1),
  rgb(160/255, 211/255, 136/255, 1),
  rgb(55/255, 122/255, 182/255, 1),
  rgb(207/255, 241/255, 123/255, 1),
  rgb(230/255, 189/255, 76/255, 1)
)

par(mfrow=c(1,2))
pie(pie_data[which(pie_data$perso=="Shy"), "proportion"], labels=states[-1], border="white", col=colors, main="Shy")
pie(pie_data[which(pie_data$perso=="Bold"), "proportion"], labels=states[-1], border="white", col=colors, main="Bold")



pie_data2 <- data.frame(
  perso = rep(perso, each=length(states2)),
  state = rep(states2, length(perso)),
  proportion = c(0.474397, 1-0.474397, 
                 0.3988024, 1-0.3988024)
)

par(mfrow=c(1,2))
pie(pie_data2[which(pie_data2$perso=="Shy"), "proportion"], labels=states2, border="white", col=colors[1:2], main="Shy")
pie(pie_data2[which(pie_data2$perso=="Bold"), "proportion"], labels=states2, border="white", col=colors[1:2], main="Bold")





##########################################
##### FEMALES
pie_data_f <- data.frame(
  perso = rep(perso, each=length(states[-1])),
  state = rep(states[-1], length(perso)),
  proportion = occ_f[c(1:5, 8:12),1]
)



par(mfrow=c(1,2))
pie(pie_data_f[which(pie_data_f$perso=="Shy"), "proportion"], labels=states[-1], border="white", col=colors, main="Shy")
pie(pie_data_f[which(pie_data_f$perso=="Bold"), "proportion"], labels=states[-1], border="white", col=colors, main="Bold")



pie_data2_f <- data.frame(
  perso = rep(perso, each=length(states2)),
  state = rep(states2, length(perso)),
  proportion = c(0.5379589, 1-0.5379589, 
                 0.5357326, 1-0.5357326)
)


par(mfrow=c(1,2))
pie(pie_data2_f[which(pie_data2_f$perso=="Shy"), "proportion"], labels=states2, border="white", col=colors[1:2], main="Shy")
pie(pie_data2_f[which(pie_data2_f$perso=="Bold"), "proportion"], labels=states2, border="white", col=colors[1:2], main="Bold")