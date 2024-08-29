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
  \item{...}{A variable number of strings representing the names of the input WAV files.}
}
\value{
  None. The function saves the mixed audio as a new WAV file.
}
\examples{
 Example usage:
 tracksmix("track1.wav", "track2.wav", "track3.wav")
}
