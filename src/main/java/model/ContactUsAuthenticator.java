package model;

import db.DbProvider;
import entities.ContactUs;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ContactUsAuthenticator
{
    public boolean isContactUs(ContactUs contactUs)
    {
        Session session = DbProvider.getSession();
        Transaction tx = session.beginTransaction();

        session.persist(contactUs);
        tx.commit();
        System.out.println(contactUs);
        if(tx.isActive())
        {
            tx.rollback();
            return true;
        }
        return false;
    }
}
