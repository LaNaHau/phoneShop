package ptithcm.dao;

import java.util.List;

import ptithcm.entity.WebActionLogEntity;

public interface WebActionLogDAO {
    void saveLog(WebActionLogEntity log);
    List<WebActionLogEntity> getAllLogs();
    public List<WebActionLogEntity> getLogsBySeverity(String severity);
}
