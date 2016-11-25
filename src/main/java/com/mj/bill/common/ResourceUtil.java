package com.mj.bill.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

public class ResourceUtil {
	public static String loadFileFromClassPath(String file_path)
			throws Exception {
		InputStream is = Thread.currentThread().getContextClassLoader()
				.getResourceAsStream(file_path);
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		String tmp = null;
		StringBuilder sb = new StringBuilder();
		while (true) {
			tmp = br.readLine();
			if (tmp == null)
				break;
			sb.append(tmp);
			sb.append("\n");
		}

		return sb.toString();
	}

	public static URL loadURLFromClassPath(String file_path) throws Exception {
		return Thread.currentThread().getContextClassLoader()
				.getResource(file_path);
	}

	public static InputStream loadInputStreamFromClassPath(String file_path)
			throws Exception {
		return Thread.currentThread().getContextClassLoader()
				.getResourceAsStream(file_path);
	}

	public static Properties loadPropertiesFromClassPath(String file_path)
			throws Exception {
		Properties pc = new Properties();
		pc.load(loadInputStreamFromClassPath(file_path));
		return pc;
	}

	public static Properties loadPropertiesFromClassPath(String filePath,
			String prefix, boolean isDiscardPrefix) throws Exception {
		Properties rtn = new Properties();
		Properties pc = loadPropertiesFromClassPath(filePath);
		Set key = pc.keySet();
		for (Iterator iter = key.iterator(); iter.hasNext();) {
			String element = (String) iter.next();
			if (StringUtils.indexOf(element, prefix) != -1) {
				if (isDiscardPrefix == true) {
					rtn.put(StringUtils.replace(element, prefix + ".", "")
							.trim(), pc.get(element));
				} else {
					rtn.put(element, pc.get(element));
				}
			}
		}
		return rtn;
	}
}
