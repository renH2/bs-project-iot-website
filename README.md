#### 使用方法

##### 一、项目部署

- **前端部署** **（Vue）**

请按顺序执行指令

```
#安装依赖
npm install

#在local:8080端口运行服务
npm run dev
```

- **后端部署**  **(Django)**

后端部署需要连接相应的数据库

在`backend/iot_django/settings`文件中，可以调节成自己的mysql账号和密码。

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'iotproject1',
        'USER': 'root',  # 账号
        'PASSWORD': '123456',  # 密码
        'HOST': '127.0.0.1',  # IP
        'PORT': '3306',  # 端口号
    }
}
```

而在`backend/manage.py`中，修改下面代码段为自身的MySQL账号和密码

```python
def on_message(mqttc, obj, msg):
    db = pymysql.connect(
        host='127.0.0.1',
        port=3306,
        user='root',
        password='123456',
        db='iotproject1',
        charset='utf8'
    )
```

修改完成后前往后端目录`backend`请按顺序执行指令

```
#生成迁移文件
python manage.py makemigrations

#数据库建表
python manage.py migrate

#在8000端口开启服务器服务
python manage.py runserver
```

(注意如果要实现外部手机平板等设备访问web，则将最后指令改为`python manage.py runserver 0.0.0.0:8000`)

##### 二、界面

我们在8000端口出打开网页，网站 url 为`http://127.0.0.1:8000/login/`进入登录界面。

<img src="img\登录界面.png" alt="登录界面" style="zoom:80%;" />

输入用户名和密码还有验证码即可登录，若没有账号，可在`点击注册`中注册账号。

<img src="img\注册界面.png" alt="注册界面" style="zoom:80%;" />

之后登录进去，页面会跳转至个人主页`http://127.0.0.1:8000/index/`，并打开IOT网站主页面`http://localhost:8081/picture`

如果需要退出登录，只需要点击index页面右下角退出登录即可。

<img src="C:\Users\HP\Desktop\BS\img\主页.png" alt="主页" style="zoom:80%;" />

----

在IOT网站主页面中，可以进行设备配置、地图界面、统计信息等功能。

**查看首页**：**提供统计信息**

**设备配置**：**进行增加/删除/修改设备**

**地图界面**：**地图界面展示设备信息，区分告警、正常**

**统计信息**：**提供统计设备value统计信息**

具体可根据侧边栏进行选择：

<img src="C:\Users\HP\Desktop\BS\img\侧边栏.png" alt="侧边栏" style="zoom:80%;" />

