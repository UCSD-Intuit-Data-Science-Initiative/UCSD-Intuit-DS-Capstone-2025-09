---
layout: default
title: Datasets & Materials
parent: Resources
nav_order: 1
---

## Dataset Access
Secure links to download or access the project datasets. Include version numbers if the data is updated.

*Note: Specific dataset access details will be provided during the project kickoff.*

## Workforce Management Data Dictionary

> The following data descriptions are *proposed* data attributes that could be
> used for the different flavors of datasets used throughout this project.

### **Demand Forecasting Data**

| Column Name | Data Type | Description | Notes |
|-------------|-----------|-------------|-------|
| timestamp | Timestamp | Time of customer interaction (UTC) | Primary time series index |
| interaction_type | String | Type of interaction (call, chat, email) | Categorical variable |
| volume | Integer | Number of interactions per time period | Target variable for forecasting |
| product_category | String | Product line (TurboTax, QuickBooks, etc.) | Demand segmentation |
| complexity_score | Float | Interaction complexity (1-10 scale) | Affects handling time |
| seasonality_flag | Boolean | Peak season indicator | Tax season, holidays |

### **Staff Performance Data**

| Column Name | Data Type | Description | Notes |
|-------------|-----------|-------------|-------|
| agent_id | String | Unique agent identifier | Anonymized |
| skill_set | String | Agent expertise areas | Multi-category |
| experience_level | Integer | Years of experience | 1-5 scale |
| handling_time_avg | Float | Average interaction duration (minutes) | Performance metric |
| service_level | Float | Percentage of interactions within SLA | Quality metric |
| availability_hours | String | Work schedule pattern | Scheduling constraint |

### **Operational Metrics Data**

| Column Name | Data Type | Description | Notes |
|-------------|-----------|-------------|-------|
| time_slot | Timestamp | 30-minute time intervals | Standard granularity |
| demand_forecast | Float | Predicted interaction volume | Model output |
| actual_volume | Integer | Actual interactions received | Ground truth |
| staff_scheduled | Integer | Number of agents scheduled | Supply planning |
| staff_available | Integer | Agents actually available | Real-time adjustment |
| queue_length | Integer | Current queue size | Real-time metric |

## Data Sources & Integration

### **Historical Data Sources**
- **Call/Chat Volumes**: Interaction volumes by time intervals (30-minute granularity)
- **Customer Interaction Patterns**: Types of inquiries, complexity scores, resolution times
- **Staff Performance Metrics**: Individual agent metrics, skill assessments, handling times
- **Seasonal Trends**: Historical patterns, peak periods, and cyclical variations

### **External Data Sources**

#### **Business Calendar Data**
- **Tax Deadlines**: Federal and state tax filing deadlines
- **Product Launches**: New feature releases and updates
- **Marketing Campaigns**: Promotional periods and events
- **Holiday Calendar**: National holidays and observances

#### **Economic Indicators**
- **Unemployment Rates**: Economic factors affecting demand
- **Consumer Confidence**: Economic sentiment indicators
- **Seasonal Patterns**: Historical seasonal trends

### **Real-time Data Integration**
- **Live Demand Tracking**: Current call volumes and queue lengths
- **Staff Availability Updates**: Real-time agent status and capacity
- **Performance Dashboards**: Live operational metrics and KPIs
- **Alert Systems**: Threshold monitoring and automated notifications

## Reference Library

### **Academic Papers**
- [Rob Hyndman's Forecasting Principles & Practice](https://otexts.com/fpp3/)
- Workforce Management in Service Operations
- Time Series Forecasting in Business Applications
- Optimization Models for Staff Scheduling

### **Technical Resources**
- Prophet Documentation and Tutorials
- OR-Tools Optimization Examples
- Python Time Series Analysis Guides
- Jupyter Notebook Best Practices

### **Industry Case Studies**
- Call Center Optimization Examples
- Workforce Management Success Stories
- Demand Forecasting in Service Industries
- Real-time Scheduling Implementations

## Project Templates

### **Documentation Templates**
- Project Proposal Template (.docx)
- Technical Report Template (.docx)
- Code Documentation Template (.md)

### **Presentation Materials**
- Presentation Slide Template (.pptx)
- Demo Script Template (.docx)
- Stakeholder Update Template (.docx)

### **Code Templates**
- Python Project Structure Template
- Jupyter Notebook Template
- Model Evaluation Template
- Data Pipeline Template
