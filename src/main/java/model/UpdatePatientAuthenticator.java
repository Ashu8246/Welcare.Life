package model;

import db.DbProvider;
import entities.Patient;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UpdatePatientAuthenticator
{
    public boolean isUpdate(Patient patient)
    {
        if (patient != null)
        {
            String pid = patient.getPid();
            String password = patient.getPassword();
            try {
                Session session = DbProvider.getSession();
                if(pid != null && password != null)
                {
                    Query query = session.createQuery("select password from patients WHERE p_id = :pid");
                    query.setParameter("pid", pid);
                    String tablePassword = (String) query.getSingleResult();

                    if(password.equals(tablePassword))
                    {
                        Transaction tx = session.beginTransaction();
                        String hql = "UPDATE patients p SET " +
                                "p.fname = :fname, " +
                                "p.lname = :lname, " +
                                "p.city = :city, " +
                                "p.dob = :dob, " +
                                "p.email = :email, " +
                                "p.gender = :gender, " +
                                "p.address = :address, " +
                                "p.phone = :phone, " +
                                "p.bloodgroup = :bloodgroup " +
                                "WHERE p.p_id = :p_id";

                        Query query2 = session.createQuery(hql);
                        query2.setParameter("p_id", pid);
                        query2.setParameter("fname", patient.getFname());
                        query2.setParameter("lname", patient.getLname());
                        query2.setParameter("city", patient.getCity());
                        query2.setParameter("dob", patient.getDob());
                        query2.setParameter("email", patient.getEmail());
                        query2.setParameter("gender", patient.getGender());
                        query2.setParameter("address", patient.getAddress());
                        query2.setParameter("phone", patient.getPhone());
                        query2.setParameter("bloodgroup", patient.getBloodgroup());
                        int updated = query2.executeUpdate();
                        tx.commit();

                        if(updated > 0)
                        {
                            return true;
                        }
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            catch (Exception e) {
                System.out.println(e);
            }
        }
        return false;
    }
}
