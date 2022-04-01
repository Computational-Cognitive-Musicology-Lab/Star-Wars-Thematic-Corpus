# Star Wars Themeatic Corpus Github Guide

This document serves as an extended table-of-contents for the Star Wars Thematic Corpus, outlining its organization and the kinds of files contained in the final corpus.

## Star Wars Thematic Corpus (SWTC)
This repository contains a dataset of melodic and harmonic transcriptions of the major themes from the complete Star Wars trilogies (Episodes I-IX). There are a total of 64 distinct themes, each with its own file available in multiple formats (.sib, .musicxml, .krn), with the primary  computer-readable encoding in humdrum format (https://www.humdrum.org/).

## Contributions
This corpus was originally transcribed by Frank Lehman in Sibelius format, and released as a complete catalog in the form of a large table document including a score engraving of each theme, the films in which the theme recurs, and the timestamp for its original presentation in the associated film. This document was released publicly in XXXX and is available on Lehman’s website (https://franklehman.com/starwars/)
Expansion of the themes to their unrestricted size (measures were previously constrained by space in the pdf document) and updates to the Sibelius file transcriptions were undertaken by Frank Lehman, and subsequent conversion to humdrum format was undertaken by Claire Arthur and John McNarmara.

## Directory Organization
The corpus’s musical files have been organized into folders based on the three trilogies of “main-line” Star Wars movies: themes originating in Episodes IV, V, and and VI appear in the “Original Trilogy Theme ,” folder, those originating in Episodes I, II, and III are in the “Prequel Trilogy…” folder, and those originating in Episodes VII, VIII, and IX are in the “Sequel Trilogy…” folder. Within each of these folders, the corpus data is further categorized based on file extension as follows:

*Sibelius Files* - This is the format in which the themes were initially digitized and which were used for the initial harmonic and formal transcriptions. Chords are labeled using “Chord Symbol” objects within Sibelius, and text contains Roman numeral annotations, pedal notes, cadential annotations, with any  additional annotations encoded as “lyrics”.

*XML* - These uncompressed musicxml files are the direct output of Sibelius’s batch export feature. They are included to facilitate viewing the corpus content in other music notation programs such as Finale or Musescore.

*Kerns* - We converted the musicxml files to kern (.krn) format using the musicxml2hum command within the humlib library (Sapp, 2021; available at https://github.com/humdrum-tools/humlib).  We then processed these files with several scripts (see below) to reformat and reorganize the raw output data. Finally, we manually reviewed and edited each file to ensure that formatting and notation were consistent across the corpus. 

## Kern Files
 We include the following spine types in the SWTC humdrum files: \*\*kern, \*\*harte, \*\*harm, \*\*altharm, \*\*pedal, \*\*cadence, and \*\*text.  Both \*\*kern and \*\*harm are preexisting humdrum format standards (see https://www.humdrum.org/guide/ch02/ and https://www.humdrum.org/rep/harm/, respectively), whereas the rest have been customized for this specific corpus. For the SWTC, we propose a new standard humdrum representation for chord symbols, \*\*harte, based on an existing proposed standard for representing chord symbols (Harte, 2010) widely in use already within the music information retrieval community. Descriptions of each kern spine can be found in Table 1 below. Since not every file contains information for the relevant spine, the number of spines per file is variable. At a minimum, each file must contain a \*\*kern (melodic information) spine, and may optionally include all other spines as relevant. For instance, themes with no clear tonal center do not contain \*\*harm or \*\*altharm spines (functional harmony representations). Themes with explicit harmonic accompaniment will include a \*\*harte spine (and \*\*harm spine if appropriate), however, files with only a \*\*harm spine but no \*\*harte spine are indicative of implied harmony only. 

#### Table 1. Kern spines (columns), and the description of each, for the SWTC.

| Spine Label | Description |
| ----------- | ----------- |
| \*\*kern | Melodic information in humdrum’s standard kern format. See https://www.humdrum.org/guide/ch02/ | 
| \*\*harte | Chord labels based on Harte, 2010. A brief explanation can be found below and a more extensive explanation in the documentation on the SWTC github repository. (See: https://github.com/Computational-Cognitive-Musicology-Lab/Star-Wars-Thematic-Corpus). |
| \*\*harm | Roman numerals according to the \*\*harm format. See https://www.humdrum.org/rep/harm/ |
| \*\*altharm | Alternative Roman numeral interpretations in \*\*harm format. If none, then the spine is empty with only placeholder tokens. |
| \*\*pedal | Indication of pedal tones. Pedal tones are assumed to continue unless explicitly overtaken by a new pedal tone or replaced with “None”. |
| \*\*cadence | Cadential information (e.g., HC, PAC, etc.) and Formal boundary markings (e.g., “;;” signifies an abrupt or non-conclusive ending). See list of cadence and boundary types and their associated abbreviations described in Table XXX |
| \*\*text | Any additional information or notes in comment-style form. E.g., type of modulation (e.g., pivot), textural notes, etc. |


Each file includes relevant bibliographic metadata in the humdrum reference records (see: https://www.humdrum.org/reference-records/). Reference records at the top of each file include: the composer, title, associated work, date of composition, transcriber, and digital encoders. 

## Harte Encoding
The inclusion of a new non-functional harmony encoding in humdrum format is aimed to facilitate data sharing, and provide a more robust encoding method for songs that contain harmony where traditional Roman numeral interpretations frequently become inappropriate or inconsistent (e.g., popular, jazz, and film music). We chose the Harte (2005, 2010) representation since it provides a comprehensive method for encoding any chord as well as a simple, condensed method for common chords; and because it is already widely encountered in the music information retrieval (MIR) community. See Harte (2010) for a complete explanation.

Note that we had to make one small modification in order to make the data more appropriate for use with the the humdrum toolkit and other humdrum tools (e.g., Verovio Humdrum Viewer, citeXXX; humdrumR, citeXXX). That is, since in kern the lower case letter “b” is used to represent chordal inversions, a flat is instead represented with a minus symbol (-). Since Harte encodings are specified in the following format: root: intervals above bass, we chose to convert flats in the root encoding to be consistent with humdrum syntax. In addition, we observed a lack of clarity in Harte’s documentation as to the default syntax for representing intervals above the bass. This is extremely important as the exact intervals must be easily understood and systematically applied so as to allow for ease of use with computational methods. We inferred from Harte’s examples that perfect intervals and major imperfect intervals are defaults, and therefore any minor, augmented, or diminished intervals must be explicitly specified. As such, a C major 7th chord over the 7th would be written as C:maj7/7 while a minor 7th chord or major-minor 7th must be written as explicitly over a minor seventh (e.g., C:min7/m7; C:7/m7, respectively). 

Scripts
The files in the “Scripts” folder were used to revise and edit the krn files created from the musicxml conversion into humdrum format. 
Add_header.py - adds global interpretations to krn files describing the composer, composition date, theme title, and associated movie of each theme. It also adds information about the corpus encoder and editors.
Remove_empty.sh - removes spines that do not contain any data
Remove_space.py - replaces spaces in file names with underscores
Renamespines.sh - takes the raw output from “musicxml2hum” and renames and reorders the spines appropriately.
Rn2harm.py/sh - converts harmonic information from rntxt formant to humdrum format.
Unbeam.sh - removes beaming information from \*\*kern spines.
Unbracket.sh - removes brackets from \*\*kern spines.