---
layout: default
title: Project Overview
nav_order: 2
---

## Business Problem

The project addresses the challenge of **workforce management** in
customer-facing operations, focusing on aligning
staffing levels with fluctuating customer demand. This is a complex
optimization problem due to several industry pain points, including the need
to meet strict operational constraints like target response times and
service level agreements.

A significant complexity is the **Many-to-Many mapping** between staff groups
and customer demand types, where staff have varied skill sets and efficiencies.

Solving this is highly valuable as it directly impacts both cost and quality.
An effective solution optimizes resource utilization to reduce operational costs
while ensuring adequate staffing to maintain high service quality and
customer satisfaction.

## Domain Background

### **Intuit's Virtual Expert Platform (VEP)**

Intuit, a leading financial software company, offers products like TurboTax and QuickBooks, and connects users with live experts through its Virtual Expert Platform (VEP). This platform's operational efficiency relies heavily on accurate demand forecasting and precise supply planning. By effectively matching expert availability with user needs, Intuit ensures timely support and maintains cost-effectiveness.

### **The Forecasting Challenge**

**Forecasting models** in workforce management set the stage for everything else. The expectation is to accurately capture **when, how much, and what kind of demand** will show up. For example, it's not enough to know that thousands of customers will seek help next week — the models must account for hourly patterns, seasonal spikes, and even unexpected events. Accuracy matters because small errors in forecasts ripple downstream, leading to overstaffing (higher costs) or understaffing (longer wait times and lower customer satisfaction).

### **The Supply Planning Challenge**

On the **supply planning** side, the challenge is about **optimization under constraints**. Supply planning requires building staffing schedules that balance multiple, often conflicting requirements:

- Ensuring the right mix of skills (e.g., tax experts vs. bookkeeping experts)
- Covering peak hours without burning out the team
- Staying within budget and labor regulations
- Allowing flexibility for last-minute changes when forecasts shift

### **Operational Context**

In a real-world operations center:

- **Time granularity matters**: forecasts and schedules are often broken down by 30-minute intervals
- **Real-time monitoring is key**: forecasts guide the plan, but live adjustments (like reassigning staff or calling in reserves) keep service levels on track
- **Data sources are diverse**: historical call/chat volumes, marketing campaigns, product release calendars, and even external events (like tax deadlines) all influence demand
- **Performance metrics drive decisions**: service level agreements (SLAs), average handling time, and cost per interaction are the yardsticks used to evaluate success

## Goals & Objectives

The project is divided into two areas for Quarter 1 (Fall 2025):

- **Part 1: Demand Forecasting**: You will develop a working demand forecasting model
  and evaluate several ML algorithms to produce a robust forecasts.
  The goal is to

  1. Be familiar with the essential python toolkits and development environment (e.g. poetry, jupyter, git, etc.)
  2. Be comfortable with timeseries data handling, data processing, seasonality analysis, and feature engineering
  3. Define key metrics, understand how to perform evaluation for time series data, model selection, and optimization

- **Part 2: Supply Optimization**: Based on the forecasted demand, you will build a supply optimization model to determine
  optimal headcount allocation. The goal is to create a efficient staffing plan that meets predefined business constraints
  and service levels, progressing from simple one-to-one to more complex many-to-many scenarios.

## Learning Objectives

By the end of this project, students will be able to:

- **Understand the basics of forecasting and supply optimization** — why they matter, how they're built, and what makes them challenging in real-world operations
- **Recognize key trade-offs** in workforce planning, like balancing service quality, staffing costs, and operational flexibility
- **Interpret and use data** from demand patterns, schedules, and performance metrics to guide decision-making
- **Apply optimization logic** to create staffing plans that adapt to shifting demand
- **Work with industry partners** to understand real-world constraints and business requirements
- **Develop end-to-end solutions** that integrate forecasting and optimization models

## Success Metrics

### **Technical Metrics**

#### **Demand Forecasting Accuracy**

- **wMAPE** (Weighted Mean Absolute Percentage Error): Volume-weighted percentage error
- **MAE** (Mean Absolute Error): Average absolute difference between forecast and actual
- **MASE** (Mean Absolute Scaled Error): Scaled error relative to naive forecast
- **RMSE** (Root Mean Squared Error): Primary accuracy metric for forecasting models

#### **Supply Optimization Performance**

- **Service Level Achievement**: Percentage of interactions answered within target time (e.g., 80% within 20 seconds)
- **ASA** (Average Speed of Answer): Average wait time before customer connects to agent
- **AHT** (Average Handling Time): Average duration of customer interactions
- **Staff Utilization Rate**: Efficiency of resource allocation and usage
- **Constraint Satisfaction**: Adherence to business rules and operational constraints

### **Operational Metrics**

- **Cost per Interaction**: Total operational cost divided by number of interactions
- **Abandonment Rate**: Percentage of customers who hang up before reaching an agent
- **First Call Resolution**: Percentage of issues resolved in a single interaction
- **Adherence**: How closely actual schedules match planned schedules

### **Business Impact**

- **Cost Savings Analysis**: Quantified reduction in operational costs through optimized staffing
- **Customer Satisfaction**: Improvement in service quality and customer experience
- **Scalability Assessment**: Model's ability to handle varying demand volumes
- **ROI Projection**: Return on investment from implementing the workforce management solution

## Final Deliverables

By the end of the quarter, you will deliver the following:

- A comprehensive report detailing the project's methodoligies, analysis,
  and final results.
- A link to a well-commented code repository (i.e. GitHub repository)
- A slide deck suitable for a final presentation to stakeholders.
- (Optional) A short video demonstrating the project's solution and key outcomes.
