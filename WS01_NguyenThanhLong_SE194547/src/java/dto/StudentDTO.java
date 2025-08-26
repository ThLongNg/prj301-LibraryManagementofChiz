package dto;


import java.io.Serializable;

public class StudentDTO implements Serializable {
    private int id;
    private String username;
    private String firstName;
    private String lastName;
    private String password;

    // Constructors
    public StudentDTO() {
    }

    public StudentDTO(int id, String username, String firstName, String lastName, String password) {
        this.id = id;
        this.username= username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password=password;
    }
     // Getters and Setters

public StudentDTO(int id, String firstName, String lastName) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    public String getUsername() {
        return username;
    }
   
    public void setUsername(String username) {    
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
}