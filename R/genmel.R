library(tuneR)

# Source the piano_wave function
source("R/piano_wave.R")

# Natural String -> Audio

# Produce a piano like melody given the number of notes and the name of the file

# genmel <- function(notes, file_name) ""  # stub

# genmel <- function(notes, file_name) {   # template
#   (... notes, file_name) 
# }

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
  
  # 1. Define note frequencies for all keys on a full-sized piano (88 keys)
  note_frequencies <- c(
    A0 = 27.50, ASharp0 = 29.14, B0 = 30.87, C1 = 32.70, CSharp1 = 34.65, D1 = 36.71, DSharp1 = 38.89, E1 = 41.20, F1 = 43.65, FSharp1 = 46.25, G1 = 49.00, GSharp1 = 51.91, A1 = 55.00, ASharp1 = 58.27, B1 = 61.74,
    C2 = 65.41, CSharp2 = 69.30, D2 = 73.42, DSharp2 = 77.78, E2 = 82.41, F2 = 87.31, FSharp2 = 92.50, G2 = 98.00, GSharp2 = 103.83, A2 = 110.00, ASharp2 = 116.54, B2 = 123.47,
    C3 = 130.81, CSharp3 = 138.59, D3 = 146.83, DSharp3 = 155.56, E3 = 164.81, F3 = 174.61, FSharp3 = 185.00, G3 = 196.00, GSharp3 = 207.65, A3 = 220.00, ASharp3 = 233.08, B3 = 246.94,
    C4 = 261.63, CSharp4 = 277.18, D4 = 293.66, DSharp4 = 311.13, E4 = 329.63, F4 = 349.23, FSharp4 = 369.99, G4 = 392.00, GSharp4 = 415.30, A4 = 440.00, ASharp4 = 466.16, B4 = 493.88,
    C5 = 523.25, CSharp5 = 554.37, D5 = 587.33, DSharp5 = 622.25, E5 = 659.25, F5 = 698.46, FSharp5 = 739.99, G5 = 783.99, GSharp5 = 830.61, A5 = 880.00, ASharp5 = 932.33, B5 = 987.77,
    C6 = 1046.50, CSharp6 = 1108.73, D6 = 1174.66, DSharp6 = 1244.51, E6 = 1318.51, F6 = 1396.91, FSharp6 = 1479.98, G6 = 1567.98, GSharp6 = 1661.22, A6 = 1760.00, ASharp6 = 1864.66, B6 = 1975.53,
    C7 = 2093.00, CSharp7 = 2217.46, D7 = 2349.32, DSharp7 = 2489.02, E7 = 2637.02, F7 = 2793.83, FSharp7 = 2959.96, G7 = 3135.96, GSharp7 = 3322.44, A7 = 3520.00, ASharp7 = 3729.31, B7 = 3951.07,
    C8 = 4186.01
  )
  
  # 2. Define note names
  scale <- names(note_frequencies)
  
  # 3. Generate random melody with notes from the defined scale
  melody <- sample(scale, size = notes, replace = TRUE)
  
  # 4. Set duration for each note (in seconds)
  note_duration <- 0.4
  
  # 5. Define volume adjustment (between 0 and 1, where 1 is the original volume)
  volume_factor <- 0.5
  
  # 6. Calculate total duration and sample rate
  sample_rate <- 44100
  samples_per_note <- round(note_duration * sample_rate)
  total_samples <- samples_per_note * notes
  
  # 7. Create a single Wave object for the entire melody
  combined_wave <- Wave(left = numeric(total_samples), right = numeric(total_samples), samp.rate = sample_rate, bit = 16)
  
  # 8. Generate and combine piano-like waves for each note
  for (i in seq_along(melody)) {
    note <- melody[i]
    frequency <- note_frequencies[note]
    
    # 8.1 Generate piano-like wave for this note
    wave <- piano_wave(frequency, note_duration, sample_rate)
    
    # 8.2 Apply volume adjustment
    wave <- wave * volume_factor
    
    # 8.3 Calculate start and end sample for this note
    start_sample <- ((i - 1) * samples_per_note) + 1
    end_sample <- i * samples_per_note
    
    # 8.4 Add this wave to the combined wave
    combined_wave@left[start_sample:end_sample] <- wave
    combined_wave@right[start_sample:end_sample] <- wave
  }
  
  # 9. Normalize combined wave to ensure uniform volume levels
  combined_wave <- normalize(combined_wave, unit = "16")
  
  # 10. Save to file
  output_file_name <- paste0(file_name, ".wav")
  writeWave(combined_wave, output_file_name)
  
  cat("Piano melody audio saved as", output_file_name, "\n")
}