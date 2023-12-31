% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.R
\name{plotConfidenceIntervals}
\alias{plotConfidenceIntervals}
\title{plotConfidenceIntervals}
\usage{
plotConfidenceIntervals(
  confidence_intervals,
  interval_name = c("low", "high"),
  pattern_name = NULL,
  sort = T,
  genes = NULL,
  weights = NULL,
  weights_clip = 0.99,
  weights_vis_norm = "none"
)
}
\arguments{
\item{confidence_intervals}{A dataframe of features x estimates.}

\item{interval_name}{names of columns that contain the low and high estimates, respectively. Default: c("low","high")}

\item{pattern_name}{string to use as the title for plots.}

\item{sort}{Boolean. Whether or not to sort genes by their estimates (default = T)}

\item{genes}{a vector with names of genes to include in plot. If sort=F, estimates will be plotted in this order.}

\item{weights}{optional. weights of features to include as annotation.}

\item{weights_clip}{optional. quantile of data to clip color scale for improved visualization. Default: 0.99}

\item{weights_vis_norm}{Which processed version of weights to visualize as a heatmap. 
Options are "none" (which uses provided weights) or "quantiles". Default: none}
}
\value{
A list with pointrange estimates and, if requested, a heatmap of pattern weights.
}
\description{
Generate point and line confidence intervals from provided estimates.
}
