CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    isbn VARCHAR(20),
    publicationYear INT,
    genre VARCHAR(100),
    pages INT,
    image_data LONGBLOB,
    image_type VARCHAR(50)
); 