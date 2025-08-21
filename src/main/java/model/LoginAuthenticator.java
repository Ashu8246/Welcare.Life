package model;

import db.DbProvider;
import dto.DoctorDto;
import dto.PatientDto;
import entities.Admin;
import entities.Doctor;
import entities.Patient;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


public class LoginAuthenticator
{

    public boolean isPatient(PatientDto patient)
    {
        if(patient.getPid() != null  && patient.getPassword() != null)
        {
            try {
                String pid = patient.getPid();
                String password = patient.getPassword();

                Session session = DbProvider.getSession();
                Query query = session.createQuery("select password from patients where p_id=:pid").setParameter("pid", pid);
                String tablePassword = query.getSingleResult().toString();

                if (password.equals(tablePassword))
                {
                    return true;
                }
                return false;
            }
            catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
        return false;
    }

    public boolean isAdmin(Admin admin)
    {
        if(admin.getAdmin_id() != null  && admin.getPassword() != null)
        {
            try {
                String admin_id = admin.getAdmin_id();
                String password = admin.getPassword();

                Session session = DbProvider.getSession();
                Query query = session.createQuery("select password from admins where admin_id=:admin_id").setParameter("admin_id", admin_id);
                String tablePassword = query.getSingleResult().toString();

                if (password.equals(tablePassword))
                {
                    return true;
                }
                return false;
            }
            catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
        return false;
    }

    public boolean isDoctor(DoctorDto doctor)
    {
        if(doctor.getD_id() != null && doctor.getPassword() != null)
        {
            try
            {
                String doctor_id = doctor.getD_id();
                String password = doctor.getPassword();

                Session session = DbProvider.getSession();
                Query query = session.createQuery("select password from doctors where d_id=:did").setParameter("d_id", doctor_id);
                String tablePassword = query.getSingleResult().toString();

                if(password.equals(tablePassword))
                {
                    return true;
                }
                return false;
            }
            catch(Exception ex)
            {
                System.out.println(ex.getMessage());
            }
        }
        return false;
    }
}
