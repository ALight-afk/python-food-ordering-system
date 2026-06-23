from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
"""
所有模型的基类，继承自declarative_base()
所有模型都应该继承自这个类,都要引用这个类
万一哪天需要扩展，就可以直接在这里扩展，使用了这个Base地方都会被更改
"""
