/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import mylib.DBUtils;

/**
 *
 * @author user
 */
public class UserDAO {

    public User getUserByEmail(String email){
        User result=null;
        Connection cn=null;
        try {
            //bc1: ket noi app voi sqlserver
            cn=DBUtils.getConnection();
            if(cn!=null){
                //bc 2: viet query va execute query
                String sql = "select [id],username,email,password,role,status,avatar\n"
                        + "from dbo.users\n"
                        + "where email='"+email+"'";
                Statement st=cn.createStatement();
                
                ResultSet table=st.executeQuery(sql);
                if(table!=null && table.next()){
                    //bc3: doc noi dung trong bien table
                    int id=table.getInt("id");
                    String username=table.getString("username");
                    //String email=table.getString("email");
                    String password=table.getString("password");
                    String role=table.getString("role");
                    String status=table.getString("status");
                    String avatar = table.getString("avatar");
                    result=new User(id, username, email, password, role, status,avatar);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
               if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }   
    public int insertNewUser(String username,String email, String password, String role, String avatar){
        int result=0;
         Connection cn=null;
        try {
            //bc1: ket noi app voi sqlserver
            cn=DBUtils.getConnection();
            if(cn!=null){
                String sql = "INSERT INTO Users (username, email, password, role, avatar) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st=cn.prepareStatement(sql);
                st.setString(1, username);// so 1 la vi tri cua ? dau tien
                st.setString(2, email);
                st.setString(3, password);
                st.setString(4, role);
                st.setString(5, avatar);
        //DEBUG SIGN UP
        System.out.println(">>> SQL PARAMS:");
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("Avatar: " + avatar);

                result =st.executeUpdate();
                
            }
        } catch (Exception e) {
            System.err.println(">>> SQL Exception: " + e.getMessage());
            e.printStackTrace();
        }
        finally{
            try {
               if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    public User getUser(String email, String password){
        User result=null;
        Connection cn=null;
        try {
            //bc1: ket noi app voi sqlserver
            cn=DBUtils.getConnection();
            if(cn!=null){
                //bc 2: viet query va execute query
                String sql = "select [id],username,email,password,role,status,avatar\n"
                        + "from dbo.users\n"
                        + "where email=? and password=?  COLLATE Latin1_General_CS_AS ";
                PreparedStatement st=cn.prepareStatement(sql);
                st.setString(1, email);
                st.setString(2, password);
                ResultSet table=st.executeQuery();
                if(table!=null && table.next()){
                    //bc3: doc noi dung trong bien table
                    int id=table.getInt("id");
                    String username=table.getString("username");
                    //String email=table.getString("email");
                    //String password=table.getString("password");
                    String role=table.getString("role");
                    String status=table.getString("status");
                    String avatar = table.getString("avatar");
                    result=new User(id, username, email, password, role, status, avatar);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
               if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    } 
    public int UpdateUser(int id, String username, String password, String role,String avatar) {
    int result = 0;
    String sql = "UPDATE Users SET username = ?, password = ?, role = ?, avatar = ? WHERE id = ?";
    
    try (
        Connection con = DBUtils.getConnection(); 
        PreparedStatement pst = con.prepareStatement(sql)
    ) {
        
        pst.setString(1, username);
        pst.setString(2, password);
        pst.setString(4, avatar);
        pst.setString(3, role);
        pst.setInt(5, id);
        result = pst.executeUpdate(); // trả về số dòng bị ảnh hưởng
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return result;
}
    public User getUserByLoginInfoAndPassword(String loginInfo, String password) {
    User user = null;
    // Sử dụng try-with-resources để đảm bảo Connection, PreparedStatement, ResultSet được đóng tự động
    try (Connection cn = DBUtils.getConnection();
         PreparedStatement ps = cn.prepareStatement("SELECT * FROM Users WHERE (username = ? OR email = ?) AND password = ?")) {
        if (cn != null) { 
            ps.setString(1, loginInfo);
            ps.setString(2, loginInfo);
            ps.setString(3, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setName(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setAvatar(rs.getString("avatar"));
                }
            }
        }
    } catch (Exception e) { // Bắt tất cả các ngoại lệ, bao gồm SQLException từ DBUtils.getConnection()
        e.printStackTrace(); // In stack trace để debug
    }
    return user;
}
    public ArrayList<User> getAllUsers() throws SQLException, ClassNotFoundException {
        ArrayList<User> userList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "SELECT id,username, email, password, role, status, avatar FROM Users";
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    int id=rs.getInt("id");
                    String username = rs.getString("username");
                    String email = rs.getString("email");
                    String password = rs.getString("password");
                    String role = rs.getString("role");
                    String status = rs.getString("status");
                    String avatar = rs.getString("avatar");
                    
                    
                    userList.add(new User(id, username, email, password, role, status, avatar));
                }
            }
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
        return userList;
    }

    // Phương thức cập nhật thông tin người dùng (cho admin)
    public boolean updateUserByAdmin(int id, String newUserName, String newRole) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "UPDATE Users SET username = ?, role = ? WHERE id = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, newUserName);
                pst.setString(2, newRole);
                pst.setInt(3, id); 
                int rowsAffected = pst.executeUpdate();
                return rowsAffected > 0;
            }
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }


    // Phương thức xóa người dùng
    public boolean deleteUser(int id) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "DELETE FROM Users WHERE id = ?";
                pst = con.prepareStatement(sql);
                pst.setInt(1,id);
                int rowsAffected = pst.executeUpdate();
                return rowsAffected > 0;
            }
        } finally {
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
        return false;
    }

// Phuong thuc login Google
public boolean newGoogleUser(User user) throws SQLException, ClassNotFoundException {
    Connection cn = null;
    PreparedStatement st = null;
    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "INSERT INTO Users (username, password, email, role, status, avatar) VALUES (?, ?, ?, ?, ?, ?)";
            st = cn.prepareStatement(sql);
            st.setString(1, user.getName());
            st.setString(2, user.getPassword()); // Thêm dòng này để gán giá trị cho cột password
            st.setString(3, user.getEmail());
            st.setString(4, user.getRole());
            st.setString(5, user.getStatus());
            st.setString(6, user.getAvatar());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    } finally {
        if (st != null) st.close();
        if (cn != null) cn.close();
    }
    return false;
}
public boolean updateGoogleUser(User user) throws SQLException, ClassNotFoundException {
    Connection cn = null;
    PreparedStatement st = null;
    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "UPDATE Users SET username = ?,password = ?, avatar = ?, status = ? WHERE email = ?";
            st = cn.prepareStatement(sql);
            
            st.setString(1, user.getName());
            st.setString(2, user.getPassword());
            st.setString(3, user.getAvatar());
            st.setString(4, user.getStatus());
            st.setString(5, user.getEmail());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    } finally {
        if (st != null) st.close();
        if (cn != null) cn.close();
    }
    return false;
}
}
