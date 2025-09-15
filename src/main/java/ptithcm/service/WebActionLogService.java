package ptithcm.service;

import java.util.List;

import ptithcm.entity.WebActionLogEntity;

public interface WebActionLogService {
    void logAction(String actionType, String actionDetails, String userName, String ipAddress, String userAgent, String severityLevel);
    List<WebActionLogEntity> getLogsBySeverity(String severity);
    List<WebActionLogEntity> getLogs();
}