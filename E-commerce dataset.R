install.packages("tidyverse")
library(tidyverse)
conflict_prefer("fliter")
install.packages("readr")
library(readr)
install.packages("lubridate")
library(lubridate)
e_commerce <- read_excel("ecommerce_dataset_updated.csv.xlsx")
View(e_commerce)
colnames(e_commerce)
table(e_commerce$Category)
table(e_commerce$Payment_Method)

# Satistical summary of the data
summary(e_commerce)

#Convert the purchase date to a date format
e_commerce$Purchase_Date <- as.Date(e_commerce$Purchase_Date, format = "%d-%m-%Y")
e_commerce$month <- month(e_commerce$Purchase_Date)
e_commerce$day <- day(e_commerce$Purchase_Date)
e_commerce$year <- year(e_commerce$Purchase_Date)
e_commerce$day_of_the_week <- wday(e_commerce$Purchase_Date, label = TRUE)

#Statisticsl cal by category 
e_commerce %>% group_by(Category) %>% drop_na() %>% 
  summarise(mean_priceRS = mean(`Price (Rs.)`))

e_commerce %>% group_by(Category) %>% drop_na() %>% 
  summarise(max_priceRS = max(`Price (Rs.)`))

e_commerce %>% group_by(Category) %>% drop_na() %>% 
  summarise(min_priceRS = min(`Price (Rs.)`))

#min, max, mean value of discount
e_commerce_stat <- e_commerce %>%
  summarize(mean_discount = mean(`Discount (%)`), 
            max_discount = max(`Discount (%)`), 
            min_discount = min(`Discount (%)`))
e_commerce_stat

e_commerce_sales_by_month <- e_commerce %>%
  group_by(month) %>%
  summarize(Total_Sales = sum(`Final_Price(Rs.)`), 
            .groups = 'drop') %>%
  arrange(desc(Total_Sales))
e_commerce_sales_by_month

#Total sales by day of the week
e_commerce_sales_by_dayoftheweek <- e_commerce %>%
  group_by(day_of_the_week) %>%
  summarize(Total_Sales = sum(`Final_Price(Rs.)`), 
            .groups = 'drop') %>%
  arrange(desc(Total_Sales))
e_commerce_sales_by_dayoftheweek


e_commerce_sales_by_category <- e_commerce %>%
  group_by(Category) %>%
  summarize(
    max_finalpriceRs = max(`Final_Price(Rs.)`),
    min_finalpriceRs = min(`Final_Price(Rs.)`),
    mean_finalpriceRs = mean(`Final_Price(Rs.)`),
    Total_Sales = sum(`Final_Price(Rs.)`),
    .groups = 'drop'
  ) %>%
  arrange(desc(mean_finalpriceRs))  #ordering by the mean in descending order

e_commerce_sales_by_category


# Visualize monthly sales trends
e_commerce_sales_by_month <- e_commerce %>%
  group_by(month) %>%
  summarize(Total_Sales = sum(`Final_Price(Rs.)`), 
            .groups = 'drop') %>%
  arrange(desc(Total_Sales))
e_commerce_sales_by_month

ggplot(data = e_commerce_sales_by_month) + 
  geom_line(mapping =  aes(x = month, y = Total_Sales)) +
      labs(title = "Monthly Sales Trends",
  x = "Month",
  y = "Total Sales (Rs.)") +
  theme_minimal() +
 theme(axis.text.x = element_text(angle = 20, hjust = 1))



# Visualize e_commerce_sales_by_month with a 'month' column in "YYYY-MM" format
e_commerce_sales_by_month <- e_commerce %>%
  mutate(month = format(Purchase_Date, "%Y-%m")) %>%
  group_by(month) %>%
  summarize(Total_Sales = sum(`Final_Price(Rs.)`), .groups = 'drop')
e_commerce_sales_by_month

ggplot(e_commerce_sales_by_month, aes(x = as.Date(paste0(month, "-01")), y = Total_Sales)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red") +
  labs(title = "Monthly Sales Trends",
       x = "Month",
       y = "Total Sales (Rs.)") +
  theme_minimal() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +  # Adjust date labels as needed
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# bar plot to visualize sales by category
ggplot(e_commerce_sales_by_category, aes(x = reorder(Category, Total_Sales), y = Total_Sales)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total Sales by Product Category",
       x = "Product Category",
       y = "Total Sales (Rs.)") +
  coord_flip() +  # Flip coordinates for better readability
  theme_minimal()

# bar plot for the count of payment methods
ggplot(data = e_commerce, aes(x = (Payment_Method)))+
  geom_bar(fill = "purple", color = "white") +
  labs(title = "Count of Payment Method",
       x = "Payment Method",
       y = "Payment Count")+
  theme_minimal()


