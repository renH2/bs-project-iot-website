from django.db import models


# Create your models here.

class Device(models.Model):
    client_id = models.CharField(verbose_name='设备ID', max_length=45)
    info = models.CharField(verbose_name='上报信息', max_length=50)
    value = models.IntegerField(verbose_name='设备数值')
    alert = models.IntegerField(verbose_name='是否告警')
    lat = models.FloatField(verbose_name='纬度')
    lng = models.FloatField(verbose_name='经度')
    timestamp = models.BigIntegerField(verbose_name="上报时间")


class DeviceInfo(models.Model):
    client_id = models.CharField(verbose_name='设备ID', max_length=45, unique=True)
    client_name = models.CharField(verbose_name='设备名字', max_length=50)
    client_declare = models.CharField(verbose_name='设备描述', max_length=100)
    client_user = models.CharField(verbose_name='用户', max_length=100)
