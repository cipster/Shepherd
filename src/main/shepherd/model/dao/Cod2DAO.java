package model.dao;


import model.domain.Cod2;

import java.util.List;

public interface Cod2DAO extends GenericDAO<Cod2, Integer> {

    List<Cod2> getAll();

    List<Cod2> getAllByCod1(int cod1);

}
