package projectManager.dao;


import projectManager.repository.Bd;

import java.util.List;

public interface BdDAO extends GenericDAO<Bd, Integer> {

    public List<Bd> getAll();

}
