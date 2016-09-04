$(function(){
        $.validator.addMethod( "specialCheck", function( value, element ) {
        var pattern = new RegExp(("[`~@#$^&*()=|{}''\\[\\]<>&*|{}【】‘']") ) ;
        if(pattern.test(value)) {
            return false;
        } else {
            return true;
        }
    }, "不能输入该特殊字符" );
})


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
                maxlength:50,
                special: true
            },
            showName:{
                required:true,
                maxlength:8,
                special: true
            },
            valueCardType: "required",

            rechargemAount:{
                required:true,
                maxlength:10,
                min:1,
                digits:true
            },
            serviceType: "required",
            validMonth:{
                required:true,
                range:[1, 100],
                digits:true
            },
            saleChannel:"required",
            remark:{
                maxlength:100,
                specialCheck:true
            }
        }
    }).form();
}