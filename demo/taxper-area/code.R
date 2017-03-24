library(ggplot2)

data_plot <- readRDS(file = "data_plot.rds")

colarea = c("#929292",
            "#4f81bd",
            "#cccccc",
            "#a7b9e3",
            "#edf0f7",
            "white"
            )

all_breaks <- function(x) seq(x[1], x[2], 1)

p <-
  ggplot(data = data_plot, aes(x = year, y = value, fill = taxlegend)) +
  geom_area(position = "stack", color = "#a6a6a6", size = 0.25) +
geom_label(aes(y = labelposition, label = labelvalue), na.rm = TRUE, position = "identity", label.size = 0, label.padding = unit(0.15, "lines"), alpha = 0.5) + # alpha = 0.5
  scale_fill_manual(values = rev(colarea)) +
  scale_x_continuous(breaks = all_breaks, expand = c(0,0)) +
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100), expand = c(0,0)) +
  xlab("Year")

gt <- ggplot_gtable(ggplot_build(p))
gt$layout$clip[gt$layout$name == "panel"] <- "off"

pdf(file = "plot.pdf", width = 16, height = 8)
grid::grid.draw(gt)
dev.off()

png(file = "plot.png", width = 1000, height = 500)
grid::grid.draw(gt)
dev.off()

write.csv(data_plot, file = "data_plot.csv", row.names = FALSE)

sessionInfo()

unlink("Rplots.pdf")

quit("no")
