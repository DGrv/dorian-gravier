#!/usr/bin/env python3

# made by dorian 
# made by dorian 
# made by dorian 
# made by dorian 
# made by dorian 

import sys
import os
import gpxpy
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import savgol_filter

def gpx2elevation(gpx_file, output_svg, smooth_window):
    with open(gpx_file, 'r') as f:
        gpx = gpxpy.parse(f)

    distances = []
    elevations = []
    total_distance = 0
    last_point = None

    for track in gpx.tracks:
        for segment in track.segments:
            for point in segment.points:
                if point.elevation is not None:
                    if last_point:
                        total_distance += point.distance_2d(last_point)
                    distances.append(total_distance / 1000)  # km
                    elevations.append(point.elevation)
                    last_point = point

    # Smooth elevations
    elevations = smooth(elevations, smooth_window)

    plt.figure(figsize=(10, 3))
    plt.plot(distances, elevations, color='black', linewidth=1.2)
    plt.axis('off')
    plt.tight_layout()
    plt.savefig(output_svg, format='svg', transparent=True)
    plt.close()




def smooth(data, smooth_window, polyorder=2):
    if smooth_window % 2 == 0:
        smooth_window += 1  # must be odd for savgol_filter
    if len(data) < smooth_window:
        return data
    return savgol_filter(data, smooth_window, polyorder).tolist()




# CLI usage
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: gpx2svgelevation input.gpx [output.svg]")
        sys.exit(1)

    gpx_input = sys.argv[1]
    output_svg = sys.argv[2] if len(sys.argv) > 2 else os.path.splitext(gpx_input)[0] + ".svg"
    smooth_window = int(sys.argv[3] if len(sys.argv) > 3 else (sys.argv[2] if len(sys.argv) > 2 and sys.argv[2].isdigit() else 11))

    gpx2elevation(gpx_input, output_svg, smooth_window)
    print(f"✅ Saved elevation profile to {output_svg}")
