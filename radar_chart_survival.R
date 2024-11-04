library(readxl)
library(dplyr)
#install.packages("fmsb")
library(fmsb)
survival_rate <- read_excel("survival_rate.xlsx", sheet = "Data")
survival_rate<- as.data.frame(t(survival_rate))
colnames(survival_rate) <- survival_rate[1, ]
survival_rate <- survival_rate[-1, ]

survival_rate[, 1:8] <- lapply(survival_rate[, 1:8], function(x) as.numeric(as.character(x)))

min_value_s <- rep(20, 8)
max_value_s <- rep(100,8)
survival_data <- rbind(max_value_s,min_value_s, survival_rate)
colnames(survival_data)[7] <- "       Heart-Lung"


# Zapis do pliku PNG
png("survival_rate_radar_chart.png", width = 1500, height = 800, res = 150)

radarchart(survival_data, axistype = 1,
           pcol = c("blue", "red", "darkgreen"),   
           pfcol = c(rgb(0.678, 0.847, 0.902, 0.5),  
                     rgb(1, 0.75, 0.796, 0.5),        
                     rgb(0.678, 1, 0.678, 0.5)),    
           plwd = 1.5,                  
           cglcol = "black",         
           cglty = 1,                 
           axislabcol = "black",       
           caxislabels = seq(20, 100, 20),
           cglwd = 1.5,               
           seg = 4)

legend(x = 1.5, y = 1.2, legend = c("1 year survival rate", "3 years survival rate", "5 years survival rate"), 
       bty = "n", pch = 20, col = c("blue", "red", "darkgreen"), 
       text.col = "black", cex = 1, pt.cex = 1.5,
       x.intersp = 0.4, 
       y.intersp = 0.4)

title(main = "Survival Rates by Organ Transplantation", 
      col.main = "black", font.main = 1, cex.main = 1.5)

# Zamknięcie urządzenia graficznego i zapis pliku
dev.off()