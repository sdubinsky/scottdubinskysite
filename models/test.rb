require 'pg'
connection = PG.connect(dbname: 'postgres')

print connection.exec("SELECT * FROM blogs")
