library(testthat)
library(mockery)

source("../R/calcBPM.R")

wav_file = "../wav_examples/CantinaBand3.wav"
test_that("calcBPM returns a numeric value", {
  expect_type(calcBPM(wav_file), "double")
})

wav_file = "../wav_examples/StarWars3.wav"
test_that("calcBPM returns a numeric value", {
  expect_type(calcBPM(wav_file), "double")
})

test_that("calcBPM handles non-existent files gracefully", {
  expect_equal(calcBPM("non_existent_file.wav"), "Error: File not found")
})

test_that("calcBPM handles files with NA values in FFT", {
  # Create a mock function to simulate NA values in FFT
  mock_readWave <- function(file_path) {
    structure(list(left = c(NA, NA, NA)), class = "Wave")
  }

  stub(calcBPM, "readWave", mock_readWave)

  result <- calcBPM("mock_file.wav")
  expect_equal(result, "Error: File not found")
})
