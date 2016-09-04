/**
 * <p>管理</p>
 *
 * <PRE>
 * <BR>    修改记录
 * <BR>-----------------------------------------------
 * <BR>    修改日期            修改人            修改内容
 * </PRE>
 *
 * @author liyn73
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
    $('#listTable').dataTable({

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
            "url" : ctxURL+"/employee/search.ajax?t=" + new Date().getTime() + "&" + query,
            "type" : "POST"
        },
        "columns" : [
            {
                //"data": "employeeId",
                "render": function (data) {
                    return '<input name="orderCheckBox" value="' + data + '" type="checkbox" />';
                }
            },
            {"data": "userName"},
            {"data" : "loginAccount"},
            {"data" : "email"},
            {"data" : "departmentCode"},
            {"data" : "positionName"},
            {"data" : "companyCode"},
            {"data" : "cityCode"},
            {"data" : "isValid"}
        ]
    });
}


$('#orderCheckBox').click(function () {
    var value = $('#orderCheckBox').prop('checked');
    $("input[name='orderCheckBox']").each(function (index, element) {
        $(element).prop('checked', value);
    });
});