package com.mj.bill.common;

/**
 * <p></p>
 * <p/>
 * <PRE>
 * <BR>	修改记录
 * <BR>-----------------------------------------------
 * <BR>	修改日期			修改人			修改内容
 * </PRE>
 *
 * @author sence
 * @version 1.0
 * @since 1.0
 */
public class ResponseDto{

    public final static String SUCCESS = "0";
    public final static String FAILED = "1";
    
    public final static String OLDSUCCESS = "success";
    public final static String OLDFAILED = "failure";
    /**
     * 0:成功,1:失败，其他：具体沟通
     */
    private String status;
    /**
     * 错误反馈信息
     */
    private String message;
    /**
     * 响应数据
     */
    private Object data;

    public ResponseDto(String message) {
        this.status = FAILED;
        this.message = message;

    }

    public ResponseDto(String status, String message) {
        this.status = status;
        this.message = message;

    }

    public ResponseDto(Object data) {
        this.status = SUCCESS;
        this.data = data;

    }

    public ResponseDto() {

    }

    /**
     * @param obj
     * @return
     */
    public static ResponseDto responseOK(Object obj) {
        ResponseDto responseDto = new ResponseDto();
        responseDto.setStatus(SUCCESS);
        responseDto.setData(obj);
        return responseDto;
    }

    /**
     * @param str
     * @return
     */
    public static ResponseDto responseFail(String str) {
        ResponseDto responseDto = new ResponseDto();
        responseDto.setStatus(FAILED);
        responseDto.setMessage(str);
        return responseDto;
    }
    /**
     * @param str
     * @return
     */
    public static ResponseDto responseFail(String str,String code) {
        ResponseDto responseDto = new ResponseDto();
        responseDto.setStatus(code);
        responseDto.setMessage(str);
        return responseDto;
    }
    public static ResponseDto responseOK(Object obj,String message) {
        ResponseDto responseDto = new ResponseDto();
        responseDto.setStatus(SUCCESS);
        responseDto.setData(obj);
        responseDto.setMessage(message);
        return responseDto;
    }
    
    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
