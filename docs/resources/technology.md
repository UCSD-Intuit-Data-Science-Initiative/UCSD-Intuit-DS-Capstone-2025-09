---
layout: default
title: Technology & Environment
parent: Resources
nav_order: 2
---

## Required Tech Stack

### **Core Development Environment**
- **Language**: Python 3.9+
- **Environment Management**: Poetry (recommended) or virtual environments
- **Version Control**: Git with GitHub/GitLab

### **Data Science & Machine Learning Libraries**
- **Data Manipulation**: pandas, numpy
- **Time Series Handling**: sktime, pandas
- **Machine Learning**: scikit-learn, LightGBM, XGBoost
- **Forecasting Models**: Prophet, darts, autogluon
- **Visualization**: matplotlib, seaborn, plotly

### **Supply Optimization & Operations Research**
- **Optimization**: PuLP, OR-Tools, scipy.optimize
- **Linear Programming**: CVXPY, Gurobi (if available)
- **Scheduling**: Custom algorithms for workforce planning

### **Cloud & Infrastructure**
- **Database**: PostgreSQL
- **Cloud Storage**: AWS S3
- **Containerization**: Docker (optional)
- **Deployment**: AWS/GCP (for production models)

## Development Setup

We'll provide further guidance on this.

## Prerequisites & Learning Path

### **Basic Tools Setup**
- **Environment Setup**: Learn how to create a virtual environment for Python development
- **Python Toolkit**: Essential libraries for data science and machine learning
  - Data manipulation: pandas, numpy, sktime
  - Machine learning: scikit-learn, LightGBM, XGBoost
  - Forecasting models: Prophet, darts, autogluon
  - Visualization: matplotlib, seaborn, plotly

### **Recommended Learning Resources**
- **Forecasting**: [Rob Hyndman's Forecasting Principles & Practice](https://otexts.com/fpp3/)
- **Time Series Analysis**: Core concepts including seasonality, lags, autoregressive models, trend decomposition
- **Optimization**: Linear programming, integer programming, constraint satisfaction
- **Industry Applications**: Workforce management case studies and real-world implementations

## Forecasting Technology Stack

### **Time Series Analysis**
- **sktime**: Comprehensive time series analysis toolkit
- **pandas**: Data manipulation and time series operations
- **numpy**: Numerical computations

### **Forecasting Models**
- **Prophet**: Facebook's forecasting tool for business time series
- **darts**: Python library for time series forecasting
- **autogluon**: AutoML for time series
- **ARIMA/SARIMA**: Traditional statistical models
- **LSTM/Deep Learning**: Neural network approaches

### **Evaluation Metrics**
- **MAE**: Mean Absolute Error
- **wMAPE**: Weighted Mean Absolute Percentage Error
- **MASE**: Mean Absolute Scaled Error
- **RMSE**: Root Mean Square Error

## Supply Optimization Technology

### **Optimization Libraries**
- **PuLP**: Python Linear Programming modeler
- **OR-Tools**: Google's optimization tools
- **scipy.optimize**: Scientific computing optimization
- **CVXPY**: Convex optimization

### **Optimization Approaches**
- **Linear Programming**: Mathematical optimization for resource allocation
- **Integer Programming**: Discrete decision optimization
- **Constraint Programming**: Complex constraint satisfaction
- **Heuristic Methods**: Approximate solutions for complex problems

## Code & Version Control

### **Repository Management**
- **Main Repository**: [UCSD-Intuit-Data-Science-Capstone](https://github.com/UCSD-Intuit-Data-Science-Initiative/UCSD-Intuit-DS-Capstone-2025-09)
- **Branching Strategy**: Feature branches with pull request reviews
- **Commit Style**: Conventional Commits specification
- **Code Review**: Required for all merges to main branch

### **Project Structure**
```
project/
├── data/                 # Raw and processed data
├── notebooks/           # Jupyter notebooks for exploration
├── src/                 # Source code modules
│   ├── forecasting/     # Demand forecasting models
│   ├── optimization/    # Supply optimization algorithms
│   └── utils/          # Utility functions
├── tests/              # Unit and integration tests
├── docs/               # Documentation
└── requirements.txt    # Python dependencies
```

## Performance & Scalability

### **Computational Requirements**
- **Memory**: 8GB+ RAM recommended for large datasets
- **CPU**: Multi-core processing for optimization algorithms
- **Storage**: Sufficient space for time series data and model artifacts

### **Production Considerations**
- **Model Serving**: REST APIs for real-time predictions
- **Monitoring**: Performance tracking and alerting
- **Scalability**: Horizontal scaling for high-volume operations
- **Backup**: Data and model versioning strategies
