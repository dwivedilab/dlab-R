if(!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

# select the data file (make sure the format is CSV)
data_file <- read_csv(file.choose())

# specify columns (conditions) to look at. (Pick 2)
conds <- c("SPIN", "Dif_Gaze_on_A")

# extract the relevant columns from the data file
sp_data <- select(data_file, all_of(conds))

# plot scatterplot + line of best fit using selected data file
ggplot(data = sp_data, aes(x = SPIN, y = Dif_Gaze_on_A)) +
  geom_point() +
  geom_smooth(method=lm, se=FALSE, col="black") + 
  theme_classic() + 
  labs(x="SPIN", y="Difference between Direct Gaze and Averted Gaze on A")

# Save plot to "My Documents" or wherever your working directory is.
# Feel free to change the name here but keep the .png to save the image
# in better quality. You can also rename the file manually after saving.
ggsave("Sent-Face India N=34 PA-Dif_Det_on_DG plot.png")

# ----------------------------additional---------------------------- 
# calculate Pearson's r
if(!require("Hmisc")) install.packages("Hmisc")
library(Hmisc)

# print correlation matrix to console (assuming you already have sp_data from above)
print(rcorr(as.matrix(sp_data)))
