USE LibraryDB;

-- Stored Procedure: Checkout a Book
DELIMITER $$
CREATE PROCEDURE CheckoutBook(
    IN member_id INT,
    IN book_id INT
)
BEGIN
    DECLARE available_quantity INT;
    SELECT quantity INTO available_quantity FROM Books WHERE book_id = book_id;
    IF available_quantity > 0 THEN
        INSERT INTO Loans (member_id, book_id) VALUES (member_id, book_id);
        UPDATE Books SET quantity = quantity - 1 WHERE book_id = book_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book not available.';
    END IF;
END $$
DELIMITER ;

-- Trigger: Update Quantity After Return
DELIMITER $$
CREATE TRIGGER AfterReturn
AFTER UPDATE ON Loans
FOR EACH ROW
BEGIN
    IF NEW.status = 'Returned' THEN
        UPDATE Books SET quantity = quantity + 1 WHERE book_id = NEW.book_id;
    END IF;
END $$
DELIMITER ;

-- Function: Calculate Overdue Fine
DELIMITER $$
CREATE FUNCTION CalculateFine(loan_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE days_overdue INT;
    DECLARE fine DECIMAL(10,2);
    SELECT DATEDIFF(CURRENT_DATE, loan_date) - 14 INTO days_overdue
    FROM Loans WHERE loan_id = loan_id;
    IF days_overdue > 0 THEN
        SET fine = days_overdue * 1.00;
    ELSE
        SET fine = 0.00;
    END IF;
    RETURN fine;
END $$
DELIMITER ;
