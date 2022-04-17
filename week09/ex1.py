from geopy.geocoders import Nominatim
import psycopg2

con = psycopg2.connect(database="dvdrental",
                       user="postgres",
                       password="1234",
                       host="localhost",
                       port="5432")
print("Database has been opened successfully")

# Definitions
geolocator = Nominatim(user_agent="ex1", timeout=5)
cur = con.cursor()

# Create new columns: longitude, latitude
cur.execute('''
    alter table address 
    add column if not exists longitude real default 0.0,
    add column if not exists latitude real default 0.0;
''')
con.commit()

# Update longitude and latitude depends on address from addresses that are result of getSpecialAddresses()
special_addresses = {}
cur.callproc("getSpecialAddresses")

rows = cur.fetchall()
for row in rows:
    address_id = row[0]
    location = geolocator.geocode(row[1])
    if location is not None:
        cur.execute("update address set longitude = %s, latitude = %s where address_id = %s",
                    [location.longitude, location.latitude, address_id])

con.commit()

cur.close()
con.close()
