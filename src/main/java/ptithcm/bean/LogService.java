package ptithcm.bean;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class LogService {

    // Use the SLF4J Logger, not your custom Logger class
    private static final Logger logger = LoggerFactory.getLogger(LogService.class);

    // Ghi log khi hành vi đáng ngờ (ví dụ: đăng nhập sai quá nhiều lần)
    public void logSuspiciousActivity(String userName, String activity) {
        logger.warn("Hành vi đáng ngờ phát hiện: Tài khoản: {}, Hoạt động: {}", userName, activity);
    }

    // Ghi log khi tài khoản bị khóa nhưng cố gắng đăng nhập
    public void logAccountLockedAttempt(String userName) {
        logger.warn("Tài khoản bị khóa đã cố gắng đăng nhập: {}", userName);
    }

    // Ghi log khi đăng nhập sai quá nhiều lần
    public void logMultipleFailedLoginAttempts(String userName, int failedAttempts) {
        logger.warn("Tài khoản: {} đã thử đăng nhập sai {} lần", userName, failedAttempts);
    }

    // Ghi log khi quyền truy cập không hợp lệ (ví dụ: truy cập trang quản trị mà không phải admin)
    public void logUnauthorizedAccess(String userName, String url) {
        logger.warn("Tài khoản: {} đã cố gắng truy cập vào trang không có quyền: {}", userName, url);
    }

    // Ghi log khi có sự cố hệ thống
    public void logSystemError(String message, Exception e) {
        logger.error("Lỗi hệ thống: {}", message, e);
    }
}
