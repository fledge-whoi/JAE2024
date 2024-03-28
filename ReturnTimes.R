# Return times

library(R.matlab)

# Males 
# Successful breeder to Breeder
RTSBB <- readMat("...returntimesSBB.mat")
RTSBB <- RTSBB$returntimesSBB
# Failed breeder to Breeder
RTFBB <- readMat("...returntimesFBB.mat")
RTFBB <- RTFBB$returntimesFBB

# Females 
# Successful breeder to Breeder
RTSBB_f <- readMat("...returntimesSBB_f.mat")
RTSBB_f <- RTSBB_f$returntimesSBB.f
# Failed breeder to Breeder
RTFBB_f <- readMat("...returntimesFBB_f.mat")
RTFBB_f <- RTFBB_f$returntimesFBB.f


# Males and females together

col_bold_female = rgb(137/255, 69/255, 133/255, 1)
col_shy_female = rgb(137/255, 69/255, 133/255, 0.5)

col_bold_male = rgb(0.1, 0.3, 0.4, 1)
col_shy_male = rgb(0.1, 0.3, 0.4, 0.5)


par(mfrow=c(1,2))
# Pannel A Successful breeder to Breeder
ylim=c(2,3)
plot(x=1:25, y=colMeans(RTSBB_f[,,1]), xlab="Age class", ylab=ylab, xlim=xlim, ylim=ylim, type="b", 
     col=col_shy_female, pch=16, main = "Breed again after success", axes=F)
axis(1, at=seq(1:25), labels=c("7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31+"))
axis(2, at=seq(2, 3, 0.2))
points(x=1:25, y=colMeans(RTSBB_f[,,2]), type="b", col=col_bold_female, pch=16)
points(x=1:25, y=colMeans(RTSBB[,,1]), type="b", col=col_shy_male, pch=16)
points(x=1:25, y=colMeans(RTSBB[,,2]), type="b", col=col_bold_male, pch=16)
legend("topleft", legend=c("Bold Female", "Shy Female", "Bold Male", "Shy Male"), pch=16, col=c(col_bold_female, col_shy_female, col_bold_male, col_shy_male), bty="n")
mtext(side=3, text="a)", line=0.5, at=-2, cex=1.5)

# Pannel B Failed breeder to Breeder
ylim=c(1,2)
plot(x=1:25, y=colMeans(RTFBB_f[,,1]), xlab="Age class", ylab=ylab, xlim=xlim, ylim=ylim, type="b", 
     col=col_shy_female, pch=16, main = "Breed again after failure", axes=F)
axis(1, at=seq(1:25), labels=c("7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31+"))
axis(2, at=seq(1, 2, 0.2))
points(x=1:25, y=colMeans(RTFBB_f[,,2]), type="b", col=col_bold_female, pch=16)
points(x=1:25, y=colMeans(RTFBB[,,1]), type="b", col=col_shy_male, pch=16)
points(x=1:25, y=colMeans(RTFBB[,,2]), type="b", col=col_bold_male, pch=16)
legend("topleft", legend=c("Bold Female", "Shy Female", "Bold Male", "Shy Male"), pch=16, col=c(col_bold_female, col_shy_female, col_bold_male, col_shy_male), bty="n")
mtext(side=3, text="b)", line=0.5, at=-2, cex=1.5)

