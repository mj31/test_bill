// 保存储值卡类型
function bindPromotionType() {
    if (!bindPromotionTypeValidate()) {
        return;
    }
    $.ajax({
        url: ctxURL + '/valueCardTypePromotion/submitCardTypePromotion.ajax?&t=' + new Date().getTime(),
        type: 'POST',
        data: $("#bindPromotionTypeForm").serialize(),
        dataType: 'json',
        success: function (data) {
            if (data.status != '0') {
                $.showMessage("错误提示： " + data.message);
            } else {
                var typeId = $('#valueCardTypeId').val();
                $.showMessage("成功提示： " + data.message);
                $.showLoading($('#processModalBody'));
                $('#processModalBody').load(ctxURL + '/valueCardTypePromotion/bindCardTypePromotion.htm', {'cardTypeId': typeId});
            }
        },
        error: function (xhr) {
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
}

// form表单验证
function bindPromotionTypeValidate() {
    var icon = "<i class='fa fa-times-circle'></i> ";
    return $("#bindPromotionTypeForm").validate({
        rules: {
            promotionTypeId: {
                required: true,
                rangelength: [32, 32],
                special: true
            },
            promotionTypeName: {
                required: true,
                maxlength: 100,
                special: true
            },
            endMonth: {
                required: true,
                range: [1, 100],
                digits: true
            },
            sendCount: {
                required: true,
                range: [1, 100],
                digits: true
            },
            sendPrice: {
                required: true,
                min: 1,
                digits: true
            }
        }
    }).form();
}

function delPromotionType(id, obj) {
    $.ajax({
        url: ctxURL + '/valueCardTypePromotion/deleteValueCardTypePromotion.ajax?&t=' + new Date().getTime(),
        type: 'POST',
        data: {'cardTypePromotionId': id},
        dataType: 'json',
        success: function (data) {
            if (data.status != '0') {
            } else {
                $.showMessage("成功提示： " + data.message);
                $(obj).parent().parent().remove();
            }
        },
        error: function (xhr) {
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
}
