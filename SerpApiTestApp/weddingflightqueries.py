import requests
import json
import uuid

# Initialize Firestore project settings
project_id = 'serpapi-test'
database_id = '(default)'
collection_id = 'queries'
api_key = '4c8b1fd5cfd54df35c8e7860f81a65f298d2e02ab3c7207feabdbd85d457d46f'

for departure in ["PDX","SEA","GEG"]:
		for arrival in ["ORD","MDW"]:
			params = {
			"engine": "google_flights",
			"hl": "en",
			"gl": "us",
			"departure_id": departure,
			"arrival_id": arrival,
			"outbound_date": "2024-05-09",
			"return_date": "2024-05-12",
			"currency": "USD",
			"travel_class": "1",
			"adults": "2",
			"api_key": api_key
			}
			
			document_id = uuid.uuid4()
			
			# Firestore REST API URL for adding a document 
			url = f'https://firestore.googleapis.com/v1/projects/{project_id}/databases/{database_id}/documents/{collection_id}/{document_id}'
			
			# Send a GET Request
			response = requests.get('https://serpapi.com/search',params=params)
			
			if response.status_code == 200:
				json_string = json.dumps(response.json())
				data = {
					'fields': {
						'json_data': {'stringValue':json_string}
					}
				}
				
				print(data)
				
				fs_response = requests.patch(url,headers={"Content-Type": "application/json"},data=json.dumps(data))
	
				if fs_response.status_code == 200:
					print('Data written to Firestore')
				else: 
					print('Failed to write data to Firestore')
					print(fs_response.text)
					
			else: 
				print('Failed to retrieve data:', response.status_code)

# Add Message to Firestore
def add_query(raw_data:dict) -> None:
	response = requests.patch(url,headers={"Content-Type": "application/json"},data=json.dumps(raw_data))
	
	if response.status_code == 200:
		print('Data written to Firestore')
	else: 
		print('Failed to write data to Firestore')
		print(response.text)
