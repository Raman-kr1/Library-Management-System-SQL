USE LibraryDB;

-- Query 1: List all books with authors and genres
SELECT b.title AS BookTitle, 
       a.author_name AS Author, 
       g.genre_name AS Genre
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Genres g ON b.genre_id = g.genre_id;

-- Query 2: Find overdue loans (assuming 14-day loan period)
SELECT m.name AS MemberName,
       b.title AS BookTitle,
       l.loan_date AS LoanDate,
       DATEDIFF(CURRENT_DATE, l.loan_date) AS DaysBorrowed
FROM Loans l
JOIN Members m ON l.member_id = m.member_id
JOIN Books b ON l.book_id = b.book_id
WHERE l.status = 'Borrowed' 
  AND DATEDIFF(CURRENT_DATE, l.loan_date) > 14;

-- Query 3: Most popular genres
SELECT g.genre_name AS Genre,
       COUNT(l.loan_id) AS TotalLoans
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Genres g ON b.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY TotalLoans DESC;

-- Query 4: Members with active loans
SELECT m.name AS MemberName,
       COUNT(l.loan_id) AS ActiveLoans
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
WHERE l.status = 'Borrowed'
GROUP BY m.name;
