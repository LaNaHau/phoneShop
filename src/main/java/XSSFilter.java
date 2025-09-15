import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class XSSFilter implements Filter{
	@Override
	public void init(FilterConfig filterConfig) throws ServletException{
		
	}
	
	@Override
	public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain) throws IOException,ServletException{
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // Create a wrapped request that sanitizes the parameters
        XSSRequestWrapper wrappedRequest = new XSSRequestWrapper(httpRequest);
        // Continue the request-response chain with the sanitized request
        chain.doFilter(wrappedRequest, httpResponse);
	}
	
	@Override
    public void destroy() {
        // Optional: Cleanup if needed
    }
	
	// Utility function to escape potentially dangerous characters
    public static String sanitize(String input) {
        if (input == null) return null;
        return input.replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("&", "&amp;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#x27;")
                    .replaceAll("script", "");  // Block "script" tag (optional)
    }
}
