from django.shortcuts import render, redirect, HttpResponse
from .models import User
# from login.models import *
from . import models
from .login_form import UserForm, RegisterForm
import hashlib
import os
import json
import re
import webbrowser


# Create your views here.

def index(request):
    url = 'http://localhost:8081/picture'
    webbrowser.open(url)
    pass
    return render(request, 'login/index.html')



def test(request):
    if request.method == "POST":
        postBody = eval(str(request.body, encoding='utf-8'))
        print(postBody)
        if postBody['msg'] == 'logout':
            webbrowser.close('http://localhost:8081/test')
            redirect("/logout")
        return HttpResponse(json.dumps([{'name': 'hrh', 'age': '11'}, {'name': 'cyx', 'age': '11'}]))
    else:
        return HttpResponse(json.dumps([{'name': 'hrh', 'age': '11'}, {'name': 'cyx', 'age': '11'}]))


def login(request):
    if request.session.get('is_login', None):
        return redirect('/index')

    if request.method == "POST":
        login_form = UserForm(request.POST)
        message = "请检查填写的内容！"
        if login_form.is_valid():
            print("here");
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            try:
                user = models.User.objects.get(name=username)
                if user.password == hash_code(password):
                    request.session['is_login'] = True
                    request.session['user_id'] = user.id
                    request.session['user_name'] = user.name
                    with open("login.txt", "w") as fp:
                        print("write the login name")
                        fp.write(user.name)
                    return redirect('/index/')
                else:
                    message = "密码不正确！"
            except:
                message = "用户不存在！"
        return render(request, 'login/login.html', locals())

    login_form = UserForm()
    return render(request, 'login/login.html', locals())


def CheckEmail(email):
    if len(email) > 7:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) != None:
            return True
    return False


def register(request):
    if request.session.get('is_login', None):
        # 登录状态不允许注册。你可以修改这条原则！
        return redirect("/index/")
    if request.method == "POST":
        register_form = RegisterForm(request.POST)
        print(register_form)
        message = "请检查填写的内容！"
        if register_form.is_valid():  # 获取数据
            username = register_form.cleaned_data['username']
            password1 = register_form.cleaned_data['password1']
            password2 = register_form.cleaned_data['password2']
            email = register_form.cleaned_data['email']
            if len(password1) < 6:
                message = "密码长度必须大于等于6"
                return render(request, 'login/register.html', locals())
            if CheckEmail(email) is False:
                message = "邮箱必须符合格式"
                return render(request, 'login/register.html', locals())
            if password1 != password2:  # 判断两次密码是否相同
                message = "两次输入的密码不同！"
                return render(request, 'login/register.html', locals())
            else:
                same_name_user = models.User.objects.filter(name=username)
                if same_name_user:  # 用户名唯一
                    message = '用户已经存在，请重新选择用户名！'
                    return render(request, 'login/register.html', locals())
                same_email_user = models.User.objects.filter(email=email)
                if same_email_user:  # 邮箱地址唯一
                    message = '该邮箱地址已被注册，请使用别的邮箱！'
                    return render(request, 'login/register.html', locals())
                new_user = models.User.objects.create()
                new_user.name = username
                new_user.password = hash_code(password1)
                new_user.email = email
                new_user.save()
                return redirect('/login/')  # 自动跳转到登录页面
    register_form = RegisterForm()
    return render(request, 'login/register.html', locals())


def logout(request):
    if not request.session.get('is_login', None):
        # 如果本来就未登录，也就没有登出一说
        return redirect("/login/")
    request.session.flush()
    # 或者使用下面的方法
    # del request.session['is_login']
    # del request.session['user_id']
    # del request.session['user_name']
    path = 'login.txt'  # 文件路径
    if os.path.exists(path):  # 如果文件存在
        # 删除文件，可使用以下两种方法。
        os.remove(path)
    return redirect("/login/")


def hash_code(s, salt='presentation'):
    h = hashlib.sha256()
    s += salt
    h.update(s.encode())
    return h.hexdigest()
