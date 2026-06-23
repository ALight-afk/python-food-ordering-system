

DB_CONFIG = {
    'host': '192.168.43.128', # 这里需要填入你的ip
    'port': 3306,
    'user': 'root',
    'password': '123456',
    'database': 'db08',
    'driver': 'pymysql',  # 还可以填入'mysqldb'，'pymysql'，'mysqlconnector'，'oursql'等
    'charset': 'utf8mb4',
    'pool_size': 5,
    'max_overflow': 10,
    'echo_sql': False
}
def get_connect_string():
    cfg = DB_CONFIG
    return (f"mysql+{cfg['driver']}://{cfg['user']}:{cfg['password']}"
            f"@{cfg['host']}:{cfg['port']}/{cfg['database']}"
            f"?charset={cfg['charset']}")

    # return 'mysql+pymysql://root:123456@192.168.157.128:3306/db08'