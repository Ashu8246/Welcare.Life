package model;

import db.DbProvider;
import entities.ProfilePics;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UpdateProfilePhotoAuthenticator
{
    public boolean isprofilepic(ProfilePics profilepic)
    {
        if(profilepic != null)
        {
            Session session = DbProvider.getSession();
            Transaction tx = session.beginTransaction();
            ProfilePics profile = session.get(ProfilePics.class,profilepic.getUser_id());
            if(profile == null)
            {
                session.persist(profilepic);
                tx.commit();
            }
            else {
                Query query = session.createQuery("update ProfilePics p set p.profilePic = :profilepic  where p.user_id = :user_id");
                query.setParameter("profilepic",profilepic.getProfilePic());
                query.setParameter("user_id",profilepic.getUser_id());
                query.executeUpdate();
                tx.commit();
            }
            return true;
        }
        return false;
    }
}
