package ptithcm.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "WEBACTIONLOG")
public class WebActionLogEntity {

    public WebActionLogEntity() {
		super();
	}

	public WebActionLogEntity(Integer logID, String actionType, String actionDetails, Date actionTime, String userName,
			String ipAddress, String userAgent, String severityLevel) {
		super();
		this.logID = logID;
		this.actionType = actionType;
		this.actionDetails = actionDetails;
		this.actionTime = actionTime;
		this.userName = userName;
		this.ipAddress = ipAddress;
		this.userAgent = userAgent;
		this.severityLevel = severityLevel;
	}

	public Integer getLogID() {
		return logID;
	}

	public void setLogID(Integer logID) {
		this.logID = logID;
	}

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public String getActionDetails() {
		return actionDetails;
	}

	public void setActionDetails(String actionDetails) {
		this.actionDetails = actionDetails;
	}

	public Date getActionTime() {
		return actionTime;
	}

	public void setActionTime(Date actionTime) {
		this.actionTime = actionTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getSeverityLevel() {
		return severityLevel;
	}

	public void setSeverityLevel(String severityLevel) {
		this.severityLevel = severityLevel;
	}

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer logID;

    private String actionType;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String actionDetails;

    @Temporal(TemporalType.TIMESTAMP)
    private Date actionTime;

    private String userName;

    private String ipAddress;

    private String userAgent;

    private String severityLevel;

    // Getters and setters...
}
