function delType(datas) {
    $.ajax({
        url: ctxURL + '/valueCardType/deleteValueCardType.ajax?&t=' + new Date().getTime(),
        type: 'POST',
        data: {'cardTypeCode': datas},
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
            $.showMessage("错误提示： " + xhr.status + " " + xhr.statusText);
        }
    });
}