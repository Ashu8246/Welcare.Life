package dto;

public class DeleteDto
{
    private String admin_id;
    private String pid;
    private String d_id;
    private String password;
    private String _for;

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getD_id() {
        return d_id;
    }

    public void setD_id(String d_id) {
        this.d_id = d_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String get_for() {
        return _for;
    }

    public void set_for(String _for) {
        this._for = _for;
    }
}
