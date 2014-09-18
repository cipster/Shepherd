package projectManager.repository;

import javax.persistence.*;

@Entity
@Table(name = "roles", schema = "", catalog = "proiecte")
public class Roles {
    private int idRole;
    private String role;

    @Id
    @Column(name = "idRole")
    public int getIdRole() {
        return idRole;
    }

    public void setIdRole(int idRole) {
        this.idRole = idRole;
    }

    @Basic
    @Column(name = "role")
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Roles that = (Roles) o;

        if (idRole != that.idRole) return false;
        if (role != null ? !role.equals(that.role) : that.role != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idRole;
        result = 31 * result + (role != null ? role.hashCode() : 0);
        return result;
    }
}
