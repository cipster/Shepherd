package projectManager.dao.jdbc;


import com.mysql.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import projectManager.dao.AlteMaterialeDAO;
import projectManager.repository.AlteMateriale;

import java.sql.*;
import java.util.List;

public class AlteMaterialeJDBCDAO extends JdbcDaoSupport implements AlteMaterialeDAO {

    private static final String ALTE_MATERIALE = "SELECT * FROM altemateriale ";
    private static final String FIND_ALTE_MATERIALE_BY_ID = ALTE_MATERIALE + " WHERE id_alte_materiale=";
    private static final String DELETE_ALTE_MATERIALE_BY_ID = "DELETE FROM altemateriale WHERE id_alte_materiale=?";
    private static final String INSERT_INTO_ALTE_MATERIALE = "INSERT INTO altemateriale(id_alte_materiale, altemateriale, nume, creat_de, creat_la)VALUES(?, ?, ?, ?, ?)";

    private ParameterizedRowMapper<AlteMateriale> alteMaterialeParameterizedRowMapper = new ParameterizedRowMapper<AlteMateriale>() {
        @Override
        public AlteMateriale mapRow(ResultSet rs, int rowNum) throws SQLException {
            AlteMateriale alteMateriale = new AlteMateriale();

            alteMateriale.setIdAlteMateriale(rs.getInt("id_alte_materiale"));
            alteMateriale.setAltemateriale(rs.getBytes("altemateriale"));
            alteMateriale.setNume(rs.getString("nume"));
            alteMateriale.setCreat_de(rs.getString("creat_de"));
            alteMateriale.setCreat_la(rs.getTimestamp("creat_la"));

            return alteMateriale;
        }
    };

    @Autowired
    public AlteMaterialeJDBCDAO(DriverManagerDataSource driverManagerDataSource) {
        setDataSource(driverManagerDataSource);
    }

    @Override
    public AlteMateriale findByID(Integer id) {
        try {

            String findAM = FIND_ALTE_MATERIALE_BY_ID + id;

            return getJdbcTemplate().queryForObject(findAM, alteMaterialeParameterizedRowMapper);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Integer create(final AlteMateriale entity) {
        JdbcTemplate jdbcTemplate = getJdbcTemplate();
        KeyHolder keyHolder = new GeneratedKeyHolder();

        PreparedStatementCreator psc = new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(INSERT_INTO_ALTE_MATERIALE, Statement.RETURN_GENERATED_KEYS);

                ps.setInt(1, entity.getIdAlteMateriale());

                ps.setBytes(2, entity.getAltemateriale());

                ps.setString(3, entity.getNume().replace(",", " "));

                ps.setString(4, entity.getCreat_de());

                ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

                logger.debug(ps.toString());
                return ps;
            }
        };
        jdbcTemplate.update(psc, keyHolder);

        return keyHolder.getKey().intValue();
    }

    @Override
    public Integer update(final AlteMateriale entity) {
        return null;
    }

    @Override
    public Integer deleteByID(Integer id) {
        return getJdbcTemplate().update(DELETE_ALTE_MATERIALE_BY_ID, new Object[]{id});
    }

    @Override
    public List<AlteMateriale> getAll() {

        List<AlteMateriale> result = getJdbcTemplate().query(ALTE_MATERIALE, alteMaterialeParameterizedRowMapper);

        if(result != null) {
            return result;
        } else {
            return null;
        }

    }
}
