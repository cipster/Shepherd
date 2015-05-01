package services;

import exceptions.DAOException;
import model.ControllerResult;
import model.dto.Cod1;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface Cod1Service {

	public List<Cod1> fetchAllCod1();

	ControllerResult modCod1(Cod1 cod1);

	ControllerResult addCod1(Cod1 cod1) throws DAOException;

	ControllerResult delCod1(Cod1 cod1) throws DAOException;
}
