# Customer Behavior & Booking Trends

#1.Which destination is the most popular based on number of bookings?
SELECT DestinationName,COUNT(BookingID) AS TotalBookings FROM destinations 
JOIN bookings
ON destinations.DestinationID = bookings.DestinationID
group by DestinationName
ORDER BY TotalBookings DESC
LIMIT 5;


#2. What is the average budget spent by customers for each destination?
SELECT DestinationName,ROUND(AVG(budget),2) FROM destinations 
JOIN bookings
ON destinations.DestinationID = bookings.DestinationID
group by DestinationName
ORDER BY AVG(budget) DESC
LIMIT 5;

#3. Which travel category (e.g., Adventure, Beach, Cultural) receives the most bookings?
SELECT categoryname,COUNT(bookingid) FROM categories
JOIN Destination_Category
ON Categories.CategoryID = Destination_Category.CategoryID
JOIN Bookings
ON Destination_Category.DestinationID = Bookings.DestinationID
GROUP BY categoryname
ORDER BY COUNT(bookingid) DESC;

#4.List customers who have made more than 2 bookings.
SELECT Customers.CustomerID,FullName,COUNT(BookingID) FROM Bookings
JOIN Customers
ON Customers.CustomerID = Bookings.CustomerID
GROUP BY CustomerID,FullName
HAVING COUNT(BookingID) > 2
ORDER BY COUNT(BookingID) DESC;


#5. What are the peak months for travel based on travel dates?
SELECT MONTHNAME(TravelDate), count(BookingID) FROM Bookings
group by MONTHNAME(TravelDate)
order by count(BookingID) DESC;


# Business Insights

#1. What is the total revenue (sum of budget) generated per country?
SELECT Country, SUM(Budget) FROM Destinations
JOIN Bookings
ON Bookings.DestinationID = Destinations.DestinationID
group by Country
ORDER BY SUM(Budget) DESC;

#2.Find destinations that received a rating of 4 or more and are budget-friendly (average budget < ₹50,000)
SELECT DestinationName,AVG(Rating),AVG(Budget) FROM Destinations
JOIN Bookings
ON Bookings.destinationid = Destinations.destinationid 
JOIN Reviews
ON Bookings.bookingid = Reviews.bookingid
GROUP BY DestinationName
HAVING AVG(Rating)>=4 AND AVG(Budget) <50000
ORDER BY AVG(Rating) DESC;


#3. Which destination categories receive the lowest customer ratings on average?
SELECT 
	CategoryName,
	AVG(rating),
    COUNT(ReviewID) 
FROM Categories 
JOIN Destination_Category
ON Categories.CategoryID = Destination_Category.CategoryID
JOIN Bookings
ON Destination_Category.DestinationID = bookings.DestinationID
JOIN Reviews
ON reviews.BookingID = bookings.BookingID
GROUP BY CategoryName
ORDER BY AVG(rating),COUNT(ReviewID) DESC;

#4. Which customers gave the highest rating to their bookings? What destination was it?
SELECT 
	FullName,
	rating,
    DestinationName,
    country
FROM Customers 
JOIN Bookings
ON Customers.CustomerID = Bookings.CustomerID
JOIN Reviews
ON Reviews.bookingid = bookings.bookingid
JOIN Destinations 
ON Bookings.DestinationID = Bookings.DestinationID
WHERE Rating = (SELECT MAX(Rating) FROM reviews);

#5. Find the top 3 countries with the highest customer retention (repeat customers).
SELECT 
    d.Country,
    COUNT(DISTINCT b.CustomerID) AS RepeatCustomers
FROM 
    Bookings b
JOIN 
    (
        SELECT CustomerID
        FROM Bookings
        GROUP BY CustomerID
        HAVING COUNT(*) > 1
    ) repeat_customers ON b.CustomerID = repeat_customers.CustomerID
JOIN 
    Destinations d ON b.DestinationID = d.DestinationID
GROUP BY 
    d.Country
ORDER BY 
    RepeatCustomers DESC
;



#Date-Based & Time Analysis

#1. Calculate average days between booking date and travel date for each customer.
SELECT 
    Customers.CustomerID,
    FullName,
    AVG(DATEDIFF(TravelDate, BookingDate)) AS AvgDaysBeforeTravel
FROM 
    Customers
JOIN 
    Bookings ON Customers.CustomerID = Bookings.CustomerID
GROUP BY 
    Customers.CustomerID, FullName
ORDER BY 
    Customers.CustomerID;
    
#2 Identify customers who book less than 15 days before travel.
SELECT 
    Customers.CustomerID,
    FullName,
    DATEDIFF(TravelDate, BookingDate) 
FROM 
    Customers
JOIN 
    Bookings ON Customers.CustomerID = Bookings.CustomerID
WHERE DATEDIFF(TravelDate, BookingDate) < 15;



#Complex Joins & Window Func

#1.Rank destinations by popularity within each category.
SELECT DestinationName,
	count(bookingid),
    dense_rank() over(ORDER BY count(bookingid) DESC)
from Bookings
JOIN Destinations
ON Bookings.Destinationid = Destinations.Destinationid
GROUP BY DestinationName;

#2. Find the customer who spent the highest total budget across all bookings.
SELECT FullName,
	SUM(Budget)
FROM Customers
JOIN Bookings
ON Customers.CustomerID = Bookings.CustomerID
GROUP BY FullName
ORDER BY 
    SUM(Budget) DESC
LIMIT 1;
    
#3. Which destination-category combinations received the highest average ratings?
SELECT categoryname, 
	AVG(rating) AS avg_rating 
FROM Categories
JOIN Destination_Category 
ON Categories.CategoryID = Destination_Category.CategoryID
JOIN Bookings
ON Destination_Category.DestinationID = bookings.DestinationID
JOIN Reviews
ON Reviews.bookingid = Bookings.bookingid
GROUP BY categoryname
ORDER BY avg_rating DESC;
