package projectManager.mvc;

import com.google.zxing.BarcodeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import projectManager.enums.StareArticol;
import projectManager.repository.*;
import projectManager.repository.User;
import projectManager.repository.dao.*;
import projectManager.util.Barcode;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.List;

/**
 * Created by Ciprian on 12/14/2014.
 * Project Shepherd
 */
@Controller
@RequestMapping(value = "/api")
public class ApiRestController {

    @Autowired
    private Cod3DAO cod3DAO;
    @Autowired
    private ArticoleDAO articoleDAO;
    @Autowired
    ServletContext servletContext;
    @Autowired
    private PersoanaDAO persoanaDAO;
    @Autowired
    private LocDAO locDAO;
    @Autowired
    private EvidentaInventarDAO evidentaInventarDAO;
    @Autowired
    private ClientDAO clientiDAO;
    @Autowired
    private ListaProiecteDAO listaProiecteDAO;
    @Autowired
    private Cod2DAO cod2DAO;
    @Autowired
    private UserDAO userDAO;
    @Autowired
    private UserRolesDAO userRolesDAO;
    @Autowired
    private RolesDAO rolesDAO;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("mm-dd-yyyy");
        sdf.setLenient(true);
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sdf, true));
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/getinventory", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Articole> getAllStoc() {

        return articoleDAO.getAll();
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/clientlist", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Client> getAllClienti() {

        return clientiDAO.getAll();
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/proiectelist", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<ListaProiecte> getAllProiecte() {

        return listaProiecteDAO.getAll();
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/userlist", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<User> getAllUsers() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = SecurityContextHolder.getContext().getAuthentication().getAuthorities().iterator().next().getAuthority();

        if(role.compareTo("ROLE_ADMIN") == 0) {
            return userDAO.getAll();
        } else {
            return userDAO.getAll(2);
        }
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/cod2list/{id}", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Cod2> getAllCod2ByCod1(@PathVariable int id) {

        return cod2DAO.getAllByCod1(id);
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/persoane", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Persoana> getPersoane() {

        return persoanaDAO.getAll();
    }

    @Transactional(isolation = Isolation.READ_UNCOMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/locuri", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Loc> getLocuri() {

        return locDAO.getAll();
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/articol/{code}", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public Cod3 getArticol(@PathVariable String code) {
        Cod3 cod3 = null;
        try {
            cod3 = cod3DAO.findByBarcode(code);
            if(cod3 == null){
                cod3 = new Cod3();
                cod3.setIdCod3(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            cod3 = new Cod3();
            cod3.setIdCod3(0);
        }
        return cod3;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/tranzactie/{idArticol}", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public EvidentaInventar getTranzactie(@PathVariable String idArticol) {
        EvidentaInventar evidentaInventar = null;
        try {
            evidentaInventar = evidentaInventarDAO.findByIdArticol(idArticol);
            if(evidentaInventar == null){
                evidentaInventar = new EvidentaInventar();
                evidentaInventar.setIdEvidentaInventar(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            evidentaInventar = new EvidentaInventar();
            evidentaInventar.setIdEvidentaInventar(0);
        }
        return evidentaInventar;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/getLoc/{idLoc}", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public Loc getLocById(@PathVariable int idLoc) {
        Loc loc = null;
        try {
            loc = locDAO.findByID(idLoc);
            if(loc == null){
                loc = new Loc();
                loc.setIdLoc(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            loc = new Loc();
            loc.setIdLoc(0);
        }
        return loc;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @RequestMapping(value = "/getPersoana/{idPersoana}", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public Persoana getPersoanaById(@PathVariable int idPersoana) {
        Persoana persoana = null;
        try {
            persoana = persoanaDAO.findByID(idPersoana);
            if(persoana == null){
                persoana = new Persoana();
                persoana.setIdPersoana(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            persoana = new Persoana();
            persoana.setIdPersoana(0);
        }
        return persoana;
    }


    @RequestMapping(value = "/generatebarcode/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<byte[]> generateBarcode(@PathVariable String id) throws IOException {
        File f = null;
        String code = articoleDAO.findByID(Integer.valueOf(id)).getBarcode();
        byte[] image;
        try (InputStream in = new FileInputStream(f)) {
            // creates temporary file
            f = File.createTempFile("tmp", ".jpg", new File("C:/"));
            Barcode.encode(f, code, BarcodeFormat.CODE_128);
            image = new byte[(int) f.length()];
            in.read(image);
            f.delete();
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); //or what ever type it is
        headers.setContentLength(image.length);
        return new ResponseEntity<byte[]>(image, headers, HttpStatus.OK);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/adaugaarticol", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String addClient(@RequestBody Cod3 cod3) {
        org.springframework.security.core.userdetails.User user = (org.springframework.security.core.userdetails.User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = user.getUsername(); //get logged in username
        cod3.setCreatDe(username);
        String response = "";
        try {
            cod3DAO.create(cod3);
            response = "1";
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            response = "-1";
        }

        return response;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value = "/modificaclient", method = RequestMethod.POST)
    @ResponseBody
    public String modificaClient(@RequestBody Client client) {
        String response = "";
        Client deModificat = clientiDAO.findByID(client.getIdClient());
        if(deModificat != null) {
            try {
                deModificat.setClient(client.getClient());
                clientiDAO.update(deModificat);
                response = "1";
            } catch (DataAccessException ex) {
                ex.printStackTrace();
                response = "-1";
            }
        }

        return response;
    }

    @Transactional(isolation = Isolation.SERIALIZABLE)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value = "/stergeclient", method = RequestMethod.POST)
    @ResponseBody
    public String stergeClient(@RequestBody Client client) {
        String response = "";
        Client deSters = clientiDAO.findByID(client.getIdClient());
        if(deSters != null) {
            try {
                clientiDAO.deleteByID(deSters.getIdClient());
                response = "1";
            } catch (DataAccessException ex) {
                ex.printStackTrace();
                response = "-1";
            }
        }

        return response;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/adaugapersoana", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String addPersoana(@RequestBody Persoana persoana) {

        String response = "";
        try {
            persoanaDAO.create(persoana);
            response = "1";
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            response = "-1";
        }

        return response;
    }

    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @Transactional(isolation = Isolation.SERIALIZABLE)
    @RequestMapping(value = "/evidentaiese", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String evidentaIese(HttpServletRequest request) {
        org.springframework.security.core.userdetails.User user = (org.springframework.security.core.userdetails.User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = user.getUsername(); //get logged in username
        EvidentaInventar evidentaInventar = new EvidentaInventar();
        String evidenta = request.getParameterNames().nextElement();
        String response = "";
        if(evidenta != null) {
            JsonObject obj = Json.createReader(new StringReader(evidenta)).readObject();

            if (obj != null) {
                Integer idLoc = Integer.parseInt(obj.getString("idLoc"));
                Integer idPersoana = Integer.parseInt(obj.getString("idPersoana"));
                String detalii = obj.getString("detalii");
                int stare = obj.getInt("stare");

                evidentaInventar.setIdLoc(idLoc);
                evidentaInventar.setIdPersoana(idPersoana);
                evidentaInventar.setDetalii(detalii);
                JsonArray cod3 = obj.getJsonArray("cod3");
                for(int i = 0; i < cod3.size(); i ++){
                    Integer cod3Val = Integer.parseInt(cod3.getJsonString(i).getString());
                    evidentaInventar.setIdCod3(cod3Val);
                    try {
                        //cod3DAO.setStare(stare, cod3Val);
                        Cod3 articol = cod3DAO.findByID(cod3Val);
                        articol.setModificatDe(username);
                        articol.setIdLoc(idLoc);
                        articol.setStare(stare);

                        cod3DAO.update(articol);
                        evidentaInventarDAO.create(evidentaInventar);
                        response = "1";
                    } catch (DataAccessException ex) {
                        ex.printStackTrace();
                        response = "-1";
                    }
                }
            }
        }
        return response;
    }


    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR')")
    @Transactional(isolation = Isolation.SERIALIZABLE)
    @RequestMapping(value = "/evidentaintra", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String evidentaIntra(HttpServletRequest request) {
        org.springframework.security.core.userdetails.User user = (org.springframework.security.core.userdetails.User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = user.getUsername(); //get logged in username
        EvidentaInventar evidentaInventar = new EvidentaInventar();
        evidentaInventar.setIdEvidentaInventar(0);
        String evidenta = request.getParameterNames().nextElement();
        String response = "";
        if(evidenta != null) {
            JsonObject obj = Json.createReader(new StringReader(evidenta)).readObject();

            if (obj != null) {
                Integer idLoc = Integer.parseInt(obj.getString("idLoc"));
                Integer idPersoana = 1;
                String detalii = obj.getString("detalii");
                int stare = StareArticol.RECUPERAT.getCode();

                JsonArray cod3 = obj.getJsonArray("cod3");
                for(int i = 0; i < cod3.size(); i ++){
                    Integer cod3Val = Integer.parseInt(cod3.getJsonString(i).getString());
                    try {
                        evidentaInventar = evidentaInventarDAO.findByIdArticol("" + cod3Val);
                        if(evidentaInventar.getIdEvidentaInventar() == 0 ) {
                            throw new EmptyResultDataAccessException("Nu s-a gasit tranzactia in evidenta!", 1);
                        }
                        Cod3 articol = cod3DAO.findByID(cod3Val);
                        articol.setStare(stare);
                        articol.setIdLoc(idLoc);
                        articol.setModificatDe(username);
                        articol.setDetaliiRecuperare(detalii);
                        cod3DAO.update(articol);
//                        cod3DAO.setStare(stare, cod3Val);
                        evidentaInventarDAO.update(evidentaInventar);
                        response = "1";
                    } catch (DataAccessException ex) {
                        ex.printStackTrace();
                        response = "-1";
                    }
                }
            }
        }
        return response;
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @RequestMapping(value = "/adaugaloc", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String addLoc(@RequestBody Loc loc) {

        String response = "";
        try {
            locDAO.create(loc);
            response = "1";
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            response = "-1";
        }

        return response;
    }

    @Transactional(isolation = Isolation.SERIALIZABLE)
    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN','ROLE_INVENTAR','ROLE_USER')")
    @RequestMapping(value = "/schimbaparola", method = RequestMethod.POST)
    @ResponseBody
    public String schimbaParola(HttpServletRequest request) {

        String response = "";
        try {
            userDAO.updatePassword(request.getParameter("user"),request.getParameter("password"));
            response = "1";
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            response = "-1";
        }

        return response;
    }

    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/adaugauser", method = RequestMethod.POST)
    @ResponseBody
    public String adaugaUser(HttpServletRequest request) {

        String response = "";
        String user = request.getParameter("username");
        String password = new BCryptPasswordEncoder(4).encode("qwerty");
        String[] roluri = request.getParameterValues("rol");
        if((user != null && user.isEmpty()) || ( roluri != null && roluri.length == 0)){
            response = "-1";
        } else {
            try {
                if(userDAO.findByID(user) != null) return "-2";

                User deCreat = new User();
                deCreat.setPassword(password);
                deCreat.setUsername(user);
                deCreat.setEnabled(1);

                UserRoles userRoles = new UserRoles();
                userRoles.setUsername(user);

                Roles roles = null;
                userDAO.create(deCreat);

                for(String rol : roluri){
                    roles = rolesDAO.findByID(Integer.parseInt(rol));
                    if(roles != null) {
                        userRoles.setRole(roles.getRoleValue());
                        userRoles.setRoleType(roles.getIdRole());
                        userRolesDAO.create(userRoles);
                    }
                }
                response = "1";
            } catch (DataAccessException ex) {
                ex.printStackTrace();
                response = "-1";
            }
        }
        return response;
    }

    @PreAuthorize("hasAnyRole('ROLE_SUPERUSER','ROLE_ADMIN')")
    @Transactional(isolation = Isolation.SERIALIZABLE)
    @RequestMapping(value = "/modificauser", method = RequestMethod.POST)
    @ResponseBody
    public String modificaUser(HttpServletRequest request) {

        String response = "";
        String user = request.getParameter("username");
        String status = request.getParameter("status");
        String[] roluri = request.getParameterValues("rol");
        if((user != null &&user.length() == 0) || ( roluri != null && roluri.length == 0)){
            response = "-1";
        } else {
            try {
                User deModificat = userDAO.findByID(user);
                deModificat.setEnabled(Integer.parseInt(status));

                UserRoles userRoles = new UserRoles();
                userRoles.setUsername(user);

                Roles roles = null;

                userDAO.update(deModificat);
                userRolesDAO.deleteByUsername(user);

                for(String rol : roluri){
                    roles = rolesDAO.findByID(Integer.parseInt(rol));
                    if(roles != null) {
                        userRoles.setRole(roles.getRoleValue());
                        userRoles.setRoleType(roles.getIdRole());
                        userRolesDAO.create(userRoles);
                    }
                }
                response = "1";
            } catch (DataAccessException ex) {
                ex.printStackTrace();
                response = "-1";
            }
        }
        return response;
    }
}
