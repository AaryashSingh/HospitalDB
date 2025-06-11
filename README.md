# 🌍  SQL for Wanderlust

Welcome to **SQL for Wanderlust**, a SQL-based data analysis project built to simulate a real-world travel booking platform. This case study demonstrates how a data analyst can extract insights from a travel company’s booking data using SQL, helping the business improve customer experience, optimize destinations, and maximize revenue.

---

## 📊 Project Overview

**Objective:**  
To analyze customer travel patterns, booking behavior, destination popularity, and budget trends using structured SQL queries on a relational database schema.  

**Tech Stack:**  
- MySQL Workbench (for schema design and querying)  
- SQL (Core + Analytical functions)  
- CSV Datasets (Generated + Synthetic)  

---

## 🧱 Database Schema

The project includes 7 relational tables:

1. `Customers` – Stores customer info & preferences  
2. `Destinations` – Travel destinations  
3. `Categories` – Types of destinations (Adventure, Romantic, etc.)  
4. `DestinationCategory` – Many-to-many relation between destinations & categories  
5. `Bookings` – Customer bookings with travel dates & budget  
6. `Itineraries` – Daily activity plans per booking  
7. `Reviews` – Post-travel feedback

---

## 📂 Dataset

All data is synthetically generated to simulate real-world travel booking data.

| File                    | Description                       |
|-------------------------|-----------------------------------|
| `customers.csv`         | Customer information              |
| `destinations.csv`      | Destinations across countries     |
| `categories.csv`        | Travel category types             |
| `destination_category.csv` | Mapping of destinations to categories |
| `bookings.csv`          | Bookings with travel & budget info|
| `itineraries.csv`       | Daily travel activities           |
| `reviews.csv`           | Ratings and reviews post-travel   |


