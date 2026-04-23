import pandas as pd
import os
import sys

def extract_all_sheets(excel_file, output_dir):
    """Extract all sheets from an Excel file to separate CSV files"""
    try:
        # Read all sheets
        xl_file = pd.ExcelFile(excel_file)
        base_name = os.path.splitext(os.path.basename(excel_file))[0]
        
        # Export each sheet as CSV
        for sheet_name in xl_file.sheet_names:
            df = pd.read_excel(excel_file, sheet_name=sheet_name)
            # Sanitize sheet name for filename
            safe_sheet_name = "".join(c for c in sheet_name if c.isalnum() or c in (' ', '-', '_')).strip()
            output_file = os.path.join(output_dir, f"{base_name}_{safe_sheet_name}.csv")
            df.to_csv(output_file, index=False, encoding='utf-8-sig')
            print(f"✓ Exported: {output_file}")
        
        return True
    except Exception as e:
        print(f"✗ Error processing {excel_file}: {str(e)}")
        return False

def main():
    # Check if file argument is provided
    if len(sys.argv) < 2:
        print("Usage: python script.py <excel_file>")
        print("Example: python script.py myfile.xlsx")
        sys.exit(1)
    
    excel_file = sys.argv[1]
    
    # Check if file exists
    if not os.path.exists(excel_file):
        print(f"✗ Error: File '{excel_file}' not found")
        sys.exit(1)
    
    # Check if it's an Excel file
    if not excel_file.lower().endswith(('.xlsx', '.xls')):
        print("✗ Error: File must be .xlsx or .xls")
        sys.exit(1)
    
    # Get output directory (same as input file's directory)
    output_dir = os.path.dirname(excel_file) or os.getcwd()
    
    print(f"Processing: {os.path.basename(excel_file)}")
    print("-" * 50)
    
    if extract_all_sheets(excel_file, output_dir):
        print("\n" + "=" * 50)
        print("✓ Conversion completed successfully")
    else:
        print("\n" + "=" * 50)
        print("✗ Conversion failed")
        sys.exit(1)

if __name__ == "__main__":
    main()