### A guide to using the schoodic_palette_ggplot functions in ggplot2


## Download the palette package
devtools::install_github("Kylelima21/schoodicPalette")
library(schoodicPalette)



##----------------------------------------##


### Ways to explore the schoodic palette

## There are two palettes, the main 5 colors and their 5 complements
schoodic_palette("main")
schoodic_palette("complimentary")

## You can visualize the colors for each palette here:
scales::show_col(schoodic_palette("main"), cex_label = 2)
scales::show_col(schoodic_palette("complimentary"), cex_label = 2)



##----------------------------------------##


### List of functions you can use in ggplot

## Regular color specification:
# schoodic_color() - geom_point(color = schoodic_color("green comp"))

## For discrete data:
# scale_fill_schoodic() - scale_fill_schoodic(palette = "main")
# scale_color_schoodic() - scale_color_schoodic(palette = "main")

## Manually specify colors for discrete data:
#scale_fill_manual(values = unname(c(schoodic_color("green", "purple"))))

## For continuous data:
# scale_fill_schoodic_c(palette = "main", direction = 1)
# scale_color_schoodic_c(palette = "main", direction = 1)



##----------------------------------------##


### Here are some examples in ggplot


## Call required packages
library(palmerpenguins)
library(tidyverse)


## Then read in dataset to use in examples
penguins <- palmerpenguins::penguins


## Simple color specifications
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(color = schoodic_color("green comp")) +
  theme_classic() +
  theme(axis.ticks = element_blank(),
        axis.title = element_blank(),
        panel.grid.major.x = element_blank())

penguins %>% 
  ggplot(aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(color = schoodic_color("purpleblue")) +
  theme_classic() +
  theme(axis.ticks = element_blank(),
        axis.title = element_blank(),
        panel.grid.major.x = element_blank())


## Scale fill
penguins %>% 
  count(species) %>% 
  ggplot(aes(x = species, y = n, fill = species)) +
  geom_bar(stat = "identity") +
  scale_fill_schoodic(palette = "main") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(y = "Number of individuals") +
  theme_classic() +
  theme(axis.title.x = element_blank())


## Scale fill manual (scale fill color would be the same idea)
penguins %>% 
  count(species) %>% 
  ggplot(aes(x = species, y = n, fill = species)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = 
                      unname(c(schoodic_color("green", "purple", "blue")))) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(y = "Number of individuals") +
  theme_classic() +
  theme(axis.title.x = element_blank())


## Scale color (with scale fill)
penguins %>% 
  count(species) %>% 
  ggplot(aes(x = species, y = n, fill = species, color = species)) +
  geom_bar(stat = "identity", linewidth = 1.3) +
  scale_fill_schoodic(palette = "main") +
  scale_color_schoodic(palette = "complimentary") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(y = "Number of individuals") +
  theme_classic() +
  theme(axis.title.x = element_blank())


## Scale color on a continuous scale
penguins %>%  
  filter(!is.na(sex)) %>%  
  ggplot(aes(x = sex, y = body_mass_g, color = bill_depth_mm)) +
  geom_jitter(size = 3, width = 0.3) +
  scale_color_schoodic_c(palette = "main", direction = -1) +
  labs(title = "Bill depth and body mass by sex",
       y = "Body mass (g)",
       color = "Bill depth (mm)") +
  theme_classic() +
  theme(axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.x = element_blank())

