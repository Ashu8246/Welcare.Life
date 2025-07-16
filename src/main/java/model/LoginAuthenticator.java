package model;

import db.DbProvider;
import dto.DoctorDto;
import dto.PatientDto;
import entities.Admin;
import entities.Doctor;
import entities.Patient;
import org.hibernate.Session;


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
                Patient p = session.find(Patient.class, pid);

                if (password.equals(p.getPassword()))
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
                Admin a = session.find(Admin.class, admin_id);
                if (password.equals(a.getPassword()))
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
                String password = doctor.getPassword();
                Session session = DbProvider.getSession();

                Doctor doctor1 = session.find(Doctor.class, doctor.getD_id());
                if(password.equals(doctor1.getPassword()))
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
