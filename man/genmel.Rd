\name{calcBPM}
\alias{calcBPM}
\title{Calculate BPM from a WAV audio}
\description{
  This function calculates the Beats Per Minute (BPM) of a WAV file that you input using the Fast Fourier Transform (FFT) algorithm.
}
\usage{
calcBPM(file_path)
}
\arguments{
  \item{file_path}{A string representing the path to the WAV file.}
}
\value{
  A numeric value representing the BPM of the audio file, or an error message if the FFT contains NA values.
}
\examples{
  \dontrun{
  bpm <- calcBPM("path/to/your/audiofile.wav")
  print(bpm)
  }
}
