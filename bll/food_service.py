"""
业物逻辑层:
- 负责业务功能的实现，每个函数都要完成一个功能主题
- 调用数据层的接口，完成业务逻辑
- 负责日志记录
- 有事务的话还要负责事务管理
"""

from bll.base_service import BaseService
from models import Food


class FoodService(BaseService):
    """菜品服务类，没有多余的方法，只有通用方法"""

    @property
    def service_name(self):
        return '菜品管理'

    @property
    def model_class(self):
        return Food

