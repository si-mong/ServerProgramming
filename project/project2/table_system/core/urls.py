# 새로 추가한 파일
# table_system/core/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # 관리자 쪽
    path('admin/menu.html', views.admin_menu),
    path('admin/table.html', views.admin_table),
    path('admin/status.html', views.admin_status),
    path('admin/checkout.html', views.admin_checkout),

    # 고객 쪽
    path('customer/order.html', views.customer_order),
]