/**
 * Created by wurt2 on 2016/8/3.
 */

var selectNode;

function loadTree() {

    var treeData;

    $.ajax({
        type: "POST",
        async: false,
        dataType: 'json',
        url: ctxURL + '/resource/get',
        success: function (data) {
            treeData = data;
        }
    });

    treeview = $('#resourceTree').treeview({
        data: treeData,
        onNodeSelected: function (event, node) {
            selectNode = node;
            loadRoleTable();
        },
        onNodeUnselected: function () {
            selectNode = null;
            $('#roleDiv').hide();
        }
    });
}

function loadRoleTable() {
    $('#roleDiv').show();
    $('#roleTable').dataTable({
        "filter" : false,//去掉搜索框
        "ordering" : false,//是否允许排序
        "paging" : false,
        "destroy" : true,
        "info": false, // 是否显示左下角信息
        "processing" : true,
        "serverSide" : true,
        "scrollX" : true,//是否显示左右滑动框
        "displayLength" : 10,//默认页面记录数
        "ajax":{
            "url" : ctxURL+"/resource/role.ajax?t=" + new Date().getTime() + "&logicCode=" + selectNode.logicCode,
            "type" : "POST"
        },
        "columns" : [
            {"data": "roleName"},
            {
                "data" : "cid",
                "render": function (data) {
                    return '<a href="javascript:void(0)" onclick="toDeletePermission(\'' + data + '\')">删除</a>';
                }
            }

        ]
    });
}

$(document).ready(function () {
    loadTree();
})

function toAddResource() {
    var parentResourceCode = '';
    if (selectNode != null && selectNode != undefined) {
        parentResourceCode = selectNode.logicCode;
    }
    $.showModal("添加菜单", ctxURL + "/resource/toAdd", {'parentResourceCode': parentResourceCode});
}

function toUpdateResource() {
    if (selectNode == undefined || selectNode == null) {
        $.showMessage("请选择要编辑的菜单");
        return;
    }
    $.showModal('编辑菜单', ctxURL + "/resource/toUpdate", {
        'logicCode': selectNode.logicCode,
        'resourceName': selectNode.text,
        'resourceUrl': selectNode.resourceUrl,
        'rank': selectNode.rank
    });
}

function toDeleteResource() {
    if (selectNode == undefined || selectNode == null) {
        $.showMessage("请选择要删除的菜单");
        return;
    }
    $.showModal('编辑菜单', ctxURL + "/resource/toDelete", {'logicCode': selectNode.logicCode});
}

function toAddPermission() {
    if (selectNode == undefined || selectNode == null) {
        $.showMessage("请选择要添加角色的菜单");
        return;
    }

    $.showModal('添加角色', ctxURL + "/resource/toAddPermission", {
        'logicCode': selectNode.logicCode,
        'resourceName': selectNode.text
    });
}

function toDeletePermission(roleId) {
    if (selectNode == undefined || selectNode == null) {
        $.showMessage("请选择要添加角色的菜单");
        return;
    }

    $.showModal('删除角色', ctxURL + "/resource/toDeletePermission", {
        'logicCode': selectNode.logicCode,
        'roleId': roleId
    });
}