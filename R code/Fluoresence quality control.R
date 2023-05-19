# Get the file names of all the files that contain microscope settings info for the GFP images, so that they can be copied into another folder
files_GFP_xlif = list.files(path = "D:/Oxford/4th-year Project/Results/Images/Fluorescence", pattern = glob2rx("*GFP*xlif"), recursive = TRUE, full.names = TRUE)

# Copy into the new folder
file.copy(files_GFP_xlif, "D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/GFP")

# Get the file names of all the files in the new directory
to_be_renamed_GFP_xlif = list.files(path = "D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/GFP", pattern = glob2rx("*GFP*xlif"), full.names = TRUE)

# Rename the files so that they have the ".txt" extension
file.rename(from = to_be_renamed_GFP_xlif, to = sub(pattern = "xlif", replacement = "txt", to_be_renamed_GFP_xlif))

# Do the same as above, but for mCherry
files_mCherry_xlif = list.files(path = "D:/Oxford/4th-year Project/Results/Images/Fluorescence", pattern = glob2rx("*mCherry*xlif"), recursive = TRUE, full.names = TRUE)
file.copy(files_mCherry_xlif, "D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/mCherry")
to_be_renamed_mCherry_xlif = list.files(path = "D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/mCherry", pattern = glob2rx("*mCherry*xlif"), full.names = TRUE)
file.rename(from = to_be_renamed_mCherry_xlif, to = sub(pattern = "xlif", replacement = "txt", to_be_renamed_mCherry_xlif))



# Load the library containing the function that I will use to read the file contents
library(readtext)

# Read in the contents of the files containing the GFP settings data
GFP_settings = readtext("D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/GFP/*")

# Create two vectors - one for the file names, and one for whether the GFP filterset was used
Image_GFP = c()
Presence_GFP = c()

# Check each file for the presence of the character string "ET GFP", which would signify that the correct filterset was used
for(i in 1:length(GFP_settings$doc_id)){
  Image_GFP[i] = GFP_settings$doc_id[i]
  Presence_GFP[i] = grepl("ET GFP", GFP_settings$text[i])
}

# Create a tibble from the two vectors
GFP_check = tibble(Image_GFP, Presence_GFP)

# Have all the GFP images really been made with the right filterset, and if not, which ones have used a different filterset?
for(i in 1:length(GFP_check$Image_GFP)){
  if(GFP_check$Presence_GFP[i] != TRUE){
    print(GFP_check$Image_GFP[i])
  }
}

# CONCLUSION: Since no output is produced, we can conclude that all the GFP images have indeed been made with the GFP filterset



# Perform the same check for mCherry
mCherry_settings = readtext("D:/Oxford/4th-year Project/Results/Images/Fluorescence/Microscope settings for each image/mCherry/*")

Image_mCherry = c()
Presence_mCherry = c()

for(i in 1:length(mCherry_settings$doc_id)){
  Image_mCherry[i] = mCherry_settings$doc_id[i]
  Presence_mCherry[i] = grepl("ET mCHER", mCherry_settings$text[i])
}

mCherry_check = tibble(Image_mCherry, Presence_mCherry)

for(i in 1:length(mCherry_check$Image_mCherry)){
  if(mCherry_check$Presence_mCherry[i] != TRUE){
    print(mCherry_check$Image_mCherry[i])
  }
}

# CONCLUSION: Three of the mCherry images ("mCherry_D6_Con_P2.txt", "mCherry_D6_CR_P4_1.txt", and "mCherry_D6_NMN_P2.txt") have been taken with the wrong filterset ("ET GFP"), and so should be excluded from the analysis