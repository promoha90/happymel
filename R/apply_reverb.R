# Apply the reverb effect (internal function)
.apply_reverb <- function(audio, delay, decay) {
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
