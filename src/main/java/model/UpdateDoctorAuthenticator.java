package model;

import db.DbProvider;
import entities.Doctor;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UpdateDoctorAuthenticator
{
    Session session = DbProvider.getSession();

    public boolean isAvailability(Doctor doctor)
    {
        String d_id = doctor.getD_id();
        int i=0;
        if(doctor != null)
        {
            try
            {
                Transaction tx = session.beginTransaction();
                Query query = session.createQuery("update doctors d set d.status = case when d.status = 1 then 0 else 1 end where d.d_id = :id");
                query.setParameter("id",d_id);
                i=query.executeUpdate();

                doctor = session.get(Doctor.class, doctor.getD_id());
                session.refresh(doctor);

                tx.commit();


                if(tx.isActive())
                {
                    tx.rollback();
                }
                if(i>0)
                {
                    return true;
                }
            }
            catch(Exception e)
            {
                System.out.println(e);
            }
        }
        return false;
    }

    public boolean isUpdateDetails(Doctor doctor) {
        String d_id = doctor.getD_id();
        String password = doctor.getPassword();
        Transaction tx = session.beginTransaction();
        int i=0;
        if(d_id != null && doctor.getPassword() != null)
        {
            Query query1 = session.createQuery("select password from doctors d where d.d_id = '" + d_id + "'");
            String password1 = (String) query1.uniqueResult();

            System.out.println(password +" = "+password1);

            if (password.equals(password1))
            {
                Query query = session.createQuery("update doctors d set d.fname = :fname,d.lname = :lname,d.qualification = :qualification,d.specialization = :specialization,d.city = :city,d.address = :address where d.d_id = '" + d_id + "'");
                query.setParameter("fname", doctor.getFname());
                query.setParameter("lname", doctor.getLname());
                query.setParameter("qualification", doctor.getQualification());
                query.setParameter("specialization", doctor.getSpecialization());
                query.setParameter("city", doctor.getCity());
                query.setParameter("address", doctor.getAddress());
                i = query.executeUpdate();
                tx.commit();

                if (i > 0)
                {
                    return true;
                }
                return false;
            }
            return false;
        }
        return false;
    }
}
