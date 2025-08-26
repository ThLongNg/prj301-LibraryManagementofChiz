package dao;

import dto.Book; // Keep this import as it's used in insertBorrowRequest method signature
import dto.BookRequest;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import mylib.DBUtils;

public class BookRequestDAO {

    // Current method to create ONE book request
    public boolean createBookRequest(int bookId, int userId) {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO book_requests (book_id, user_id, request_date, status)\n"
                           + "VALUES (?, ?, GETDATE(), 'Pending')"; // 'Pending' is the initial status
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookId);
                st.setInt(2, userId);
                int rowsAffected = st.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    // NEW METHOD: insertBorrowRequest to handle a cart (multiple books)
    // Returns the number of successfully inserted requests
    public int insertBorrowRequest(int userId, ArrayList<Book> cartList) throws SQLException {
        Connection cn = null;
        int totalRowsAffected = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                cn.setAutoCommit(false); // Start transaction

                String sql = "INSERT INTO book_requests (book_id, user_id, request_date, status) VALUES (?, ?, GETDATE(), 'Pending')";
                PreparedStatement st = cn.prepareStatement(sql);

                for (Book book : cartList) {
                    st.setInt(1, book.getId()); // Assuming Book DTO has a getId() method
                    st.setInt(2, userId);
                    st.addBatch(); // Add to batch
                }

                int[] results = st.executeBatch(); // Execute batch
                for (int res : results) {
                    if (res > 0) {
                        totalRowsAffected++; // Count successful requests
                    }
                }
                cn.commit(); // Commit transaction if no errors
            }
        } catch (ClassNotFoundException | SQLException e) {
            if (cn != null) {
                cn.rollback(); // Rollback if an error occurs
            }
            e.printStackTrace();
            throw new SQLException("Error inserting borrow requests for cart: " + e.getMessage());
        } finally {
            try {
                if (cn != null) {
                    cn.setAutoCommit(true); // Ensure auto-commit is re-enabled
                    cn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return totalRowsAffected;
    }

    public ArrayList<BookRequest> getAllBookRequests() {
        ArrayList<BookRequest> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Added actual_return_date to the SELECT statement for consistency
                String sql = "SELECT id, book_id, user_id, request_date, borrow_date, return_date, status, fine_amount, actual_return_date\n"
                           + "FROM book_requests\n";
                           
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                System.out.println("Executing SQL query: " + sql);
                while (table.next()) {
                    int id = table.getInt("id");
                    int bookId = table.getInt("book_id");
                    int userId = table.getInt("user_id");
                    Date requestDate = table.getDate("request_date");
                    Date borrowDate = table.getDate("borrow_date");
                    Date returnDate = table.getDate("return_date");
                    String status = table.getString("status");
                    double fineAmount = table.getDouble("fine_amount");
                    Date actualReturnDate = table.getDate("actual_return_date"); // Retrieve actual_return_date
                    list.add(new BookRequest(id, bookId, userId, requestDate, borrowDate, returnDate, status, fineAmount));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public boolean updateBookRequestStatus(int id, String newStatus, Date borrowDate, Date returnDate) throws SQLException {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE book_requests\n"
                           + "SET status = ?, borrow_date = ?, return_date = ?\n"
                           + "WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, newStatus);
                st.setDate(2, borrowDate);
                st.setDate(3, returnDate);
                st.setInt(4, id);
                int rowsAffected = st.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating book request status: " + e.getMessage());
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean updateBookRequestStatusAndFine(int id, String newStatus, double fineAmount) throws SQLException {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE book_requests\n"
                           + "SET status = ?, fine_amount = ?, actual_return_date = GETDATE()\n" // Cập nhật ngày trả thực tế khi có fine
                           + "WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, newStatus);
                st.setDouble(2, fineAmount);
                st.setInt(3, id);
                int rowsAffected = st.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating book request status and fine: " + e.getMessage());
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public BookRequest getBookRequestById(int id) {
        Connection cn = null;
        BookRequest request = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT id, book_id, user_id, request_date, borrow_date, return_date, status, fine_amount, actual_return_date\n"
                           + "FROM book_requests\n"
                           + "WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    int bookId = rs.getInt("book_id");
                    int userId = rs.getInt("user_id");
                    Date requestDate = rs.getDate("request_date");
                    Date borrowDate = rs.getDate("borrow_date");
                    Date returnDate = rs.getDate("return_date");
                    String status = rs.getString("status");
                    double fineAmount = rs.getDouble("fine_amount");
                    Date actualReturnDate = rs.getDate("actual_return_date"); // Make sure this column exists in DB

                    request = new BookRequest(id, bookId, userId, requestDate, borrowDate, returnDate, status, fineAmount);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return request;
    }
    public boolean deleteBookRequestById(int requestId) throws SQLException {
    Connection cn = null;
    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "DELETE FROM book_requests WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, requestId);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (cn != null) {
            cn.close();
        }
    }
    return false;
}
        public ArrayList<BookRequest> getBookRequestsByUserId(int userId) {
        ArrayList<BookRequest> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT id, book_id, user_id, request_date, borrow_date, return_date, status, fine_amount, actual_return_date "
                           + "FROM book_requests "
                           + "WHERE user_id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    int id = table.getInt("id");
                    int bookId = table.getInt("book_id");
                    
                    Date requestDate = table.getDate("request_date");
                    Date borrowDate = table.getDate("borrow_date");
                    Date returnDate = table.getDate("return_date");
                    String status = table.getString("status");
                    double fineAmount = table.getDouble("fine_amount");


                    list.add(new BookRequest(id, bookId, userId, requestDate, borrowDate, returnDate, status, fineAmount));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
         public boolean returnBook(int requestId) throws Exception {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Bước 1: Lấy thông tin yêu cầu mượn sách để lấy book_id
                String getBookIdSql = "SELECT book_id FROM book_requests WHERE id = ?";
                PreparedStatement getBookIdSt = cn.prepareStatement(getBookIdSql);
                getBookIdSt.setInt(1, requestId);
                ResultSet rs = getBookIdSt.executeQuery();
                if (rs.next()) {
                    int bookId = rs.getInt("book_id");

                    // Bước 2: Cập nhật ngày trả sách thực tế và trạng thái của yêu cầu
                    String updateRequestSql = "UPDATE book_requests SET actual_return_date = ?, status = 'Returned' WHERE id = ?";
                    PreparedStatement updateRequestSt = cn.prepareStatement(updateRequestSql);
                    updateRequestSt.setDate(1, Date.valueOf(LocalDate.now()));
                    updateRequestSt.setInt(2, requestId);
                    int rowsUpdated = updateRequestSt.executeUpdate();

                    if (rowsUpdated > 0) {
                        // Bước 3: Tăng số lượng bản sao có sẵn của sách
                        BookDAO bookDAO = new BookDAO();
                        return bookDAO.increaseAvailableCopies(bookId);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }

    }