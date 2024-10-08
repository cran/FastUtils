% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/iteration.R
\name{val}
\alias{val}
\title{Get Value from Enumerated Element by Index}
\usage{
val(elem, index)
}
\arguments{
\item{elem}{An enumerated element.}

\item{index}{The index of the value to extract.}
}
\value{
The value at the specified index in the enumerated element.
}
\description{
This function extracts the value from an enumerated element by the given
index.
}
\examples{
# Extract value from an enumerated element by index
elem <- list(1, "a", "b")
val(elem, 2)
}
\seealso{
\code{\link[=enumerateit]{enumerateit()}}
}
\keyword{iteration}
