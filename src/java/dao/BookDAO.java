/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import mylib.DBUtils;

/**
 *
 * @author user
 */
public class BookDAO {
    public ArrayList<Book>  getBooks(String name){
        ArrayList<Book> list=new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select id,title,author,isbn,category,published_year,total_copies,available_copies,status\n"
                        + "from dbo.books\n"
                        + "where title like ?";
                PreparedStatement st=cn.prepareStatement(sql);
                st.setString(1, "%"+name +"%");
                ResultSet table=st.executeQuery();
                if(table!=null){
                   while(table.next()){
                       int id=table.getInt("id");
                       String title=table.getString("title");
                       String author=table.getString("author");
                       String isbn=table.getString("isbn");
                       String category=table.getString("category");
                       int year=table.getInt("published_year");
                       int totol_copy=table.getInt("total_copies");
                       int available_copy=table.getInt("available_copies");
                       String status=table.getString("status");
                       
                       Book b=new Book(id, title, author, isbn, category, year, totol_copy, available_copy, status);
                       list.add(b);
                   } 
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
    
     public Book  getBook(int id){
        Book b=null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select id,title,author,isbn,category,published_year,total_copies,available_copies,status\n"
                        + "from dbo.books\n"
                        + "where id = ?";
                PreparedStatement st=cn.prepareStatement(sql);
                st.setInt(1,id);
                ResultSet table=st.executeQuery();
                if(table!=null){
                   while(table.next()){                       
                       String title=table.getString("title");
                       String author=table.getString("author");
                       String isbn=table.getString("isbn");
                       String category=table.getString("category");
                       int year=table.getInt("published_year");
                       int totol_copy=table.getInt("total_copies");
                       int available_copy=table.getInt("available_copies");
                       String status=table.getString("status");
                       
                       b=new Book(id, title, author, isbn, category, year, totol_copy, available_copy, status);
                      
                   } 
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

        return b;
    }
     
      public boolean updateAvailableCopies(int bookId, int change) throws SQLException {
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE dbo.books SET available_copies = available_copies + ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, change);
                st.setInt(2, bookId);
                int rowsAffected = st.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating available copies: " + e.getMessage());
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
      public boolean decreaseAvailableCopies(int bookId) throws SQLException {
        return updateAvailableCopies(bookId, -1);
    }
      public boolean increaseAvailableCopies(int bookId) throws SQLException {
    // Tăng số lượng bản sao có sẵn lên 1
    return updateAvailableCopies(bookId, 1);
}
       public ArrayList<Book> getAllBooks() {
        ArrayList<Book> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select id,title,author,isbn,category,published_year,total_copies,available_copies,status\n"
                        + "from dbo.books";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int id = table.getInt("id");
                        String title = table.getString("title");
                        String author = table.getString("author");
                        String isbn = table.getString("isbn"); // Lấy trường isbn
                        String category = table.getString("category");
                        int year = table.getInt("published_year"); // Lấy trường published_year
                        int totalCopies = table.getInt("total_copies");
                        int availableCopies = table.getInt("available_copies");
                        String status = table.getString("status"); // Lấy trường status
                        
                        // Đảm bảo constructor của Book DTO có đủ các trường này
                        list.add(new Book(id, title, author, isbn, category, year, totalCopies, availableCopies, status));
                    }
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
       public boolean addBook(String title, String author, String isbn, String category, int publishedYear, int totalCopies, int availableCopies, String status) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO books (title, author, isbn, category, published_year, total_copies, available_copies, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement pst = cn.prepareStatement(sql)) {
            
            pst.setNString(1, title); // Sử dụng setNString cho dữ liệu có dấu
            pst.setNString(2, author);
            pst.setNString(3, isbn);
            pst.setNString(4, category);
            pst.setInt(5, publishedYear);
            pst.setInt(6, totalCopies);
            pst.setInt(7, availableCopies);
            pst.setNString(8, status);
            
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        }
    }
} 

