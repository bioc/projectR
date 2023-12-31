

#######################################################################################################################################
#' @examples
#' library(projectR)
#' data(p.RNAseq6l3c3t)
#' condition<-sapply(colnames(p.RNAseq6l3c3t),function(x) strsplit(x,"[.]")[[1]][1])
#' cluster2pattern(clusters=condition,data=p.RNAseq6l3c3t)
#'
.cluster2pattern <- function(
  clusters, # a vector of character cluster assignments
  data # data used to make clusters object
  ){

  nD<-length(unique(clusters))
  nG<-dim(data)[1]
  tempP<-matrix(data=rep(0,nD*nG),nrow = nG,ncol =nD)
  rownames(tempP)<-rownames(data)
  colnames(tempP)<-unique(clusters)
  for(x in unique(clusters)) 
  {
     mean_cluster <- colMeans(data[,clusters==x])
     tempP[, x]<-apply(data[,clusters==x], 1, cor ,mean_cluster)
  }
  Patterns<-tempP
  Patterns <- new("cluster2pattern",clusterMatrix = Patterns)
  return(Patterns)
}

#' @rdname cluster2pattern-methods
#' @aliases cluster2pattern
setMethod("cluster2pattern",signature(clusters="character"),.cluster2pattern)



#######################################################################################################################################

#'
#'  
.cluster2pattern_numeric <- function(
  clusters, # a vector of numeric cluster assignments
  data # data used to make clusters object
  ){

  nD<-length(unique(clusters))
  nG<-dim(data)[1]
  tempP<-matrix(data=rep(0,nD*nG),nrow = nG,ncol =nD)
  rownames(tempP)<-rownames(data)
  for(x in unique(clusters)) 
  {
     mean_cluster <- colMeans(data[,clusters==x])
     tempP[, x]<-apply(data[,clusters==x], 1, cor ,mean_cluster)
  }
  Patterns<-tempP
  Patterns <- new("cluster2pattern",clusterMatrix = Patterns)
  return(Patterns)
}

#' @rdname cluster2pattern-methods
#' @aliases cluster2pattern
setMethod("cluster2pattern",signature(clusters="numeric"),.cluster2pattern_numeric)




#######################################################################################################################################
#' @importFrom stats kmeans
setOldClass("kmeans")
.cluster2pattern_kmeans<- function(
  clusters, # a kmeans object
  data # data used to make clusters object
  ){

  nD<-length(clusters$size)
  nG<-dim(data)[1]
  tempP<-matrix(data=rep(0,nD*nG),nrow = nG,ncol =nD)
  rownames(tempP)<-rownames(data)
  colnames(tempP)<-unique(clusters$cluster)
  for(x in unique(clusters$cluster)) 
  {
    mean_cluster <- colMeans(data[,clusters$cluster==x])
    tempP[, x]<-apply(data[,clusters$cluste==x], 1, cor ,mean_cluster)
  }
  Patterns<-tempP
  Patterns <- new("cluster2pattern",clusterMatrix = Patterns)
  return(Patterns)
}

#' @rdname cluster2pattern-methods
#' @aliases cluster2pattern
setMethod("cluster2pattern",signature(clusters="kmeans"),.cluster2pattern_kmeans)

#######################################################################################################################################
#' @importFrom stats hclust

setOldClass("hclust")
.cluster2pattern_hclust<-function(
  clusters, # an hclust object
  NP, # number of desired patterns
  data=NA # data used to make hclust object
  ){

#  if(is.na(Patterndata)){stop("data used to make hclust object must also be provided.")}
  cut=cutree(clusters,k=NP)
  nG<-dim(data)[1]
  tempP<-matrix(data=rep(0,NP*nG),nrow = nG,ncol=NP)
  rownames(tempP)<-rownames(data)
  for(x in unique(cut)) 
  {
    mean_cluster <- colMeans(data[,cut==x])
    tempP[, x]<-apply(data[,cut==x], 1, cor ,mean_cluster)
  }
  
  Patterns<-tempP
  Patterns <- new("cluster2pattern",clusterMatrix = Patterns)
  return(Patterns)
}

#' @rdname cluster2pattern-methods
#' @aliases cluster2pattern
setMethod("cluster2pattern",signature(clusters="hclust"),.cluster2pattern_hclust)

#######################################################################################################################################

