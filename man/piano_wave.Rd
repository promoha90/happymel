\name{piano_wave}
\alias{piano_wave}
\title{Generate a Piano-like Waveform}
\description{
  Generates a piano-like waveform given a frequency, duration, and sample rate.
}
\usage{
piano_wave(frequency, duration, sample_rate)
}
\arguments{
  \item{frequency}{The frequency of the note in Hertz.}
  \item{duration}{The duration of the note in seconds.}
  \item{sample_rate}{The sample rate in samples per second.}
}
\value{
  A numeric vector representing the waveform of the note.
}
\examples{
 Example usage:
 wave <- piano_wave(440, 1, 44100)
}
