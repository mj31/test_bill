/**
 * <p></p>
 *
 * <PRE>
 * <BR>    修改记录
 * <BR>-----------------------------------------------
 * <BR>    修改日期            修改人            修改内容
 * </PRE>
 *
 * @author caoshoujun
 * @date 2016/7/20 9:24
 * @since 1.0
 * @version 1.0
 */
function updateState() {
    $.ajax({
        url : ctxURL + "/valueCard/updateCardState.ajax?t=" + new Date().getTime(),
        data : $("#updateStateForm").serialize(),
        dataType : 'json',
        type : 'POST',
        success : function (result) {
            if(result.status == '0'){
                $.showMessage(result.message);
                loadData($("#searchForm").serialize());
                $.closeProcessModal();
            }else{
                $.showMessage("错误提示： " + result.message);
                $.closeProcessModal();
            }
        },
        error : function (xhr) {
            $.showMessage("错误提示：" + xhr.status + " " + xhr.statusText);
            $.closeProcessModal();
        }
    });
}