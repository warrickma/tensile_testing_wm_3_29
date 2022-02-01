library(ggplot2)
library(scales)
library(svglite)
data_1 = read.csv("trial_1.csv")
#Clean up the data, remove unnecessary headers
data_1 = data_1[-(1:2136),(1:3)]
colnames(data_1) = c("Time", "Displacement", "Force")
data_1$Time = as.numeric(as.character(data_1$Time))
data_1$Displacement = as.numeric(as.character(data_1$Displacement))
data_1$Force = as.numeric(as.character(data_1$Force))
#Compute Strain (mm/mm)
data_1$Tensile_Strain = data_1$Displacement/14.18
#Compute Stress
data_1$Tensile_Stress = data_1$Force/(1.07*1.58)
data_1$trial = "1"

data_2 = read.csv("trial_2.csv")
data_2 = data_2[-(1:2136),(1:3)]
colnames(data_2) = c("Time", "Displacement", "Force")
data_2$Time = as.numeric(as.character(data_2$Time))
data_2$Displacement = as.numeric(as.character(data_2$Displacement))
data_2$Force = as.numeric(as.character(data_2$Force))
data_2$Tensile_Strain = data_2$Displacement/15.31
data_2$Tensile_Stress = data_2$Force/(1.58*1.05)
data_2$trial = "2"

data_3 = read.csv("trial_3.csv")
data_3 = data_3[-(1:2136),(1:3)]
colnames(data_3) = c("Time", "Displacement", "Force")
data_3$Time = as.numeric(as.character(data_3$Time))
data_3$Displacement = as.numeric(as.character(data_3$Displacement))
data_3$Force = as.numeric(as.character(data_3$Force))
data_3$Tensile_Strain = data_3$Displacement/14.22
data_3$Tensile_Stress = data_3$Force/(1.57*0.96)
data_3$trial = "3"

#Combine trials in one single file
subtotal = rbind(data_1, data_2)
total = rbind(subtotal, data_3)

ggplot(total) +
  geom_path(aes(x = Tensile_Strain, y = Tensile_Stress, color = trial), size = 1) +
  #Use Cornell branding color
  scale_color_manual(name = "Trial",
                     limits = c("1", "2", "3"),
                     values = c("#D47500", "#6EB43F", "#073949")) +
  labs(x = "Strain", y = "Stress (kPa)") +
  scale_x_continuous(limits = c(0,0.60), n.breaks = 5, labels = scales::percent) +
  theme_classic() +
  theme(
    axis.text.x = element_text(size=10, color = "black", face = "bold"),
    axis.text.y = element_text(size=10, color = "black", face = "bold"),
    axis.title = element_text(size=10, color = "black", face = "bold"),
    legend.title = element_text(size=10, color = "black", face = "bold"),
    legend.text = element_text(size=10, color = "black", face = "bold"),
    legend.position = "none")
ggsave("tension.svg", width = 80, height = 80, units = "mm")
levels(processed$Cycle)