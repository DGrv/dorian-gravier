import fitz
import sys

def resize_pdf(input_path, output_path, scale_factor):
    scale_factor = float(scale_factor)  # Convert scale factor to float

    doc = fitz.open(input_path)
    new_doc = fitz.open()  # Create a new PDF

    for page in doc:
        pix = page.get_pixmap(matrix=fitz.Matrix(scale_factor, scale_factor))
        new_page = new_doc.new_page(width=pix.width, height=pix.height)
        new_page.insert_image(new_page.rect, pixmap=pix)

    new_doc.save(output_path)
    print(f"Resized PDF saved as: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python resize_pdf.py <input.pdf> <output.pdf> <scale_factor>")
    else:
        _, input_pdf, output_pdf, scale_factor = sys.argv
        resize_pdf(input_pdf, output_pdf, scale_factor)
