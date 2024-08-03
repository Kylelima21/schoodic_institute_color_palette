## Schoodic Institute Color Palette Functions
## For use with ggplot2


schoodic_color <- function(...) {
  
  schoodic_colors <- c(
    `green` = "#578e5b",
    `greenpurple` = "#4f7866",
    `purple` = "#37246a",
    `purpleblue` = "#5c77ae",
    `blue` = "#8fd4d7",
    
    `green comp` = "#8e578b",
    `greenpurple comp` = "#784f61",
    `purple comp` = "#586a24",
    `purpleblue comp` = "#ae925b",
    `blue comp` = "#d6928f")
  
  cols <- c(...)
  
  if (is.null(cols))
    return(schoodic_colors)
  
  schoodic_colors[cols]
  
}




schoodic_palette <- function(palette = "main", ...) {
  
  schoodic_palettes <- list(
    `main` = schoodic_color("green", "greenpurple", "purple", "purpleblue", 
                            "blue"),
    
    `complimentary` = schoodic_color("green comp", "greenpurple comp",
                                     "purple comp", "purpleblue comp", 
                                     "blue comp")
  )
  
  schoodic_palettes[[palette]]
  
}




palette_gen <- function(palette = "main", direction = 1) {
  
  function(n) {
    
    if (n > length(schoodic_palette(palette)))
      warning("Not enough colors in this palette!")
    
    else {
      
      all_colors <- schoodic_palette(palette)
      
      all_colors <- unname(unlist(all_colors))
      
      all_colors <- if (direction >= 0) all_colors else rev(all_colors)
      
      color_list <- all_colors[1:n]
      
    }
  }
}




palette_gen_c <- function(palette = "main", direction = 1, ...) {
  
  pal <- schoodic_palette(palette)
  
  pal <- if (direction >= 0) pal else rev(pal)
  
  colorRampPalette(pal, ...)
  
}




scale_fill_schoodic <- function(palette = "main", direction = 1, ...) {
  
  ggplot2::discrete_scale(
    "fill", "schoodic",
    palette_gen(palette, direction),
    ...
  )
}




scale_colour_schoodic <- function(palette = "main", direction = 1, ...) {
  
  ggplot2::discrete_scale(
    "colour", "schoodic",
    palette_gen(palette, direction),
    ...
  )

}

scale_color_schoodic <- scale_colour_schoodic




scale_color_schoodic_c <- function(palette = "main", direction = 1, ...) {
  
  pal <- palette_gen_c(palette = palette, direction = direction)
  
  scale_color_gradientn(colors = pal(256), ...)
  
}



