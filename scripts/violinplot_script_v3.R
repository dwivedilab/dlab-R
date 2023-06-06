if(!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

if(!require("ggbeeswarm")) install.packages("ggbeeswarm")
library(ggbeeswarm)

# select the data file (make sure the format is CSV)
data_file <- read_csv(file.choose())

# specify columns (conditions) to look at. 
# make sure the columns are in order of how you want it presented (left to right)
# presets: conds <- c("A_DG", "A_AG", "That_DG", "That_AG") for sent-faces
#          or conds <- c("A", "That") for sent-only
conds <- c("A_DG", "A_AG", "That_DG", "That_AG")
# conds <- c("Non-specific w/ Direct Gaze",	"Non-specific w/ Averted Gaze",	"Specific w/ Direct Gaze",	"Specific w/ Averted Gaze")
# conds <- c("May_DG", "May_AG", "Might_DG", "Might_AG", "Will_DG", "Will_AG")

# extract the relevant columns from the data file and reformat it
vp_data <- select(data_file, all_of(conds)) %>% 
  gather("condition", "avg_rating", na.rm = TRUE)

# reorder legends for plotting (doesn't actually affect vp_data)
vp_data$condition <- factor(vp_data$condition, levels = conds)

# plot violin graph using selected data file without colour
ggplot(data = vp_data, aes(x = condition, y = avg_rating)) +
  geom_violin() +
  geom_boxplot(width = 0.15) +
  geom_quasirandom(alpha = 0.6) +
  theme_classic() +
  labs(x="Sentence-Gaze Condition",y="Average Naturalness Rating") + 
  scale_y_continuous(limits = c(2,7)) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x,width=15))

# plot violin graph using selected datafile with colour
ggplot(data = vp_data, aes(x = condition, y = avg_rating)) +
  geom_violin(mapping=aes(fill=condition)) +
  geom_boxplot(width = 0.15) +
  geom_quasirandom(alpha = 0.6) +
  theme_classic() +
  labs(x="Sentence-Gaze Condition",y="Average Naturalness Rating",
       fill="Sentence-Gaze Condition") + 
  scale_y_continuous(limits = c(2,7)) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x,width=15))

# Save plot to "My Documents" or wherever your working directory is.
# Feel free to change the name here but keep the .png to save the image
# in better quality. You can also rename the file manually after saving.
ggsave("Sent-Face Brock N=51 Det-Ratings Violinplot Colour.png")
