package dao;

import dto.StudentDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import pe.utils.DbUtils;

public class StudentDAO {

    public StudentDTO checkLogin(String username, String password) {
        String sql = "SELECT id, username, firstName, lastName, password FROM dbo.Students WHERE username=? AND password=?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new StudentDTO(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("password")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStudent(StudentDTO student) throws Exception {
        String sql = "UPDATE Students SET firstName = ?, lastName = ? WHERE id = ?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, student.getFirstName());
            ps.setString(2, student.getLastName());
            ps.setInt(3, student.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public StudentDTO getStudentById(int id) throws Exception {
        String sql = "SELECT id, firstName, lastName FROM Students WHERE id = ?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new StudentDTO(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName"));
                }
            }
        }
        return null;
    }

    public List<StudentDTO> searchByLastName(String lastName) throws Exception {
        List<StudentDTO> list = new ArrayList<>();
        String sql = "SELECT id, firstName, lastName FROM Students WHERE lastName LIKE ?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + lastName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new StudentDTO(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName")));
                }
            }
        }
        return list;
    }

    public boolean deleteStudent(int id) throws Exception {
        String sql = "DELETE FROM Students WHERE id = ?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public StudentDTO getStudentByUsername(String username) throws Exception {
        String sql = "SELECT id, username, firstName, lastName, password FROM Students WHERE username = ?";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new StudentDTO(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("password")
                    );
                }
            }
        }
        return null;
    }
    public void newStudent(StudentDTO student) throws Exception {
        String sql = "INSERT INTO Students (username, firstName, lastName, password) VALUES (?, ?, ?, ?)";
        try (Connection con = DbUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, student.getUsername());
            ps.setString(2, student.getFirstName());
            ps.setString(3, student.getLastName());
            ps.setString(4, student.getPassword());
            ps.executeUpdate();
        }
    }
}
