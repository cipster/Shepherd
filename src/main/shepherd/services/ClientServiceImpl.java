package services;

import exceptions.DAOException;
import model.dao.ClientDAO;
import model.dto.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import util.enums.DAOResult;

/**
 * Created by Ciprian on 3/8/2015.
 * Project Shepherd
 */
public class ClientServiceImpl implements ClientService {

	@Qualifier("clientDAO")
	@Autowired
	private ClientDAO clientDAO;

	@Override
	public Client createClient(Client client) throws RuntimeException {
		if ( clientExists(client) )
			throw new IllegalArgumentException("Clientul există deja!");
		if ( clientDAO.create(client) > DAOResult.ZERO )
			return client;
		else
			throw new DAOException("Client was not created!");
	}

	@Override
	public Client modifyClient(Client client) throws RuntimeException {
		if ( clientDoesntExist(client) )
			throw new NullPointerException("Client doesn't exist!");
		if ( clientExists(client) )
			throw new IllegalArgumentException("Clientul " + client.getClient() + " există deja!");
		if ( clientDAO.update(client) > DAOResult.ZERO )
			return client;
		else
			throw new DAOException("Client was not updated!");
	}

	@Override
	public boolean deleteClient(Client client) throws RuntimeException {
		if ( clientDoesntExist(client) )
			throw new NullPointerException("Clientul doesn't exist!!");
		if ( clientDAO.deleteByID(client.getIdClient()) > DAOResult.ZERO )
			return true;
		else
			throw new DAOException("Client was not deleted!");
	}

	private boolean clientDoesntExist(Client client) {
		Client existingClient = clientDAO.findByID(client.getIdClient());

		if ( existingClient == null )
			return true;
		else
			return false;
	}

	private boolean clientExists(Client client) {
		Client existingClient = clientDAO.findClientByName(client.getClient());

		if ( existingClient == null )
			return false;
		else
			return true;
	}
}
