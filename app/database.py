import pymysql
from pymysql import Error

class Database:
    def __init__(self, host='localhost', user='root', password='ruchira', database='pet_adoption_system'):
        """Initialize database connection parameters"""
        self.host = host
        self.user = user
        self.password = 'ruchira'  #change to your real password here
        self.database = database
        self.connection = None
    
    def connect(self):
        """Establish database connection"""
        try:
            self.connection = pymysql.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database,
                cursorclass=pymysql.cursors.DictCursor
            )
            print(" Successfully connected to the database")
            return self.connection
        except Error as e:
            print(f" Error connecting to database: {e}")
            print(f" Make sure MySQL is running and password is correct!")
            return None
    
    def disconnect(self):
        """Close database connection"""
        if self.connection:
            self.connection.close()
            print(" Database connection closed")
    
    def fetch_query(self, query, params=None):
        """Fetch data (SELECT queries)"""
        try:
            cursor = self.connection.cursor()
            cursor.execute(query, params)
            return cursor.fetchall()
        except Error as e:
            print(f" Error fetching data: {e}")
            return []
    
    def call_procedure(self, proc_name, params=None):
        """Call a stored procedure"""
        try:
            cursor = self.connection.cursor()
            if params:
                cursor.callproc(proc_name, params)
            else:
                cursor.callproc(proc_name)
            self.connection.commit()
            return cursor
        except Error as e:
            print(f" Error calling procedure '{proc_name}': {e}")
            self.connection.rollback()
            raise e