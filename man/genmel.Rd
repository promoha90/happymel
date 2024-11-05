\name{genmel}
\alias{genmel}
\title{Generate a Piano Melody and Save as WAV File}
\description{
  Generates a piano-like melody given the number of notes and the name of the file, and saves it as a WAV file.
}
\usage{
  genmel(notes, file_name)
}
\arguments{
  \item{notes}{A positive integer representing the number of notes in the melody.}
  \item{file_name}{A non-empty string representing the name for the output WAV file (without extension).}
}
\value{
  None. The function saves the generated melody as a WAV file.
}
\examples{
  library(happymel)
  genmel(10, "melody")
}
