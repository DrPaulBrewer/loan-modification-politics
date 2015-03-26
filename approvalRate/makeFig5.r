# inspired in part by
# http://www.r-bloggers.com/how-to-plot-points-regression-line-and-residuals/
library(calibrate)
png("fig5.png", width=800, height=400)
df<-read.csv("./hampapprovalVSpopvote.csv",header=T)
row.names(df)<-df$state
hardest_hit_fund<-rep(0,50)
names(hardest_hit_fund)<-df$state
hardest_hit_fund[c("AL","AZ","CA","FL","GA","IL","IN","KY","MI","MS","NV","NJ","NC","OH","OR","RI","SC","TN")]=1
df$hardest_hit_fund<-hardest_hit_fund
linearModel<-lm(hamp_approval_rate~1+sign(popular_vote2012)+hardest_hit_fund, df)
plot(df$popular_vote2012,df$hamp_approval_rate,
	xlab="2012 Popular Vote %Romney - %Obama",
	ylab="MSA HAMP Loan Modification Approval Rate (%)")
pre<-predict(linearModel)
lines(df$popular_vote2012,pre,col="brown")
segments(df$popular_vote2012,df$hamp_approval_rate,df$popular_vote2012,pre,col="orange")
textxy(df$popular_vote2012, df$hamp_approval_rate, df$state, cex=0.7)
dev.off()
