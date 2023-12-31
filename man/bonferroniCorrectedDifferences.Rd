% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/projectionDriveR.R
\name{bonferroniCorrectedDifferences}
\alias{bonferroniCorrectedDifferences}
\title{bonferroniCorrectedDifferences}
\usage{
bonferroniCorrectedDifferences(group1, group2, diff_weights = NULL, pvalue)
}
\arguments{
\item{group1}{count matrix 1}

\item{group2}{count matrix 2}

\item{diff_weights}{oadings to weight the differential expression between the groups}

\item{pvalue}{significance value to threshold at}
}
\description{
Calculate the (weighted) difference in means for each measurement between two groups.
}
