library(dplyr)
library(readxl)
crime_dt <- read_excel("Transnational_Crime.xlsx", sheet = "Organs") %>% select(-Country)
library(ggplot2)
library(scales)

##### BOXPLOT PRICE OF ORGANS
price_plot <- ggplot(crime_dt, aes(x = Organ, y = Price)) +
  geom_boxplot(fill = "lightblue") +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "Price of Organs",
    x = "Organ",
    y = "Price"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14))
price_plot
ggsave("price_plot.png", price_plot, width = 8, height = 6)


#### grafy
library(igraph)

###########
# krawedzie <- c(1, 2, 2, 3, 3, 4, 4, 1, 1, 3)
# graf <- make_graph(edges = krawedzie, directed = TRUE)
# plot(graf, vertex.color = "skyblue", vertex.size = 30, edge.arrow.size = 0.5,
#      vertex.label.color = "black", main = "Przykładowy graf")
###########

crime_dt2 <- read_excel("Transnational_Crime.xlsx", sheet = "Vendors vs Recipients")
crime_dt2 <- crime_dt2 %>% mutate(markup = Recipient_Paid-Vendor_Received)

edges <- data.frame(from = crime_dt2$Vendor_From, to = crime_dt2$Recipient_From)

g <- graph_from_data_frame(d = edges, directed = TRUE)

# Dodanie wartości markup jako atrybutu krawędzi
# E(g)$label <- crime_dt2$markup
# E(g)$label.cex <- 0.8
# E(g)$label.color <- "black"

x_coords <- c(4, 6, 2, 2, 4, 3, 5, 0, 0, 6, 1)
y_coords <- c(6, 5, 6, 1, 1, 4, 3, 4, 2, 2, 3)

custom_layout <- cbind(x_coords, y_coords)

plot(
  g,
  vertex.size = 33,
  vertex.label.cex = 0.7,
  vertex.label.color = "black",
  edge.arrow.size = 0.5,
  edge.color = "darkgrey",
  vertex.color = "lightblue",
  edge.loop.angle = pi/2,
  layout = custom_layout
  # edge.label = E(g)$label,
  # edge.label.cex = E(g)$label.cex,
  # edge.label.color = E(g)$label.color
)
title(main = "Kidney Crime Map", font.main = 1, cex.main = 1.5)


