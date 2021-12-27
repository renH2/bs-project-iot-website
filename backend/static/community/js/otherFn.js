/**
 * Created by Chation on 2016/12/28.
 */
addLoadEvent(modalBoxName);

function modalBoxName(){
    document.getElementById("user_Msg_to").innerHTML = "发送给 " + document.getElementById("user-name").innerHTML;
}

/* bootstrap轮播插件 */
$(function() {
    $("#myCarousel").carousel({
        interval: 2400
    });
});

/* 动画显示QR */
$(function() {
    $("#qrCode-div").hover(function() {
        $("#qrCode").show(300);
    }, function() {
        $("#qrCode").hide(300);
    });
});

/* 关闭广告 */
$(function(){
    $(".right_nav_ad_btn").click(function(){
        $(".right_nav_ad").hide(500);
    });
});