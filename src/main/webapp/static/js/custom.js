$.extend({

    // 项目名称
    PROJECT_NAME: '/',
    // 默认显示的后台管理界面
    defaultUrl: null,

    /**
     * 打开新的Tab页
     *
     * @param id Tab页ID
     * @param dataUrl Tab页链接
     * @param menuName Tab页标题
     */
    openNewTab: function (id, dataUrl, menuName) {
        var flag = true;
        if (dataUrl == undefined || $.trim(dataUrl).length == 0)return false;
        // 选项卡菜单已存在
        $('.J_menuTab', window.parent.document).each(function () {
            if ($(this).data('id') == dataUrl) {
                if (!$(this).hasClass('active')) {
                    $(this).addClass('active').siblings('.J_menuTab').removeClass('active');
                    scrollToTab(this);
                    // 显示tab对应的内容区
                    $('.J_mainContent .J_iframe', window.parent.document).each(function () {
                        if ($(this).data('id') == dataUrl) {
                            $(this).show().siblings('.J_iframe').hide();
                            return false;
                        }
                    });
                }
                flag = false;
                return false;
            }
        });

        // 选项卡菜单不存在
        if (flag) {
            var str = '<a href="javascript:;" class="active J_menuTab" data-id="' + dataUrl + '">' + menuName + ' <i class="fa fa-times-circle"></i></a>';
            $('.J_menuTab', window.parent.document).removeClass('active');

            // 添加选项卡对应的iframe
            var str1 = '<iframe class="J_iframe" name="iframe' + id + '" width="100%" height="100%" src="' + dataUrl + '" frameborder="0" data-id="' + dataUrl + '" seamless></iframe>';
            $('.J_mainContent', window.parent.document).find('iframe.J_iframe').hide().parents('.J_mainContent').append(str1);

            //显示loading提示
//            var loading = layer.load();
//
//            $('.J_mainContent iframe:visible').load(function () {
//                //iframe加载完成后隐藏loading提示
//                layer.close(loading);
//            });
            // 添加选项卡
            $('.J_menuTabs .page-tabs-content', window.parent.document).append(str);
            scrollToTab($('.J_menuTab.active', window.parent.document));
        }
        return false;
    },

    showLoading: function (element) {
        var loadingHtml = '<div class="spiner-example"><div class="sk-spinner sk-spinner-wave"><div class="sk-rect1"></div><div class="sk-rect2"></div><div class="sk-rect3"></div><div class="sk-rect4"></div><div class="sk-rect5"></div></div></div>';
        $(element).html(loadingHtml);
    },

    /**
     * 数字前补零达到指定长度
     *
     * @param num
     *      原始数字
     * @param n
     *      补零后长度
     * @returns {*}
     */
    addNumberZero: function (num, n) {
        var len = num.toString().length;
        while (len < n) {
            num = "0" + num;
            len++;
        }
        return num;
    },

    /**
     * 显示模态窗口
     * @param title
     * @param url
     * @param data
     * @param size 1 正常窗口 2 大窗口
     */
    showModal: function (title, url, data, size) {
        if (url == '')
            return;
        if (size == 2) {
            $('#processModal .modal-dialog').addClass('modal-lg');
        } else {
            $('#processModal .modal-dialog').removeClass('modal-lg');
        }
        $.showLoading($('#processModalBody'));
        $('#processModal').modal({keyboard: true});
        $('#processModalTitle').html(title);

        $('#processModalBody').load(url, data);
    },

    closeProcessModal: function () {
        $('#processModal').modal('hide');
    },

    /**
     * 展示提示信息
     * @param title
     * @param data
     */
    showMessage: function (data, title) {

        $('#messageModal').modal({keyboard: true});
        $('#messageModalBody').html(data);
        var origin = $('#messageModalTitle').html();

        if (title && title != '') {
            $('#messageModalTitle').html(title);
        }
        $('#messageModal').on('hidden.bs.modal', function () {
            // 显示消息有可能出现在加载模态框之上，关闭后重新定义body的高度
            if ($('.modal').hasClass('in')) {
                $('body').addClass('modal-open');
            }
            if (title && title != '') {
                $('#messageModalTitle').html(origin);
            }
        })
    },

    /**
     * 添加标记
     * @param data
     *      标记标识
     * @param element
     *      要添加标记的元素
     */
    addSignClass: function (data, element) {
        if (!data || data == null || data == '')
            return;
        element.addClass('flag' + data);
    },
    /**
     * 显示父页面内容并回调
     * @param parentDataUrl 父页面url
     * @param closeCurrent 是否关闭当前选项卡
     * @param callBack 回调函数
     */
    callBackParent: function (parentDataUrl, closeCurrent, callBack) {
        var currentTabId;
        $('.J_menuTab', window.parent.document).each(function () {
            if ($(this).hasClass('active')) {
                currentTabId = $(this).data('id');
                //  移除当前选项卡
                if (closeCurrent) {
                    $(this).remove();
                }
            }
        });
        $('.J_menuTab', window.parent.document).each(function () {
            if ($(this).data('id') == parentDataUrl) {
                if (!$(this).hasClass('active')) {
                    $(this).addClass('active').siblings('.J_menuTab').removeClass('active');
                    scrollToTab(this);
                    // 显示tab对应的内容区
                    $('.J_mainContent .J_iframe', window.parent.document).each(function () {
                        if ($(this).data('id') == parentDataUrl) {
                            callBack(this.contentWindow);
                            $(this).show().siblings('.J_iframe').hide();
                        }
                    });
                }
            }
        });
        // 移除相应tab对应的内容区
        if (closeCurrent) {
            $('.J_mainContent', window.parent.document).find('.J_iframe').each(function () {
                if ($(this).data('id') == currentTabId) {
                    $(this).remove();
                    return;
                }
            });
        }
    }
});

$.validator.setDefaults({
    highlight: function (element) {
        $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    success: function (element) {
        element.closest('.form-group').removeClass('has-error').addClass('has-success');
    },
    errorElement: "span",
    errorPlacement: function (error, element) {
        if (element.is(":radio") || element.is(":checkbox")) {
            error.appendTo(element.parent().parent().parent());
        } else {
            error.appendTo(element.parent());
        }
    },
    errorClass: "help-block m-b-none",
    validClass: "help-block m-b-none"
});