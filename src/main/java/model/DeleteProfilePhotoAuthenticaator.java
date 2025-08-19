package model;

import db.DbProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class DeleteProfilePhotoAuthenticaator
{
    public boolean isDelete(String user_id)
    {
        Session session = DbProvider.getSession();
        Transaction tx = session.beginTransaction();

        Query query = session.createQuery("delete from ProfilePics where user_id=:user_id").setParameter("user_id", user_id);
        int delete = query.executeUpdate();
        if(delete > 0)
        {
            return true;
        }
        return false;
    }
}
