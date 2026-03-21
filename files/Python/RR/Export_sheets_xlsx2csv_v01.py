import pandas as pd
import os
import glob

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
    # Get current directory
    current_dir = os.getcwd()
    
    # Find all Excel files
    excel_files = glob.glob(os.path.join(current_dir, "*.xlsx")) + \
                  glob.glob(os.path.join(current_dir, "*.xls"))
    
    if not excel_files:
        print("No Excel files found in the current directory.")
        return
    
    print(f"Found {len(excel_files)} Excel file(s)")
    print("-" * 50)
    
    success_count = 0
    for excel_file in excel_files:
        print(f"\nProcessing: {os.path.basename(excel_file)}")
        if extract_all_sheets(excel_file, current_dir):
            success_count += 1
    
    print("\n" + "=" * 50)
    print(f"Completed: {success_count}/{len(excel_files)} files processed successfully")

if __name__ == "__main__":
    main()