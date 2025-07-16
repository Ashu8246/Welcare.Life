package db;

import entities.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author ashug
 */
public class DbProvider
{
    static SessionFactory sf = null ;
    static Session session = null;
    static
    {
        try
        {
            sf = new Configuration()
                    .configure()
                    .addAnnotatedClass(Patient.class)
                    .addAnnotatedClass(Doctor.class)
                    .addAnnotatedClass(ContactUs.class)
                    .addAnnotatedClass(Appointment.class)
                    .addAnnotatedClass(Admin.class)
                    .addAnnotatedClass(ProfilePics.class)
                    .buildSessionFactory();
            session = sf.openSession();
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        System.out.println("Connection stablized...:)");
        if(session == null)
        {
            System.out.println("Session is null");
        }
    }
    public static Session getSession()
    {
        return session;
    }
}
