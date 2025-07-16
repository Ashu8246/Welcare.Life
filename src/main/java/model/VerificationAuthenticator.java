package model;

import db.DbProvider;
import entities.Doctor;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class VerificationAuthenticator
{
    public boolean isVerify(String d_id, String verification)
    {
        if(d_id != null)
        {
            int i = 0;
            try {

                Session session = DbProvider.getSession();
                Transaction tx = session.beginTransaction();

                Query query = session.createQuery("update doctors d set d.verified =:verification where d.d_id = :d_id");
                query.setParameter("verification", verification);
                query.setParameter("d_id", d_id);
                i = query.executeUpdate();
                tx.commit();

                Doctor doctor = session.get(Doctor.class,d_id);
                session.refresh(doctor);

                if (tx.isActive()) {
                    tx.rollback();
                }
            }
            catch (Exception e) {
                System.out.println(e.getMessage());
            }

            if(i>0)
            {
                return true;
            }
            return false;
        }
        return false;
    }
}
