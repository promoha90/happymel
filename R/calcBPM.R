library(tuneR)    # library for audio processing
library(seewave)  # library for sound analysis
library(signal)   # library for peak analysis

# Wav Audio File -> Number

# calcBPM <- function(file_path) return(0)  ; stub

# calcBPM <- function(file_path) {          ; template
#   (... file_path)    
#}

calcBPM <- function(file_path) {
  ### Calculate the BPM of a wav file using the Fast Fourier Transform algorithm ###
  # 1. Read audio file
  if (!file.exists(file_path)) {
    return("Error: File not found")
  }
  
  audio <- tryCatch({
    readWave(file_path)
  }, error = function(e) {
    return("Error: Cannot read audio file")
  })
  
  if (is.character(audio)) {
    return(audio)  # Return the error message if readWave failed
  }
  
  # 2. Extract audio data
  audio_data <- audio@left
  
  if (length(audio_data) < 2) {
    return("Error: Audio data is too short")
  }
  
  # 3. Compute the FFT
  fft_data <- fft(audio_data)
  
  # 4. Check for NA values
  if (any(is.na(fft_data))) {
    return("Error: FFT contains NAs")
  }
  
  # 5. Compute the Spectrum
  spec_data <- spec(audio_data, f = audio@samp.rate)
  
  # 6. Find Peaks
  peaks <- fpeaks(spec_data)
  
  # 7. Find dominant frequency
  dominant_freq <- which.max(spec_data)
  
  # 8. Conversion of the frequency to Hz
  frequency <- (dominant_freq * audio@samp.rate) / length(audio_data)
  
  # 9. Conversion to BPM
  return(frequency / 60)
}