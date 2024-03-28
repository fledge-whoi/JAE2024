# LHO
# Produce figures for manuscript

perso <- seq(-3,3, length.out=100) 

col_bold_female = rgb(137/255, 69/255, 133/255, 1)
col_shy_female = rgb(137/255, 69/255, 133/255, 0.5)

col_bold_male = rgb(0.1, 0.3, 0.4, 1)
col_shy_male = rgb(0.1, 0.3, 0.4, 0.5)


# Life expectancy, lifetime reproductive outcome and lambda (from Matlab)

# Females
lambdaF <- read.table("...Lambda_pers_uncertaintiesF_2008_SCALE.txt",header=F)
lambdaF <- as.matrix(lambdaF)

lrsF <- read.table("...OccupancySB_pers_uncertaintiesF_2008_SCALE.txt",header=F)
lrsF <- as.matrix(lrsF)

lexF <- read.table("...Expectancy_pers_uncertaintiesF_2008_SCALE.txt",header=F)
lexF <- as.matrix(lexF)

summary_F <- data.frame(
  perso = perso,
  median_lambda = rep(0, 100),
  low_lambda = rep(0, 100),
  up_lambda = rep(0,100),
  
  median_lrs = rep(0, 100),
  low_lrs = rep(0, 100),
  up_lrs = rep(0,100),
  
  median_lex = rep(0, 100),
  low_lex = rep(0, 100),
  up_lex = rep(0,100)
)




for(i in 1:100){
  summary_F[i,"median_lambda"] <- quantile(lambdaF[i,], probs=0.5)
  summary_F[i,"low_lambda"] <- quantile(lambdaF[i,], probs=0.025)
  summary_F[i,"up_lambda"] <- quantile(lambdaF[i,], probs=0.975)
  
  summary_F[i,"median_lrs"] <- quantile(lrsF[i,], probs=0.5)
  summary_F[i,"low_lrs"] <- quantile(lrsF[i,], probs=0.025)
  summary_F[i,"up_lrs"] <- quantile(lrsF[i,], probs=0.975)
  
  summary_F[i,"median_lex"] <- quantile(lexF[i,], probs=0.5)
  summary_F[i,"low_lex"] <- quantile(lexF[i,], probs=0.025)
  summary_F[i,"up_lex"] <- quantile(lexF[i,], probs=0.975)
}


mean(summary_F$median_lex)
mean(summary_F$median_lrs)
mean(summary_F$median_lambda)

summary_F$median_lrs[1]
summary_F$median_lrs[100]

summary_F$median_lex[1]
summary_F$median_lex[100]

summary_F$median_lambda[1]
summary_F$median_lambda[100]


# Males
lambdaM <- read.table("...Lambda_pers_uncertaintiesM_2008_SCALE.txt",header=F)
lambdaM <- as.matrix(lambdaM)

lrsM <- read.table("...OccupancySB_pers_uncertaintiesM_2008_SCALE.txt",header=F)
lrsM <- as.matrix(lrsM)

lexM <- read.table("...Expectancy_pers_uncertaintiesM_2008_SCALE.txt",header=F)
lexM <- as.matrix(lexM)

summary_M <- data.frame(
  perso = perso,
  median_lambda = rep(0, 100),
  low_lambda = rep(0, 100),
  up_lambda = rep(0,100),
  
  median_lrs = rep(0, 100),
  low_lrs = rep(0, 100),
  up_lrs = rep(0,100),
  
  median_lex = rep(0, 100),
  low_lex = rep(0, 100),
  up_lex = rep(0,100)
)




for(i in 1:100){
  summary_M[i,"median_lambda"] <- quantile(lambdaM[i,], probs=0.5)
  summary_M[i,"low_lambda"] <- quantile(lambdaM[i,], probs=0.025)
  summary_M[i,"up_lambda"] <- quantile(lambdaM[i,], probs=0.975)
  
  summary_M[i,"median_lrs"] <- quantile(lrsM[i,], probs=0.5)
  summary_M[i,"low_lrs"] <- quantile(lrsM[i,], probs=0.025)
  summary_M[i,"up_lrs"] <- quantile(lrsM[i,], probs=0.975)
  
  summary_M[i,"median_lex"] <- quantile(lexM[i,], probs=0.5)
  summary_M[i,"low_lex"] <- quantile(lexM[i,], probs=0.025)
  summary_M[i,"up_lex"] <- quantile(lexM[i,], probs=0.975)
}

mean(summary_M$median_lex)
mean(summary_M$median_lrs)
mean(summary_M$median_lambda)



summary_M$median_lrs[1]
summary_M$median_lrs[100]
summary_M$median_lambda[1]
summary_M$median_lambda[100]

# FIGURES
# 3 pannels : LEX, LRS, Lambda
par(mfrow=c(1,3), mar=c(4,4,2,2), bty="n", bg="white")
plot(summary_F$perso, summary_F$median_lex, ylim=c(10,30), type="l", pch=16, xlab="Boldness", ylab="Life expectancy (years)", lwd=3, col=col_bold_female)
polygon(x=c(summary_F$perso, rev(summary_F$perso)), y=c(summary_F$low_lex, rev(summary_F$up_lex)), col=col_shy_female, border=NA)
lines(summary_F$perso, summary_F$low_lex, type="l", lty=2, pch=16, col=col_bold_female)
lines(summary_F$perso, summary_F$up_lex, type="l",lty=2, pch=16, col=col_bold_female)

lines(summary_M$perso, summary_M$median_lex, lwd=3, col=col_bold_male)
polygon(x=c(summary_M$perso, rev(summary_M$perso)), y=c(summary_M$low_lex, rev(summary_M$up_lex)), col=col_shy_male, border=NA)
lines(summary_M$perso, summary_M$low_lex, type="l", lty=2, pch=16, col=col_bold_male)
lines(summary_M$perso, summary_M$up_lex, type="l", lty=2, pch=16, col=col_bold_male)
legend("bottomright", legend=c("Females", "Males"), col=c(col_bold_female, col_bold_male), bty='n', lwd=3)
mtext(side=3, text="a)", line=0.5, at=-3.2)

plot(summary_F$perso, summary_F$median_lrs, ylim=c(0,10), type="l", pch=16, xlab="Boldness", ylab="Lifetime reproductive success", lwd=3, col=col_bold_female)
polygon(x=c(summary_F$perso, rev(summary_F$perso)), y=c(summary_F$low_lrs, rev(summary_F$up_lrs)), col=col_shy_female, border=NA)
lines(summary_F$perso, summary_F$low_lrs, type="l", lty=2, pch=16, col=col_bold_female)
lines(summary_F$perso, summary_F$up_lrs, type="l", lty=2, pch=16, col=col_bold_female)

lines(summary_M$perso, summary_M$median_lrs, lwd=3, col=col_bold_male)
polygon(x=c(summary_M$perso, rev(summary_M$perso)), y=c(summary_M$low_lrs, rev(summary_M$up_lrs)), col=col_shy_male, border=NA)
lines(summary_M$perso, summary_M$low_lrs, type="l", lty=2, pch=16, col=col_bold_male)
lines(summary_M$perso, summary_M$up_lrs, type="l", lty=2, pch=16, col=col_bold_male)
legend("bottomright", legend=c("Females", "Males"), col=c(col_bold_female, col_bold_male), bty='n', lwd=3)
mtext(side=3, text="b)", line=0.5, at=-3.2)


plot(summary_F$perso, summary_F$median_lambda, ylim=c(1.00,1.06), type="l", pch=16, xlab="Boldness", ylab="Lambda", lwd=3, col=col_bold_female)
polygon(x=c(summary_F$perso, rev(summary_F$perso)), y=c(summary_F$low_lambda, rev(summary_F$up_lambda)), col=col_shy_female, border=NA)
lines(summary_F$perso, summary_F$low_lambda, type="l", lty=2, pch=16, col=col_bold_female)
lines(summary_F$perso, summary_F$up_lambda, type="l", lty=2, pch=16, col=col_bold_female)

lines(summary_M$perso, summary_M$median_lambda, lwd=3, col=col_bold_male)
polygon(x=c(summary_M$perso, rev(summary_M$perso)), y=c(summary_M$low_lambda, rev(summary_M$up_lambda)), col=col_shy_male, border=NA)
lines(summary_M$perso, summary_M$low_lambda, type="l", lty=2, pch=16, col=col_bold_male)
lines(summary_M$perso, summary_M$up_lambda, type="l", lty=2, pch=16, col=col_bold_male)
legend("bottomright", legend=c("Females", "Males"), col=c(col_bold_female, col_bold_male), bty='n',lwd=3)
mtext(side=3, text="c)", line=0.5, at=-3.2)



