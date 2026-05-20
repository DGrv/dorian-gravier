
setwd(wd)
h <- fread("history.csv", encoding = "UTF-8")
cf<- fread("customFields.csv", encoding = "UTF-8")
cfv<- fread("customFieldValues.csv", encoding = "UTF-8")


setnames(cf, "ID", "FieldID")
setnames(h, "Field", "FieldID")

h <- dtjoin(h, cf[, .(FieldID, Name)])
cfv <- dtjoin(cfv, cf[, .(FieldID, Name)])

write.csv(cfv, "customFieldValues_all.csv")
write.csv(h, "history_all.csv")
