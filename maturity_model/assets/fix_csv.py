#!/usr/bin/env python3
"""
Script to fix the BPMN CSV file to match the structure of other fixed CSVs.
Consolidates the question + 5 assessment rows into single rows with maturity_1 through maturity_5 columns.
"""

import csv
from pathlib import Path

def fix_bpmn_csv():
    input_path = Path("csv/bpmn.csv")
    
    if not input_path.exists():
        print(f"❌ File {input_path} not found!")
        return
    
    print("Fixing BPMN CSV file...")
    
    # Read the CSV
    with open(input_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    print(f"Original rows: {len(rows)}")
    
    # Group rows by domain (skip "General" domain rows)
    domains = {}
    
    for row in rows:
        domain = row.get('domain', '').strip()
        item_type = row.get('item_type', '').strip()
        
        # Skip General domain (header/description rows)
        if domain == 'General' or not domain:
            continue
            
        if domain not in domains:
            domains[domain] = {
                'question': None,
                'assessments': {}
            }
        
        if item_type == 'question':
            domains[domain]['question'] = row
        elif item_type == 'assessment':
            level = row.get('maturity_level')
            if level:
                domains[domain]['assessments'][str(level)] = row
    
    # Create consolidated rows
    fixed_rows = []
    
    for domain_name, domain_data in domains.items():
        if not domain_data['question'] or not domain_data['assessments']:
            print(f"  ⚠️  Skipping {domain_name} - incomplete data")
            continue
        
        question = domain_data['question']
        assessments = domain_data['assessments']
        
        # Create consolidated row
        consolidated = {
            'framework_id': 'BPM+',
            'domain': domain_name,
            'subdomain': 'Assessment',
            'item_id': question['item_id'],
            'item_type': 'maturity_rubric',
            'question_text': question.get('question_text', ''),
            'response_type': 'maturity_level',
            'maturity_1': assessments.get('1', {}).get('text_english', ''),
            'maturity_2': assessments.get('2', {}).get('text_english', ''),
            'maturity_3': assessments.get('3', {}).get('text_english', ''),
            'maturity_4': assessments.get('4', {}).get('text_english', ''),
            'maturity_5': assessments.get('5', {}).get('text_english', ''),
            'scoring_note': ''
        }
        
        fixed_rows.append(consolidated)
    
    print(f"\nDomains found and consolidated:")
    for row in fixed_rows:
        print(f"  ✓ {row['domain']}")
    
    # Write the fixed CSV
    output_columns = [
        'framework_id', 'domain', 'subdomain', 'item_id', 'item_type',
        'question_text', 'response_type', 'maturity_1', 'maturity_2',
        'maturity_3', 'maturity_4', 'maturity_5', 'scoring_note'
    ]
    
    with open(input_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=output_columns)
        writer.writeheader()
        writer.writerows(fixed_rows)
    
    print(f"\n✅ Fixed BPMN CSV: {len(rows)} rows → {len(fixed_rows)} rows")
    print("   Each domain now has all 5 maturity levels in one row")

if __name__ == "__main__":
    fix_bpmn_csv()