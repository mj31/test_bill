package com.mj.bill.common;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisShardInfo;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;


public class RedisClient {
	// 日志输出
	private final static transient Log logger = LogFactory
			.getLog(RedisClient.class);
	
	private static final String REDIS_POOL_MAXACTIVE = "redis.maxActive";
	private static final String REDIS_POOL_MAXIDLE = "redis.maxIdle";
	private static final String REDIS_POOL_MAXWAIT = "redis.maxWait";
	private static final String REDIS_POOL_TESTONBORROW = "redis.testOnBorrow";
	private static final String REDIS_IP = "redis.host";
	private static final String REDIS_PORT = "redis.port";
	private String PROJECT_NAME = "BILL_";
	// redis客户端
	private static RedisClient client = null;
			  
	// redis池
	private ShardedJedisPool pool;

	private boolean isInit = false;

	private RedisClient() {
		// 初始化redis池
		init();
	}

	// 单例返回 RedisClient
	public static RedisClient getInstance() {
		if (client == null) {
			synchronized (RedisClient.class) {
				if (client == null) {
					client = new RedisClient();
				}
			}
		}
		return client;
	}

	// 初始化 redis池
	private synchronized void init() {
		if (isInit == false) {
			// 读取配置文件
			JedisPoolConfig cfg = new JedisPoolConfig();
			String maxActive = ConfigUtil.properties
					.getProperty(REDIS_POOL_MAXACTIVE);
			if (StringUtils.isNotBlank(maxActive)) {
				try {
					int _maxActive = Integer.parseInt(maxActive);
					cfg.setMaxActive(_maxActive);
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
				}
			}
			String maxIdle = ConfigUtil.properties
					.getProperty(REDIS_POOL_MAXIDLE);
			if (StringUtils.isNotBlank(maxIdle)) {
				try {
					int _maxIdle = Integer.parseInt(maxActive);
					cfg.setMaxIdle(_maxIdle);
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
				}
			}
			String maxWait = ConfigUtil.properties
					.getProperty(REDIS_POOL_MAXWAIT);
			if (StringUtils.isNotBlank(maxWait)) {
				try {
					int _maxWait = Integer.parseInt(maxWait);
					cfg.setMaxWait(_maxWait);
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
				}
			}
			String testOnBorrow = ConfigUtil.properties
					.getProperty(REDIS_POOL_TESTONBORROW);
			if (StringUtils.isNotBlank(testOnBorrow)) {
				try {
					boolean _testOnBorrow = Boolean.parseBoolean(testOnBorrow);
					cfg.setTestOnBorrow(_testOnBorrow);
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
				}
			} else {
				cfg.setTestOnBorrow(true);
			}

			String redisIp = ConfigUtil.properties.getProperty(REDIS_IP);

			// redis 端口地址
			String redisPort = ConfigUtil.properties.getProperty(REDIS_PORT);

			List<JedisShardInfo> shareInfoList = new ArrayList<JedisShardInfo>();

			JedisShardInfo shareInfo = new JedisShardInfo(redisIp, redisPort);
			shareInfoList.add(shareInfo);

			pool = new ShardedJedisPool(cfg, shareInfoList);
			isInit = true;
		}

	}

	/**
	 * 设置值
	 * 
	 * @param key
	 * @param value
	 * @param timeout
	 * @return
	 */
	public String set(String key, String value, int timeout) {
		key=PROJECT_NAME+key;
        ShardedJedis jedis = null;
        String result = null;
        try {
            jedis = pool.getResource();
            // 现将value数据转成json格式
            result = jedis.set(key, value);
            if (timeout > 0) {
                jedis.expire(key, timeout);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(jedis!=null)
                pool.returnResource(jedis);
        }

		return result;
	}

	/**
	 * 根据key获取键值
	 * 
	 * @param key
	 * @return
	 */
	public String get(String key) {
		key=PROJECT_NAME+key;
        String value = null;
        ShardedJedis jedis =null;
        try {
            jedis = pool.getResource();
            value = jedis.get(key);
            // 将key再转化
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(jedis!=null){
                pool.returnResource(jedis);
            }
        }
        return value;
	}

	/**
	 * 删除键值
	 * 
	 * @param key
	 * @return
	 */
	public Long delete(String key) {
		key=PROJECT_NAME+key;
        Long del = null;
        ShardedJedis jedis = null;
        try {
            jedis = pool.getResource();
            del = jedis.del(key);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(jedis!=null){
                pool.returnResource(jedis);
            }
        }
        return del;
	}

	/**
	 * 将 key 中储存的数字值增一。 如果 key 不存在，那么 key 的值会先被初始化为 0 ，然后再执行 INCR 操作
	 * 
	 * @param key
	 * @return
	 */
	public long increment(String key) {
        long incr = 0;
        ShardedJedis jedis =null;
        String newKey=PROJECT_NAME+key;
        try {
            jedis = pool.getResource();
            // 将 key 中储存的数字值增一
            incr = jedis.incr(newKey);
            if(incr>=9000000000000000000l){
                jedis.set(newKey,"0");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(jedis!=null){
                pool.returnResource(jedis);
            }
        }
        return incr;
	}
	
	public String incrKey(String key) {
		String newKey=PROJECT_NAME+key;
		RedisClient redisClient = RedisClient.getInstance();
		String KeyNum=redisClient.increment(newKey)+"";
		if(Long.parseLong(KeyNum)<10000000) {
			KeyNum="10000000";
			redisClient.set(key, "10000000", 0);
		}
		if(Long.parseLong(KeyNum)>99999998) {
			redisClient.set(key, "10000000", 0);
		}
		return KeyNum;
	}
	

	/**
	 * 
	 * 将消息放入队列
	 * @param key
	 * @param value
	 */
	public void lpush(String key, String value){
		key=PROJECT_NAME+key;
        ShardedJedis jedis =null;
        try {
            jedis= pool.getResource();
            jedis.lpush(key, value);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(jedis!=null){
                pool.returnResource(jedis);
            }
        }
    }
	/**
	 * 
	 * 从消息队列取出消息
	 * @param key
	 */
	public String rpop(String key){
		key=PROJECT_NAME+key;
        String msg = null;
        ShardedJedis jedis =null;
        try {
            jedis = pool.getResource();
            msg = jedis.rpop(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.returnResource(jedis);
        }
        return msg;
	}

}
