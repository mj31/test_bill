
// 保存储值卡类型
function saveValueCardType(){
    if (!valueCardTypeValidate()){
        return;
    }
    var providerOrders = $("#providerOrders").val();
    $.ajax({
        url: ctxURL + '/valueCardType/submitValueCardType.ajax?&t='+new Date().getTime(),
        type: 'POST',
        data: $("#valueCardTypeForm").serialize(),
        dataType: 'json',
        success: function (data) {
            if (data.status != '0') {
                $.closeProcessModal();
                $.showMessage("错误提示： " + data.message);
            } else {
                $.closeProcessModal();
                $.showMessage("成功提示： " + data.message);
                loadData($("#listTable").serialize());
            }
        },
        error: function (xhr) {
            $.closeProcessModal();
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
    $.closeProcessModal();
}

// form表单验证
function valueCardTypeValidate() {
    var icon = "<i class='fa fa-times-circle'></i> ";
    return $("#valueCardTypeForm").validate({
        rules: {

            valueCardName:{
                required:true,
                maxlength:50

            },
            showName:{
                required:true,
                maxlength:8

            },
            valueCardType: "required",

            rechargemAount:{
                required:true,
                maxlength:10,
                digits:true

            },
            serviceType: "required",
            validMonth:{
                required:true,
                maxlength:11,
                number:true

            },
            saleChannel:"required",
            remark:{
                maxlength:100
            }
        },
        messages: {
            signContent: icon + "请输入标记的具体内容"
        }
    }).form();
}

function CheckInputIntFloat(oInput)
{
    if('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,2}/,''))
    {
        oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,2}/) == null ? '' :oInput.value.match(/\d{1,}\.{0,1}\d{0,2}/);
    }
}
