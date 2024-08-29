\name{apply_reverb}
\alias{.apply_reverb}
\title{Apply the Reverb Effect to a file}
\description{
  Internal function to apply a reverb effect onto an audio object.
}
\usage{
.apply_reverb(audio, delay, decay)
}
\arguments{
  \item{audio}{An audio file/object.}
  \item{delay}{The delay time in seconds.}
  \item{decay}{The decay factor.}
}
\value{
  The modified audio file/object with the reverb effect applied.
}
\examples{
 Example usage:
 audio <- some_audio_object
 audio <- .apply_reverb(audio, delay = 0.5, decay = 0.3)
}
