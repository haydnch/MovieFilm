package dao;


import model.Movie;

import java.util.List;



public interface MovieDao {

	
	//插入新纪录
	public void insertBean(Movie bean);
	
	//根据id删除纪录
	public void deleteBean(Movie bean);
	
	//根据id更新纪录
	public void updateBean(Movie bean);

	//获取信息列表,带查询功能，start 表示当前页，limit表示每页显示的条数 start=1,lmit=10
	public List<Movie> selectBeanList(final int start,final int limit,final String where);
	
	public List<Movie>selectAllMovie(final String where);
	
	//根据id列表查找 
	public List<Movie> selectByIds(final int start,final int limit,final String where,List<Integer> id);
	//查询记录的总的条数
	public long selectBeanCount(final String where);
	
	public long selectCount(final String where,List<Integer> id);
	
	
	//查询信息
	public Movie selectBean(String where);
	

}
