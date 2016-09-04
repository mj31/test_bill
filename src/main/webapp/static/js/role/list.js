/**
 * Created by wurt2 on 2016/8/2.
 */
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
    $('#roleTable').dataTable({
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
            "url" : ctxURL+"/role/search.ajax?t=" + new Date().getTime() + "&" + query,
            "type" : "POST"
        },
        "columns" : [
            {
                "data": "logicCode",
                "render": function (data, type, full) {
                    return '<a href="javascript:void(0)" onclick="toUpdateRole(\'' + data + '\', \'' + full.roleName + '\', \'' + full.resourceName + '\')">修改</a>&nbsp;&nbsp;' +
                        '<a href="javascript:void(0)" onclick="toAddUserRole(\'' + data + '\', \'' + full.roleName + '\')">职能赋权</a>&nbsp;&nbsp;'　+
                        '<a href="javascript:void(0)" onclick="toDeleteRole(\'' + data + '\')">删除</a>';
                }
            },
            {"data": "roleName"},
            {"data" : "logicCode"},
            {"data" : "resourceName"},
            {"data" : "createTime"}

        ],
        "fnRowCallback" : function (row, data) {//每行创建完毕后回调
            //每行粉笔记录ID
            $(row).data('logicCode',data.logicCode);
        }
    });
}

/**
 * 展示添加角色的弹框
 */
function toAddRole() {
    $.showModal("添加角色", ctxURL + '/role/toAdd');
}

function toUpdateRole(logicCode, roleName, resourceName) {
    $.showModal("编辑角色", ctxURL + '/role/toUpdate', {
        'logicCode': logicCode,
        'roleName': roleName,
        'resourceName': resourceName
    });
}

function toDeleteRole(logicCode) {
    $.showModal("删除角色", ctxURL + '/role/toDelete', {'logicCode': logicCode});
}

function toAddUserRole(logicCode, roleName) {
    $.showModal("职能赋权", ctxURL + '/role/toAddUserRole', {
        'logicCode': logicCode,
        'roleName': roleName
    });
}