library(rayshaderanimate)
library(data.table)
library(rayshader)
# library(raster)
# library(R.utils)


# reassignInPackage(name=".download", pkgName="raster", value="my.fn")
# el_mat <- get_elevdata_from_bbox(databbox)


gpx <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2022/B_2022_Bike-travel_051.gpx"
data <-get_table_from_gpx(gpx)
data

data2 <- get_enriched_gpx_table(data)
data2

databbox <- get_bbox_from_gpx_table(data)
databbox
# bbox_map(databbox)

# getAnywhere(".download")
# el_mat <- get_elevdata_from_bbox(databbox)

my.fn <- function(aurl, filename){
  cat("You wanna download: ", aurl, "\n")
  cat("You wanna save it there : ", filename, "\n\n")
  httr::set_config(httr::config(ssl_verifypeer=0L))
  httr::GET(aurl, httr::write_disk(path = filename, overwrite = F))
}
tmpfun <- get(".download", envir = asNamespace("raster"))
environment(my.fn) <- environment(tmpfun)
attributes(my.fn) <- attributes(tmpfun)  # don't know if this is really needed
assignInNamespace(".download", my.fn, ns="raster")

# getAnywhere(".download")
el_mat <- get_elevdata_from_bbox(databbox)
el_mat
# fixInNamespace(".download", "raster")

elmat_rayshade <- unlabel_elevdata(el_mat)
elmat_rayshade
elevdata_long<- data.table(get_elevdata_long(el_mat))


# Animate GPX line on 2d plot
plot_2d_animation(gpx_table = data2, elevdata_long = elevdata_long)

# Plot a 2D raster of the bbox
plot_2d_elevdata(elevdata_rayshade = elmat_rayshade)


matrix_extended <- elmat_rayshade
zscale <- 50
raymat <- ray_shade(matrix_extended, sunaltitude=20, zscale = zscale, lambert = TRUE)
ambmat <- ambient_shade(matrix_extended, zscale = zscale)
watermap <- detect_water(matrix_extended)
matrix_extended
map_to_plot <- matrix_extended %>% sphere_shade(texture = "imhof4") %>% 
  add_shadow(raymat, max_darken = 0.5) %>%
  add_shadow(ambmat, max_darken = 0.5)
if (!is.null(overlay_img)) {
  map_to_plot <- map_to_plot %>% add_overlay(png::readPNG(overlay_img), 
                                             alphalayer = 0.5)
}
plot_map(map_to_plot)


output_gif <- video_animation(gpx_table = data2, elevdata_long = elmat_long, make_gif = TRUE, number_of_screens = 4,
                              output_file_loc = tempfile(fileext = ".gif"))


output_vid <- video_animation(gpx_table = data2, elevdata_long = elmat_long, make_gif = FALSE, number_of_screens = 6,
                              output_file_loc = "C:/Users/doria/Downloads/srtm_37_04.mp4", ffmpeg_path = "C:/Users/doria/Downloads/Software/ffmpeg-4.3.2-2021-02-27-full_build/bin/ffmpeg.exe")



