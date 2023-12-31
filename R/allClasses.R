#' rotatoR
#' @export
#'
#' @slot rotatedM rotated basis set (matrix) that is output of rotatoR function
#' @description class of rotatoR output.

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
#' @description class of correlateR output.

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


#' cluster2pattern
#' @export
#'
#' @slot clusterMatrix matrix of continous values for projection that is output of cluster2pattern function
#' @description class of cluster2pattern output.

setClass("cluster2pattern", slots=c(
	clusterMatrix = "matrix"
))

#' Constructor for cluster2pattern
#' @param .Object clusterMatrix object
#' @param clusterMatrix matrix of continous values for projection that is output of cluster2pattern function
#' @param ... additional arguments to intialize cluster2pattern
#' @return initialized cluster2pattern object

#' @importFrom methods callNextMethod

setMethod("initialize", "cluster2pattern",
function(.Object, clusterMatrix, ... )
{
	.Object <- callNextMethod(.Object, ...)
	.Object@clusterMatrix <- clusterMatrix
    .Object
})
