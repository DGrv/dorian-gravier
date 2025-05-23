
df <- structure(list(Lon = c(-66.6319163369509, -66.5400363369509, 
                             -65.3972830036509, -65.2810430036509, -65.1169763369509, -64.7409730036509, 
                             -64.3898230036509, -64.3458230036509, -64.1435830036509, -64.1902230036509, 
                             -64.5269330036509, -64.5508330036509, -64.9324130036509, -66.4002496703509, 
                             -66.4605896703509, -66.6230763369509, -66.6636963369509, -66.6425830036509, 
                             -66.5310230036509, -66.4582830036509, -66.2992030036509, -65.8810363369509, 
                             -65.3338363369509, -65.2480363369509, -65.3705963369509, -65.8357874342282, 
                             -66.7324643369709, -66.8768896703509, -66.8215363369509, -66.8320584884004
), Lat = c(63.9018749538395, 64.1357216205395, 64.4444682872395, 
           64.4580016205395, 64.4744549538395, 64.4951416205395, 64.5202416205395, 
           64.5237216205395, 64.5388016205395, 64.5400516205395, 64.5090116205395, 
           64.5069516205395, 64.4609016205395, 64.2904882872395, 64.1898016205395, 
           63.9022816205395, 63.9948082872395, 64.0236682872395, 64.1115882872395, 
           64.2171216205395, 64.3599949538395, 64.3979682872395, 64.4634216205395, 
           64.4719816205395, 64.4459016205395, 64.4008282316608, 63.8029216205395, 
           63.7730882872395, 63.8046816205395, 63.8239941445658), DateTime =     structure(c(1451784300, 
                                                                                             1451790981, 1451806092, 1451807038, 1451808331, 1451811238, 1451813999, 
                                                                                             1451814338, 1451815898, 1451820189, 1451822838, 1451823018, 1451826048, 
                                                                                             1451838029, 1451840610, 1451848380, 1451864271, 1451865064, 1451867591, 
                                                                                             1451870472, 1451874641, 1451878100, 1451882678, 1451883331, 1451886921, 
                                                                                             1451890867, 1451910187, 1451925099, 1451929401, 1451934427), class =     c("POSIXct", 
                                                                                                                                                                        "POSIXt"), tzone = "GMT")), class = c("tbl_df", "tbl", "data.frame"
                                                                                                                                                                        ), row.names = c(NA, -30L))

df$TimeNum <- as.numeric(df$DateTime)



##### successful fade - with points     
p <- ggplot(df) +
  geom_point(aes(x = Lon, y = Lat), size = 2) + 
  transition_components(TimeNum, exit_length = 20) + 
  ease_aes(x = 'sine-out', y = 'sine-out') + 
  shadow_wake(0.05, size = 2, alpha = TRUE, wrap = FALSE, #exclude_layer = c(2, 3),
              falloff = 'sine-in', exclude_phase = 'enter') 
p
animate(p, renderer = gifski_renderer(loop = F), duration = 10)         
anim_save("try.gif")        

##### successful plot with geom_path, but no fading - it gets REALLY busy with the 
##### full dataset! 
p1 <- ggplot(df) +
  geom_path(aes(x = Lon, y = Lat), size = 2) + 
  transition_reveal(DateTime, keep_last = FALSE) +
  labs(title = 'A: {frame_along}') +
  exit_fade()
p1
animate(p1, renderer = gifski_renderer(loop = F), duration = 10)            
anim_save("try1.gif", width = 1000, height = 1000) 