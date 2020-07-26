package dao.impl;
import dao.RecordsDao;
import model.Records;

import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;



public class RecordsDaoImpl extends HibernateDaoSupport implements RecordsDao {

	

	public void deleteBean(Records bean) {
		this.getHibernateTemplate().delete(bean);
		
	}

	public void insertBean(Records bean) {
		this.getHibernateTemplate().save(bean);
		
	}

	@SuppressWarnings("unchecked")
	public Records selectBean(String where) {
		List<Records> list = this.getHibernateTemplate().find("from Records "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from Records  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<Records> selectBeanList(final int start,final int limit,final String where) {
		return (List<Records>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Records> list = session.createQuery(" from Records"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});
		
	}

	public void updateBean(Records bean) {
		this.getHibernateTemplate().update(bean);
		
	}
	
	
	
	
	
	
	
}
