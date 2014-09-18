package projectManager.dao;

import projectManager.repository.ListaProiecte;

import java.util.List;

public interface ListaProiecteDAO extends GenericDAO<ListaProiecte, Integer> {

    List<ListaProiecte> getAll();

    List<ListaProiecte> findProiecteByClient(Integer id_client);

    Integer updatePropunere(Integer id_propunere, Integer id_proiect);

    Integer updateChestionarFinal(Integer id_chestionar_final, Integer id_proiect);

    Integer updateRaportFinal(Integer id_raport_final, Integer id_proiect);

    Integer updateBd(Integer id_bd, Integer id_proiect);

    Integer updateAlteMateriale(Integer id_alte_materiale, Integer id_proiect);

    Integer stergeAlteMateriale(final Integer id_alte_materiale, final Integer id_proiect);

    Integer stergePropunere(final Integer id_propunere, final Integer id_proiect);

    Integer stergeChestionar(final Integer id_chestionar, final Integer id_proiect);

    Integer stergeRaport(final Integer id_raport, final Integer id_proiect);

    Integer stergeBd(final Integer id_bd, final Integer id_proiect);
}
