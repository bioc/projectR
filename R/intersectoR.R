#' @title intersectoR (Base)
#'
#' @description a function to find and test the intersecting values of two sets of lists, presumably the genes associated with patterns in two different datasets. 
#' @param pSet1 a list for a set of patterns where each entry is a set of genes associated with a single pattern
#' @param pSet2 a list for a second set of patterns where each entry is a set of genes associated with a single pattern
#' @param pval the maximum p-value considered significant
#' @param full logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
#' @param k numeric giving cut height for hclust objects, if vector arguments will be applied to pSet1 and pSet2 in that order
#' @examples \dontrun{
#'	 intersector(pSet1, pSet2, pval=.05)
#'}
#' @export

intersectoR<-function(
	pSet1=NA, #a list for a set of patterns where each entry is a set of genes associated with a single pattern
	pSet2=NA, #a list for a second set of patterns where each entry is a set of genes associated with a single pattern
	pval=.05, # the maximum p-value considered significant
	full=FALSE, #logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
	k=NULL #cut height for hclust objects 
){
  UseMethod("intersectoR",pSet1,pSet2)
}

#' @title intersectoR (default)
#'
#' @description a function to find and test the intersecting values of two sets of lists, presumably the genes associated with patterns in two different datasets. 
#' @param pSet1 a list for a set of patterns where each entry is a set of genes associated with a single pattern
#' @param pSet2 a list for a second set of patterns where each entry is a set of genes associated with a single pattern
#' @param pval the maximum p-value considered significant
#' @param full logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
#' @param k cut height for hclust objects  
#' @examples \dontrun{
#'  intersector(pSet1, pSet2, pval=.05)
#'}
#' @export

intersectoR.default <- function(
	pSet1=NA, #a list for a set of patterns where each entry is a set of genes associated with a single pattern
	pSet2=NA, #a list for a second set of patterns where each entry is a set of genes associated with a single pattern
	pval=.05, # the maximum p-value considered significant
	full=FALSE, #logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
	k=NULL #cut height for hclust objects, not used for default 
){

	overLPmtx=matrix(nrow=0,ncol=9) #intialize matrix
	colnames(overLPmtx)=c("pSet1","NpSet1","pSet2","NpSet2","NoverLP",
		"OverLap%1","OverLap%2","pval","pval.REV")

#calculate overlaps and stats
	for(i in 1:length(pSet1)){
		for(j in 1:length(pSet2)){
	# overlap between genes in p1K cluster i and p2K cluster j
		pvalOLP=phyper(
			q=length(which(pSet1[[i]] %in% pSet2[[j]])), # q: # white balls drawn without replacement from an urn with both black and white balls.
			m=length(pSet1[[i]]), # m: the number of white balls in the urn.
			n=length(unlist(pSet1))-length(pSet1[[i]]), # n: the number of black balls in the urn.
			k=length(pSet2[[j]]), # k: the number of balls drawn from the urn.
			lower.tail = FALSE, log.p = FALSE) # lower.tail: logical; if TRUE (default), probabilities are P[X <= x], otherwise, P[X > x].
		pvalOLP.rev=phyper(q=length(which(pSet2[[j]] %in% pSet1[[i]])), m=length(pSet2[[j]]), 
			n=length(unlist(pSet2))-length(pSet2[[j]]), k=length(pSet1[[i]]), lower.tail = FALSE, log.p = FALSE)

		if(pvalOLP<=pval){overLPmtx=rbind(overLPmtx,c(i,length(pSet1[[i]]),j,length(pSet2[[j]]),
			length(which(pSet1[[i]] %in% pSet2[[j]])),
			round(100*length(which(pSet1[[i]] %in% pSet2[[j]]))/length(pSet1[[i]]),2),
			round(100*length(which(pSet1[[j]] %in% pSet1[[i]]))/length(pSet2[[j]]),2),
			pvalOLP,pvalOLP.rev))}
		}
	}
	if(full==FALSE){
		return(overLPmtx) #return summary matrix 
	} else if(full){
		overLPindx<-overLPmtx[,c("pSet1","pSet2")] #indx of significantly overlapping sets
		overLPsets<-cbind(pSet1[overLPindx],pSet2[overLPindx]) # mtx of significantly overlapping sets
		colnames(overLPsets)<-c("pSet1","pSet2")
		return(overLPmtx,overLPindx,overLPsets)
	}
}  	

#' @title intersectoR (Kmeans)
#'
#' @description a function to find and test the intersecting values of two sets of kmeans clusters, presumably the genes associated with clusters in two different datasets. 
#' @param pSet1 a kmeans object 
#' @param pSet2 a second kmeans object
#' @param pval the maximum p-value considered significant
#' @param full logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
#' @param k cut height for hclust objects, not used with kmeans   
#' @examples \dontrun{
#'  intersector(pSet1, pSet2, pval=.05)
#'}
#' @export

intersectoR.kmeans <- function(
	pSet1=NA, #a list for a set of patterns where each entry is a set of genes associated with a single pattern
	pSet2=NA, #a list for a second set of patterns where each entry is a set of genes associated with a single pattern
	pval=.05, # the maximum p-value considered significant
	full=FALSE, #logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
	k=NULL #cut height for hclust objects 
  ){
	overLPmtx=matrix(nrow=0,ncol=9)
	colnames(overLPmtx)=c("pSet1","NpSet1","pSet2","NpSet2","NoverLP",
		"OverLap%1","OverLap%2","pval","pval.REV")

	for(i in sort(unique(pSet1$cluster))){
		for(j in sort(unique(pSet2$cluster))){
			pvalOLP=phyper(q=sum(pSet1$cluster==i&pSet2$cluster==j),m=sum(pSet1$cluster==i), 
				n=sum(pSet1$cluster!=i), k=sum(pSet2$cluster==j),lower.tail = FALSE, log.p = FALSE) 
			pvalOLP.rev=phyper(q=sum(pSet2$cluster==j&pSet1$cluster==i), m=sum(pSet2$cluster==j), 
				n=sum(pSet2$cluster!=j), k=sum(pSet1$cluster==i), lower.tail = FALSE, log.p = FALSE)
			if(pvalOLP<=pval){overLPmtx=rbind(overLPmtx,c(i,sum(pSet1$cluster==i),j,
				sum(pSet2$cluster==j),sum(pSet1$cluster==i&pSet2$cluster==j),
				round(100*sum(pSet1$cluster==i&pSet2$cluster==j)/sum(pSet1$cluster==i),2),
				round(100*sum(pSet1$cluster==i&pSet2$cluster==j)/sum(pSet2$cluster==j),2),
				pvalOLP,pvalOLP.rev))}
		}
	}
	print(paste(dim(overLPmtx)[1]," cluster pairs have overlap with p<",pval,":",sep=""))
	if(full==FALSE){
		return(overLPmtx)
	} else if(full){
		overLPindx<-overLPmtx[,c("pSet1","pSet2")] 
		overLPsets<-sapply(1:dim(overLPmtx)[1],function(x)
			cbind("pSet1"=names(pSet1$cluster[pSet1$cluster==overLPindx[x,1]]),
				"pSet2"=names(pSet2$cluster[pSet2$cluster==overLPindx[x,2]]))) 
		return(overLPmtx,overLPindx,overLPsets)
	}
}

#' @title intersectoR (hclust)
#'
#' @description a function to find and test the intersecting values of two hierarchial clustering objects, presumably the genes associated with clusters in two different datasets. 
#' @param pSet1 a hclust object 
#' @param pSet2 a second hclust object
#' @param pval the maximum p-value considered significant
#' @param full logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
#' @param k #numeric giving cut height for hclust objects, if vector arguments will be applied to pSet1 and pSet2 in that order
#' @examples \dontrun{
#'  intersector(pSet1, pSet2, pval=.05, k=c(3,4))
#'}
#' @export

intersectoR.hclust <- function(
	pSet1=NA, #a hclust obj
	pSet2=NA, #a second set hclust obj
	pval=.05, # the maximum p-value considered significant
	full=FALSE, #logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix. 
	k=NULL #numeric giving cut height for hclust objects, if vector arguments will be applied to pSet1 and pSet2 in that order
  ){
  	overLPmtx=matrix(nrow=0,ncol=9)
  	colnames(overLPmtx)=c("pSet1","NpSet1","pSet2","NpSet2","NoverLP",
		"OverLap%1","OverLap%2","pval","pval.REV")

	if(length(k)==1){cut1<-cutree(pSet1,k=k) ; cut2<-cutree(pSet2,k=k)}
	if(length(k)==2){cut1<-cutree(pSet1,k=k[1]) ; cut2<-cutree(pSet2,k=k[2])}
	for(i in sort(unique(cut1))){
		for(j in sort(unique(cut2))){
			pvalOLP=phyper(q=sum(cut1==i&cut2==j),m=sum(cut1==i),n=sum(cut1!=i), 
				k=sum(cut2==j), lower.tail = FALSE, log.p = FALSE)
			pvalOLP.rev=phyper(q=sum(cut2==j&cut1==i), m=sum(cut2==j), n=sum(cut2!=j), 
				k=sum(cut1==i), lower.tail = FALSE, log.p = FALSE)
			if(pvalOLP<=pval){overLPmtx=rbind(overLPmtx,c(i,sum(cut1==i),j,
				sum(cut2==j),sum(cut1==i&cut2==j),sum(cut1==i&cut2==j)/sum(cut1==i),
				sum(cut1==i&cut2==j)/sum(cut2==j),pvalOLP,pvalOLP.rev))}
		}
	}
	print(paste(dim(overLPmtx)[1]," cluster pairs have overlap with p<",pval,":",sep=""))
	if(full==FALSE){
		return(overLPmtx) #return summary matrix 
	} else if(full){
		overLPindx<-overLPmtx[,c("pSet1","pSet2")] 
		overLPsets<-sapply(1:dim(overLPmtx)[1],function(x)
			cbind("pSet1"=names(cut1[cut1==overLPindx[x,1]]),
				"pSet2"=names(cut2[cut2==overLPindx[x,2]]))) 
		return(overLPmtx,overLPindx,overLPsets)
	}
}

 