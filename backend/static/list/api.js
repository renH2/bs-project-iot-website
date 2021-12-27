function sendAjax(param, url, callback) {
    $.ajax({
        async: false,
        ache: false,
        type: 'POST',
        url: url,
        //JSON对象转化JSON字符串
        data: JSON.stringify(param),
        //服务器返回的数据类型
        dataType: "json",
        success: function (data) {
            callback(data.result)
        },
        error: function (data) {
            //错误处理
        }
    })
}

function addNote() {
    var d = {}
    //表单是否存在空值
    var isNull = false
    var t = $('#newNoteForm').serializeArray()
    $.each(t, function () {
        if (this.value === "") {
            isNull = true
            swal("信息填写不完整", "请重试", "error")
            // return false才代表退出each()函数
            return false
        }
        d[this.name] = this.value
    })
    //若存在空值则不发送ajax
    if (isNull) {
        return
    }
    sendAjax(d, '/list/add/', function (value) {
        if (value === 1) {
            swal({title: "添加成功", text: "", type: "success", timer: 2000}, function () {
                location.href = '/list/'
            })
        }
        if (value === 0) {
            swal("填写内容不能为空", "请重写填写", "error")
        }
    })
}


function delNote(n_id) {
    swal({
            title: "确定要删除该记事吗？",
            text: "删除不可恢复",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确认",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false
        },
        function (isConfirm) {
            if (!isConfirm) {
                swal({
                    title: "已取消",
                    text: "您取消了删除操作！",
                    type: "warning"
                })
                return
            }
            var data = {
                'n_id': n_id,
            }
            sendAjax(data, '/list/del/', function (value) {
                if (value === 1) {
                    swal({title: "删除成功", text: "", type: "success", timer: 2000}, function () {
                        location.reload()
                    })
                }
                if (value === -1) {
                    swal("删除失败", "请重试", "error")
                }
            })
        }
    )
}


function finishNote(n_id) {
    var data = {
        'n_id': n_id,
        'status': 'F'
    }
    sendAjax(data, '/list/change/', function (value) {
        if (value === 1) {
            swal({title: "记事已完成", text: "", type: "success", timer: 2000}, function () {
                location.reload()
            })
        }
        if (value === -1) {
            swal("网络异常", "请重试", "error")
        }
    })
}


function modifyNote() {
    var d = {}
    //表单是否存在空值
    var isNull = false
    var t = $('#modifyNoteForm').serializeArray()
    $.each(t, function () {
        if (this.value === "") {
            isNull = true
            swal("信息填写不完整", "请重试", "error")
            // return false才代表退出each()函数
            return false
        }
        d[this.name] = this.value
    })
    //若存在空值则不发送ajax
    if (isNull) {
        return
    }
    sendAjax(d, '/list/modify/', function (value) {
        if (value === 1) {
            swal({
                title: "修改成功",
                text: "",
                type: "success",
                timer: 2000
            }, function () {
                location.href = '/list/'
            })
        }
        if (value === 0) {
            swal("填写内容不能为空", "请重写填写", "error")
        }
    })
}
