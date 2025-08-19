package controllers;

import dao.BookDAO;
import dao.BookRequestDAO;
import dto.Book;
import dto.User; // Assuming you have a User DTO for session management
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(name = "BorrowController", urlPatterns = {"/borrow"})
public class BorrowController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "productIndex.jsp"; // Default redirect
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user"); // Get logged-in user from session

            if (user == null) {
                // User is not logged in, redirect to login page or show an error
                request.setAttribute("ERROR_MESSAGE", "Please log in to borrow books.");
                url = "Login.jsp"; // Or wherever your login page is
            } else {
                int bookId = Integer.parseInt(request.getParameter("txtid"));
                BookDAO bookDAO = new BookDAO();
                Book book = bookDAO.getBook(bookId); // Get book details

                if (book != null && book.getAvailable_copies() > 0) {
                    BookRequestDAO bookRequestDAO = new BookRequestDAO();
                    boolean success = bookRequestDAO.createBookRequest(bookId, user.getId()); // Assuming getUserId() exists

                    if (success) {

                        request.setAttribute("SUCCESS_MESSAGE", "Borrow request for '" + book.getTitle() + "' submitted successfully! Waiting for admin approval.");
                    } else {
                        request.setAttribute("ERROR_MESSAGE", "Failed to submit borrow request for '" + book.getTitle() + "'. Please try again.");
                    }
                } else {
                    request.setAttribute("ERROR_MESSAGE", "Book not found or no copies available for borrowing.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("ERROR_MESSAGE", "Invalid book ID.");
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("ERROR_MESSAGE", "An unexpected error occurred.");
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}