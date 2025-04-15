# Library-Management-System
A web-based application for managing library operations, developed using Java, JSP, CSS, and MySQL.


## Normalization Process for Library Management System

### Rules of Normalization

- **First Normal Form (1NF):**
  - Eliminate repeating groups (e.g., multiple values in a single column).
  - Ensure all attributes are atomic (indivisible).
  - Assign a primary key to each table.

- **Second Normal Form (2NF):**
  - Must be in 1NF.
  - Ensure all non-key attributes are fully dependent on the entire primary key (no partial dependencies).

- **Third Normal Form (3NF):**
  - Must be in 2NF.
  - Eliminate transitive dependencies (non-key attributes should not depend on other non-key attributes).

---

## Normalization Steps

### Unnormalized Form (UNF)
**Description:** A single table with all attributes, including repeating groups for inquiries and borrowings.

**Structure:**  
```
(MemberID, Name, Email, Password, RoleID, RoleName, RoleDescription, 
 {InquiryID, InquiryName, InquiryEmail, Message, InquiryDate}, 
 {BorrowID, ISBN, BorrowDate, ReturnDate, Title, Author, Category, Status})
```

---

### First Normal Form (1NF)
**Description:** Repeating groups are removed, and separate tables are created for members, inquiries, borrowings, and books. Each table has a primary key.

**Tables:**
- **Members-1:** `(MemberID, Name, Email, Password, RoleID, RoleName, RoleDescription)`  
  - Primary Key: `MemberID`
- **Inquiries-1:** `(InquiryID, MemberID, InquiryName, InquiryEmail, Message, InquiryDate)`  
  - Primary Key: `InquiryID`, Foreign Key: `MemberID`
- **Borrowings-1:** `(BorrowID, MemberID, ISBN, BorrowDate, ReturnDate)`  
  - Primary Key: `BorrowID`, Foreign Keys: `MemberID`, `ISBN`
- **Books-1:** `(ISBN, Title, Author, Category, Status)`  
  - Primary Key: `ISBN`

---

### Second Normal Form (2NF)
**Description:** Confirms no partial dependencies exist. Since all tables use single-column primary keys, the 1NF schema already satisfies 2NF.

**Tables:**
- **Members-2:** `(MemberID, Name, Email, Password, RoleID, RoleName, RoleDescription)`
- **Inquiries-2:** `(InquiryID, MemberID, InquiryName, InquiryEmail, Message, InquiryDate)`
- **Borrowings-2:** `(BorrowID, MemberID, ISBN, BorrowDate, ReturnDate)`
- **Books-2:** `(ISBN, Title, Author, Category, Status)`

---

### Third Normal Form (3NF)
**Description:** Removes transitive dependencies by separating role details into a new table (`UserRoles`). Other tables remain unchanged.

**Tables:**
- **Members-3:** `(MemberID, Name, Email, Password, RoleID)`  
  - Primary Key: `MemberID`, Foreign Key: `RoleID`
- **UserRoles-3:** `(RoleID, RoleName, RoleDescription)`  
  - Primary Key: `RoleID`
- **Inquiries-3:** `(InquiryID, MemberID, Name, Email, Message, InquiryDate)`  
  - Primary Key: `InquiryID`, Foreign Key: `MemberID`
- **Borrowings-3:** `(BorrowID, MemberID, ISBN, BorrowDate, ReturnDate)`  
  - Primary Key: `BorrowID`, Foreign Keys: `MemberID`, `ISBN`
- **Books-3:** `(ISBN, Title, Author, Category, Status)`  
  - Primary Key: `ISBN`

---

## Final 3NF Schema
- **Members:** `(MemberID, Name, Email, Password, RoleID)`
- **UserRoles:** `(RoleID, RoleName, RoleDescription)`
- **Inquiries:** `(InquiryID, MemberID, Name, Email, Message, InquiryDate)`
- **Borrowings:** `(BorrowID, MemberID, ISBN, BorrowDate, ReturnDate)`
- **Books:** `(ISBN, Title, Author, Category, Status)`
