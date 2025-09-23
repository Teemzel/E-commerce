# E-Commerce Data Analysis

This project performs a comprehensive analysis of an e-commerce dataset, focusing on sales trends, product categories, and payment methods. The analysis includes data cleaning, statistical summaries, and visualizations to gain insights into the sales performance.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Data Overview](#data-overview)
- [Statistical Summaries](#statistical-summaries)
- [Visualizations](#visualizations)
- [Contributing](#contributing)
- [License](#license)

## Installation

To run this analysis, you need to have R and the `tidyverse` package installed. You can install the package using the following command:

```r
install.packages("tidyverse")

Additionally, you'll need the readr and lubridate packages:
install.packages("readr")
install.packages("lubridate")

Load the necessary libraries in your R script:
library(tidyverse)
library(readr)
library(lubridate)
Data File
Make sure to place the ecommerce_dataset_updated.csv.xlsx file in your working directory, as this script reads the data from this file.

Usage
Load the dataset and view its structure.
Perform data cleaning and transformation, such as converting purchase dates into the correct format.
Generate statistical summaries by category and overall.
Visualize sales trends and payment methods.
Code Snippet
Here's a brief overview of the main code sections:

r

# Load the dataset
e_commerce <- read_excel("ecommerce_dataset_updated.csv.xlsx")
View(e_commerce)

# Convert the purchase date to the correct format
e_commerce$Purchase_Date <- as.Date(e_commerce$Purchase_Date, format = "%d-%m-%Y")

# Statistical summary by category
e_commerce_summary <- e_commerce %>%
  group_by(Category) %>%
  summarise(mean_priceRS = mean(`Price (Rs.)`), .groups = 'drop')
Data Overview
Categories: The dataset contains various product categories.
Payment Methods: Different payment methods utilized by customers.
Statistical Summaries
Mean, Max, Min Prices: Calculate statistical metrics for prices and discounts.
Total Sales: Aggregate sales data by month and category.
Visualizations
Monthly Sales Trends:

Line graph showing total sales over the months.


Sales by Product Category:

Bar plot visualizing total sales by category.


Payment Method Counts:

Bar plot displaying the count of different payment methods used.


Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or additional features.
