 Create Database Ola;
 Use Ola;
 
# 1. What is the total number of rides completed?

SELECT COUNT(*) AS total_completed_rides
FROM rides
WHERE Booking_Status = 'Success';

# 2. What percentage of rides were canceled by customers vs. drivers?

SELECT 
    Booking_Status, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rides) AS percentage
FROM rides
WHERE Booking_Status IN ('Canceled by Driver', 'Canceled by Customer')
GROUP BY Booking_Status;

# 3. What are the top 5 most popular pickup and drop locations?

SELECT Pickup_Location, COUNT(*) AS ride_count
FROM rides
GROUP BY Pickup_Location
ORDER BY ride_count DESC
LIMIT 5;
SELECT Drop_Location, COUNT(*) AS ride_count
FROM rides
GROUP BY Drop_Location
ORDER BY ride_count DESC
LIMIT 5;

# 4. What is the average ride distance for each vehicle type?

SELECT Vehicle_Type, AVG(Ride_Distance) AS avg_distance
FROM rides
WHERE Ride_Distance > 0
GROUP BY Vehicle_Type;

# 5. What is the most frequently used vehicle type?

SELECT Vehicle_Type, COUNT(*) AS ride_count
FROM rides
GROUP BY Vehicle_Type
ORDER BY ride_count DESC
LIMIT 1;

# 6. What is the total revenue generated from successful bookings?

SELECT SUM(Booking_Value) AS total_revenue
FROM rides
WHERE Booking_Status = 'Success';

# 7. What is the average fare per ride for different vehicle types?

SELECT Vehicle_Type, AVG(Booking_Value) AS avg_fare
FROM rides
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

# 8. What is the most common payment method used?

SELECT Payment_Method, COUNT(*) AS payment_count
FROM rides
WHERE Payment_Method IS NOT NULL
GROUP BY Payment_Method
ORDER BY payment_count DESC
LIMIT 1;

# 9. What percentage of rides were paid via UPI, Cash, and Credit Card?

SELECT Payment_Method, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rides WHERE Payment_Method IS NOT NULL) AS percentage
FROM rides
WHERE Payment_Method IN ('UPI', 'Cash', 'Credit Card')
GROUP BY Payment_Method;

# 10. What is the total revenue lost due to canceled rides?

SELECT SUM(Booking_Value) AS lost_revenue
FROM rides
WHERE Booking_Status IN ('Canceled by Driver', 'Canceled by Customer');

# 11. Who are the top 5 customers with the most bookings?

SELECT Customer_ID, COUNT(*) AS total_rides
FROM rides
GROUP BY Customer_ID
ORDER BY total_rides DESC
LIMIT 5;

# 12. What is the average customer rating per vehicle type?

SELECT Vehicle_Type, AVG(Customer_Rating) AS avg_customer_rating
FROM rides
WHERE Customer_Rating IS NOT NULL
GROUP BY Vehicle_Type;

# 13. Which customers have the highest cancellation rate?

SELECT Customer_ID, 
       COUNT(*) AS total_cancellations
FROM rides
WHERE Booking_Status = 'Canceled by Customer'
GROUP BY Customer_ID
ORDER BY total_cancellations DESC
LIMIT 5;

# 14. What is the most common reason for driver cancellations?

SELECT Canceled_Rides_by_Driver, COUNT(*) AS count
FROM rides
WHERE Canceled_Rides_by_Driver IS NOT NULL
GROUP BY Canceled_Rides_by_Driver
ORDER BY count DESC
LIMIT 1;

# 15. How do driver ratings correlate with ride distance?

SELECT Ride_Distance, AVG(Driver_Ratings) AS avg_driver_rating
FROM rides
WHERE Ride_Distance > 0 AND Driver_Ratings IS NOT NULL
GROUP BY Ride_Distance
ORDER BY Ride_Distance;

# 16. Which day of the month had the highest number of ride bookings?

SELECT DAY(Date) AS ride_day, COUNT(*) AS total_rides
FROM rides
GROUP BY ride_day
ORDER BY total_rides DESC
LIMIT 1;

# 17. How do ride bookings vary by time of day (morning, afternoon, night)?

SELECT 
    CASE 
        WHEN HOUR(Time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(Time) BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Night'
    END AS time_period, 
    COUNT(*) AS ride_count
FROM rides
GROUP BY time_period
ORDER BY ride_count DESC;

# 18. What is the peak booking time for each vehicle type?

SELECT Vehicle_Type, HOUR(Time) AS peak_hour, COUNT(*) AS ride_count
FROM rides
GROUP BY Vehicle_Type, peak_hour
ORDER BY ride_count DESC
LIMIT 5;

# 19. Which month had the highest ride cancellation rate?

SELECT MONTH(Date) AS ride_month, 
       COUNT(*) AS total_cancellations
FROM rides
WHERE Booking_Status IN ('Canceled by Driver', 'Canceled by Customer')
GROUP BY ride_month
ORDER BY total_cancellations DESC
LIMIT 1;

# 20. How does average ride distance vary across different hours of the day?

SELECT HOUR(Time) AS hour_of_day, AVG(Ride_Distance) AS avg_distance
FROM rides
WHERE Ride_Distance > 0
GROUP BY hour_of_day
ORDER BY hour_of_day;
