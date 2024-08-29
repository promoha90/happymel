library(tuneR)

# Function to generate a piano-like waveform
piano_wave <- function(frequency, duration, sample_rate) {
  samples <- round(duration * sample_rate)
  t <- seq(0, duration, length.out = samples)
  
  # Fundamental frequency
  wave <- sin(2 * pi * frequency * t)
  
  # Add harmonics with decreasing amplitude
  wave <- wave +
    0.5 * sin(2 * 2 * pi * frequency * t) +
    0.25 * sin(3 * 2 * pi * frequency * t) +
    0.125 * sin(4 * 2 * pi * frequency * t)
  
  # Apply an envelope to simulate piano decay
  envelope <- exp(-3 * t / duration)
  wave <- wave * envelope
  
  return(wave)
}