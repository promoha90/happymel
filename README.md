# Happy-Melodies

## Overview

The **Happy-Melodies** R package provides tools for processing audio files. It includes functions to apply reverb effects, mix multiple audio tracks, and generate melodies.  
The package utilizes the `tuneR` library for handling `.wav` files and performing basic audio operations.

## Installation

To install the **Happy-Melodies** package, clone the repository and install it using `devtools`:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install the Happy-Melodies package from GitHub
devtools::install_github("promoha90/Happy-Melodies")
```

# Functions
## genmel(notes, file_name)
### Description: Generates a melody with a given number of notes and saves it as a .wav file.

### Arguments:

- **notes: The number of notes in the melody (positive integer).**
- **file_name: The name of the output .wav file.**
  
***Saves a new .wav file with the generated melody.***

### Example:
```r
genmel(notes = 10, file_name = "melody")
```

<br>

## reverb(file_name, delay, decay)
### Description: Applies a **reverb effect** to an audio file and saves the modified audio to a new file.

### Arguments:

- **file_name: The path to the .wav file to process.**
- **delay: The delay time in seconds for the reverb effect (positive number).**
- **decay: The decay factor for the reverb effect (positive number).**
  
***Saves a new .wav file with the reverb effect applied.***

### Example:
```r
reverb("input.wav", delay = 0.5, decay = 0.3)
```

<br>

## tracksmix(...)
### Description: Combines multiple audio tracks into a single track by summing their samples and saving the result as a new .wav file.

### Arguments:

- **...: A list of paths to .wav files to be mixed.**
  
***Saves a new .wav file with the mixed audio.***

### Example:
```r
tracksmix("track1.wav", "track2.wav", "track3.wav")
```

<br>

# Function Details
## reverb
This function applies a reverb effect to the specified .wav file. It validates the input parameters, applies the reverb effect, and saves the processed audio to a new file with _reverbed appended to the original file name.

## tracksmix
This function combines multiple .wav files into a single audio track. It pads shorter tracks with zeros to match the length of the longest track, sums the audio samples, and normalizes the result to prevent clipping.

## genmel
This function generates a melody composed of random notes from the musical scale. It creates sine waves for each note, combines them, and saves the resulting melody as a .wav file.

<br>

# Tests
The functions are tested with various scenarios to ensure their correctness:

- **reverb: Tests include applying reverb to a valid .wav file with different delay and decay values, and handling invalid input.**
- **tracksmix: Tests include mixing multiple .wav files, handling files of different lengths, and ensuring proper padding and normalization.**
- **genmel: Tests include generating melodies with different numbers of notes and saving them to .wav files.**

### Example Test Usage
To run the tests, use the testthat package or manually verify each function's behavior as demonstrated in the examples provided above.

<br>

# License
This repository is licensed under the [MIT License](LICENSE).

<br>

# Contact
For any questions or issues, please contact Mohamed Lotfi Hireche Benkert via gmail.