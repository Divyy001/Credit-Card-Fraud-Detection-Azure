# Credit-Card-Fraud-Detection-Azure
Project Overview

This project implements a robust Credit Card Fraud Detection system using a combination of advanced data engineering and machine learning techniques. The solution is designed to predict fraudulent transactions, providing critical insights and visualizations to help prevent fraud in real-time. The system leverages Azure's cloud ecosystem, including Synapse Analytics, Data Factory, and Power BI, to build a scalable, efficient, and interactive data pipeline.

Architecture

The architecture of this Credit Card Fraud Detection system involves several key components:

- Data Ingestion: Raw transactional data is ingested into Azure Data Lake Storage (ADLS) using Azure Data Factory.
- Data Processing: Data is processed and transformed in Azure Synapse Analytics using PySpark. Feature engineering and data cleaning are performed to prepare the data for machine learning.
- Fraud Detection Model: An ONNX regression model is deployed within Azure Synapse SQL dedicated pool to predict fraudulent transactions.
- Data Visualization: The results are visualized using Power BI, which provides interactive dashboards to monitor and analyze fraud patterns.

Technologies Used

- Azure Synapse Analytics: For data warehousing, ETL processes, and running the fraud detection model.
- Azure Data Factory: To orchestrate data movement and transformation.
- Azure Data Lake Storage (ADLS): For storing raw and processed data.
- PySpark: For distributed data processing and feature engineering.
- ONNX Models: For deploying machine learning models in Synapse SQL.
- SQL: For querying and managing data in the Synapse SQL pool.
- Power BI: For creating interactive dashboards to visualize fraud detection insights.

Implementation Details

- Data Ingestion: Azure Data Factory pipelines are used to ingest data from various sources into ADLS, where it is stored as raw data.
- Data Processing: PySpark scripts are executed in Azure Synapse to perform data cleaning, feature engineering, and preparation for the fraud detection model.
- Model Deployment: The ONNX model is deployed within a Synapse SQL dedicated pool, where it scores incoming transactions for fraud likelihood.
- Results Visualization: The output from the model is aggregated and visualized in Power BI, which provides actionable insights to stakeholders.
