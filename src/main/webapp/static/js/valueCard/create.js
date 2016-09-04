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
 * @since 1.0
 * @version 1.0
 */
/**
 * 查询储值卡类型
 * @param serviceTypeId
 */
function findCardType() {
    var serviceTypeId = $("#serviceType").val();
    var select = document.getElementById("valueCardTypeCode");
    select.options.length = 0;
    select.options.add(new Option("请选择", ""));
    $.ajax({
        url : ctxURL+"/valueCard/findAllCardType.ajax",
        type : "POST",
        data: {"serviceTypeId": serviceTypeId, "t": new Date().getTime()},
        dataType: 'json',
        success : function(data) {
            if(data.status=="0") {
                // 返回结果
                var list = data.data;
                //循环对象取值
                $.each(list,function(idx,item){
                    select.options.add(new Option(item.showName, item.logicCode));
                });
            }else {
                $.showMessage(data.message);
                $.closeProcessModal();
            }
        },
        error: function (xhr) {
            $.closeProcessModal();
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
}

function setCardTypeIdAndRechargemAount(data) {
    var datas = data.split("_");
    $("#valueCardTypeCode").val(datas[0]);
    $("#rechargeAmount").val(datas[1]);
}
/**
 * 生成储值卡
 */
function saveValueCard(){
    if (!valueCardValidate()) {
        return;
    }

    $.ajax({
        url : ctxURL+"/valueCard/save.ajax?t=" + new Date().getTime(),
        data: $("#createValueCardForm").serialize(),
        dataType: 'json',
        success: function (data) {
            if (data.status == '0') {
                $.showMessage("操作成功！");
                loadData($("#searchForm").serialize());
                $.closeProcessModal();
            } else {
                $.showMessage("错误提示： " + data.message);
            }
        },
        error: function (xhr) {
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
}

// form表单验证
function valueCardValidate() {
    var icon = "<i class='fa fa-times-circle'></i> ";
    return $("#createValueCardForm").validate({
        rules: {
            serviceType: {
                required:true
            },
            valueCardTypeCode: {
                required:true
            },
            valueCardType: "required",

            valueCardCount: {
                required: true,
                min: 1,
                maxlength: 4,
                digits: true
            }
        }
    }).form();
}

