package model;

import db.DbProvider;
import entities.Appointment;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class AppointmentAuthenticator
{
    public boolean isAppoint(Appointment appoint)
    {
        if(appoint.getPname() != null && appoint.getD_id() != null && appoint.getDate() != null && appoint.getTime() != null)
        {
            Session session = DbProvider.getSession();
            Transaction tx = session.beginTransaction();
            session.persist(appoint);
            tx.commit();
            if(tx.isActive())
            {
                tx.rollback();
            }
            return true;
        }
        return false;
    }

    public boolean isStatus(Appointment appoint)
    {
        if(appoint.getStatus() != null) {
            int i = 0;
            try {
                Session session = DbProvider.getSession();
                Transaction tx = session.beginTransaction();
                Query query = session.createQuery("update appointments set status =:status where reason_id =:reason_id");
                query.setParameter("status", appoint.getStatus());
                query.setParameter("reason_id", appoint.getReason_id());
                i = query.executeUpdate();
                appoint = session.get(Appointment.class, appoint.getReason_id());
                session.refresh(appoint);
                tx.commit();
                if (i > 0) {
                    if (tx.isActive()) {
                        tx.rollback();
                    }
                    return true;
                }
            }
            catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            return false;
        }
        return false;
    }
}
