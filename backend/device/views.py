from django.shortcuts import render, HttpResponse, redirect
from django.http import JsonResponse
from device.models import Device, DeviceInfo
from . import models
import datetime
import json


# Create your views here.

def home(request):
    a = {'aa': 12, 'bb': 11}
    return HttpResponse(json.dumps(a))


def get_unique_device(devices):
    devices = models.Device.objects.all().values('client_id')
    l = list(devices)
    p = []
    print("record len:", len(l))
    for i in range(len(l)):
        if l[i]['client_id'] not in p:
            p.append(l[i]['client_id'])
    return sorted(p), len(p)


def get_device_value(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        print(client_id)
        with open("login.txt", "r") as fp:
            client_user = fp.read()
        p = list(models.DeviceInfo.objects.filter(client_user=client_user, client_id=client_id))
        if len(p) != 0:
            temp = list(models.Device.objects.filter(client_id=client_id).values('value'))
            xdata = [i for i in range(len(temp))]
            ydata = []
            for i in range(len(temp)):
                tempy = temp[i]['value']
                ydata.append(tempy)
            package = {"xdata": xdata, "ydata": ydata}
    return JsonResponse(package, safe=False)


def get_device(request):
    with open("login.txt", "r") as fp:
        client_user = fp.read()
    p = list(models.DeviceInfo.objects.filter(client_user=client_user).values('client_id'))
    xdata = []
    ydata = []
    for i in range(len(p)):
        name = p[i]['client_id']
        xdata.append(name)
        temp = len(list(models.Device.objects.filter(client_id=name)))
        ydata.append(temp)
    package = {"xdata": xdata, "ydata": ydata}
    return JsonResponse(package, safe=False)


def get_gjdevice(request):
    with open("login.txt", "r") as fp:
        client_user = fp.read()
    p = list(models.DeviceInfo.objects.filter(client_user=client_user).values('client_id'))
    xdata = []
    ydata = []
    for i in range(len(p)):
        name = p[i]['client_id']
        xdata.append(name)
        temp = len(list(models.Device.objects.filter(client_id=name, alert=1)))
        ydata.append(temp)
    package = {"xdata": xdata, "ydata": ydata}
    return JsonResponse(package, safe=False)


# 获得地图数据
def get_chart_value(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        interval_test = False
        alert_test = False
        if 'interval' in postBody.keys():
            interval = postBody['interval']
            if '~' in interval:
                a, b = interval.split('~')
                interval_test = True
                a = int(a)
                b = int(b)
        if 'is_alert' in postBody.keys():
            alert = postBody['is_alert']
            if alert == "是":
                alert_test = True
            if alert == "否":
                alert_test = True
        user_id = list(models.DeviceInfo.objects.filter(client_id=client_id))
        if len(user_id):
            devices = list(
                models.Device.objects.filter(client_id=client_id).values('client_id', 'info', 'value', 'alert',
                                                                         'lat',
                                                                         'lng'))
            device = []
            if interval_test is True:
                for i in range(len(devices)):
                    if devices[i]['value'] >= a and devices[i]['value'] <= b:
                        device.append(devices[i])
                devices = device
            device = []
            if alert_test is True:
                for i in range(len(devices)):
                    if devices[i]['alert'] == 1 and alert == "是":
                        device.append(devices[i])
                    elif devices[i]['alert'] == 0 and alert == "否":
                        device.append(devices[i])
                devices = device
            data = []
            for i in range(len(devices)):
                dic_temp = {}
                temp = []
                temp.append(devices[i]['lng'])
                temp.append(devices[i]['lat'])
                dic_temp["coord"] = temp
                dic_temp["elevation"] = devices[i]['value']
                data.append(dic_temp)
            print(data)
            fin = []
            fin.append(data)
            return JsonResponse(fin, safe=False)
        else:
            devices = list(models.DeviceInfo.objects.filter(client_id=client_id))
        return JsonResponse(list(devices), safe=False)
    else:
        return HttpResponse(json.dumps([{'name': 'hrh', 'age': '11'}, {'name': 'cyx', 'age': '11'}]))


def get_chart_value_alter(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        interval_test = False
        alert_test = False
        if 'interval' in postBody.keys():
            interval = postBody['interval']
            if '~' in interval:
                a, b = interval.split('~')
                interval_test = True
                a = int(a)
                b = int(b)
        user_id = list(models.DeviceInfo.objects.filter(client_id=client_id))
        if len(user_id):
            devices = list(
                models.Device.objects.filter(client_id=client_id).values('client_id', 'info', 'value', 'alert',
                                                                         'lat',
                                                                         'lng'))
            device = []
            if interval_test is True:
                for i in range(len(devices)):
                    if devices[i]['value'] >= a and devices[i]['value'] <= b:
                        device.append(devices[i])
                devices = device
            for i in range(len(devices)):
                if devices[i]['alert'] == 1:
                    device.append(devices[i])
            devices = device
            data = []
            for i in range(len(devices)):
                dic_temp = {}
                temp = []
                temp.append(devices[i]['lng'])
                temp.append(devices[i]['lat'])
                dic_temp["coord"] = temp
                dic_temp["elevation"] = devices[i]['value']
                data.append(dic_temp)
            print(data)
            fin = []
            fin.append(data)
            return JsonResponse(fin, safe=False)
        else:
            devices = list(models.DeviceInfo.objects.filter(client_id=client_id))
        return JsonResponse(list(devices), safe=False)
    else:
        return HttpResponse(json.dumps([{'name': 'hrh', 'age': '11'}, {'name': 'cyx', 'age': '11'}]))



def get_statics_info(devices):
    devices = models.Device.objects.all()
    l = list(devices)
    all_record_num = len(l)


#
def show_all(request):
    devices = models.Device.objects.all().values('client_id')
    unique_device, num = get_unique_device(devices)
    print(unique_device, num)
    package = {}
    package['devices_list'] = unique_device
    return HttpResponse(json.dumps(package))


# 查找设备
def find_device(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        interval_test = False
        alert_test = False
        if 'interval' in postBody.keys():
            interval = postBody['interval']
            if '~' in interval:
                a, b = interval.split('~')
                interval_test = True
                a = int(a)
                b = int(b)
        if 'is_alert' in postBody.keys():
            alert = postBody['is_alert']
            if alert == "是":
                alert_test = True
            if alert == "否":
                alert_test = True
        user_id = list(models.DeviceInfo.objects.filter(client_id=client_id))
        if len(user_id):
            devices = list(
                models.Device.objects.filter(client_id=client_id).values('client_id', 'info', 'value', 'alert',
                                                                         'lat',
                                                                         'lng'))
            device = []
            if interval_test is True:
                for i in range(len(devices)):
                    if devices[i]['value'] >= a and devices[i]['value'] <= b:
                        device.append(devices[i])
                devices = device
            device = []
            if alert_test is True:
                for i in range(len(devices)):
                    if devices[i]['alert'] == 1 and alert == "是":
                        device.append(devices[i])
                    elif devices[i]['alert'] == 0 and alert == "否":
                        device.append(devices[i])
                devices = device
            return JsonResponse(devices, safe=False)
        else:
            devices = list(models.DeviceInfo.objects.filter(client_id=client_id))
        return JsonResponse(list(devices), safe=False)
    else:
        return HttpResponse(json.dumps([{'name': 'hrh', 'age': '11'}, {'name': 'cyx', 'age': '11'}]))


# 创建设备
def create_device(request):
    if request.method == "GET":
        with open("login.txt", "r") as fp:
            client_user = fp.read()
        devices = models.DeviceInfo.objects.filter(client_user=client_user).values('client_id', 'client_name',
                                                                                   'client_declare')
        return JsonResponse(list(devices), safe=False)
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        client_name = postBody['client_name']
        client_declare = postBody['client_declare']
        with open("login.txt", "r") as fp:
            client_user = fp.read()
        if len(list(models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user))) == 0:
            models.DeviceInfo.objects.create(client_id=client_id, client_name=client_name,
                                             client_declare=client_declare,
                                             client_user=client_user)
        devices = models.DeviceInfo.objects.filter(client_user=client_user).values('client_id', 'client_name',
                                                                                   'client_declare')
        return JsonResponse(list(devices), safe=False)


# 更新设备
def update_device(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        print(postBody)
        client_id = postBody['client_id']
        client_name = "Dsdsa"
        client_declare = "Dsdsa"
        is_name = False
        is_declare = False
        if 'client_name' in postBody.keys():
            client_name = postBody['client_name']
            is_name = True
        if 'client_declare' in postBody.keys():
            client_declare = postBody['client_declare']
            is_declare = True
        with open("login.txt", "r") as fp:
            client_user = fp.read()
        if len(list(models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user))) != 0:
            if is_name is True:
                models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user).update(
                    client_name=client_name)
            if is_declare is True:
                models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user).update(
                    client_declare=client_declare)
        devices = models.DeviceInfo.objects.filter(client_user=client_user).values('client_id', 'client_name',
                                                                                   'client_declare')
        return JsonResponse(list(devices), safe=False)


# 删除设备
def delete_device(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        client_id = postBody['client_id']
        client_name = postBody['client_name']
        with open("login.txt", "r") as fp:
            client_user = fp.read()
        print(client_id)
        a = list(models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user))
        if len(list(models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user))) != 0:
            print("dsa")
            models.DeviceInfo.objects.filter(client_id=client_id, client_user=client_user).delete()
        devices = models.DeviceInfo.objects.filter(client_user=client_user).values('client_id', 'client_name',
                                                                                   'client_declare')
        return JsonResponse(list(devices), safe=False)
