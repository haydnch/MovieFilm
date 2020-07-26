package util;

import dao.EvaluateDao;
import dao.UserDao;
import model.Evaluate;
import model.User;

import java.util.*;
import java.util.Map.Entry;

public class RecommendByUCF {
	
	
	   private  UserDao userDao;	
		private EvaluateDao evaluateDao;
		
	////建立所有对电影评过分的{user movie}map集合
	public  HashMap<String,List<HashMap<String, String>>> AllUserMovie()
	{
		HashMap<String,List<HashMap<String, String>>> res =
				new HashMap<String,List<HashMap<String, String>>>(); //建立所有对电影评过分的{user movie}map集合
		//{userid=[{movieid,rating}...]}
		
	   List<User> users=userDao.selectAllUser("  where deletestatus=0 order by id");
	  // List<Movie> movies=movieDao.selectAllMovie("where movielock=0 order by id ");
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
	   return res;
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
			double sum1=rating1.stream().mapToInt(x->x).sum();
			double sum2=rating2.stream().mapToInt(x->x).sum();
			//计算评分平方和
			for(int i=0;i<len;i++)
			{
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


		//计算与给定用户最相似的5位用户{user:similar...}
		public  HashMap<String, Double> top5_similar_pearson(HashMap<String,List<HashMap<String, String>>> res,List<User> users,String user)
		{
			HashMap<String, Double> result =new HashMap<String,Double>();
			for(User u:users)
			{
				if(!String.valueOf(u.getId()).equals(user))
				{
					double similar=pearson_sim(res, user,String.valueOf(u.getId()));
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
			int len=result.size()<5?result.size():5;
			int i=0;
			HashMap<String, Double> re =new HashMap<String,Double>();
			for(Entry<String, Double> k:result.entrySet())
			{
				if(i<len) {
					re.put(k.getKey(), k.getValue());
				     i++;
				}
				else
					break;
			}
			return re;
		}
		
		//返回推荐给 指定用户的十部电影
		public  List<Integer> RecommendedMovie(HashMap<String,List<HashMap<String, String>>> res,List<User> users,String user)
		{
			List<HashMap<String, String>> user_movie=res.get(user); //指定用户已经评过分的电影及评分，即不再推荐
			List<String> have_seen =new ArrayList<String>(); //存放指定用户已经评分电影的id
			for(HashMap<String, String> t:user_movie)
			{
				have_seen.add(String.join("", t.keySet()));
			}
			List<Integer> result =new ArrayList<Integer>(); //存放推荐的电影的id
			HashMap<String, Double> recommend_user = top5_similar_pearson(res, users, user);
			for(String u:recommend_user.keySet())
			{
				List<HashMap<String, String>> ms=res.get(u);//得到该用户评分过的电影
				for(HashMap<String, String> m:ms )
				{
					String mid=String.join("", m.keySet());//该电影id
					String rid=m.get(mid); //该电影的评分
					if(!have_seen.contains(mid)&&Integer.parseInt(rid)>=3)
					{
						result.add(Integer.parseInt(mid));
					}
				}
			}
			int len=result.size()<10?result.size():10;
			//System.out.println(mid);	
			return result.subList(0, len);
		}
		

}
