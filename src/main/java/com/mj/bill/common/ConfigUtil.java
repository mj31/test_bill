package com.mj.bill.common;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



public class ConfigUtil {
	
	private final static transient Log logger = LogFactory.getLog(ConfigUtil.class);

	// 读取Properties文件信息
	public static Properties properties = null ;
	
	static {
		
		try {
			properties = ResourceUtil.loadPropertiesFromClassPath("redis.properties");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}
	

	public static String getProperty(Properties property, String key) {
		String value=property.getProperty(key);
		if(StringUtils.isNotEmpty(value)) {
			try {
				value=new String(value.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				logger.error(e.getMessage(), e);
			}
		}
		return value;
	}
			
}
