library(tuneR)

source(file.path("R", "apply_reverb.R"))

# String positiveDouble positiveDouble -> Audio

# Generate a reverbed audio given a WAV file, delay, and decay
reverb <- function(file_name, delay, decay) {
  # Validate Input
  file_name <- trimws(file_name)
  if (!grepl("\\.wav$", file_name, ignore.case = TRUE)) {
    stop("Error: 'file_name' must be a .wav file.")
  }
  
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
  reverb_audio <- .apply_reverb(audio, delay, decay)
  
  # 3. Save modified audio file
  output_file_name <- paste0(tools::file_path_sans_ext(file_name), "_reverbed.wav")
  writeWave(reverb_audio, output_file_name)
  
  # Informative message
  if (verbose) {
    message("Reverbed audio saved as", output_file_name)
  }
}