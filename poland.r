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




library(scales) 
#### OK WYKRES
poland_plot <- ggplot(poland_sum, aes(x=factor(Year))) +
  geom_bar(aes(y=total), stat="identity", fill="#aecfee") +
  labs(x="Year", y="Number of organs") +
  scale_y_continuous(expand = c(0,0),
                     limits = c(0,2000),
                     breaks = seq(0, 2000, by = 500))+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 75, vjust = 1, hjust = 1, family = "Calibri", size = 11),
        axis.text = element_text(color = "white", family = "Calibri", size = 11),
        axis.title = element_text(color = "white", family = "Calibri", size = 11),
        panel.grid.major.x = element_blank(),  # Usuwa pionowe linie siatki
        #panel.grid.minor = element_blank(),    # Usuwa wszystkie linie siatki pomocnicze
        panel.grid.major.y = element_line()    # Pozostawia tylko poziome linie siatki
  )
poland_plot
ggsave("poland_plot.png", poland_plot, width = 10, height = 5)
library(ggplot2)
