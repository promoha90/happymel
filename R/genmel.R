library(tuneR)

# Generate a melody and save it as a WAV file given the number of notes and the file name
genmel <- function(notes, file_name) {
  file_name <- trimws(file_name)
  
  # Validate input parameters
  if (!is.numeric(notes) || notes <= 0 || notes %% 1 != 0) {
    stop("Error: 'notes' must be a positive integer.")
  }
  
  if (!is.character(file_name) || nchar(file_name) == 0) {
    stop("Error: 'file_name' should be a non-empty string.")
  }
  
  # 1. Define note frequencies
  scale <- c("C", "D", "E", "F", "G", "A", "B")
  note_frequencies <- c(A = 261.63, B = 293.66, C = 329.63, D = 349.23, E = 392.00, F = 440.00, G = 493.88)
  
  # 2. Generate random melody
  melody <- sample(scale, size = notes, replace = TRUE)
  
  # 3. Generate random durations for each note (between 0.5 and 2 seconds)
  note_durations <- runif(notes, min = 0.5, max = 2)
  
  # 4. Generate sine waves for each note
  waves <- lapply(seq_along(melody), function(i) {
    note <- melody[i]
    duration <- note_durations[i]
    sine(note_frequencies[note], duration = duration, xunit = "time")
  })
  
  # 5. Combine waves
  combined_wave <- do.call(bind, waves)
  
  # 6. Save to file
  output_file_name <- paste0(file_name, ".wav")
  writeWave(combined_wave, output_file_name)
  
  cat("Melody audio saved as", output_file_name, "\n")
}
