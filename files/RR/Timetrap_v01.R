# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

wd <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/configBU/timetrap/")
wd2 <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/timetrap")
setwd(wd)

# list files --------------------------------------------------------------

ll <- list.files(wd, "csv")
ll <- ll[rev(order(ll))]
lf <- ll[1]


# format data -------------------------------------------------------------

data <- data.table(read.csv(lf, encoding = "utf-8"))
data[, start2 := as.POSIXct(start, format = "%Y-%m-%d %H:%M:%S")]
data[, end2 := as.POSIXct(end, format = "%Y-%m-%d %H:%M:%S")]
data[, EventDay := F]
data[note %like% " EVENT", EventDay := T]
data[EventDay==T, nDays := as.numeric(difftime(end2, start2, units = "days"))]
data[, nDays2 := ifelse(nDays<1, ceiling(nDays), ceiling(nDays*2)/2)]
data[EventDay==F, nHours := as.numeric(difftime(end2, start2, units = "hours"))]

# Events ------------------------------------------------------------------

dataE <- data[EventDay==T, .(SumDays = sum(nDays2), StartDay = format(min(start2), "%Y-%m-%d"), EndDay = format(max(start2), "%Y-%m-%d")), note]
dataE[, note := gsub(" EVENT", "", note)]
TTDays <- sum(dataE$SumDays)
cat(red("Number of Event days: "), TTDays, "\n")


# bind --------------------------------------------------------------------

data2 <- data[EventDay==F, .(SumHours = sum(nHours)), note]
data2 <- dtjoin(data2, dataE, type = "full")
data2[, OnSite := ifelse(is.na(SumDays)==T, F, T)]
data2[is.na(SumHours), SumHours := 0]


# Graphics ----------------------------------------------------------------


a <- ggplot(data2, aes(note, SumHours, fill = OnSite))+
  geom_bar(stat="identity")+
  turnXaxis()+
  geom_text(aes(label=p0(round(SumHours), "h", ifelse(is.na(SumDays)==F, p0(" - ", SumDays, "d"), ""))), hjust = -0.1, size = 3)+
  coord_flip()+
  orderX(data2[order(SumHours)]$note)+
  xlab("Event")+
  ylim(c(0, max(data2$SumHours)*1.3))+
  labs(title=p0("Time distribution per Event ", format(Sys.time(), "%Y-%m-%d")))

b <- ggplot(dataE, aes(note, SumDays))+
  geom_bar(stat="identity")+
  turnXaxis()+
  coord_flip()+
  orderX(data2[order(SumHours)]$note)+
  xlab("Event")+
  labs(title=p0("Days distribution per Event ", format(Sys.time(), "%Y-%m-%d"), " TT=", TTDays))


# Export ------------------------------------------------------------------


setwd(wd2)
printfast(a, "Event_hours.jpg", 600, 800)
printfast(b, "Event_days.jpg", 600, 800)


