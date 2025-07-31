import os
from PIL import Image
import imagehash

# Folder with images
folder = "."

# Store hashes to detect duplicates
hashes = {}

for filename in os.listdir(folder):
    if filename.lower().endswith(".png"):
        filepath = os.path.join(folder, filename)
        try:
            img = Image.open(filepath)
            hash = imagehash.average_hash(img)  # perceptual hash

            if hash in hashes:
                print(f"Duplicate found: {filename} (duplicate of {hashes[hash]}) - deleting")
                os.remove(filepath)
            else:
                hashes[hash] = filename

        except Exception as e:
            print(f"Error processing {filename}: {e}")

print("Done checking for duplicates.")
