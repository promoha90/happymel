library(testthat)
library(tuneR)

# Load the function to be tested
source("../R/piano_wave.R")
source("../R/genmel.R")

# Define test cases

test_that("Successful melody generation", {
  # Generate a melody with 5 notes
  genmel(5, "wavs/test_melody")

  # Check if output file is created
  output_file <- "wavs/test_melody.wav"
  expect_true(file.exists(output_file))

  # Check if the file is a valid WAV file and contains data
  audio <- readWave(output_file)
  expect_gt(length(audio@left), 0)  # Ensure the file is not empty

  # Clean up
  file.remove(output_file)
})

test_that("Invalid number of notes", {
  expect_error(genmel(-5, "wavs/test_melody"),
               "Error: 'notes' must be a positive integer.")

  expect_error(genmel(0, "wavs/test_melody"),
               "Error: 'notes' must be a positive integer.")

  expect_error(genmel(3.5, "wavs/test_melody"),
               "Error: 'notes' must be a positive integer.")

  expect_error(genmel("five", "wavs/test_melody"),
               "Error: 'notes' must be a positive integer.")
})

test_that("Invalid file name", {
  expect_error(genmel(5, ""), "Error: 'file_name' should be a non-empty string.")
})


