package projectManager.repository.dao.jdbc;

import com.mysql.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import projectManager.repository.Roles;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


public class RolesDAOImpl extends JdbcDaoSupport implements projectManager.repository.dao.RolesDAO {

    String ROLE = "SELECT * FROM roles ORDER BY role ASC";
    String FIND_ROLE_BY_ID = "SELECT * FROM roles WHERE id_role=?";
    String DELETE_ROLE = "DELETE FROM roles where id_role=?";
    String INSERT_INTO_ROLES = "INSERT INTO roles(id_role, role) VALUES(?,?)";

    private RowMapper<Roles> rolesParameterizedRowMapper = new RowMapper<Roles>() {
        @Override
        public Roles mapRow(ResultSet rs, int rowNum) throws SQLException {
            Roles roles = new Roles();

            roles.setIdRole(rs.getInt("id_role"));
            roles.setRole(rs.getString("role"));
            roles.setRoleValue(rs.getString("role_value"));

            return roles;
        }
    };

    @Autowired
    public RolesDAOImpl(DataSource driverManagerDataSource) {
        setDataSource(driverManagerDataSource);
    }


    @Override
    public List<Roles> getAll() {
        List<Roles> result = getJdbcTemplate().query(ROLE, rolesParameterizedRowMapper);

        if(result != null) {
            return result;
        } else {
            return null;
        }
    }

    @Override
    public Roles findByID(Integer id) {
        try {

            String findUser = "SELECT * FROM roles where id_role=" + id;

            return getJdbcTemplate().queryForObject(findUser, rolesParameterizedRowMapper);
        } catch(EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Integer create(final Roles entity) {
        JdbcTemplate jdbcTemplate = getJdbcTemplate();
        KeyHolder keyHolder = new GeneratedKeyHolder();

        PreparedStatementCreator psc = new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(INSERT_INTO_ROLES, Statement.RETURN_GENERATED_KEYS);

                ps.setInt(1, entity.getIdRole());

                ps.setString(2, entity.getRole());

                logger.debug(ps.toString());
                return ps;
            }
        };
        jdbcTemplate.update(psc, keyHolder);

        return keyHolder.getKey().intValue();
    }

    @Override
    public Integer update(Roles entity) {
        return null;
    }

    @Override
    public Integer deleteByID(Integer id) {
        return getJdbcTemplate().update(DELETE_ROLE, new Object[]{id});
    }
}
