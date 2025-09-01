package dao;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Refund;
import dto.Book; // Keep this import as it's used in insertBorrowRequest method signature
import dto.BookRequest;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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

public ArrayList<BookRequest> getAllBookRequests() {
        ArrayList<BookRequest> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Thêm payment_status và transaction_id vào câu lệnh SELECT
                String sql = "SELECT id, book_id, user_id, request_date, borrow_date, return_date, status, fine_amount, actual_return_date, payment_status, transaction_id FROM book_requests";
                           
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    int id = table.getInt("id");
                    int bookId = table.getInt("book_id");
                    int userId = table.getInt("user_id");
                    Date requestDate = table.getDate("request_date");
                    Date borrowDate = table.getDate("borrow_date");
                    Date returnDate = table.getDate("return_date");
                    String status = table.getString("status");
                    double fineAmount = table.getDouble("fine_amount");
                    String paymentStatus = table.getString("payment_status");
                    String transactionId = table.getString("transaction_id");
                    
                    // Sử dụng constructor mới
                    BookRequest request = new BookRequest(id, bookId, userId, requestDate, borrowDate, returnDate, status, fineAmount, paymentStatus, transactionId);
                    list.add(request);
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

 public BookRequest getBookRequestById(int id) {
        Connection cn = null;
        BookRequest request = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Thêm payment_status và transaction_id vào câu lệnh SELECT
                String sql = "SELECT id, book_id, user_id, request_date, borrow_date, return_date, status, fine_amount, actual_return_date, payment_status, transaction_id FROM book_requests WHERE id = ?";
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
                    Date actualReturnDate = rs.getDate("actual_return_date");
                    String paymentStatus = rs.getString("payment_status");
                    String transactionId = rs.getString("transaction_id");

                    request = new BookRequest(id, bookId, userId, requestDate, borrowDate, returnDate, status, fineAmount);
                    request.setPaymentStatus(paymentStatus);
                    request.setTransactionId(transactionId);
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
          public int createBookRequestWithPaymentInfo(int bookId, int userId) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO book_requests (user_id, book_id, request_date, status, payment_status) VALUES (?, ?, ?, ?, ?)";
        int id = -1;
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement pst = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, userId);
            pst.setInt(2, bookId);
            pst.setDate(3, new Date(System.currentTimeMillis())); // Ngày hiện tại
            pst.setString(4, "Pending"); // Trạng thái mặc định
            pst.setString(5, "Unpaid"); // Trạng thái thanh toán ban đầu
            
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pst.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        id = generatedKeys.getInt(1);
                    }
                }
            }
        }
        return id;
    }

    // Thêm phương thức mới để cập nhật trạng thái thanh toán và lưu Transaction ID
    public boolean updatePaymentStatus(int requestId, String newPaymentStatus, String transactionId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE book_requests SET payment_status = ?, transaction_id = ? WHERE id = ?";
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement pst = cn.prepareStatement(sql)) {
            
            pst.setString(1, newPaymentStatus);
            pst.setString(2, transactionId);
            pst.setInt(3, requestId);
            
            return pst.executeUpdate() > 0;
        }
    }
        public boolean refundBookRequestWithStripe(int requestId, String transactionId, double refundAmount) throws SQLException, ClassNotFoundException, StripeException {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            cn.setAutoCommit(false); // Bắt đầu một giao dịch
            
            // 1. Gọi API của Stripe để hoàn tiền
            Stripe.apiKey = "sk_test_51S0xg5HmOs8sEpKXlImB9LemyeFS4zSFT2RZIFRRRqWVSUPMva1nHwtH4PeVLpdHT4EeO6Le53we9GhaqMr77OKQ00WC6xO9YS"; // Đặt khóa API của bạn ở đây
            Map<String, Object> params = new HashMap<>();
            params.put("charge", transactionId);
            long amountToRefund = (long) refundAmount;
            params.put("amount", amountToRefund); 
            Refund refund = Refund.create(params);
            
            // 2. Nếu hoàn tiền thành công trên Stripe, cập nhật cơ sở dữ liệu
            if ("succeeded".equals(refund.getStatus())) {
                String sql = "UPDATE book_requests SET status = 'Refunded', payment_status = 'Refunded' WHERE id = ?";
                try (PreparedStatement pst = cn.prepareStatement(sql)) {
                    pst.setInt(1, requestId);
                    int rowsAffected = pst.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        cn.commit(); 
                        return true;
                    } else {
                        cn.rollback(); 
                        return false;
                    }
                }
            } else {
                
                cn.rollback();
                return false;
            }
        } catch (StripeException | SQLException e) {
            if (cn != null) {
                try {
                    cn.rollback(); // Hoàn tác nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e; // Ném lại ngoại lệ để controller xử lý
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
// File: dao/BookRequestDAO.java
// Sửa đổi phương thức này trong BookRequestDAO của bạn
public ArrayList<BookRequest> getBookRequestsByUserId(int userId) throws SQLException, ClassNotFoundException {
    ArrayList<BookRequest> list = new ArrayList<>();
    String sql = "SELECT r.id, r.book_id, r.user_id, r.request_date, r.borrow_date, r.return_date, r.status, r.fine_amount, b.title AS book_title " +
                 "FROM book_requests r " +
                 "JOIN books b ON r.book_id = b.id " +
                 "WHERE r.user_id = ?";

    try (Connection cn = mylib.DBUtils.getConnection();
         PreparedStatement pst = cn.prepareStatement(sql)) {

        pst.setInt(1, userId);

        try (ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                // Tạo đối tượng BookRequest mới với tên sách
                list.add(new BookRequest(
                    rs.getInt("id"),
                    rs.getInt("book_id"),
                    rs.getInt("user_id"),
                    rs.getDate("request_date"),
                    rs.getDate("borrow_date"),
                    rs.getDate("return_date"),
                    rs.getString("status"),
                    rs.getDouble("fine_amount"),
                    rs.getString("book_title") // Lấy tên sách từ ResultSet
                ));
            }
        }
    }
    return list;
}
    }