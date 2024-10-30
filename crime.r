library(dplyr)
library(readxl)
crime_dt <- read_excel("Transnational_Crime.xlsx", sheet = "Organs") %>% select(-Country)
library(ggplot2)
library(scales)

ggplot(crime_dt, aes(x = Organ, y = Price)) +
  geom_boxplot(fill = "lightblue") +
  labs(x = "Organ",
       y = "Price") + scale_y_continuous(labels = dollar)


#### grafy
library(igraph)

###########
# krawedzie <- c(1, 2, 2, 3, 3, 4, 4, 1, 1, 3)
# graf <- make_graph(edges = krawedzie, directed = TRUE)
# plot(graf, vertex.color = "skyblue", vertex.size = 30, edge.arrow.size = 0.5,
#      vertex.label.color = "black", main = "Przykładowy graf")
###########

crime_dt2 <- read_excel("Transnational_Crime.xlsx", sheet = "Vendors vs Recipients")
crime_dt2 <- crime_dt2 %>% 
  mutate(markup = Recipient_Paid-Vendor_Received)

# Tworzymy ramkę danych dla krawędzi grafu
edges <- data.frame(from = crime_dt2$Vendor_From, to = crime_dt2$Recipient_From)

# Tworzymy graf w oparciu o ramkę danych
g <- graph_from_data_frame(d = edges, directed = TRUE)

# Dodanie wartości Markup_Pr jako atrybutu krawędzi
#E(g)$label <- crime_dt2$markup

# Ustalenie własnego układu
x_coords <- c(5, 6, 3, 2, 4, 3, 4, 1, 1, 6, 2)  
y_coords <- c(6, 5, 6, 1, 1, 4, 3, 5, 2, 2, 3)

# Tworzymy macierz z współrzędnymi
custom_layout <- cbind(x_coords, y_coords)

plot(
  g,
  vertex.size = 33,                      # Rozmiar wierzchołków
  vertex.label.cex = 0.7,                 # Rozmiar etykiet
  vertex.label.color = "black",
  edge.arrow.size = 0.5,                  # Standardowy rozmiar strzałek
  edge.color = "darkgrey",
  vertex.color = "lightblue",
  layout = custom_layout
)







