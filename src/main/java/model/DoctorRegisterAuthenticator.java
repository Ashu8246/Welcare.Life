package model;


import db.DbProvider;
import entities.Doctor;
import entities.Patient;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Random;

public class DoctorRegisterAuthenticator
{
    public boolean isRegister(Doctor doctor)
    {
        if(!doctor.getEmail().equals("") && !doctor.getPassword().equals("") && !doctor.getFname().equals("") && !doctor.getLname().equals(""))
        {
            try
            {

                int i = 0;
                Random rand = new Random();
                int randNum = rand.nextInt(1000);

                doctor.setD_id(doctor.getFname()+randNum);

                Session session = DbProvider.getSession();

                Query query = session.createQuery("select fname from doctors where email = '"+doctor.getEmail()+"'");
                Doctor d1 = (Doctor) query.uniqueResult();

                if(d1 != null)
                {
                    return false;
                }

                Transaction tx = session.beginTransaction();
                session.persist(doctor);
                tx.commit();
                if(tx.isActive())
                {
                    tx.rollback();
                }

            }
            catch (Exception ex)
            {
                System.out.println(ex.getMessage());
                return false;
            }
            return true;
        }
        return false;
    }

    public boolean isDetails(Doctor doctor)
    {
        if(!doctor.getPhone().equals("") && !doctor.getDob().equals("") && !doctor.getAddress().equals(""))
        {
            int i =0;
            try
            {
                Session session = DbProvider.getSession();
                Transaction tx = session.beginTransaction();

                Query query = session.createQuery("update doctors d set d.phone = :phone,d.address =:address, d.dob =:dob,d.experience =:experience,d.specialization =:specialization, d.qualification =:qualification,d.city=:city,d.gender=:gender  where d.d_id = :d_id ");
                query.setParameter("phone", doctor.getPhone());
                query.setParameter("address", doctor.getAddress());
                query.setParameter("dob", doctor.getDob());
                query.setParameter("experience", doctor.getExperience());
                query.setParameter("specialization", doctor.getSpecialization());
                query.setParameter("qualification", doctor.getQualification());
                query.setParameter("city", doctor.getCity());
                query.setParameter("gender", doctor.getGender());
                query.setParameter("d_id", doctor.getD_id());

                i =  query.executeUpdate();
                tx.commit();
                if(tx.isActive()) {
                    tx.rollback();
                }

                if(i>0)
                {
                    return true;
                }
            }
            catch(Exception e)
            {
                System.out.println(e.getMessage());
            }
        }
        return false;
    }

}
