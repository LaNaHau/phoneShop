package ptithcm.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptithcm.entity.WebActionLogEntity;

@Repository
public class WebActionLogDAOImpl implements WebActionLogDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<WebActionLogEntity> getLogsBySeverity(String severity) {
        String hql = "FROM WebActionLogEntity log WHERE log.severityLevel LIKE :severity";
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery(hql);
        query.setParameter("severity", "%" + severity + "%");
        return query.list();
    }

    @Override
    public void saveLog(WebActionLogEntity log) {
        sessionFactory.getCurrentSession().save(log);
    }

    @Override
    public List<WebActionLogEntity> getAllLogs() {
        String hql = "FROM WebActionLogEntity";
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery(hql);
        return query.list();
    }
}


