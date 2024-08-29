library(testthat)

source("../R/piano_wave.R")

test_that("piano_wave generates a waveform within the correct range", {
  frequency <- 440
  duration <- 1
  sample_rate <- 44100

  wave <- piano_wave(frequency, duration, sample_rate)

  expect_is(wave, "numeric")

  expected_length <- round(duration * sample_rate)
  expect_equal(length(wave), expected_length)

  expect_true(all(wave >= -1 & wave <= 1))
})

test_that("piano_wave generates a waveform with all positive values", {
  frequency <- 440
  duration <- 1
  sample_rate <- 4410

  wave <- piano_wave(frequency, duration, sample_rate)

  expect_true(all(wave >= -1 & wave <= 1))
})