#install.packages('readxl')
library("readxl")
library(dplyr)
library(tidyr)
library(ggplot2)


donors <- read_excel("Organ_Donation_and_Transplantation_Data.xlsx", sheet = "Donor Demographics")
donors_table <- donors %>%
  filter(`Category` == "4 - Sex" & `Donor Type Filter` != "All") %>% 
  mutate(`Donor Count` = as.numeric(`Donor Count`))

donor_summary <- donors_table %>%
  group_by(`Donor Type Filter`) %>%
  summarize(
    Total_Donors = sum(`Donor Count`),
    Female_Count = sum(`Donor Count`[Level == "Female"]),
    Male_Count = sum(`Donor Count`[Level == "Male"]),
    .groups = "drop"
  ) %>%
  mutate(
    Female_Percentage = (Female_Count / Total_Donors) * 100,
    Male_Percentage = (Male_Count / Total_Donors) * 100
  ) %>%
  select(`Donor Type Filter`, Female_Percentage, Male_Percentage) %>%
  pivot_longer(cols = ends_with("Percentage"), names_to = "Level", values_to = "Percentage") %>%
  mutate(Sex = ifelse(grepl("Female", Level), "Female", "Male")) %>% select(-Level)

plot <- donor_summary %>%
  mutate(Percentage = ifelse(Sex == "Male", -Percentage, Percentage)) %>%
  ggplot(aes(x = `Donor Type Filter`, y = Percentage, fill = Sex)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_y_continuous(limits = c(-100, 100), expand = c(0, 0), labels = scales::percent_format(scale = 1)) +
  labs(x = "") + coord_flip()

plot
ggsave("donor_plot.png", plot, width = 10, height = 3)
