#' @importFrom stats hclust kmeans
setOldClass("kmeans")
setOldClass("hclust")

#' pclust
#'
#' @slot patterns patterns found from clusters (either hclust or kmeans object) using cluster2pattern
#' @description parent class of plcustKmeans and plcusltHclust
#' @export


setClass("pclust", slots=c(
	patterns = "matrix"      
))

#' Constructor for pclust
#' @param .Object pclust object
#' @param patterns patterns found from clusters (either hclust or kmeans object)) using cluster2pattern
#' @param ... Additional arguments to initalize pclust 
#' @return initialized plclust object

#' @importFrom methods callNextMethod

setMethod("initialize", "pclust",
function(.Object, patterns, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@patterns <- patterns
    .Object
})
  

#' pclustKmeans
#' @slot kmeans kmeans object used as input to cluster2pattern
#' @description defines class of cluster2pattern output with kmeans input
#' @export
setClass("pclustKmeans", slots=c(
	kmeans = "kmeans"	      
),contains = "pclust")

#' Constructor for pclustKmeans
#' @param .Object pclustKmeans object
#' @param kmeans kmeans object passed to \code{cluster2pattern} generic
#' @param ... Additional arguments to \code{cluster2pattern} generic
#' @return initialized plclustKmeans object
#' @importFrom methods callNextMethod
setMethod("initialize", "pclustKmeans",
function(.Object, kmeans, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@kmeans <- kmeans
    .Object
})

#' pclustHclust
#' @slot hclust hclust input to cluster2pattern
#' @description defines class of cluster2pattern output with hclust input
#' @export
setClass("pclustHclust", slots=c(
	hclust = "hclust"	      
),contains = "pclust")

#' Constructor for pclust
#' @param .Object pclust object
#' @param hclust hclust object passed to cluster2pattern function
#' @param ... additional arguments to intialize pclust
#' @return initialized plclustHclust object
#' @importFrom methods callNextMethod
setMethod("initialize", "pclustHclust",
function(.Object, hclust, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@hclust <- hclust
    .Object
})

#' rotatoR
#' @export
#'
#' @slot rotatedM rotated matrix that is output of rotatoR function
#' @description class of rotatoR output

setClass("rotatoR", slots=c(
	rotatedM = "matrix"      
))

#' Constructor for rotatoR
#' @param .Object rotatoR object
#' @param rotatedM rotated matrix from rotatoR function
#' @param ... additional arguments to intialize rotatoR
#' @return initialized rotatoR object

#' @importFrom methods callNextMethod

setMethod("initialize", "rotatoR",
function(.Object, rotatedM, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@rotatedM <- rotatedM
    .Object
})

#' correlateR
#' @export
#'
#' @slot corM correlation matrix obtained from correlateR
#' @description class of correlateR output

setClass("correlateR", slots=c(
	corM = "list"      
))

#' Constructor for correlateR
#' @param .Object correlateR object
#' @param corM correlation matrix obtained from correlateR
#' @param ... additional arguments to intialize correlateR
#' @return initialized correlateR object

#' @importFrom methods callNextMethod

setMethod("initialize", "correlateR",
function(.Object, corM, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@corM <- corM
    .Object
})