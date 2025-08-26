<%-- 
    Document   : ViewSearchBook
    Created on : May 31, 2025, 4:05:48 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.util.ArrayList" %>
<%@page import="dto.Book" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="css/style.css" rel="stylesheet">
         
    </head>
    <body>
        <%
        //doc RESULT trong request dc tao boi SearchBookController
            ArrayList<Book> list=(ArrayList<Book>) request.getAttribute("RESULT");
           
            //xuat ket qua tim kiem(list)
            if(list!=null && !list.isEmpty()){
                for (Book book : list) {
                    out.print("<div style='float:left;margin:1%'>");
                    out.print("<form>");
                    out.print("<img src='"+ book.getUrl() +"'   />");
                    out.print("<br/>id:" + book.getId());
                    out.print("<br/>title:" + book.getTitle());
                    out.print("<br/>category:" + book.getCategory());
                    out.print("<br/>available copy:" + book.getAvailable_copies());
                    if(book.getAvailable_copies()>0){
                        out.print("<br/><input type='submit' value='request borrow' /> ");
                    }
                    out.print("</form>");
                    out.print("</div>");
                }
            }
            else{
                out.print("<h3>not found</h3>");
                out.print("<a href='index.html'>home</a>");
            }
        %>
    </body>
</html>
