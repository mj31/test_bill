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
 * @date 2016/7/17 18:21
 * @since 1.0
 * @version 1.0
 */

function outbound() {
    var outboundReason = $("#outboundReason").val();
    if(outboundReason == ''){
        $.showMessage("请输入出库原因！");
        return false;
    }
    var valueCardIds = $("#valueCardIds").val();
    $("#valueCardIds").val(valueCardIds.split(","));
    $.ajax({
        url : ctxURL + "/valueCard/outbound.ajax?t=" + new Date().getTime(),
        data : $("#outboundValueCardForm").serialize(),
        dataType : 'json',
        type : 'POST',
        success : function (result) {
            if(result.status == '0'){
                $.showMessage("储值卡出库成功");
                loadData($("#searchForm").serialize());
                $.closeProcessModal();
            }else{
                $.showMessage("错误提示： " + result.message);
            }
        },
        error : function (xhr) {
            $.showMessage("错误提示：" + xhr.status + " " + xhr.statusText);
        }
    });
}
