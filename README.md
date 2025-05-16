# DataAnalytics-Assessment

## Overview
This repository contains SQL solutions for a data analyst assessment involving customer transactions and behavior analysis across savings and investment accounts.

---

## Questions and Solutions

### Q1: High-Value Customers with Multiple Products
**Objective**: Identify customers with both savings and investment plans and calculate their total deposits.

**Approach**:
- Joined `users_customuser` with `savings_savingsaccount` and `plans_plan`.
- Filtered savings accounts with confirmed positive amounts and investment plans flagged as funds.
- Aggregated counts and total deposit amounts (converted from kobo to Naira by dividing by 100).

---

### Q2: Transaction Frequency Analysis
**Objective**: Segment customers by their monthly transaction frequency.

**Approach**:
- Calculated monthly transaction counts per customer using the transaction date field (replace `transaction_date` with actual column name).
- Averaged monthly transactions per customer.
- Categorized customers into High, Medium, and Low frequency based on transaction averages.

---

### Q3: Account Inactivity Alert
**Objective**: Detect accounts with no transactions in over a year.

**Approach**:
- Retrieved the most recent transaction date (`created_on`) from both savings and investment accounts.
- Computed inactivity period using `DATEDIFF` against the current date.
- Selected accounts with inactivity exceeding 365 days.

---

### Q4: Customer Lifetime Value (CLV) Estimation
**Objective**: Estimate customer value based on tenure and transaction activity.

**Formula**:  
\[
CLV = \left(\frac{\text{Total Transactions}}{\text{Tenure in Months}}\right) \times 12 \times \text{Average Profit per Transaction}
\]

**Approach**:
- Calculated customer tenure in months from `date_joined`.
- Summed total transactions and amounts.
- Estimated CLV assuming a profit margin of 0.1% (i.e., dividing transaction amount by 1000).
- Converted amounts from kobo to Naira accordingly.

---

## Challenges

- **Currency Units**: Amounts were in kobo; consistent conversion to Naira was necessary.
- **Data Fields**: Clarification on transaction date columns (`created_on` used).
- **Date Calculations**: Ensured up-to-date inactivity and tenure calculations based on current system date.

---

## Final Note

All SQL queries adhere to MySQL standards and are optimized for clarity and accuracy.
