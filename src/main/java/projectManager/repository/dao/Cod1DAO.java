package projectManager.repository.dao;


import projectManager.repository.Cod1;

import java.util.List;

public interface Cod1DAO extends GenericDAO<Cod1, Integer> {

    public List<Cod1> getAll();

}
