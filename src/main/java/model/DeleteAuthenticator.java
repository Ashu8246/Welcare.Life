package model;

import db.DbProvider;
import dto.DeleteDto;
import entities.Doctor;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class DeleteAuthenticator
{
    public boolean isDeleteDocByAdmin(DeleteDto deleteDto)
    {
        Session session = DbProvider.getSession();
        Transaction tx = session.beginTransaction();

        Query query = session.createQuery("select password from admins where admin_id=:admin_id");
        query.setParameter("admin_id", deleteDto.getAdmin_id());
        String password = (String) query.uniqueResult();

        if(password.equals(deleteDto.getPassword()))
        {
            Doctor doctor = session.get(Doctor.class,deleteDto.getD_id());
            session.remove(doctor);
            return true;
        }
        return false;
    }
}
