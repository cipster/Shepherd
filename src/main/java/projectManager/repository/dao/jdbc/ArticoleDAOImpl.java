package projectManager.repository.dao.jdbc;

import com.mysql.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import projectManager.repository.Articole;
import projectManager.repository.Cod3;
import projectManager.repository.dao.ArticoleDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Ciprian on 12/14/2014.
 * Project Raindrop
 */
public class ArticoleDAOImpl extends JdbcDaoSupport implements ArticoleDAO {
    private RowMapper<Articole> rowMapper = new RowMapper<Articole>() {
        @Override
        public Articole mapRow(ResultSet rs, int rowNum) throws SQLException {
            Articole articole = new Articole();

            articole.setIdCod3(rs.getInt("id_cod_3"));
            articole.setDenumire1(rs.getString("denumire_1"));
            articole.setDenumire2(rs.getString("denumire_2"));
            articole.setDenumire3(rs.getString("denumire_3"));
            articole.setBarcode(rs.getString("barcode"));
            articole.setDetalii(rs.getString("detalii"));
            articole.setPretAchizitie(rs.getString("pret_achizitie"));

            return articole;
        }
    };

    @Autowired
    public ArticoleDAOImpl(DriverManagerDataSource driverManagerDataSource) {
        setDataSource(driverManagerDataSource);
    }

    @Override
    public List<Articole> getAll() {
        final String query = "SELECT * FROM proiecte.articole";
        try {
            return getJdbcTemplate().query(query, rowMapper);
        } catch (DataAccessException ex){
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public Articole findByID(Integer id) {
        try {
            String query = "SELECT * FROM proiecte.articole WHERE id_cod_3=" + id;

            return getJdbcTemplate().queryForObject(query, rowMapper);
        } catch (DataAccessException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Integer create(final Articole entity) {
        return null;
    }

    @Override
    public Integer update(final Articole entity) {
       return null;
    }

    @Override
    public Integer deleteByID(Integer id) {
        return null;
    }
}
