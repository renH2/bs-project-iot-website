from django.urls import path
from device import views
from django.conf.urls import url

urlpatterns = [
    # 将函数绑定至对应路由
    path('home/', views.home),
    url('show_all/', views.show_all),
    url('find_device/', views.find_device),
    url('create_device/', views.create_device),
    url('update_device/', views.update_device),
    url('delete_device/', views.delete_device),
    url('get_device/', views.get_device),
    url('update_device/', views.update_device),
    url('get_gjdevice/', views.get_gjdevice),
    url('get_device_value/', views.get_device_value),
    url('get_chart_value/', views.get_chart_value),
    url('get_chart_value_alter/', views.get_chart_value_alter),
]
