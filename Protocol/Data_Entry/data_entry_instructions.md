# Data Entry Instructions - Allergy Epidemiology Study

**Study:** Epidemiological Study on Allergy in SIMS&RH Tumkur, Karnataka

**Version:** 1.0

**Effective Date:** __________

---

## 1. Overview

This document provides detailed instructions for data entry personnel to ensure accurate, complete, and consistent data entry for the allergy epidemiology study. All data entry must follow these guidelines to maintain data quality and integrity.

## 2. Data Entry Software and Setup

### 2.1 Recommended Software
- **Primary:** Microsoft Excel or Google Sheets
- **Alternative:** LibreOffice Calc, OpenOffice Calc
- **Database:** REDCap (for electronic data capture)

### 2.2 File Setup
- Use the provided `data_entry_template.csv` as the starting point
- Save files with participant ID as filename: `participant_[ID].csv`
- Maintain one row per participant
- Use UTF-8 encoding for special characters

### 2.3 Data Validation Setup
Enable data validation in Excel:
1. Select column headers
2. Go to Data → Data Validation
3. Set appropriate validation rules for each variable type

## 3. General Data Entry Guidelines

### 3.1 Data Entry Principles
- **Accuracy:** Enter data exactly as recorded on forms
- **Completeness:** Do not leave required fields blank
- **Consistency:** Use standardized codes and formats
- **Timeliness:** Enter data within 24 hours of collection

### 3.2 Data Entry Process
1. **Review Forms:** Check for completeness and legibility
2. **Double Entry:** Enter data twice by different operators
3. **Validation:** Run automated validation checks
4. **Verification:** Cross-check with original forms
5. **Correction:** Make corrections with audit trail

### 3.3 Quality Control
- **Error Rate Target:** <1% error rate
- **Supervisor Review:** 10% random review of entries
- **Weekly Audits:** Data quality assessment
- **Training:** Regular refresher training

## 4. Variable-Specific Entry Instructions

### 4.1 Administrative Variables

#### Participant ID
- Format: 6-digit number (000001-999999)
- Always start with leading zeros
- Unique for each participant
- Never reuse IDs

#### Date Fields
- Format: YYYY-MM-DD (e.g., 2025-01-15)
- Use calendar picker in Excel
- No future dates allowed
- Consistent date format throughout

#### Interviewer Name
- Use full name as registered
- Consistent spelling across all entries
- Use dropdown list for standardization

### 4.2 Sociodemographic Variables

#### Age
- Enter as whole number (5-65)
- Verify against age group calculation
- Flag outliers for review (>65 or <5)

#### Gender
- Codes: Male = 1, Female = 2, Other = 3
- Use dropdown validation
- Match biological sex for clinical variables

#### Education Level
- Use exact codes from data dictionary
- No free text - use standardized categories
- Verify logical progression

#### Income Categories
- Use exact ranges from questionnaire
- Convert verbal responses to categories
- Flag inconsistencies with occupation

### 4.3 Clinical Variables

#### Allergy Diagnoses
- Binary codes: 0 = No, 1 = Yes
- Based on doctor diagnosis only
- Cross-verify with symptoms and treatment

#### Symptom Variables
- Multiple responses allowed (comma-separated)
- Use standardized terminology
- Code intensity: Mild = 1, Moderate = 2, Severe = 3

#### Anthropometric Measurements
- Height: centimeters (2 decimal places)
- Weight: kilograms (1 decimal place)
- BMI: auto-calculated (weight/height² × 10000)
- Flag biologically implausible values

#### Blood Pressure
- Format: systolic/diastolic (e.g., 120/80)
- Enter as separate columns
- Flag hypertensive values (>140/90)

### 4.4 Laboratory Variables

#### Skin Prick Test Results
- Wheal size: millimeters (1 decimal place)
- Interpretation: Positive ≥3mm and > negative control
- Multiple allergens: semicolon-separated
- Grading: Monosensitive/Oligosensitive/Polysensitive

#### Microbiome Sample Data
- Sample ID format: S001-S999
- Collection status: 0 = No, 1 = Yes
- Quality assessment: Good/Fair/Poor
- Contamination: 0 = No, 1 = Yes

### 4.5 Quality of Life Variables

#### QoL Items
- Scale: 1-5 (1 = Strongly disagree, 5 = Strongly agree)
- No missing values allowed
- Reverse coding where necessary
- Total score: average of items 1-7

#### Treatment Variables
- Treatment type: Use exact categories
- Satisfaction: 5-point Likert scale
- Open-ended responses: Clean and categorize

### 4.6 Spatial Variables

#### GPS Coordinates
- Latitude: -90 to 90 (6 decimal places)
- Longitude: -180 to 180 (6 decimal places)
- Accuracy check: Within Karnataka boundaries
- Missing values: Use 999 for unavailable

#### Distance Measurements
- Industrial distance: kilometers (1 decimal place)
- Highway distance: kilometers (1 decimal place)
- Source: GPS calculation or participant report

## 5. Data Validation Rules

### 5.1 Range Checks
- Age: 5-65
- Height: 50-200 cm
- Weight: 10-150 kg
- BMI: 10-50
- Blood pressure: 80-200/50-130

### 5.2 Logical Checks
- If age < 18, education cannot be "Postgraduate"
- If asthma = 1, peak flow should be recorded
- If doctor_diagnosed = 0, treatment variables should be empty
- If urban_rural = "Urban", industrial_distance should be < 10km

### 5.3 Cross-Validation
- Allergy status should match individual diagnoses
- QoL scores should be consistent with symptom severity
- Treatment satisfaction should correlate with treatment received

### 5.4 Skip Patterns
- If no allergies reported, skip allergy-specific questions
- If no clinical examination, skip clinical variables
- If no samples collected, skip laboratory variables

## 6. Error Handling and Correction

### 6.1 Error Identification
- Automated validation rules
- Manual review of flagged records
- Statistical outlier detection
- Logical inconsistency checks

### 6.2 Correction Process
1. Identify error source
2. Consult original forms
3. Make corrections in data file
4. Document changes with reasons
5. Re-run validation checks

### 6.3 Audit Trail
- Track all changes with timestamps
- Record who made changes
- Maintain original values for reference
- Generate change logs for review

## 7. Data Security and Confidentiality

### 7.1 Access Control
- Password-protected files
- Role-based access permissions
- Encrypted storage
- Regular backup procedures

### 7.2 Data Handling
- No personal identifiers in analysis files
- Secure file transfer protocols
- Regular security training
- Incident reporting procedures

### 7.3 Privacy Protection
- Remove direct identifiers before analysis
- Use coded identifiers only
- Secure storage of linking files
- Compliance with data protection regulations

## 8. Data Export and Backup

### 8.1 Export Procedures
- Export to CSV format for analysis
- Include data dictionary with exports
- Compress large files
- Verify export integrity

### 8.2 Backup Procedures
- Daily automatic backups
- Weekly offsite backups
- Monthly archival backups
- Disaster recovery testing

### 8.3 Version Control
- Date-stamped file versions
- Change documentation
- Backup before major changes
- Recovery procedures

## 9. Training and Certification

### 9.1 Initial Training
- Comprehensive data entry training
- Practice sessions with sample data
- Certification assessment
- Supervisor evaluation

### 9.2 Ongoing Training
- Monthly refresher sessions
- Updates on protocol changes
- New variable training
- Quality improvement workshops

### 9.3 Performance Monitoring
- Individual error rates
- Timeliness metrics
- Quality scores
- Feedback and improvement plans

## 10. Troubleshooting

### 10.1 Common Issues
- **Missing values:** Use appropriate missing codes
- **Invalid formats:** Standardize date and number formats
- **Inconsistent coding:** Refer to data dictionary
- **Software crashes:** Regular data saves, backup procedures

### 10.2 Technical Support
- IT support contact: [Contact information]
- Data manager: [Contact information]
- Supervisor: [Contact information]
- Emergency procedures: [Backup plans]

### 10.3 Quality Assurance
- Regular data quality reports
- Feedback mechanisms
- Continuous improvement processes
- Best practice sharing

## 11. Appendices

### Appendix A: Data Dictionary
[Complete variable reference]

### Appendix B: Validation Rules
[Detailed validation specifications]

### Appendix C: Error Codes
[Standardized error handling codes]

### Appendix D: Sample Data Entry Forms
[Annotated examples]

---

**Data Entry Instructions Prepared by:** __________ (Data Manager)

**Reviewed by:** __________ (Principal Investigator)

**Approved by:** __________ (Study Coordinator)

**Date:** __________

**Next Review:** __________ (6 months)
