library(tuneR)

# Number String -> Wav Audio File

# generate_melody <- function(size, file_name) invisible(NULL)  # stub

# generate_melody <- function(size, file_name) {                # template
#   (... size, file_name)
#}

generate_melody <- function(size, file_name) {
  # Function to generate a melody from a number string and save it as a WAV file
  # Arguments:
  #   size: The size of the melody or the number of notes
  #   file_name: The name of the output WAV file
  # Returns: NULL (saves the WAV file but does not return a value)
  
  # 1. Generate melody
  scale <- c("C", "D", "E", "F", "G", "A", "B")
  note_frequencies <- c(C = 261.63, D = 293.66, E = 329.63, F = 349.23, G = 392.00, A = 440.00, B = 493.88)
  
  melody <- sample(scale, size = size, replace = TRUE)
  
  # 2. Generate sine waves
  waves <- lapply(melody, function(note) {
    sine(note_frequencies[note], duration = 1, xunit = "time")
  })
  
  print(waves)  # Add this line to inspect the waves list
  # 3. Conbine waves
  combined_wave <- do.call(bind, waves)
  
  # Save to file
  writeWave(combined_wave, paste0(file_name, ".wav"))
  invisible(NULL)
}
generate_melody(100, "pessoua")
