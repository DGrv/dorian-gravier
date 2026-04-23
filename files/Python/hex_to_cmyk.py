
# to use this way :  cat test.txt  | python hex_to_cmyk.py
# with text the hex colors
# cat test.txt
# #18A7A5
# #E1365C
# cat test.txt  | python hex_to_cmyk.py
# #18A7A5,90.6,34.5,35.3,0.0
# #E1365C,11.8,78.8,63.9,0.0


import sys
from PIL import Image

def hex_to_cmyk(hex_color):
    # Remove # if present
    hex_color = hex_color.strip().lstrip('#')
    
    # Convert hex to RGB
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    
    # Create 1x1 RGB image and convert to CMYK
    rgb_img = Image.new('RGB', (1, 1), (r, g, b))
    cmyk_img = rgb_img.convert('CMYK')
    c, m, y, k = cmyk_img.getpixel((0, 0))
    
    # Convert to percentages and round
    c_pct = round(c/255*100)
    m_pct = round(m/255*100)
    y_pct = round(y/255*100)
    k_pct = round(k/255*100)
    
    return f"#{hex_color.upper()} - C({c_pct},{m_pct},{y_pct},{k_pct})"

# Read from stdin
for line in sys.stdin:
    hex_color = line.strip()
    if hex_color:
        result = hex_to_cmyk(hex_color)
        print(result)