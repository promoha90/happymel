library(testthat)
library(tuneR)

source("../R/apply_reverb.R")

test_that("apply_reverb works with valid input", {
  audio <- readWave("wavs/test.wav")
  reverbed_audio <- .apply_reverb(audio, delay = 0.5, decay = 0.3)
  expect_true(is(reverbed_audio, "Wave"))
})

test_that("apply_reverb handles invalid delay", {
  audio <- readWave("wavs/test.wav")
  expect_error(.apply_reverb(audio, delay = -0.5, decay = 0.3), "delay must be a positive number")
})

test_that("apply_reverb handles invalid decay", {
  audio <- readWave("wavs/test.wav")
  expect_error(.apply_reverb(audio, delay = 0.5, decay = "invalid"), "non-numeric argument")
})

test_that("apply_reverb handles zero decay", {
  audio <- readWave("wavs/test.wav")
  expect_error(.apply_reverb(audio, delay = 0.5, decay = 0), "decay must be a positive number")
})