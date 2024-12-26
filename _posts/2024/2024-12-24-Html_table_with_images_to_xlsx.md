--- 
title: "Html table with images to xlsx with python" 
date: "2024-12-24 14:53" 
--- 

How to convert a html table with images to xlsx with those images included.
Here you have to adapt your code with input output (here info.html and info.xlsx).

```python
import os
import requests
import pandas as pd
from bs4 import BeautifulSoup
from openpyxl import Workbook
from openpyxl.drawing.image import Image
from io import StringIO


# Function to convert column index to Excel column letter(s)
def col_idx_to_excel(col_idx):
    result = ''
    while col_idx >= 0:
        result = chr(col_idx % 26 + 65) + result
        col_idx = col_idx // 26 - 1
    return result


# Read the HTML file and parse it with BeautifulSoup
html_file = 'info.html'  # Replace with your HTML file
with open(html_file, 'r') as file:
    html_content = file.read()

# Parse the HTML with BeautifulSoup
soup = BeautifulSoup(html_content, 'html.parser')
table = soup.find('table')  # Assuming there's only one table in the HTML

# Find all <img> tags and extract the URLs
img_tags = soup.find_all('img')
# Extract image sources (src attributes) and their positions
img_sources = {}
for row_idx, tr in enumerate(table.find_all('tr')):
    for col_idx, td in enumerate(tr.find_all('td')):
        img = td.find('img')
        if img:
            # Store the image source in a dictionary with (row_idx, col_idx) as the key
            img_sources[(row_idx, col_idx)] = img['src']

# Create a new workbook
wb = Workbook()
ws = wb.active

# Read the HTML table and convert it to DataFrame
df = pd.read_html(StringIO(str(table)))[0]


# Write the table data to the Excel sheet
for row_idx, row in df.iterrows():
    for col_idx, cell in enumerate(row):
        ws.cell(row=row_idx + 1, column=col_idx + 1, value=cell)

# Replace the corresponding cells in the DataFrame with image sources
for (row_idx, col_idx), img_src in img_sources.items():
    # Convert the column index to Excel-style letter(s)
    col_letter = col_idx_to_excel(col_idx)
    # Add the image to the corresponding cell in Excel
    img = Image(img_src)
    img.anchor = f'{col_letter}{row_idx}'  # Adjust the cell where the image will be inserted
    ws.add_image(img)

# Save the workbook
excel_file = 'info.xlsx'
wb.save(excel_file)

print(f"HTML table with images has been successfully converted to {excel_file}")

```



