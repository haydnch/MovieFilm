package action;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;


import model.Evaluate;
import model.Gonggao;
import model.Movie;
import model.Records;
import model.User;


import org.apache.struts2.ServletActionContext;
import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;

import util.Pager;
import util.RecommendByUCF;

import com.mysql.jdbc.Util;
import com.opensymphony.xwork2.ActionSupport;

import dao.EvaluateDao;
import dao.GonggaoDao;
import dao.MovieDao;
import dao.RecordsDao;
import dao.UserDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class IndexAction extends ActionSupport {
 
	private static final long serialVersionUID = 1L;

	private String url = "./";
	
	 private File uploadfile;
		
		
	 public File getUploadfile() {
			return uploadfile;
		}

		
	 public void setUploadfile(File uploadfile) {
			this.uploadfile = uploadfile;
		}
	 
    private UserDao userDao;
	private GonggaoDao gonggaoDao;
	private MovieDao movieDao;
	private EvaluateDao evaluateDao;
	private RecordsDao recordsDao;
	
	
	public RecordsDao getRecordsDao() {
		return recordsDao;
	}


	public void setRecordsDao(RecordsDao recordsDao) {
		this.recordsDao = recordsDao;
	}


	public EvaluateDao getEvaluateDao() {
		return evaluateDao;
	}


	public void setEvaluateDao(EvaluateDao evaluateDao) {
		this.evaluateDao = evaluateDao;
	}


	public MovieDao getMovieDao() {
		return movieDao;
	}

	public void setMovieDao(MovieDao movieDao) {
		this.movieDao = movieDao;
	}

	public GonggaoDao getGonggaoDao() {
		return gonggaoDao;
	}

	public void setGonggaoDao(GonggaoDao gonggaoDao) {
		this.gonggaoDao = gonggaoDao;
	}

	
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}

	
	
	public void CalculateMoviesRating() throws IOException{
		List<Object[]> list=evaluateDao.calculateMovieRating("");
		System.out.println(list.size());
		for(Object[] object : list){    
            int mid= (int) object[0];    
            String rating = object[1].toString();    
            Movie m =movieDao.selectBean(" where id="+mid);
            if(m!=null) {
            	double t=Double.parseDouble(rating);
            	m.setZong((double) Math.round(t * 10) / 10);
            	movieDao.updateBean(m);
            }
          
        }    		
	}	
	
	public void CalculateMoviesCount() throws IOException{
		List<Object[]> list=evaluateDao.calculateMovieCount("");
		System.out.println(list.size());
		for(Object[] object : list){    
            int mid= (int) object[0];    
            int  count = Integer.parseInt(object[1].toString());    
            Movie m =movieDao.selectBean(" where id="+mid);
            if(m!=null) {
            	m.setRatedNum(count);
            	movieDao.updateBean(m);
            }
          
        }    		
	}	
	//首页
	public  String  index(){
//		try {
//			CalculateMoviesCount();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		this.setUrl("index.jsp");
		return SUCCESS;
	
	}
	
	

	// 用户注册操作
	public void register() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String username = request.getParameter("username");
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		String sex = request.getParameter("sex");
		String likes[] = request.getParameterValues("likes");
		User bean = userDao.selectBean("  where deletestatus=0 and username='"+ username + "'");
		if (bean == null) {
			bean = new User();
			
			bean.setCreatetime(new Date());
			bean.setEmail(email);
			bean.setPassword(password);
			
			
			bean.setUsername(username);
			bean.setSex(sex);
			StringBuffer sb = new StringBuffer();
			sb.append("");
			if(likes!=null) {
			for (int i = 0; i < likes.length; i++) {
				sb.append(likes[i]+"|");	
			}
		}
			bean.setLikes(sb.toString());
			userDao.insertBean(bean);
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("注册成功,当前用户名："+bean.getUsername()+"");
			writer.print("<script  language='javascript'>alert('注册成功');window.location.href='index.jsp'; </script>");
		} else {
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('用户名已经存在，注册失败！');window.location.href='register.jsp'; </script>");
		}

	}
	
	// 用户登录操作
	public void login() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User bean = userDao.selectBean("  where deletestatus=0 and username='"+ username + "' and password='" + password + "'   ");
		if (bean != null) {
			int uid=bean.getId();
			HttpSession session = request.getSession();
			session.setAttribute("user", bean);
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			new Thread(new Runnable() {
				@Override
				public void run() { 
					List<Integer> r =calculate_rocommend_mid(String.valueOf(uid));
					session.setAttribute("recommend"+uid, r);
				}
			}).start();
			
			writer.print("<script  language='javascript'>alert('登录成功！');window.location.href='index.jsp'; </script>");
			
			
		} else {
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('用户名或者密码错误！登录失败');window.location.href='index.jsp'; </script>");
		}

	}

	// 用户退出操作
	public void loginout() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('退出成功！');window.location.href='index.jsp'; </script>");

	}
	
	
	//跳转到更新用户页面
	public String userupdate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		User bean =userDao.selectBean(" where id= "+user.getId());
		request.setAttribute("bean", bean);
		this.setUrl("userupdate.jsp");
		return SUCCESS;
	}
	
	
	//更新用户操作
	public void userupdate2() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		
		String sex = request.getParameter("sex");
		String id = request.getParameter("id");
		User bean =userDao.selectBean(" where id= "+id);
		
		bean.setCreatetime(new Date());
		bean.setEmail(email);
		bean.setPassword(password);
		
		
		bean.setSex(sex);
		bean.setCreatetime(new Date());
		userDao.updateBean(bean);
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('个人信息修改成功');window.location.href='indexmethod!userupdate'; </script>");
	}
	
	

	
	
	//公告列表(首页)
	public String sy_gonggaolist(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String biaoti = request.getParameter("biaoti");
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");

		if(biaoti !=null &&!"".equals(biaoti)){
			sb.append(" biaoti like '%"+biaoti+"%' ");
			sb.append(" and ");

			request.setAttribute("biaoti", biaoti);
		}
		
		sb.append(" deletestatus=0 order by id desc ");

		String where = sb.toString();
		
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		
		long total = gonggaoDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Gonggao> list = gonggaoDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!sy_gonggaolist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("sy_gonggaolist.jsp");
		return SUCCESS;
	}
	
	//跳转到查看公告页面(首页)
	public String xq_gonggao(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		Gonggao bean =gonggaoDao.selectBean(" where id= "+id);
		request.setAttribute("bean", bean);
		this.setUrl("xq_gonggao.jsp");
		return SUCCESS;
	}
	
	

	
	//跳转到查看影视页面
	public String xq_movie(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		String mid = null;//当前电影的id ,必须反复传值
		Movie bean =movieDao.selectBean(" where id= "+id);  
		request.setAttribute("bean", bean);
		if(id!=null) {
			mid=id;
		}
		
//		List<Evaluate> list = evaluateDao.selectBeanList(0, 99, " where movie="+bean.getId()+" and deletestatus=0  ");
//		request.setAttribute("list", list);
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		sb.append("  movie="+mid+" and deletestatus=0    order by id desc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = evaluateDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Evaluate> list = evaluateDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);//该电影的评分列表
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!xq_movie?id="+mid, "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("xq_movie.jsp");
		return SUCCESS;
	}
	
	
	//查看影视列表(如果选中了左侧类别)
	public String movielist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String biaoti = request.getParameter("biaoti");
		String dao = request.getParameter("dao");
		String category = request.getParameter("category");
//		if(category!=null)
//			category=new String(category.getBytes("iso8859-1"),"UTF-8");
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		if(biaoti !=null &&!"".equals(biaoti)){
			sb.append(" biaoti like '%"+biaoti+"%' ");
			sb.append(" and ");
			request.setAttribute("biaoti", biaoti);
		}
		if(dao !=null &&!"".equals(dao)){
			sb.append(" dao like '%"+dao+"%' ");
			sb.append(" and ");
			request.setAttribute("dao", dao);
		}
		if(category !=null &&!"".equals(category)){
			sb.append(" category like '%"+category+"%' ");
			sb.append(" and ");
			request.setAttribute("category", category);
		}
		sb.append("  movielock=0   order by id desc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = movieDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Movie> list = movieDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!movielist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("movielist.jsp");
		return SUCCESS;
	}
	
	//查看影视列表(顶部及右边栏)
	public String top_movielist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String biaoti = request.getParameter("biaoti");
		String dao = request.getParameter("dao");
		
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		if(biaoti !=null &&!"".equals(biaoti)){
			sb.append(" biaoti like '%"+biaoti+"%' ");
			sb.append(" and ");
			request.setAttribute("biaoti", biaoti);
		}
		if(dao !=null &&!"".equals(dao)){
			sb.append(" dao like '%"+dao+"%' ");
			sb.append(" and ");
			request.setAttribute("dao", dao);
		}
		
		sb.append("  zong>0 and movielock=0  order by zong desc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = movieDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Movie> list = movieDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!top_movielist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("movielist.jsp");
		return SUCCESS;
	}
	
	
	//所有电影列表
	public String dy_movielist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String biaoti = request.getParameter("biaoti");
		String dao = request.getParameter("dao");
		
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		if(biaoti !=null &&!"".equals(biaoti)){
			sb.append(" biaoti like '%"+biaoti+"%' ");
			sb.append(" and ");
			request.setAttribute("biaoti", biaoti);
		}
		if(dao !=null &&!"".equals(dao)){
			sb.append(" dao like '%"+dao+"%' ");
			sb.append(" and ");
			request.setAttribute("dao", dao);
		}
		
		sb.append("  movielock=0   order by id asc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = movieDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Movie> list = movieDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!dy_movielist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("movielist.jsp");
		return SUCCESS;
	}
	
	
	/****************评价
	 * @throws IOException **************/
	
	//跳转到评价页面
	public String evaluateadd() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if (user == null) {
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='index.jsp'; </script>");
			return null ;
		}
		String id = request.getParameter("id");
		Movie bean =movieDao.selectBean(" where id= "+id);
		
		Evaluate a =evaluateDao.selectBean(" where user="+user.getId()+" and  movie="+bean.getId()+" and deletestatus=0 ");
		if(a!=null){
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('您已评价过，无法再次评价');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
			return null;
		}
		
		request.setAttribute("bean", bean);
		this.setUrl("evaluateadd.jsp");
		return SUCCESS;
	}
	
	
	//评价操作
	public void evaluateadd2() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		Integer fen = Integer.parseInt(request.getParameter("fen"));
		String content = request.getParameter("content");
		String id = request.getParameter("id");
		Movie m =movieDao.selectBean(" where id= "+id);
		Evaluate bean=new Evaluate();
		bean.setFen(fen);
		bean.setContent(content);
		bean.setUser(user);
		bean.setMovie(m);
		bean.setCreatetime(new Date());
		evaluateDao.insertBean(bean);
		List<Evaluate> list = evaluateDao.selectAllEvaluate( "  where movie="+m.getId()+" ");
		double c=0.0;
		for(Evaluate a:list ){
			c=c+a.getFen();
		}
		c=c/list.size();
		m.setZong((double) Math.round(c * 10) / 10); //使评分保留1位小数
		m.setRatedNum(m.getRatedNum()+1);
		movieDao.updateBean(m);
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('评价成功');window.location.href='indexmethod!xq_movie?id="+m.getId()+"'; </script>");
		
	}	
	
	
	//根据喜好推荐电影列表
	@SuppressWarnings("unchecked")
	public String my_movielist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		List<Movie> list = new ArrayList<Movie>();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String bh=user.getLikes();//分割喜欢的分类
//		String[] as = bh.split(",");//逗号为分割点
//		StringBuffer sb=new StringBuffer();
//		sb.append("");
//		for(int i=0;i<as.length;i++)
//		{
//			if(i!=as.length-1)
//				sb.append(as[i]+'|');
//			else
//				sb.append(as[i]);
//		}
		String string =bh.substring(0, bh.length()-2);
		String where="  where  REGEXP(category, "+"'"+string +"')=1"+ 
 		"  and zong >=4 and ratedNum>99 order by zong desc   ";
		
		//得到分类的正则表达式
		 list=movieDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		long total =movieDao.selectBeanCount(where.replaceAll("order by zong desc", ""));
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!my_movielist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		request.setAttribute("list", list);
		this.setUrl("my_movielist.jsp");
		return SUCCESS;
	}
	
	//计算两个用户的皮尔逊相似度
			public  double pearson_sim(HashMap<String,List<HashMap<String, String>>> res ,String user1,String user2)
			{
				double sim=0;
				List<HashMap<String, String>> u1=res.get(user1);
				List<HashMap<String, String>> u2=res.get(user2);
				List<String> commonMovie=new ArrayList<>();
				List<Integer> rating1=new ArrayList<>();
				List<Integer> rating2=new ArrayList<>();
				if((u1==null||u1.isEmpty())||(u2==null||u2.isEmpty()))
					return 0; //表示这两个用户至少有一个没有对任何电影评过分
				int count=0;
				//取出两位用户评论过的电影和评分
				for(HashMap<String, String> map1:u1)
				{
					for(HashMap<String, String>map2:u2)
					{
					//String mid=String.join("", map1.keySet());
						if(map2.containsKey(String.join("", map1.keySet())))
								{
									count++;
									commonMovie.add(String.join("", map1.keySet()));
									rating1.add(Integer.parseInt(map1.get(String.join("", map1.keySet()))));
									rating2.add(Integer.parseInt(map2.get(String.join("", map1.keySet()))));
								}
					}
				}
				if(count==0)
					return 0;//表示两者没有任何共同评分的电影
				int len=rating1.size();
				double sum1Sq=0,sum2Sq=0;
				double Psum=0;
				//计算评分和
				//double sum1=rating1.stream().mapToInt(x->x).sum();
				//double sum2=rating2.stream().mapToInt(x->x).sum();
				double sum1=0,sum2=0;
				//计算评分平方和
				for(int i=0;i<len;i++)
				{
					sum1+=rating1.get(i);
					sum2+=rating2.get(i);
					sum1Sq+=Math.pow(rating1.get(i), 2);
					sum2Sq+=Math.pow(rating2.get(i), 2);
				}
				//计算乘积和
				for(int i=0;i<len;i++)
					Psum+=rating1.get(i)*rating2.get(i);
				
				//计算皮尔逊相关系数
				double num=Psum-((sum1*sum2)/count);
				double den=Math.sqrt((sum1Sq-Math.pow(sum1, 2)/count)*(sum2Sq-Math.pow(sum2, 2)/count));
				if(den==0)
					return 0;//分母为0
				sim=num/den;
				return sim;
			}


			//计算与给定用户最相似的10位用户[user:similar...]
			public  List<Map.Entry<String, Double>> top10_similar_pearson(HashMap<String,List<HashMap<String, String>>> res,List<User> users,String user)
			{
				HashMap<String, Double> result =new HashMap<String,Double>();
				for(User u:users)
				{
					if(!String.valueOf(u.getId()).equals(user))
					{
						double similar=pearson_sim(res, user,String.valueOf(u.getId()));
						if(similar!=0.0)
							result.put(String.valueOf(u.getId()), similar);
					}
				}
				
				List<Map.Entry<String, Double>> wordMap = new ArrayList<Map.Entry<String, Double>>(result.entrySet());
				Collections.sort(wordMap, new Comparator<Map.Entry<String, Double>>() {// 根据value排序
				public int compare(Map.Entry<String, Double> o1, Map.Entry<String, Double> o2) {
				double r = o2.getValue() - o1.getValue();
				if (r > 0)
					return 1;
				else if (r == 0)
					return 0;
				else
					return -1;
				}
				});
				int len=wordMap.size()<10?result.size():10;
			
				System.out.println("******************************************");
				System.out.println("similar: "+wordMap.subList(0, len));
				System.out.println("******************************************");
				return wordMap.subList(0, len);
			}
			
			//返回推荐给 指定用户的二十部电影
			public  List<Integer> RecommendedMovie(HashMap<String,List<HashMap<String, String>>> res,List<User> users,String user)
			{
				List<HashMap<String, String>> user_movie=res.get(user); //指定用户已经评过分的电影及评分，即不再推荐
				if(user_movie==null)	return null;
				List<String> have_seen =new ArrayList<String>(); //存放指定用户已经评分电影的id
				for(HashMap<String, String> t:user_movie)
				{
					have_seen.add(String.join("", t.keySet()));
				}
				List<Integer> result =new ArrayList<Integer>(); //存放推荐的电影的id
				List<Map.Entry<String, Double>> recommend_user = top10_similar_pearson(res, users, user);
				
				for(Map.Entry<String, Double> set:recommend_user)
				{
					List<HashMap<String, String>> ms=res.get(set.getKey());//得到该用户评分过的电影
					for(HashMap<String, String> m:ms )
					{
						String mid=String.join("", m.keySet());//该电影id
						String rid=m.get(mid); //该电影的评分
						if(!have_seen.contains(mid)&&Integer.parseInt(rid)>=3.5)
						{
							result.add(Integer.parseInt(mid));
						}
					}
				}
				int len=result.size()<20?result.size():20;
				//System.out.println(mid);	
				return result.subList(0, len);
			}
			
   public List<Integer> calculate_rocommend_mid(String user)
   {
	   HashMap<String,List<HashMap<String, String>>> res =
				new HashMap<String,List<HashMap<String, String>>>(); //建立所有对电影评过分的{user movie}map集合
		//{userid=[{movieid,rating}...]}
		  List<User> users=userDao.selectAllUser("  where deletestatus=0 order by id");
		   List<Evaluate> evaluates=evaluateDao.selectAllEvaluate(" where deletestatus=0 order by user,movie"); 
		   for(Evaluate evaluate : evaluates) {
				List<HashMap<String, String>> temp = new ArrayList<HashMap<String, String>>();
				String userId = String.valueOf(evaluate.getUser().getId());
				String movieId = String.valueOf(evaluate.getMovie().getId());
				String rating = String.valueOf(evaluate.getFen());
				if (res.containsKey(userId)){
					temp =res.get(userId);
				}
				HashMap<String, String> r = new HashMap<String, String>();
				r.put(movieId, rating);
				temp.add(r);
				res.put(userId, temp);
			}
		
			 
	  //得到要推荐的电影id的列表
	    return RecommendedMovie(res, users,  user);
   }

	
	@SuppressWarnings("unchecked")
	public String recommend() throws IOException{
		List<Integer> recommend_movie =new ArrayList<>();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	//为user进行推荐
		Evaluate e =evaluateDao.selectBean(" where user = "+user.getId()); //该用户为新用户 没有对任何电影评过分,则按照喜好推荐
		if(e==null)
		{
			my_movielist();
	    	return SUCCESS;
		}
		if(session.getAttribute("recommend"+user.getId())==null) {
			recommend_movie=calculate_rocommend_mid(String.valueOf(user.getId()));
			if(recommend_movie==null)
			{
				my_movielist();
				return SUCCESS;
			}
			if(recommend_movie!=null)
				session.setAttribute("recommend"+user.getId(), recommend_movie);
		}
		else {
			recommend_movie=(List<Integer>) session.getAttribute("recommend"+user.getId());
		}
		
	   StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		
		sb.append("  movielock=0 and id in (:idlist) and zong>=3.5 order by zong desc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		
		List<Movie> list = movieDao.selectByIds((currentpage-1)*pagesize, pagesize, where,recommend_movie);
		//long total = movieDao.selectBeanCount(where.replaceAll("order by zong desc", ""));
		long total=movieDao.selectCount(where, recommend_movie);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!recommend", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("my_movielist.jsp");
		return SUCCESS;
	}
	

	//查看高分电影列表
	public String gf_movielist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		sb.append("  movielock=0 and ratedNum>99 and zong>3.4 order by zong desc  ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = movieDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Movie> list = movieDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!gf_movielist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("gf_movielist.jsp");
		return SUCCESS;
	}
	
	
	/*************想看和看过电影列表****************/
	//记录列表
	public String recordslist(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		String status = request.getParameter("status");
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		if(status !=null &&!"".equals(status)){
			sb.append(" status like '%"+status+"%' ");
			sb.append(" and ");
			request.setAttribute("status", status);
		}
		sb.append(" user="+user.getId()+" and deletestatus=0 order by id desc ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = recordsDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Records> list = recordsDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!recordslist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("recordslist.jsp");
		return SUCCESS;
	}
	

	
	
	//对电影操作"想看"
	public void recordsadd() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		String id = request.getParameter("id");
		Movie  movie =movieDao.selectBean(" where id= "+id);
		Records bean=recordsDao.selectBean(" where movie="+movie.getId()+" and user="+user.getId()+" and deletestatus=0 ");
		if(bean!=null&&bean.getstatus().equals("看过")){
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('该电影您已看过，添加失败');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");	
		}else if(bean==null){
				bean =new Records();
				bean.setMovie(movie);
				bean.setUser(user);
				bean.setstatus("想看");
				bean.setCreatetime(new Date());
				recordsDao.insertBean(bean);
				response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
				PrintWriter writer = response.getWriter();
				writer.print("<script  language='javascript'>alert('提交成功');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
	
		}
		else {
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('该电影您已记录过，添加失败');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
					
		}
	}
	
	//对电影操作"已看过"
	public void recordsadd2() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		String id = request.getParameter("id");
		Movie  movie =movieDao.selectBean(" where id= "+id);
		Records bean=recordsDao.selectBean(" where movie="+movie.getId()+" and user="+user.getId()+" and deletestatus=0 ");
		if(bean==null) {
		bean =new Records();
		bean.setMovie(movie);
		bean.setUser(user);
		bean.setstatus("看过");
		bean.setCreatetime(new Date());
		recordsDao.insertBean(bean);
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('提交成功');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
		}
		else if(bean.getstatus().equals("想看")) {
			bean.setMovie(movie);
			bean.setUser(user);
			bean.setstatus("看过");
			bean.setCreatetime(new Date());
			recordsDao.updateBean(bean);;
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('提交成功');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
			
		}
		else {
			response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('该电影您已记录过，添加失败');window.location.href='indexmethod!xq_movie?id="+id+"'; </script>");
		}
		
	}
	
	

	//删除记录操作
	public void recordsdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String id = request.getParameter("id");
		Records bean =recordsDao.selectBean(" where id= "+id);
		bean.setDeletestatus(1);
		recordsDao.updateBean(bean);
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('删除成功');window.location.href='indexmethod!recordslist'; </script>");
		
	}
	
	
	
	/*************我的影评****************/
	//我的影评列表
	public String evaluatelist(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");	
		StringBuffer sb = new StringBuffer();
		sb.append(" where ");
		sb.append(" user="+user.getId()+" and deletestatus=0 order by id desc ");
		String where = sb.toString();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		long total = evaluateDao.selectBeanCount(where.replaceAll("order by id desc", ""));
		List<Evaluate> list = evaluateDao.selectBeanList((currentpage-1)*pagesize, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "indexmethod!evaluatelist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("evaluatelist.jsp");
		return SUCCESS;
	}
	
	
	//删除我的影评操作
	public void evaluatedelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String id = request.getParameter("id");
		Evaluate bean =evaluateDao.selectBean(" where id= "+id);
		bean.setDeletestatus(1);
		evaluateDao.updateBean(bean);
		response.setCharacterEncoding("utf-8");response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('删除成功');window.location.href='indexmethod!evaluatelist'; </script>");
		
	}
	
	
	
	
}
