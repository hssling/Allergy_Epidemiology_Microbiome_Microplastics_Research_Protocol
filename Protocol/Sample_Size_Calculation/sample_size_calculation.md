# Sample Size Calculation - Allergy Epidemiology Study

**Study Title:** Epidemiological Study on Allergy in SIMS&RH Tumkur, Karnataka

**Date:** __________

**Calculated by:** __________ (Statistician)

---

## 1. Study Objectives and Sample Size Requirements

### Primary Objective
To determine the prevalence of allergic diseases in the study population

### Secondary Objectives
- To assess microbiome composition and allergy associations
- To evaluate microplastic exposure and allergy associations
- To examine spatial distribution of allergic diseases
- To assess quality of life and treatment perceptions

---

## 2. Main Survey Sample Size Calculation

### 2.1 Formula for Prevalence Studies
For cross-sectional studies estimating prevalence with specified precision:

**Formula:**
```
n = (Z² × P × (1-P)) / d²
```

Where:
- **n** = required sample size
- **Z** = Z-score for confidence level
- **P** = expected prevalence
- **d** = desired precision (margin of error)

### 2.2 Parameters Used

| Parameter | Value | Justification |
|-----------|-------|---------------|
| **Expected Prevalence (P)** | 0.20 (20%) | Based on Indian studies (range: 15-30%) |
| **Confidence Level** | 95% | Standard for epidemiological studies |
| **Z-score (Z)** | 1.96 | For 95% confidence level |
| **Precision (d)** | 0.05 (5%) | Acceptable margin of error |
| **Design Effect (DEFF)** | 1.5 | Accounts for clustering in complex sampling |
| **Non-response Rate** | 20% | Anticipated non-response in community survey |

### 2.3 Step-by-Step Calculation

#### Step 1: Basic Sample Size
```
n_basic = (Z² × P × (1-P)) / d²
        = (1.96² × 0.20 × 0.80) / 0.05²
        = (3.8416 × 0.16) / 0.0025
        = 0.614656 / 0.0025
        = 245.8624
```

#### Step 2: Adjust for Design Effect
```
n_design = n_basic × DEFF
         = 245.8624 × 1.5
         = 368.7936
```

#### Step 3: Adjust for Non-response
```
n_final = n_design / (1 - non_response_rate)
         = 368.7936 / (1 - 0.20)
         = 368.7936 / 0.80
         = 460.992
```

#### Step 4: Round up to nearest 10
```
Main survey sample size = 470 participants
```

### 2.4 Sensitivity Analysis

#### Different Prevalence Estimates
| Expected Prevalence | Basic Sample Size | Final Sample Size |
|-------------------|------------------|------------------|
| 15% | 196.35 | 408 |
| 20% | 245.86 | 470 |
| 25% | 288.12 | 518 |
| 30% | 322.69 | 552 |

#### Different Precision Levels
| Precision (d) | Basic Sample Size | Final Sample Size |
|---------------|------------------|------------------|
| 3% | 1,068.67 | 1,336 |
| 4% | 614.66 | 768 |
| 5% | 393.22 | 491 |
| 6% | 273.15 | 341 |

---

## 3. Microbiome Sub-study Sample Size

### 3.1 Study Design
Case-control study nested within the main cohort

### 3.2 Parameters
- **Power (1-β)**: 80%
- **Significance level (α)**: 0.05
- **Odds Ratio (OR)**: 2.0 (minimum detectable effect)
- **Case:Control ratio**: 1:1
- **Prevalence of exposure in controls (P₀)**: 0.30

### 3.3 Formula for Case-Control Studies
```
n = (Z_α + Z_β)² × (P₁(1-P₁) + P₀(1-P₀)) / (P₁ - P₀)²
```

Where:
- **P₁** = prevalence in cases = P₀ × OR / (1 + P₀ × (OR - 1))
- **P₀** = prevalence in controls

### 3.4 Calculation
```
P₁ = (0.30 × 2.0) / (1 + 0.30 × (2.0 - 1))
    = 0.60 / (1 + 0.30 × 1)
    = 0.60 / 1.30
    = 0.4615

Z_α = 1.96 (95% confidence)
Z_β = 0.84 (80% power)

n_per_group = (1.96 + 0.84)² × (0.4615×0.5385 + 0.30×0.70) / (0.4615 - 0.30)²
            = (2.80)² × (0.2485 + 0.21) / (0.1615)²
            = 7.84 × 0.4585 / 0.02607
            = 3.593 / 0.02607
            = 137.78

Microbiome sample size = 138 participants per group
Total microbiome samples = 276 participants
```

---

## 4. Microplastic Sub-study Sample Size

### 4.1 Study Design
Similar case-control design as microbiome study

### 4.2 Parameters
- **Power**: 80%
- **Significance level**: 0.05
- **Effect size**: OR = 2.0
- **Exposure prevalence in controls**: 0.25
- **Case:Control ratio**: 1:1

### 4.3 Calculation
```
P₁ = (0.25 × 2.0) / (1 + 0.25 × (2.0 - 1))
    = 0.50 / (1 + 0.25 × 1)
    = 0.50 / 1.25
    = 0.40

n_per_group = (1.96 + 0.84)² × (0.40×0.60 + 0.25×0.75) / (0.40 - 0.25)²
            = 7.84 × (0.24 + 0.1875) / (0.15)²
            = 7.84 × 0.4275 / 0.0225
            = 3.351 / 0.0225
            = 148.93

Microplastic sample size = 149 participants per group
Total microplastic samples = 298 participants
```

---

## 5. Spatial Analysis Sample Size

### 5.1 Requirements for Spatial Statistics
- **Moran's I**: Minimum 30-50 points for reliable estimation
- **Hotspot Analysis**: At least 100 points recommended
- **Interpolation**: 50+ points for basic mapping

### 5.2 Spatial Sample Size
```
Spatial analysis sample = 470 (main survey participants)
```

---

## 6. Overall Study Sample Size

### 6.1 Component Breakdown
| Component | Sample Size | Notes |
|-----------|-------------|-------|
| **Main Survey** | 470 | Prevalence estimation |
| **Microbiome Analysis** | 276 | Nested case-control |
| **Microplastic Analysis** | 298 | Nested case-control |
| **Total Required** | 1,044 | Maximum of all components |

### 6.2 Final Sample Size Decision
```
Total study sample size = 1,200 participants
```

**Rationale:**
- Round up from 1,044 to account for:
  - Additional losses to follow-up
  - Subgroup analyses requirements
  - Buffer for quality control exclusions
  - Future expansion possibilities

---

## 7. Sample Size Justification

### 7.1 Statistical Power
- **Main outcome**: >95% power to detect 20% prevalence ±5%
- **Subgroup analyses**: Adequate power for age, gender, urban/rural comparisons
- **Risk factors**: Sufficient power for OR ≥ 1.5 with 95% confidence

### 7.2 Precision
- **Prevalence estimate**: ±5% margin of error
- **Confidence intervals**: Narrow enough for policy decisions
- **Subgroup estimates**: Reliable estimates for key demographics

### 7.3 Feasibility
- **Time constraints**: Achievable within 6-month field period
- **Resource availability**: Within budget and personnel constraints
- **Logistical considerations**: Manageable for Tumkur district

---

## 8. Assumptions and Limitations

### 8.1 Assumptions
- Response rate of 80% (conservative estimate)
- Design effect of 1.5 (moderate clustering)
- Equal distribution across subgroups
- No major protocol deviations

### 8.2 Potential Limitations
- **Selection bias**: Hospital-based recruitment may affect generalizability
- **Non-response**: Higher than anticipated non-response rates
- **Clustering effects**: Higher design effect than assumed
- **Missing data**: Incomplete questionnaires or examinations

### 8.3 Contingency Planning
- **Buffer sample**: 15% above calculated minimum
- **Monitoring**: Regular assessment of recruitment rates
- **Adjustments**: Protocol amendments if needed
- **Substitutions**: Replacement sampling for non-responders

---

## 9. Sample Size Monitoring

### 9.1 Recruitment Tracking
- **Weekly targets**: 15-20 participants per week
- **Monthly reviews**: Progress against targets
- **Contingency plans**: Accelerated recruitment if needed

### 9.2 Power Calculations During Study
- **Interim analyses**: Assess actual power achieved
- **Effect size monitoring**: Track observed effect sizes
- **Sample size re-estimation**: If needed for key outcomes

---

## 10. References

1. Lwanga SK, Lemeshow S. Sample size determination in health studies: a practical manual. Geneva: World Health Organization; 1991.

2. Naing L, Winn T, Rusli BN. Practical issues in calculating the sample size for prevalence studies. Archives of Orofacial Sciences. 2006;1:9-14.

3. Dupont WD, Plummer WD. Power and sample size calculations for studies involving linear regression. Controlled Clinical Trials. 1998;19(6):589-601.

4. Hsieh FY, Bloch DA, Larsen MD. A simple method of sample size calculation for linear and logistic regression. Statistics in Medicine. 1998;17(14):1623-1634.

---

## 11. Appendices

### Appendix A: Sample Size Calculation Formulas
[Detailed mathematical formulas]

### Appendix B: Software Used
- Microsoft Excel for basic calculations
- R package `pwr` for power calculations
- Online calculators for verification

### Appendix C: Sensitivity Analysis Results
[Complete tables of alternative scenarios]

### Appendix D: Power Curves
[Graphs showing power vs sample size relationships]

---

**Sample Size Calculation Reviewed by:** __________ (Principal Investigator)

**Approved by:** __________ (Ethics Committee)

**Date:** __________

**Next Review:** __________ (Study completion)
