library(testthat)
library(tuneR)

source("../R/apply_reverb.R")

test_that("apply_reverb works with valid input", {
  audio <- readWave("CantinaBand3.wav")
  expect_silent(reverbed_audio <- .apply_reverb(audio, delay = 0.5, decay = 0.3))
  expect_true(is(audio, "Wave"))
})

test_that("apply_reverb handles invalid delay", {
  audio <- readWave("CantinaBand3.wav")
  expect_error(.apply_reverb(audio, delay = -0.5, decay = 0.3), "invalid 'times' argument")
})

test_that("apply_reverb handles invalid decay", {
  audio <- readWave("CantinaBand3.wav")
  expect_error(.apply_reverb(audio, delay = 0.5, decay = "invalid"), "non-numeric argument to binary operator")
})
