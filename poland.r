poland1 <- read.csv("Poland.csv", sep = ";", na.strings = "-")

poland <- read.csv("Polska_1966.csv", sep = ";", na.strings = "–")

library(dplyr)
poland_sum <- poland %>% 
  mutate(kidney = rowSums(poland[,c("Kidney_DD","Kidney_LD","Kidney_Pancreas","Liver_Kidney","Heart_Kidney","Kidney_Lung")], na.rm = TRUE),
         heart = rowSums(poland[,c("Heart","Heart_Lung","Heart_Kidney","Heart_Liver")],na.rm=TRUE),
         liver = rowSums(poland[,c("Liver_DD","Liver_LD","Liver_Kidney","Heart_Liver","Lung_Liver")],na.rm=TRUE),
         pancreas = rowSums(poland[,c("Pancreas","Kidney_Pancreas","Liver_Pancreas")],na.rm=TRUE),
         lung = rowSums(poland[,c("Lung_LD","Lung_DD","Heart_Lung","Lung_Liver","Kidney_Lung")],na.rm=TRUE))
poland_sum <- poland_sum %>% 
  mutate(total = rowSums(poland_sum[,c("kidney","heart","liver","pancreas","lung")], na.rm = TRUE))
library(ggplot2)

poland_sum1 <- poland1 %>% 
  mutate(kidney = rowSums(poland1[,c("Kidney_DD","Kidney_LD","Kidney_Pancreas","Liver_Kidney","Heart_Kidney","Kidney_Lung")], na.rm = TRUE),
         heart = rowSums(poland1[,c("Heart","Heart_Lung","Heart_Kidney","Heart_Liver")],na.rm=TRUE),
         liver = rowSums(poland1[,c("Liver_DD","Liver_LD","Liver_Kidney","Heart_Liver","Lung_Liver")],na.rm=TRUE),
         pancreas = rowSums(poland1[,c("Pancreas","Kidney_Pancreas","Liver_Pancreas")],na.rm=TRUE),
         lung = rowSums(poland1[,c("Lung_LD","Lung_DD","Heart_Lung","Lung_Liver","Kidney_Lung")],na.rm=TRUE))
poland_sum1 <- poland_sum1 %>% 
  mutate(total = rowSums(poland_sum1[,c("kidney","heart","liver","pancreas","lung")], na.rm = TRUE))


ggplot(poland_sum1[7:13,], aes(x=factor(Year))) +
  geom_bar(aes(y=total), stat="identity", fill="lightgrey") +
  geom_line(aes(y=kidney, color="Kidney", group=1), size=0.5) +
  geom_line(aes(y=liver, color="Liver", group=1), size=0.5) +
  geom_line(aes(y=heart, color="Heart", group=1), size=0.5) +
  geom_line(aes(y=pancreas, color="Pancreas", group=1), size=0.5) +
  geom_line(aes(y=lung, color="Lung", group=1), size=0.5) +
  labs(x="Year", y="Number of organs", color="Organ Type") +
  scale_color_manual(values=c(
    "Kidney" = "#1f78b4",  # A stronger blue for kidney
    "Liver" = "#33a02c",   # A vibrant green for liver
    "Heart" = "#e31a1c",   # A bold red for heart
    "Pancreas" = "#ff7f00",# A bright orange for pancreas
    "Lung" = "#6a3d9a"     # A deep purple for lung
  )) +
  scale_y_continuous(expand = c(0,0)) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "#D5E5F0"),
    legend.position = "right"  
  )


library(scales) 
####
ggplot(poland_sum, aes(x=factor(Year))) +
  geom_bar(aes(y=total), stat="identity", fill="#D5E5F0") +
  labs(x="Year", y="Number of organs") +
  scale_y_continuous(expand = c(0,0),breaks = pretty_breaks(n = 7)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
