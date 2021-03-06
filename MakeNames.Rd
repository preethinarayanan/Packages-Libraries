% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MakeNames.R
\name{MakeNames}
\alias{MakeNames}
\title{MakeNames}
\usage{
MakeNames(df)
}
\arguments{
\item{df}{a data_frame, tibble or data.table}
}
\value{
returns the data_frame, tibble or data.table with altered names.
}
\description{
creates standard variable names,
removing non-alphaumeric characters and replacing these with `_`
}
\examples{
iris2 <- MakeNames(iris)
rbind(colnames(iris), colnames(iris2))
}
