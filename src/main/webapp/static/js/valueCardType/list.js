//储值卡类型查询
function loadData(query) {
    $('#listTable').dataTable({
        "filter": false,//去掉搜索框
        "ordering": false, // 是否允许排序
        "paginationType": "full_numbers", // 页码类型
        "destroy": true,
        "processing": true,
        "serverSide": true,
        "scrollX": true, // 是否允许左右滑动
        "displayLength": 10, // 默认长度
        "ajax": { // 请求地址
            url: ctxURL + "/valueCardType/searchValueCardTypeForPage.ajax?t=" + new Date().getTime() + "&" + query,
            type: 'post'
        },
        "columns": [ // 数据映射
            {
                "data": "cid",
                "render": function (data) {
                    return '<input name="cardTypeId" value="' + data + '" type="checkbox" />';
                }
            },
            {
                "data": "cid",
                "render": function (data, type, full) {
                    return '<a href="javascript:void(0)" onclick="editType(\'' + data + '\')">修改</a>&nbsp;&nbsp;' +
                        '<a href="javascript:void(0)" onclick="preparedelType(\'' + full.logicCode + '\')">删除</a>';
                }
            },
            {"data": "typeName"},
            {"data": "showName"},
            {"data": "cardTypeStr"},
            {
                "data": "rechargeAmount",
                "render": function (data) {
                    return data;
                }
            },
            {"data": "createTimeStr"},
            {"data": "createUserName"},
            {
                "data": "validMonth",
                "render": function (data) {
                    return data + "个月";
                }
            },
            {"data": "serviceTypeName"},

            {"data": "remark"}
        ],
        "fnRowCallback": function (row, data) { // 每行创建完毕的回调
            // 每行分别记录ID
            $(row).data('id', data.cid);

            // 修改和删除阻止事件冒泡
            $(row).children().eq(0).click(function () {
                event.stopPropagation();
            });
        }
    });
}

function editType(data) {
    $.showModal("储值卡类型修改", ctxURL + '/valueCardType/saveValueCardType.htm',{'cardTypeId':data});
}


function preparedelType(data) {
    $.showModal("储值卡类型删除", ctxURL + '/valueCard/prepareDelValueCardType.htm',{'valueCardTypeCode':data});
}


$(document).ready(function () {
    loadData($("#searchForm").serialize());

    // 查询按钮
    $("#queryBtn").click(function () {
        loadData($("#searchForm").serialize());
    });

    //储值卡类型保存
    $("#addButton").click(function () {
        $.showModal("储值卡类型-保存", ctxURL + '/valueCardType/saveValueCardType.htm',{'cardTypeId':null});
    });

    //绑定优惠码类型
    $("#bindButton").click(function () {
        if ($("input[name='cardTypeId']:checked").length <= 0) {
            $.showMessage('请选择一条记录','储值卡类型选择');
            return false;
        }
        if ($("input[name='cardTypeId']:checked").length >1) {
            $.showMessage('仅允许选择一条记录','储值卡类型选择');
            return false;
        }
        var row =  $($("input[name='cardTypeId']:checked")[0]).parent().parent();
        var id = row.data('id');
        $.showModal("优惠码-绑定", ctxURL + '/valueCardTypePromotion/bindCardTypePromotion.htm',{'cardTypeId':id});
    });

    //重置按钮
    $("#resetButton").click(function () {
        $("#valueCardName").text(null);
        $("#valueCardType").val(null);
    });
});