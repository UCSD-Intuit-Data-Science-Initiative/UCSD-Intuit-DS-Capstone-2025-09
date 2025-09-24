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
and customer demand types, where staff have varied skill sets and edficiencies.

Solving this is highly valuable as it directly impacts both cost and quality.
An effective solution optimizes resource utilization to reduce operational costs
while ensuring adequate staffing to maintain high service quality and
customer satisfaction.

## Goals & Objectives
The project is divided into two quarters with distinct, time-bound objectives:

- **Quarter 1 (Fall 2025): Demand Forecasting Model**: By the end of the 1st
quarter, the team will develop and evaluate several time-series algorithms
to produce a robust baseline model for forecasting incoming customer demand.
The goal is to select the model with the highest predictive accuracy to serve
as the input for the second quarter's work.

- **Quarter 1 (Fall 2025): Supply Optimization Model**: Using the demand
forecasts from `Q1`, the team will build a supply optimization model to determine
optimal headcount allocation. The objective is to create a staffing plan
that meets predefined business constraints and service levels, progressing
from simple one-to-one to more complex many-to-many *staff-to-demand* scenarios.


## Success Metrics
- **Technical**:
    - **Demand Forecasting** : Accuracy measured by metrics such as
    `Room Mean Squared Error` (RMSE) or `Mean Absolute Percentage Error` (MAPE).
    - **Supply Optimization** : The model's ability to generate a staffing
    plan that meets or exceeds key service level targets
    (e.g. Average Speed to Answer.)

- **Business**:
    - A final analysis projecting the potential for operational cost savings
    through optimized staffing.
    - A qualitative assessment of the expected improvement in customer
    satisfaction by consistently meeting service quality goals.

## Final Deliverables
By the end of the 2nd quarter, the team will deliver the following:

- A comprehensive report detailing the project's methodoligies, analysis,
and final results.
- A link to a well-commented code repository (i.e. GitHub repository)
- A slide deck suitable for a final presentation to stakeholders.
- A short video demonstrating the project's solution and key outcomes.
