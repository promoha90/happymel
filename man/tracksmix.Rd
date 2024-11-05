\name{tracksmix}
\alias{tracksmix}
\title{Mix Multiple Audio Tracks}
\description{
  Produces a mixed audio file given multiple audio tracks in WAV format.
}
\usage{
  tracksmix(...)
}
\arguments{
  \item{...}{A variable number of strings representing the names of the input WAV files, each including the .wav extension.}
}
\value{
  None. The function saves the mixed audio as a new WAV file.
}
\examples{
  library(happymel)
  file_path1 <- system.file("extdata", "example_track1.wav", package = "happymel")
  file_path2 <- system.file("extdata", "example_track2.wav", package = "happymel")
  file_path3 <- system.file("extdata", "example_track3.wav", package = "happymel")
  tracksmix(file_path1, file_path2, file_path3)
}
