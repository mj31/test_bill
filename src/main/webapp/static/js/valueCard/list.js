/**
 * <p>储值卡管理</p>
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

$(document).ready(function () {
    loadData($("#searchForm").serialize());

    //查询按钮
    $("#queryBtn").click(function () {
        loadData($("#searchForm").serialize());
    })
})


function loadData(query) {
    $('#valueCardLogDiv').hide();
    $('#listCardTable').dataTable({
        "filter" : false,//去掉搜索框
        "ordering" : false,//是否允许排序
        "paginationType" : "full_numbers",//页码类型
        "destroy" : true,
        "processing" : true,
        "serverSide" : true,
        "scrollX" : true,//是否显示左右滑动框
        "displayLength" : 10,//默认页面记录数
        "lengthMenu" : [10, 25, 50],
        "ajax":{
            "url" : ctxURL+"/valueCard/search.ajax?t=" + new Date().getTime() + "&" + query,
            "type" : "POST"
        },
        "columns" : [
            {
                "data": "cid",
                "render": function (data) {
                    return '<input name="valueCardCheckBox" value="' + data + '" type="checkbox" />';
                }
            },
            {"data" : "valueCardName"},
            {"data" : "cardNumber"},
            {"data" : "cardState",
                "render": function (data) {
                    switch (data){
                        case 1 : return "未激活";
                        case 2 : return "可用";
                        case 3 : return "禁用";
                        case 4 : return "过期";
                        case 5 : return "作废";
                        default : return data;
                    }
                }
            },
            {"data" : "outboundState",
                "render" : function (data) {
                    switch (data){
                        case 1 : return "已出库";
                        case 2 : return "未出库";
                        default : return data;
                    }
                }
            },
            {"data" : "activeState",
                "render": function (data) {
                    if(data == 1){
                        return "已激活";
                    }else if(data == 2){
                        return "未激活";
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "userName"},
            {"data" : "userMobile"},
            {"data" : "totalAmount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "cardAmount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "consumeAmount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "remainAmount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "createTime"},
            {"data" : "activeTime"},
            {"data" : "endTime"},
            {"data" : "lastUseTime"}

        ],
        "fnDrawCallback" : addTrSelectTrigger,//表单创建完毕后回调
        "fnRowCallback" : function (row, data) {//每行创建完毕后回调
            //每行粉笔记录ID
            $(row).data('id',data.cid);
            $(row).data('logicCode',data.logicCode);
            $(row).data('cardNumber',data.cardNumber);
            $(row).data('outboundState',data.outboundState);
            $(row).data('activeState',data.activeState);
            $(row).data('cardState',data.cardState);
            $(row).children().eq(0).click(function () {
                event.stopPropagation();
            });
        }
    });
}

$('#allValueCardCheckBox').click(function () {
    var value = $('#allValueCardCheckBox').prop('checked');
    $("input[name='valueCardCheckBox']").each(function (index, element) {
        $(element).prop('checked', value);
    });
});

//每行选中触发事件
function addTrSelectTrigger() {
    //点击某行获取储值卡的跟进记录
    $('#listCardTable tbody tr').click(function () {
        $('#valueCardLogDiv').show();
        var hasClass = $(this).hasClass('selected');
        //添加选中状态
        $(this).siblings().removeClass('selected');
        $(this).addClass('selected');
        var valueCardNumber = $(this).data('cardNumber');
        $("#valueCardNumber").html("卡号"+valueCardNumber);
        var valueCardLogicCode = $(this).data('logicCode');
        loadValueCardLog(valueCardLogicCode);
    });
}



function loadValueCardLog(valueCardLogicCode) {
    $('#subOrderIBox').hide();
    $('#listValueVardLogTable').dataTable({
        "paging" : false,
        "filter" : false,//去掉搜索框
        "ordering" : false,//是否允许排序
        "destroy" : true,
        "processing" : true,
        "serverSide" : true,
        "scrollX" : true,//是否显示左右滑动框
        "displayLength" : 10,//默认页面记录数
        "info" : false,//是否显示左下角信息
        "ajax":{
            "url" : ctxURL+"/valueCard/findValueCardLog.ajax?t=" + new Date().getTime() + "&valueCardCode=" + valueCardLogicCode,
            "type" : "POST"
        },
        "columns" : [
            {"data" : "createTime"},
            {"data" : "recordType",
                "render":function (data) {
                    switch (data){
                        case 1 : return "充值";
                        case 2 : return "绑定激活";
                        case 3 : return "消费";
                        case 4 : return "过期";
                        case 5 : return "作废";
                        case 6 : return "禁用";
                        case 7 : return "解除禁用";
                        default : data;
                    }
                }
            },
            {"data" : "createUserName"},
            {"data" : "amount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "remainAmount",
                "render": function (data) {
                    if(data > 0){
                        return data/100;
                    }else{
                        return data;
                    }
                }
            },
            {"data" : "description"}
        ]
    });
}


//发卡时间日期插件
var startCreateTime = {
    elem:'#startCreateTime',
    format:'YYYY-MM-DD',//日期格式
    istime:false,//是否开启时间选择
    isclear:true,//是否显示清空
    istoday:true,//是否显示今天
    issure:true,//是否显示确认
    festival:false,//是否显示节日
    fixed:false,//是否固定在可视区域
    zIndex:99999999, //csss z-index ?
    choose:function (data) {//选择日期后执行的的函数
        endCreateTime.min = data ;
        endCreateTime.start = data;
    }
}

var endCreateTime = {
    elem:'#endCreateTime',
    format:'YYYY-MM-DD',
    istime:false,
    isclear:true,
    istoday:true,
    issure:true,
    festival:false,
    fixed:false,
    zIndex:99999999,
    choose:function (data) {
        startCreateTime.max = data;
    }
}

laydate(startCreateTime);
laydate(endCreateTime);

//最后使用时间日期插件
var startLastModifyTime = {
    elem:'#startLastModifyTime',
    format:'YYYY-MM-DD',//日期格式
    istime:false,//是否开启时间选择
    isclear:true,//是否显示清空
    istoday:true,//是否显示今天
    issure:true,//是否显示确认
    festival:false,//是否显示节日
    fixed:false,//是否固定在可视区域
    zIndex:99999999, //csss z-index ?
    choose:function (data) {//选择日期后执行的的函数
        endLastModifyTime.min = data ;
        endLastModifyTime.start = data;
    }
}

var endLastModifyTime = {
    elem:'#endLastModifyTime',
    format:'YYYY-MM-DD',
    istime:false,
    isclear:true,
    istoday:true,
    issure:true,
    festival:false,
    fixed:false,
    zIndex:99999999,
    choose:function (data) {
        startLastModifyTime.max = data;
    }
}

laydate(startLastModifyTime);
laydate(endLastModifyTime);

/**
 * 生成储值卡初始化
 */
function createValueCard() {
    $.showModal("储值卡生成", ctxURL + '/valueCard/createInit.htm');
}

/**
 * 出库储值卡初始化
 */
function outboundValueCard() {
    var valueCardIds = [];
    var outboundValueCardCount = 0;
    if ($("input[name='valueCardCheckBox']:checked").length <= 0) {
        $.showMessage('请至少选择一张未出库的储值卡');
        return false;
    }
    $("input[name='valueCardCheckBox']:checked").each(function (index, element) {
        var row = $(element).parent().parent();
        var outboundState = row.data('outboundState');
        //alert(row.data('id'))
        if(outboundState != 1){
            valueCardIds[outboundValueCardCount++] = row.data('id');
        }

    });
    if (outboundValueCardCount == 0) {
        $.showMessage('请至少选择一张未出库的储值卡');
        return false;
    }
    valueCardIds = valueCardIds.join(",");
    $.showModal("储值卡出库", ctxURL + '/valueCard/outboundInit.htm?valueCardIds='+valueCardIds+'&outboundValueCardCount='+outboundValueCardCount);
}

/**
 * 储值卡启用/禁用操作
 */
function enableOrDisableValueCard() {
    //获取被选中
    if ($("input[name='valueCardCheckBox']:checked").length != 1) {
        $.showMessage('请选择一张储值卡进行操作');
        return false;
    }
    var row = $("input[name='valueCardCheckBox']:checked").parent().parent();
    var valueCardId = row.data('id');
    var activeState = row.data('activeState');
    if(activeState != 1){
        $.showMessage('请选择已激活的储值卡进行操作');
        return false;
    }
    if(cardState == 4){
        $.showMessage('请选择未过期的储值卡进行操作');
        return false;
    }
    var cardState = row.data('cardState');
    if(cardState == 5){
        $.showMessage('请选择未作废的储值卡进行操作');
        return false;
    }
    if(cardState == 2){//如果储值卡处于可用状态，进行储值卡禁用操作
        cardState = 3;
        $.showModal("储值卡禁用", ctxURL + '/valueCard/updateCardStateInit.htm?valueCardId='+valueCardId+'&cardState='+cardState);
    }else if(cardState == 3){//如果储值卡处于不可用状态，进行储值卡启用操作
        cardState = 2;
        $.showModal("储值卡启用", ctxURL + '/valueCard/updateCardStateInit.htm?valueCardId='+valueCardId+'&cardState='+cardState);
    }else{
        $.showMessage('请选择可启用可用或禁用的储值卡进行操作');
        return false;
    }


}

/**
 * 储值作废操作
 */
function validValueCard() {
    //获取被选中
    if ($("input[name='valueCardCheckBox']:checked").length != 1) {
        $.showMessage('请选择一张储值卡进行操作');
        return false;
    }
    var row = $("input[name='valueCardCheckBox']:checked").parent().parent();

    var cardState = row.data('cardState');
    if(cardState == 2){//如果储值卡处于可用状态，进行储值卡作废操作
        cardState = 5;
    }else{//如果储值卡处于不可用状态，进行错误提示
        $.showMessage('请选择处于可用状态的储值卡进行作废操作');
        return false;
    }
    var valueCardId = row.data('id');
    $.showModal("储值卡作废", ctxURL + '/valueCard/updateCardStateInit.htm?valueCardId='+valueCardId+'&cardState='+cardState);
}

function searchAccountLog() {
    $.showModal("账户查询", ctxURL + '/valueCard/toAccountLog', {}, 2);
}
