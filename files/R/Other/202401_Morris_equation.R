library(ggplot2)

theme_set(theme_bw())

#define equation
e41 <- 1064*10^-9
e41
e32 <- 810*10^-9
e32
t <- 0.02
as <- 0.103

# build your equation
my_equation <- function(x){ ((e41/e32)*((t+x)/t)*as)  }
# test your equation with x 
my_equation(0)

#plot equation
a <- ggplot(data.frame(x=c(0, 1)), aes(x=x)) + 
  stat_function(fun=my_equation)+
  xlim(0, 0.15)+
  ylim(0,1)+
  xlab("Resonatorverlust L")+
  ylab("Quantenausbeute T")
a

# test font
a+  theme(text=element_text(family="lmodern"))
library(extrafont)
font_import()
loadfonts(device = "win")


windowsFonts()
 