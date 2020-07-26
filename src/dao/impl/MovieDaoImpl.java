package dao.impl;
import dao.MovieDao;
import model.Movie;

import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.sun.org.apache.bcel.internal.generic.NEW;



public class MovieDaoImpl extends HibernateDaoSupport implements MovieDao {

	

	public void deleteBean(Movie bean) {
		this.getHibernateTemplate().delete(bean);
		
	}

	public void insertBean(Movie bean) {
		this.getHibernateTemplate().save(bean);
		
	}

	@SuppressWarnings("unchecked")
	public Movie selectBean(String where) {
		List<Movie> list = this.getHibernateTemplate().find("from Movie "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from Movie  "+where).get(0);
		return count;
	}
	public long selectCount(final String where,List<Integer> id)
	{
		Session session = getSession();
		return (long) session.createQuery(" select count(*) from Movie"+where).setParameterList("idlist",id ).list().get(0);
		
	}

	@SuppressWarnings("unchecked")
	public List<Movie> selectBeanList(final int start,final int limit,final String where) {
		return (List<Movie>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Movie> list = session.createQuery(" from Movie"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});	
	}
	
	@SuppressWarnings("unchecked")
	public List<Movie> selectByIds(final int start,final int limit,final String where,List<Integer> id) {
		return (List<Movie>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Movie> list = session.createQuery(" from Movie"+where).setParameterList("idlist",id ).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});	
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Movie> selectAllMovie(final String where) {
		return (List<Movie>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Movie> list = session.createQuery(" from Movie"+where).list();
				return list;
			}
		});
		
	}

	public void updateBean(Movie bean) {
		this.getHibernateTemplate().update(bean);
		
	}
	
	
	
	
	
	
	
}
