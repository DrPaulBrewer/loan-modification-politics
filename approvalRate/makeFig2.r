library(calibrate)
png("fig2.png", width=800, height=400)
df<-read.csv("./hampapprovalVSpopvote.csv",header=T)
row.names(df)<-df$state
linearStepModel<-lm(hamp_approval_rate~1+popular_vote2012+sign(popular_vote2012)+sign(popular_vote2012)*popular_vote2012, df)
plot(df$popular_vote2012,df$hamp_approval_rate,
	xlab="2012 Popular Vote %Romney - %Obama",
	ylab="MSA HAMP Loan Modification Approval Rate (%)")
pre<-predict(linearStepModel)
lines(df$popular_vote2012,pre,col="green")
segments(df$popular_vote2012,df$hamp_approval_rate,df$popular_vote2012,pre,col="orange")
textxy(df$popular_vote2012, df$hamp_approval_rate, df$state, cex=0.7)
dev.off()
