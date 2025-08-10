nsec = Clock | Format "ss" |  ToNumber 
nmin = Clock | Format "mm" | ToNumber
min2 = (nmin % 2)*60 + nsec
min1=nsec



func RuntimeTrail(EvDate, T0)
	# --> EvDate is date of Event text([Event.Date];"de") in format "2025-08-05"
	# ---> T0 in decimal with day 
	ret datetime.now-(date.parse(EvDate)+timespan.parse(T0)) | FormatRaceResult "hh:mm:ss"
   # --> RuntimeTrail(SG.First.EventDate, SG.First.StartTime)
end

func CreateTimeRange(total, first_range, parts)
   # ---> total is the number of seconds in total
   # ---> first_range can be 0 if no first video or more if 30s video for example
   # ---> how many categories with the first_range included if there is one
   remaining = total - first_range
   if first_range==0
      step = total / parts
   else
      step = remaining / (parts-1)
      parts = parts - 1
   end
   temparray=[]
   temparray = temparray | array.concat [[0, first_range]] # Add first range
   i = 0 # Simulate a range using a loop counter
   while i < parts
      start = first_range + i * step
      stop = start + step
      temparray = temparray | array.concat [[start, stop]]
      i = i + 1
   end
   ret temparray
   # --> r1 = CreateTimeRange(120,30,6)
end

# --> Example of usage :
# -->else if TextLine1 == "12" 
# -->   timer=min2
# -->   whichRange=r3
# -->   for i in 0..((whichRange | array.Size) - 1)
# -->      if timer >= whichRange[i][0] && timer < whichRange[i][1]
# -->         i==1 ? insta : ""
# -->         i==2 ? starttimecontest : ""
# -->         i==3 ? cups : ""
# -->         i==4 ? mandaE1 : ""
# -->         i==5 ? mandaE2 : ""
# -->         i==6 ? g1 : ""
# -->         i==7 ? g2 : ""
# -->         i==8 ? g3 : ""
# -->      end
# -->   end

