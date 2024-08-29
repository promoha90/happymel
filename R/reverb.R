library(tuneR)

# String PositiveDouble PositiveDouble -> Audio

# Generate a reverbed audio given a WAV file, delay and decay

# reverb <- function(file_name) invisible(NULL)  # stub

# reverb <- function(file_name) {                # template
#   (... file_name)
#}

reverb <- function(file_name, delay, decay) {
  # Validate Input
  if (!file.exists(file_name)) {
    stop("Error: 'file_name' does not exist")
  }
  
  if (delay <= 0 || !is.finite(delay) || !is.numeric(delay)) {
    stop("Error: 'delay' must be a positive number.")
  }
  
  if (decay <= 0 || !is.finite(decay) || !is.numeric(decay)) {
    stop("Error: 'decay' must be a positive number.")
  }
  
  # 1. Load audio file
  audio <- readWave(file_name)
  
  # 2. Apply reverb effect
  reverb_audio <- apply_reverb(audio, delay, decay)
  
  # 3. Save modified audio file
  output_file_name <- paste0(tools::file_path_sans_ext(file_name), "_reverbed.wav")
  writeWave(reverb_audio, output_file_name)
  
  cat("Reverbed audio saved as", output_file_name, "\n")
}

# Function for applying the reverved effect to the audio
apply_reverb <- function(audio, delay, decay) {
  # Calculate the number of samples corresponding to the delay
  delay_samples <- as.integer(delay * audio@samp.rate)
  
  # Create delayed signal by adding zeros at the beginning
  delayed_signal <- c(rep(0, delay_samples), audio@left)
  
  # Ensure the delayed signal and original audio are the same length
  if (length(delayed_signal) > length(audio@left)) {
    delayed_signal <- delayed_signal[1:length(audio@left)]
  } else {
    delayed_signal <- c(delayed_signal, rep(0, length(audio@left) - length(delayed_signal)))
  }
  
  # Create decayed signal by multiplying the delayed signal by the decay factor
  decayed_signal <- delayed_signal * decay
  
  # Create the reverbed audio by summing the original and decayed signals
  reverbed_audio <- audio@left + decayed_signal
  
  # Handle potential clipping by normalizing the audio
  reverbed_audio <- reverbed_audio / max(abs(reverbed_audio))
  
  # Assign the reverbed signal back to the audio object
  audio@left <- reverbed_audio
  
  # Return the modified audio object
  return(audio)
}