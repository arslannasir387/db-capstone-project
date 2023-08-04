use littlelemondb;

#Task 1
Create View OrderView as 
select OrderID,Quantity,BillAmount from orders;

select * from OrderView;
#Task 2
Create View CustomerInfo as
select c.CustomerID,CONCAT(FirstName," ",LastName) as FullName,o.OrderID,O.BillAmount,m.MenuName,m.Cuisine
from orders o inner join menu m on o.MenuID = m.MenuID
inner join Bookings b on o.BookingID = b.BookingID
inner join Customers c on b.CustomerID = c.CustomerID 
where  o.BillAmount > 150;

Select * from CustomerInfo;

#Task 3
select MenuName from menu group by menuID having count(MenuID)>2;

#Task 1
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
select max(Quantity) from littlelemondb.orders;
END
DELIMITER ;

#Task 2

select o.OrderID,o.Quantity,o.BillAmount from littlelemondb.orders o inner join littlelemondb.bookings b on o.BookingID = b.BookingID
inner join customers c on b.CustomerID = c.CustomerID
where c.CustomerID = ?;

SET @sql = 'SELECT o.OrderID, o.Quantity, o.BillAmount
            FROM littlelemondb.orders o
            INNER JOIN littlelemondb.bookings b ON o.BookingID = b.BookingID
            INNER JOIN customers c ON b.CustomerID = c.CustomerID
            WHERE c.CustomerID = ?';

PREPARE stmt FROM @sql;
SET @id = 1;            
EXECUTE stmt USING @id;
DEALLOCATE PREPARE stmt;




#Task 3
DELIMITER //
CREATE PROCEDURE CancelOrder (IN input_id INT)
BEGIN
	DECLARE row_cont INT;
	select Count(*) INTO row_cont from littlelemondb.orders where OrderID ='input_id';
    
	if row_cont > 0 then
		DELETE from littlelemondb.orders where OrderID ='input_id';
        select concat("order ",input_id,"is successfully deleted ");
        
	else
		select concat("order ",input_id,"not found ");
	end if;
END
DELIMITER ;


#different test version
DELIMITER //
CREATE PROCEDURE CancelOrder (IN input_id INT)
BEGIN
	DECLARE row_cont INT;
	select Count(*) INTO row_cont from littlelemondb.orders where OrderID ='input_id';
    
	if row_cont > 0 then
		DELETE from littlelemondb.orders where OrderID ='input_id';
	end if;
END
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_delete_record
AFTER DELETE ON littlelemondb.orders
FOR EACH ROW
BEGIN
    IF @delete_id IS NOT NULL AND @delete_id = OLD.id THEN
        SELECT CONCAT('Record with ID ', OLD.id, ' is deleted.') AS 'Message';
    END IF;
END //
DELIMITER ;


DELIMITER //

CREATE PROCEDURE CancelOrder(IN input_id INT)
BEGIN
    DECLARE row_cont INT;

    SELECT COUNT(*) INTO row_cont FROM littlelemondb.orders WHERE OrderID = input_id;

    IF row_cont > 0 THEN
        SIGNAL SQLSTATE '45000';
        SET MESSAGE_TEXT = CONCAT('Record with ID ', input_id, ' is deleted.');
        DELETE FROM littlelemondb.orders WHERE OrderID = input_id;
    ELSE
		  
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('No record found with ID ', input_id, '. Nothing to delete.');
        
    END IF;
END //

DELIMITER ;


# Exercise: Create SQL queries to add and update bookings
#Task 1
DELIMITER //
CREATE PROCEDURE AddBooking (IN BookingID INT,IN CustomerID INT,IN TableNo INT,IN BookingDate date)
BEGIN
	Declare rowcount int;
	select count(1) into rowcount from bookings where BookingSlotDate = BookingDate and TableNo = TableNo;
    if rowcount < 1 then
    insert into bookings(BookingID,CustomerID,TableNo,BookingSlotDate)
	values(BookingID,CustomerID,TableNo,BookingDate);
    select concat("new booking added") as Confirmation;
    else
    select concat("table already booked") as Confirmation; 

END
DELIMETER ;


#Task 2
DELIMITER //
CREATE PROCEDURE UpdateBooking (in bookingdate date,in bookingid int)
BEGIN
	declare rowcount int;
    declare customerid int;
    declare tableno int;
    
    select count(1) into rowcount from bookings where BookingID = bookingid;
    
    if rowcount < 1 then
		select concat("Booking not found") as Confirmation; 
    else
		update bookings set BookingSlotDate = bookingdate where BookingID = bookingid;
        select concat("Booking ",bookingid," update") as Confirmation;
	end if;
END
DELIMETER ;

#Task 3
DELIMITER //
CREATE PROCEDURE CancelBooking (in bookingid int)
BEGIN
	declare rowcount int;
    select count(1) into rowcount from bookings where BookingID = bookingid;
    
    if rowcount < 1 then
		select concat("Booking not found") as Confirmation; 
    else
		DELETE from bookings where BookingID = bookingid;
        select concat("Booking ",bookingid," deleted") as Confirmation;
        
	end if;
END
DELIMETER ;

select concat("hello"," i am here") as confirmation





