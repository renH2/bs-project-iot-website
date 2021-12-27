/**
 * Created by Chation on 2016/12/23.
 */

addLoadEvent(formClick);
addLoadEvent(navPosition);
addLoadEvent(navPositionResize);
addLoadEvent(unCloth);

/* 判断是否为空,更改相应样式 */
function formClick() {
    var submit = document.getElementById("login_to");
    var sendBtn = document.getElementById("sendMsg-btn");
    var psw = document.getElementById("password");
    var username = document.getElementById("user_name");
    var email = document.getElementById("email_address");
    var sendMsg = document.getElementById("textBox-sendMsg");
    var classes = "";
    submit.addEventListener("click", function () {
        if (psw.value != "" && email.value != "" && username.value != "") {
            classes = this.getAttribute("class") + " disabled";
            this.setAttribute("class", classes);
            this.innerHTML = "<i class='icon-refresh icon-spin'></i> 正在注册...";
        } else {
            if (psw.value == "") {
                classes = psw.parentNode.getAttribute("class");
                psw.parentNode.setAttribute("class", classes + " has-error");
            }
            if (email.value == "") {
                classes = email.parentNode.getAttribute("class");
                email.parentNode.setAttribute("class", classes + " has-error");
            }
            if (username.value == "") {
                classes = username.parentNode.getAttribute("class");
                username.parentNode.setAttribute("class", classes + " has-error");
            }
        }
    }, false);
    sendBtn.addEventListener("click",function(){
        if(sendMsg.value == ""){
            sendMsg.setAttribute("placeholder","内容不能为空~!");
        }else {
            this.setAttribute("data-dismiss","modal");
            //测试阶段默认成功

        }
    },false);
    var focus = function () {
        this.parentNode.setAttribute("class", "input-group");
    };
    username.addEventListener("focus", focus, false);
    email.addEventListener("focus", focus, false);
    psw.addEventListener("focus", focus, false);
}

/* 设置导航栏的偏移量 */
function navPosition() {
    var windowHeight = window.screen.availHeight;
    var windowWidth = document.body.clientWidth;
    var divMainWidth = document.getElementById("divMain").clientWidth;
    var navWidth = Math.ceil((windowWidth - divMainWidth) / 2 + divMainWidth) + "px";
    var navHeight = windowHeight - Math.ceil(windowHeight / 2);
    var nav = document.getElementById("bottomNav");
    var bNav = document.getElementById("smallScreen-nav");
    if ((windowWidth - divMainWidth) < 67) {
        nav.style.left = (document.body.clientWidth - 66) + "px";
        nav.style.top = navHeight + "px";
        nav.style.display = "block";
        nav.style.visibility = "";
    } else {
        nav.style.left = navWidth;
        nav.style.top = navHeight + "px";
        nav.style.display = "block";
        nav.style.visibility = "";
    }
    if (windowWidth < 973) {
        bNav.style.visibility = "";
    } else {
        bNav.style.visibility = "hidden";
    }
}

/* 窗口resize之后重新调用navPosition设置偏移量 */
function navPositionResize() {
    window.addEventListener("resize", navPosition, false);
}


/* 构建window.onLoad能运行多个函数的函数 */
function addLoadEvent(func) {
    var oldOnLoad = window.onload;
    if (typeof window.onload != 'function') {
        window.onload = func;
    } else {
        window.onload = function () {
            oldOnLoad();
            func();
        }
    }
}

/*动画效果返回顶部*/
function moveToTOP() {
    var dist = Math.ceil((document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop) / 10);
    window.scrollBy(0, -dist);
    var scrollDelay = setTimeout('moveToTOP()', 10);
    var sTop = document.documentElement.scrollTop + document.body.scrollTop;
    if (sTop === 0) {
        clearTimeout(scrollDelay);
    }
}

/* 加宽搜索框 */
function addWidthForSearch() {
    var windowWidth = document.body.clientWidth;
    var dist = Math.ceil(windowWidth / 12);
    var searchBox = document.getElementById("top-nav-search");
    var searchBoxWidth = searchBox.clientWidth;
    var allWidth = dist + searchBoxWidth;
    searchBox.style.width = allWidth + "px";

}

/* 未封装代码开始 */
function unCloth() {
    document.getElementById("sToTop").onclick = moveToTOP; //返回顶部
    var searchBox=document.getElementById("top-nav-search");
    var searchBoxWidth=searchBox.clientWidth;
    searchBox.addEventListener("focus", addWidthForSearch, false);
    searchBox.addEventListener("blur",function(){
        searchBox.style.width=searchBoxWidth+"px";
    },false);
    window.addEventListener("scroll", function () { //判断是否显示返回顶部按钮
        var scrollTopElem = document.getElementById("sToTop");
        if ((document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop) > 225) {
            scrollTopElem.style.visibility = "";
        } else {
            scrollTopElem.style.visibility = "hidden";
        }
    }, false);
}

/* 发表微博 */
function submit() {
    var txt = document.getElementById("txtNew");
    var center = document.getElementById("centerBox");
    if(txt.value.trim() != ""){

    }else{
        removeElem("warningTip");
        var tips = "不能发送空白内容！";
        center.insertBefore(alertBox(tips, "warning"), center.childNodes[0]);
    }
}

/* 新建提示框innerHTML */
function alertBox(tip, color) {
    var box = document.createElement("div");
    box.setAttribute("id", "warningTip");
    box.setAttribute("class", "alert alert-" + color + " alert-dismissible");
    box.setAttribute("role", "alert");
    box.innerHTML = "<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>" + tip;
    return box;
}

/* 删除指定id的元素 */
function removeElem(elemId) {
    if (document.getElementById(elemId)) {
        var elem = document.getElementById(elemId);
        elem.parentNode.removeChild(elem);
    }
}

document.getElementById("submitNew").addEventListener("click",submit,false);