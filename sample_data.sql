-- Authors
INSERT INTO Authors (author_name) VALUES
('J.K. Rowling'),
('George Orwell'),
('Agatha Christie'),
('Stephen King'),
('Harper Lee');

-- Genres
INSERT INTO Genres (genre_name) VALUES
('Fantasy'),
('Dystopian'),
('Mystery'),
('Horror'),
('Classic');

-- Books
INSERT INTO Books (title, author_id, genre_id, published_year, quantity) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 1, 1997, 5),
('1984', 2, 2, 1949, 3),
('Murder on the Orient Express', 3, 3, 1934, 2),
('The Shining', 4, 4, 1977, 4),
('To Kill a Mockingbird', 5, 5, 1960, 3);

-- Members
INSERT INTO Members (name, email, join_date) VALUES
('Alice Smith', 'alice@example.com', '2023-01-15'),
('Bob Johnson', 'bob@example.com', '2023-02-20'),
('Charlie Brown', 'charlie@example.com', '2023-03-10');

-- Loans
INSERT INTO Loans (member_id, book_id, loan_date, return_date, status) VALUES
(1, 1, '2023-10-01', NULL, 'Borrowed'),
(2, 2, '2023-10-05', '2023-10-19', 'Returned'),
(3, 3, '2023-10-10', NULL, 'Borrowed');
