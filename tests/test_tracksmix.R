library(testthat)
library(tuneR)

source("../R/tracksmix.R")
# Define test cases

test_that("Successful audio mixing", {

  tracksmix("test1.wav", "test2.wav", "test3.wav")

  output_file <- "mixed_audio.wav"
  expect_true(file.exists(output_file))

  audio <- readWave(output_file)

  expect_gt(length(audio@left), 0)

  file.remove(output_file)
})

test_that("Invalid file extension", {
  expect_error(tracksmix("test1.txt", "test2.wav"),
               "Error: File 'test1.txt' must be a .wav file.")
})

test_that("Non-existing file", {
  expect_error(tracksmix("nonexistent.wav"),
               "Error: File 'nonexistent.wav' doesn't exist.")
})

test_that("Different lengths of tracks", {
  tracksmix("test_short.wav", "test_long.wav")

  output_file <- "mixed_audio.wav"
  expect_true(file.exists(output_file))

  audio <- readWave(output_file)

  expect_gt(length(audio@left), 0)

  file.remove(output_file)
})

test_that("Normalization to prevent clipping", {
  tracksmix("test1.wav", "test2.wav")

  audio <- readWave("mixed_audio.wav")

  expect_true(all(abs(audio@left) <= 32767))

  file.remove("mixed_audio.wav")
})
