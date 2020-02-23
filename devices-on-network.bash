#!/bin/bash

##psql --user postgres --db cooperate_network_info
##psql --user postgres --db network_info --c "SELECT * FROM device_counter;"
##psql --user postgres --db network_info --c "INSERT INTO device_counter (count_time, device_count) VALUES (NOW(), 5);"
#use nmap to see all devices connected to network 

IP_ADDRESSES=$(ifconfig | grep -E -o 'inet [^ ]*' | grep -E -o '([0-9]+\.)+[0-9]+')
LOCAL_NETWORK_ADDRESS='127.0.0.1'
WIFI_NETWORK_ADDRESS='192.168.0.165'

#get the router's public IP address using 3rd party tool ifconfig.me 
PUB_NETWORK_ADDRESS=$(curl ifconfig.me)

for ip_address in $IP_ADDRESSES 
do
	if [ $ip_address != $LOCAL_NETWORK_ADDRESS ]
	then
#		NMAP_RESULT=$(nmap $ip_address/24) 
#		DEVICES=$(echo $NMAP_RESULT | grep -E -o 'Nmap scan report for [^ ]+' | grep -E -o '[^ ]$')
		
		#count how many devices are on the network 
		i=0
#		for device in $DEVICES
#		do 
#			i=$i+1
#		done

		my_result = "SELECT a.id FROM device_counter AS a INNER JOIN (SELECT MAX(count_time) AS max_count_time) AS b ON a.count_time=b.max_count_time;"
		echo "$my_result" 


		#save the number devices to the device_count data table  
		psql --user postgres --db network_info \
		--c "INSERT INTO device_counter (count_time, device_count, network_ip) VALUES (NOW(), $i, '$PUB_NETWORK_ADDRESS');"
		
		#retrieve primary key ID for the record just added to the device_counter table
		
		my_result = "SELECT a.id FROM device_counter AS a INNER JOIN (SELECT MAX(count_time) AS max_count_time) AS b ON a.count_time=b.max_count_time;"
			#dc_id=$(psql --user postgres --db network_info --c $dc_id_retrieval_sql_query)
		
		
#		dc_id=$(psql --user postgres --db network_info 
#		--c "SELECT a.id 
#				 FROM device_counter AS a 
#				 INNER JOIN (SELECT MAX(count_time) AS max_count_time) AS b 
#				 ON a.count_time=b.max_count_time;") 	
	
		echo $dc_id
	
		#save the name of each device to the devices table 
		#for device in $DEVICES 
	  #do
		#	psql --user postgres --db network_info \
		#	--c "INSERT INTO devices (dc_id, device_name) VALUES ($dc_id, '$device')"	
		#done 	
	fi 
done 



