###############
# AllGenerics.R
###############


#' Generic projectR function
#' @docType methods
#' @rdname projectR-methods
#'
#' @description A function for the projection of new data into a previously defined
#' feature space.
#' @param data Target dataset into which you will project. It must of type matrix.
#' @param loadings loadings learned from source dataset.
#' @param dataNames a vector containing unique name, i.e. gene names, for the rows of the target dataset to be used to match features with the loadings, if not provided by \code{rownames(data)}. Order of names in vector must match order of rows in data.
#' @param loadingsNames a vector containing unique names, i.e. gene names, for the rows ofloadings to be used to match features with the data, if not provided by \code{rownames(loadings)}. Order of names in vector must match order of rows in loadings.
#' @param ... Additional arguments to projectR
#'
#' @return A matrix of sample weights for each input basis in the loadings matrix (if full=TRUE, full model solution is returned).
#' @export
#'
#' @examples
#' projectR(data=p.ESepiGen4c1l$mRNA.Seq,loadings=AP.RNAseq6l3c3t$Amean,
#' dataNames = map.ESepiGen4c1l[["GeneSymbols"]])
#'
#' @details
#' \code{loadings} can belong to one of several classes depending on upstream
#' analysis. Currently permitted classes are \code{matrix}, \code{CogapsResult},
#' \code{CoGAPS}, \code{pclust}, \code{prcomp}, \code{rotatoR},
#' and \code{correlateR}. Please note that \code{loadings} should not contain NA.
# NA in loadings result in dimension mismatch b/w loadings and data as they are removed
# by model.matrix
setGeneric("projectR",function(data, loadings, dataNames=NULL, loadingsNames=NULL, ...) standardGeneric("projectR"))
#######################################################################################################################################

#' Generic cluster2pattern function
#' @docType methods
#' @rdname cluster2pattern-methods
#'
#' @description Function to make patterns of continuous weights from clusters.
#'
#' @param clusters a cluster object which could be either an hclust or a kmeans object
#' @param NP number of desired patterns
#' @param data data used to make clusters object
#' @param ... Additional arguments to cluster2pattern
#' @return An object of class pclust containing pattern weights corresponding for each cluster.
#' @export
#' @examples
#' k.RNAseq6l3c3t<-kmeans(t(p.RNAseq6l3c3t),3)
#' cluster2pattern(clusters=k.RNAseq6l3c3t,data=p.RNAseq6l3c3t)
#'
#' distp <- dist(t(p.RNAseq6l3c3t))
#' hc.RNAseq6l3c3t <- hclust(distp)
#' cluster2pattern(clusters=hc.RNAseq6l3c3t,NP=3,data=p.RNAseq6l3c3t)

setGeneric("cluster2pattern",function(clusters,NP,data,...) standardGeneric("cluster2pattern"))
#######################################################################################################################################

#' Generic clusterPlotR function
#' @docType methods
#' @rdname clusterPlotR-methods
#'
#' @description plotting function for clustering objects
#' @param cData data used to get clusters
#' @param cls  a cluster (kmeans or hclust) object
#' @param x a vector of length equal to number of samples to use for plotting
#' @param NC vector of integers indicating which clusters to use
#' @param ... additional parameters for plotting. ex. pch,cex,col,labels, xlab, etc.
#' @return A plot of the mean behavior for each cluster
#' @export
#' @examples
#' \dontrun{
#'  k.RNAseq6l3c3t<-kmeans(p.RNAseq6l3c3t,22)
#'  clusterPlotR(p.RNAseq6l3c3t, cls=k.RNAseq6l3c3t,NC=1,x=pd.RNAseq6l3c3t$days,
#' col=pd.RNAseq6l3c3t$color)
#'}

setGeneric("clusterPlotR",function(cData, cls, x, NC, ...) standardGeneric("clusterPlotR"))
#######################################################################################################################################

#' Generic intersectoR function
#' @docType methods
#' @rdname intersectoR-methods
#'
#' @description A function to find and test the intersecting values of two sets of objects,
#' presumably the genes associated with patterns in two different datasets. Both the input objects
#' need to be of the same type either kmeans or hclust.
#' @param pSet1 an object for a set of patterns where each entry is a set of genes associated with a single pattern
#' @param pSet2 an object for a second set of patterns where each entry is a set of genes associated with a single pattern
#' @param pval the maximum p-value considered significant
#' @param ... additional parameters depending on input object
#' @return A list containing: Overlap matrix, overlap index, and overlapping sets.
#' @export

setGeneric("intersectoR",function(pSet1,pSet2,pval,...) standardGeneric("intersectoR"))
