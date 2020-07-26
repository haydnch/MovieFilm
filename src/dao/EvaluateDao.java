package dao;


import model.Evaluate;

import java.util.List;

import com.sun.javafx.binding.StringFormatter;



public interface EvaluateDao {

	
	//插入新纪录
	public void insertBean(Evaluate bean);
	
	//根据id删除纪录
	public void deleteBean(Evaluate bean);
	
	//根据id更新纪录
	public void updateBean(Evaluate bean);

	//获取信息列表,带查询功能，start 表示当前页，limit表示每页显示的条数 start=1,lmit=10
	public List<Evaluate> selectBeanList(final int start,final int limit,final String where);
	
	public List<Evaluate>selectAllEvaluate(final String where);
	
	//查询记录的总的条数
	public long selectBeanCount(final String where);
	
	//查找所有电影id 以及平均分
	public List<Object[]> calculateMovieRating(final String where);
	
	//查找所有电影被评过分的次数
	public List<Object[]> calculateMovieCount(final String where);
	
	//查询信息
	public Evaluate selectBean(String where);
	

}
