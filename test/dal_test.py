from decimal import Decimal
from dal.session_manager import SessionManager
from models.food import Food
from dal.base_dal import BaseDao
from models.user import User
from utils.constants import USER_ROLE_CUSTOM, USER_ROLE_ADMIN


def test_session_mgr():
    session = SessionManager.get_session()
    # foods = session.query(Food).all()
    # 最好不要使用session.query(Food).all()，会导致session一直处于打开状态，导致其他线程无法使用

    # foods = BaseDao.get_list(session, Food)
    #
    # for food in foods:
    #     print(food.name + " - " + str(food.price))

    # users = BaseDao.get_list(session, User)
    # for user in users:
    #     print(user.username)
    #     print('---------- carts --------------')
    #     for cart in user.carts:
    #         # print(cart.food.name + " - " + str(cart.food.price))
    #         print(cart.subtotal)
    #     print('------------------------\n')

    session = SessionManager.get_session()
    users = BaseDao.get_list_by_condition(session, User, role = USER_ROLE_ADMIN)
    for user in users:                                   # role = USER_ROLE_CUSTOM , username='admin'
        print(user.username)
        print('----------- carts -----------')
        for cart in user.carts:
            print(cart.subtotal)
        print('-----------------------------\n')


def test_exception():
    x = Decimal(input('input a number:'))
    print(x)


if __name__ == '__main__':

    # test_session_mgr()

    test_exception()