package ptithcm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ptithcm.dao.WebActionLogDAO;
import ptithcm.entity.WebActionLogEntity;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class WebActionLogServiceImpl implements WebActionLogService {

    @Autowired
    private WebActionLogDAO logDAO;
    @Override
    public void logAction(String actionType, String actionDetails, String userName, String ipAddress, String userAgent, String severityLevel) {
        WebActionLogEntity log = new WebActionLogEntity();
        log.setActionType(actionType);
        log.setActionDetails(actionDetails);
        log.setActionTime(new Date());
        log.setUserName(userName);
        log.setIpAddress(ipAddress);
        log.setUserAgent(userAgent);
        log.setSeverityLevel(severityLevel);
        logDAO.saveLog(log);
    }

    @Override
    public List<WebActionLogEntity> getLogsBySeverity(String severity) {
        return logDAO.getLogsBySeverity(severity);
    }

    @Override
    public List<WebActionLogEntity> getLogs() {
        return logDAO.getAllLogs();
    }
}
