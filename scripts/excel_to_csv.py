import pandas as pd
excel_file = '/Users/raziulhaq/Documents/Work/cascade/skills-assessment-data-engineer/carmen_sightings_20220629061307.xlsx'
all_sheets = pd.read_excel(excel_file, sheet_name=None)
sheets = all_sheets.keys()

for sheet_name in sheets:
    sheet = pd.read_excel(excel_file, sheet_name=sheet_name)

    ## removing specialcharacter/non-english characters
    sheet.columns=sheet.columns.str.replace(r'[^0-9a-zA-Z _]', '', regex=True)
    sheet.to_csv("/Users/raziulhaq/Documents/Work/cascade/case_study/data/%s_csv.csv" % sheet_name, index=False)
print("Wrote all sheets as csv")