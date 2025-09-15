package ptithcm.entity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class UserContextHolder {
    public static void setUserRole(HttpServletRequest request, String role) {
        HttpSession session = request.getSession();
        session.setAttribute("USER_ROLE", role);
    }

    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (String) session.getAttribute("USER_ROLE") : "guest";
    }

    public static void clear(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("USER_ROLE");
        }
    }
}
