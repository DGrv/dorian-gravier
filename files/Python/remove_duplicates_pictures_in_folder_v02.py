import os
from PIL import Image, ImageChops

folder = "."
images = []

def images_are_similar(img1, img2, threshold=0.01):
    diff = ImageChops.difference(img1, img2).convert("L")
    histogram = diff.histogram()
    total_diff = sum(i * val for i, val in enumerate(histogram)) / (img1.width * img1.height)
    return total_diff < threshold

for filename in sorted(os.listdir(folder)):
    if filename.lower().endswith(".png"):
        path = os.path.join(folder, filename)
        try:
            current = Image.open(path).convert("RGB")
            is_duplicate = False
            for (prev_img, prev_filename) in images:
                if images_are_similar(current, prev_img):
                    print(f"Deleting visually similar: {filename} (duplicate of {prev_filename})")
                    os.remove(path)
                    is_duplicate = True
                    break
            if not is_duplicate:
                images.append((current, filename))
        except Exception as e:
            print(f"Error with {filename}: {e}")

print("Done comparing images.")
