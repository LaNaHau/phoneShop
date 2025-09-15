package ptithcm.datasource;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import ptithcm.entity.UserContextHolder;

public class CustomRoutingDataSource  extends AbstractRoutingDataSource {

    @Override
    protected Object determineCurrentLookupKey() {
        // Lấy HttpServletRequest từ RequestContextHolder
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attributes == null) {
            System.out.println("No current request available");
            return "guest"; // Giá trị mặc định nếu không có request
        }
        
        HttpServletRequest request = attributes.getRequest();
        String userRole = (String) request.getSession().getAttribute("USER_ROLE");
        System.out.println("Current role: " + userRole);
        return userRole != null ? userRole : "guest"; // Giá trị mặc định nếu null
    }

}
