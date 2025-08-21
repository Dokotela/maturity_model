#!/usr/bin/env python3
"""
Script to analyze and optionally fix CSV files for the maturity model app.
Run from your project root: python3 fix_csvs.py

This will:
1. Analyze all CSV files to show their structure
2. Identify problems
3. Optionally create fixed versions
"""

import csv
import os
from pathlib import Path
from collections import defaultdict
import json

# Path to your CSV files
CSV_DIR = Path("csv")

def analyze_csv(filepath):
    """Analyze a single CSV file and return its structure."""
    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    if not rows:
        return None
    
    # Analyze structure
    structure = {
        'filename': filepath.name,
        'row_count': len(rows),
        'columns': list(rows[0].keys()),
        'item_types': list(set(r.get('item_type', '') for r in rows if r.get('item_type'))),
        'has_maturity_levels': any(r.get('maturity_level') for r in rows),
        'maturity_levels': sorted(set(r.get('maturity_level', '') for r in rows if r.get('maturity_level'))),
        'domains': list(set(r.get('domain', '') for r in rows if r.get('domain'))),
        'response_types': list(set(r.get('response_type', '') for r in rows if r.get('response_type'))),
    }
    
    # Check for IS4H pattern (multiple rows per question)
    item_ids = [r.get('item_id', '') for r in rows if r.get('item_type') == 'question']
    unique_item_ids = set(item_ids)
    structure['multiple_rows_per_question'] = len(item_ids) > len(unique_item_ids) if item_ids else False
    
    # Sample data
    if structure['multiple_rows_per_question'] and unique_item_ids:
        sample_id = list(unique_item_ids)[0]
        sample_rows = [r for r in rows if r.get('item_id') == sample_id]
        structure['sample_question'] = {
            'item_id': sample_id,
            'row_count': len(sample_rows),
            'levels': {r.get('maturity_level'): r.get('text_english', '')[:60] + '...' 
                      for r in sample_rows if r.get('maturity_level')}
        }
    
    return structure

def fix_is4h_csv(filepath, output_dir):
    """Fix IS4H CSV files by combining maturity levels into single rows."""
    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    # Group by item_id
    grouped = defaultdict(list)
    for row in rows:
        grouped[row['item_id']].append(row)
    
    # Create fixed rows
    fixed_rows = []
    
    for item_id, item_rows in grouped.items():
        first_row = item_rows[0]
        item_type = first_row.get('item_type', '')
        
        if item_type in ['heading', 'subheading']:
            # Keep as-is
            fixed_rows.append(first_row)
        elif item_type == 'question' and len(item_rows) > 1:
            # Combine maturity levels
            combined_row = {
                'framework_id': first_row.get('framework_id', ''),
                'domain': first_row.get('domain', ''),
                'subdomain': first_row.get('subdomain', ''),
                'item_id': item_id,
                'item_type': 'maturity_question',
                'question_text': first_row.get('question_text', ''),
                'response_type': first_row.get('response_type', 'scale'),
                'scoring_note': first_row.get('scoring_note', ''),
            }
            
            # Add maturity level descriptions
            for i in range(1, 6):
                level_row = next((r for r in item_rows if r.get('maturity_level') == str(i)), None)
                combined_row[f'maturity_{i}'] = level_row.get('text_english', '') if level_row else ''
            
            fixed_rows.append(combined_row)
        else:
            # Single row questions
            fixed_rows.append(first_row)
    
    # Write to temp file first
    temp_path = output_dir / f"{filepath.stem}_temp.csv"
    # Write to temp file first
    temp_path = output_dir / f"{filepath.stem}_temp.csv"
    
    # Determine all columns needed
    all_columns = set()
    for row in fixed_rows:
        all_columns.update(row.keys())
    
    # Ensure maturity columns are included
    for i in range(1, 6):
        all_columns.add(f'maturity_{i}')
    
    # Standard column order
    column_order = ['framework_id', 'domain', 'subdomain', 'item_id', 'item_type', 
                    'question_text', 'response_type', 'maturity_1', 'maturity_2', 
                    'maturity_3', 'maturity_4', 'maturity_5', 'scoring_note']
    
    # Add any extra columns
    extra_columns = all_columns - set(column_order)
    column_order.extend(sorted(extra_columns))
    
    with open(temp_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=column_order)
        writer.writeheader()
        for row in fixed_rows:
            # Ensure all columns exist
            for col in column_order:
                if col not in row:
                    row[col] = ''
            writer.writerow(row)
    
    return temp_path, len(rows), len(fixed_rows)

def fix_eccm_csv(filepath, output_dir):
    """Fix ECCM CSV files by removing invalid rows."""
    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    # Filter out question rows with null maturity level
    fixed_rows = [r for r in rows 
                  if not (r.get('item_type') == 'question' and not r.get('maturity_level'))]
    
    # Write to temp file
    temp_path = output_dir / f"{filepath.stem}_temp.csv"
    
    with open(temp_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(fixed_rows)
    
    return temp_path, len(rows), len(fixed_rows)

def fix_adb_csv(filepath, output_dir):
    """Fix ADB CSV by adding question_text column."""
    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    # Add question_text column (copy from text_english)
    for row in rows:
        if 'question_text' not in row:
            row['question_text'] = row.get('text_english', '')
    
    # Write to temp file
    temp_path = output_dir / f"{filepath.stem}_temp.csv"
    
    # Ensure question_text is in the columns
    columns = list(rows[0].keys())
    if 'question_text' not in columns:
        # Insert question_text after item_type
        idx = columns.index('item_type') + 1 if 'item_type' in columns else 5
        columns.insert(idx, 'question_text')
    
    with open(temp_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=columns)
        writer.writeheader()
        writer.writerows(rows)
    
    return temp_path, len(rows), len(rows)

def main():
    print("=" * 60)
    print("CSV FILE ANALYZER AND FIXER")
    print("=" * 60)
    
    if not CSV_DIR.exists():
        print(f"❌ Directory {CSV_DIR} not found!")
        print("   Make sure you run this from your project root directory")
        return
    
    csv_files = list(CSV_DIR.glob("*.csv"))
    
    if not csv_files:
        print(f"❌ No CSV files found in {CSV_DIR}")
        return
    
    print(f"\n📁 Found {len(csv_files)} CSV files in {CSV_DIR}\n")
    
    # Analyze all files
    structures = {}
    problems = []
    
    for filepath in csv_files:
        print(f"Analyzing {filepath.name}...")
        structure = analyze_csv(filepath)
        if structure:
            structures[filepath.name] = structure
            
            # Identify problems
            if 'is4h' in filepath.name and structure['multiple_rows_per_question']:
                problems.append((filepath, 'IS4H', 'Multiple rows per question (needs grouping)'))
            elif 'eccm' in filepath.name and 'question' in structure['item_types']:
                problems.append((filepath, 'ECCM', 'Has question rows with null maturity levels'))
            elif filepath.name == 'adb.csv' and 'question_text' not in structure['columns']:
                problems.append((filepath, 'ADB', 'Missing question_text column'))
    
    # Print analysis
    print("\n" + "=" * 60)
    print("ANALYSIS RESULTS")
    print("=" * 60)
    
    for filename, structure in structures.items():
        print(f"\n📄 {filename}")
        print(f"   Rows: {structure['row_count']}")
        print(f"   Item types: {', '.join(structure['item_types'])}")
        print(f"   Domains: {len(structure['domains'])}")
        
        if structure.get('sample_question'):
            sq = structure['sample_question']
            print(f"   Sample question has {sq['row_count']} rows (levels 1-5)")
    
    # Print problems
    if problems:
        print("\n" + "=" * 60)
        print("PROBLEMS FOUND")
        print("=" * 60)
        
        for filepath, framework, issue in problems:
            print(f"\n❗ {filepath.name} ({framework})")
            print(f"   Issue: {issue}")
    
    # Ask to fix
    if problems:
        print("\n" + "=" * 60)
        print("⚠️  WARNING: This will modify your CSV files in place!")
        print("   Make sure you've committed your current files to git first.")
        response = input("\nDo you want to fix the files? (y/n): ")
        
        if response.lower() == 'y':
            print(f"\n✅ Fixing files in place...\n")
            
            for filepath, framework, issue in problems:
                print(f"Fixing {filepath.name}...")
                
                try:
                    if framework == 'IS4H':
                        # Fix in place - use the same directory
                        output_path, original_count, new_count = fix_is4h_csv(filepath, CSV_DIR)
                        print(f"   ✓ Reduced from {original_count} to {new_count} rows")
                    elif framework == 'ECCM':
                        output_path, original_count, new_count = fix_eccm_csv(filepath, CSV_DIR)
                        print(f"   ✓ Filtered from {original_count} to {new_count} rows")
                    elif framework == 'ADB':
                        output_path, original_count, new_count = fix_adb_csv(filepath, CSV_DIR)
                        print(f"   ✓ Added question_text column")
                    
                    # Rename the fixed file to replace the original
                    os.replace(output_path, filepath)
                    print(f"   → Updated {filepath.name}")
                except Exception as e:
                    print(f"   ❌ Error: {e}")
            
            print("\n" + "=" * 60)
            print("✅ DONE!")
            print("=" * 60)
            print("\n1. Check your changes with: git diff")
            print("2. Restart your Flutter app")
            print("3. If something went wrong: git checkout -- assets/csv/")
    else:
        print("\n✅ No problems found in CSV files!")

if __name__ == "__main__":
    main()