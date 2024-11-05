\name{reverb}
\alias{reverb}
\title{Generate a Reverbed Version of an Existing Audio}
\description{
  Produces a reverbed version of an existing audio file given a WAV file, delay, and decay.
}
\usage{
reverb(file_name, delay, decay)
}
\arguments{
  \item{file_name}{A string representing the name of the input WAV file, including the .wav extension.}
  \item{delay}{A positive number representing the delay time in seconds.}
  \item{decay}{A positive number representing the decay factor.}
}
\value{
  None. The function saves the reverbed audio as a new WAV file.
}
\examples{
  library(happymel)
  file_path <- system.file("extdata", "example.wav", package = "happymel")
  reverb(file_path, 0.5, 0.3)
}
