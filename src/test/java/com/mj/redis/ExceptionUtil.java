package com.mj.redis;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * Created by homelink on 2016/12/14.
 */
public class ExceptionUtil {
    public static String getTrace(Throwable throwable) {
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        throwable.printStackTrace(writer);
        StringBuffer buffer = stringWriter.getBuffer();
        return buffer.toString();
    }
}

