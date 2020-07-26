package model;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

//电影信息
@Entity
@Table(name="t_Movie")
public class Movie {
	

	@Id
	@GeneratedValue
	private int id;//主键
	
	private String category;//分类   (科幻、喜剧、爱情片、惊悚、动作、剧情、战争、动漫)
	
    private String biaoti;//电影名称
    private String dao;//导演
    private String zhu;//演员表
	
    @Column(name="content", columnDefinition="TEXT")
	private String content;//简介
    
    private String imgpath;//图片
    
    private double zong;//评分

	private Date createtime;//添加时间
	
	private int ratedNum;//评分人数

	private int movielock;//删除状态  0表示未删除 1表示已删除
	
	


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBiaoti() {
		return biaoti;
	}

	public void setBiaoti(String biaoti) {
		this.biaoti = biaoti;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDao() {
		return dao;
	}

	public void setDao(String dao) {
		this.dao = dao;
	}

	public String getZhu() {
		return zhu;
	}

	public void setZhu(String zhu) {
		this.zhu = zhu;
	}

	public int getMovielock() {
		return movielock;
	}

	public void setMovielock(int movielock) {
		this.movielock = movielock;
	}

	public double getZong() {
		return zong;
	}

	public void setZong(double zong) {
		this.zong = zong;
	}

	public int getRatedNum() {
		return ratedNum;
	}

	public void setRatedNum(int ratedNum) {
		this.ratedNum = ratedNum;
	}


	

	
	

	

	
}
