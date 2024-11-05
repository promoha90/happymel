library(tuneR)

tracksmix <- function(...) {
  args <- list(...)  # Capture all arguments as a list
  
  # Validate files and ensure they are all .wav files
  for (file_name in args) {
    file_name <- trimws(file_name)  # Strip any whitespace
    if (!grepl("\\.wav$", file_name, ignore.case = TRUE)) {
      stop(paste0("Error: File '", file_name, "' must be a .wav file."))
    }
    if (!file.exists(file_name)) {
      stop(paste0("Error: File '", file_name, "' doesn't exist."))
    }
  }
  
  # 1. Load all the audio tracks
  audio_tracks <- lapply(args, readWave)
  
  # 2. Find the maximum length of the tracks
  max_length <- max(sapply(audio_tracks, function(audio) length(audio@left)))
  
  # 3. Pad shorter tracks with zeros to match the length of the longest track
  padded_tracks <- lapply(audio_tracks, function(audio) {
    if (length(audio@left) < max_length) {
      pad_length <- max_length - length(audio@left)
      audio@left <- c(audio@left, rep(0, pad_length))
    }
    return(audio)
  })
  
  # 4. Combine the tracks by summing their samples
  mixed_audio <- padded_tracks[[1]]
  for (i in 2:length(padded_tracks)) {
    mixed_audio@left <- mixed_audio@left + padded_tracks[[i]]@left
  }
  
  # 5. Normalize the mixed audio to prevent clipping
  mixed_audio@left <- mixed_audio@left / max(abs(mixed_audio@left))
  
  # 6. Save the mixed audio to a new file
  output_file_name <- "mixed_audio.wav"
  writeWave(mixed_audio, output_file_name)
  
  # Informative message
  if(verbose){
    message("Mixed audio saved as", output_file_name)
  }
}