package dao.impl;
import dao.EvaluateDao;
import model.Evaluate;

import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;



public class EvaluateDaoImpl extends HibernateDaoSupport implements EvaluateDao {

	

	public void deleteBean(Evaluate bean) {
		this.getHibernateTemplate().delete(bean);
		
	}

	public void insertBean(Evaluate bean) {
		this.getHibernateTemplate().save(bean);
		
	}

	@SuppressWarnings("unchecked")
	public Evaluate selectBean(String where) {
		List<Evaluate> list = this.getHibernateTemplate().find("from Evaluate "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from Evaluate  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<Evaluate> selectBeanList(final int start,final int limit,final String where) {
		return (List<Evaluate>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Evaluate> list = session.createQuery(" from Evaluate"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});	
	}
	@SuppressWarnings("unchecked")
	public List<Object[]> calculateMovieRating(final String where)
	{
		return (List<Object[]>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Object[]> list = session.createSQLQuery("select movie_id,avg(fen)  from t_evaluate group by movie_id"+where).list();
				return list;
			}
		});	
	}
	@SuppressWarnings("unchecked")
	public List<Object[]> calculateMovieCount(final String where)
	{
		return (List<Object[]>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Object[]> list = session.createSQLQuery("select movie_id,count(fen)  from t_evaluate group by movie_id"+where).list();
				return list;
			}
		});	
	}

	@SuppressWarnings("unchecked")
	public List<Evaluate> selectAllEvaluate(final String where) {
		return (List<Evaluate>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Evaluate> list = session.createQuery(" from Evaluate"+where).list();
				return list;
			}
		});	
	}
	public void updateBean(Evaluate bean) {
		this.getHibernateTemplate().update(bean);
		
	}
	
	
	
	
	
	
	
}
