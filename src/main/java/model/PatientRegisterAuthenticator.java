package model;

import db.DbProvider;
import dto.PatientDto;
import entities.Patient;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Random;


public class PatientRegisterAuthenticator
{
    public boolean isRegister(Patient patient)
    {
        if(!patient.getFname().isEmpty() && !patient.getLname().isEmpty() && !patient.getPassword().isEmpty() && !patient.getEmail().isEmpty())
        {
            try
            {

                int i = 0;
                Random rand = new Random();
                int randNum = rand.nextInt(1000);

                patient.setPid(patient.getFname() + randNum);

                Session session = DbProvider.getSession();

                Query query = session.createQuery("select fname from patients where email = '"+patient.getEmail()+"'");
                Patient p1 = (Patient) query.uniqueResult();

                if(p1 != null)
                {
                    return false;
                }

                Transaction tx = session.beginTransaction();

                session.persist(patient);

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


    public boolean isDetails(Patient patient)
    {
        if(!patient.getPid().equals("") && !patient.getGender().equals("") && !patient.getBloodgroup().equals("") && !patient.getDob().equals("") && !patient.getPhone().equals(""))
        {
            int i =0;
            try
            {
                Session session = DbProvider.getSession();
                Transaction tx = session.beginTransaction();

                Query query = session.createQuery("update patients p set p.gender = :gender,p.bloodgroup = :bloodgroup, p.phone = :phone, p.city = :city, p.dob = :dob, p.address = :address where p.p_id = :p_id");
                query.setParameter("gender", patient.getGender());
                query.setParameter("bloodgroup", patient.getBloodgroup());
                query.setParameter("phone", patient.getPhone());
                query.setParameter("city", patient.getCity());
                query.setParameter("dob", patient.getDob());
                query.setParameter("address", patient.getAddress());
                query.setParameter("p_id", patient.getPid());

                i =  query.executeUpdate();
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
                System.out.println(e.getMessage());
            }
        }
        return false;
    }
}
