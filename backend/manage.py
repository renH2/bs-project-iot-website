#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys
import datetime
import socket
import json
import threading
import pymysql
import paho.mqtt.client as mqtt

# ======================================================

Host = "localhost"  # 服务器地址
port = 1883  # 通讯端口
username = 'username'  # 用户名
password = 'password'  # 密码
topic = 'testapp'  # 订阅主题名


# ======================================================


def on_connect(self, mosq, obj, rc):
    self.subscribe(topic, 0)


def on_publish(mqttc, obj, mid):
    pass


def on_subscribe(mqttc, obj, mid, granted_qos):
    pass


def on_log(mqttc, obj, level, string):
    pass


def on_message(mqttc, obj, msg):
    db = pymysql.connect(
        host='127.0.0.1',
        port=3306,
        user='root',
        password='123456',
        db='iotproject1',
        charset='utf8'
    )
    cursor = db.cursor()
    m_decode = str(msg.payload.decode("utf-8", "ignore"))
    m_in = json.loads(m_decode)  # decode json data
    print(type(m_in))
    print("clientId = ", m_in["clientId"])
    print("timestamp", m_in["timestamp"])
    client_id = str(m_in["clientId"])
    alert = str(m_in["alert"])
    info = str(m_in["info"])
    lat = str(m_in["lat"])
    lng = str(m_in["lng"])
    timestamp = str(m_in["timestamp"])
    value = str(m_in["value"])
    sql = "INSERT INTO device_device(client_id, \
           alert, info, lat, lng, timestamp, value) \
           VALUES ('%s', '%s',  '%s',  '%s',  '%s', '%s', '%s')" % \
          (client_id, alert, info, lat, lng, timestamp, value)
    # 执行sql语句
    cursor.execute(sql)
    # 执行sql语句
    db.commit()


def on_exec(strcmd):
    pass


def mqtt_exec():
    mqttc = mqtt.Client("test")
    mqttc.on_message = on_message
    mqttc.on_connect = on_connect
    mqttc.on_publish = on_publish
    mqttc.on_subscribe = on_subscribe
    mqttc.on_log = on_log
    mqttc.connect(Host, port, 60)
    mqttc.subscribe(topic, 0)
    mqttc.loop_forever()


def main():
    """Run administrative tasks."""
    thread = threading.Thread(target=mqtt_exec)
    thread.setDaemon(True)
    thread.start()
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'iot_django.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
