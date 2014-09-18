package projectManager.repository;

import javax.persistence.*;

@Entity
@Table(name = "user_roles", schema = "", catalog = "proiecte")
public class UserRoles {

    private int userRoleId;
    private String role;
    private String username;

    @Id
    @Column(name = "user_role_id", nullable = false, insertable = true, updatable = true)
    public int getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    @Basic
    @Column(name = "role", nullable = false, insertable = true, updatable = true, length = 45)
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(o == null || getClass() != o.getClass()) return false;

        UserRoles userRoles = (UserRoles) o;

        if(userRoleId != userRoles.userRoleId) return false;
        if(role != null ? !role.equals(userRoles.role) : userRoles.role != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userRoleId;
        result = 31 * result + (role != null ? role.hashCode() : 0);
        return result;
    }
}
