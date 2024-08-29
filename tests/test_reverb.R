library(testthat)
library(tuneR)

# Load the function to be tested
source("../R/reverb.R")

test_that("Successful reverb application", {
  # Define a sample WAV file for testing
  writeWave(Wave(left = as.integer(runif(44100, min = -32768, max = 32767)),
                 samp.rate = 44100,
                 bit = 16), "wavs/test.wav")

  # Run the reverb function
  suppressWarnings(reverb("wavs/test.wav", 0.5, 0.7))

  # Check if output file is created
  output_file <- "wavs/test_reverbed.wav"
  expect_true(file.exists(output_file))

  # Clean up
  file.remove(output_file)
})

test_that("File does not exist", {
  expect_error(reverb("nonexistent_file.wav", 0.5, 0.7),
               "Error: 'file_name' does not exist")
})

test_that("File is not a WAV", {
  expect_error(reverb("file.txt", 0.5, 0.7),
               "Error: 'file_name' must be a .wav file.")
})

test_that("Invalid delay", {
  expect_error(reverb("wavs/test.wav", -0.5, 0.7),
               "Error: 'delay' must be a positive number.")

  expect_error(reverb("wavs/test.wav", Inf, 0.7),
               "Error: 'delay' must be a positive number.")
})

test_that("Invalid decay", {
  expect_error(reverb("wavs/test.wav", 0.5, -0.7),
               "Error: 'decay' must be a positive number.")

  expect_error(reverb("wavs/test.wav", 0.5, Inf),
               "Error: 'decay' must be a positive number.")
})

test_that("Non-numeric parameters", {
  expect_error(reverb("wavs/test.wav", "five", 0.7),
               "Error: 'delay' must be a positive number.")

  expect_error(reverb("wavs/test.wav", 0.5, "seven"),
               "Error: 'decay' must be a positive number.")
})

