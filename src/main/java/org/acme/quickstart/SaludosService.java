package org.acme.quickstart;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

@ApplicationScoped
public class SaludosService {

	@Inject
	EntityManager em;

	@Transactional
	public void crearSaludo(String nombre) {
		Saludos saludos = new Saludos();
		saludos.setNombre(nombre);
		em.persist(saludos);
	}

	public Long contarSaludo(String nombre) {
		Query query = em.createQuery("SELECT COUNT (t) FROM Saludos t WHERE t.nombre=:param").setParameter("param", nombre);
		Long count = (Long)query.getSingleResult();
		return count;
	}
}
