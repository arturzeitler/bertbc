import json
from http import HTTPStatus

def test_get(client):
    response = client.get('/')
    assert response.status_code == 200

def test_sport(client):
    response = client.post('/predict', data=json.dumps({
            "input": "Germany have beaten England again in football by 3-0"
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.OK
    assert response.json == {"status": "Sport"}

def test_length_tech(client):
    response = client.post('/predict', data=json.dumps({
            "input": "Back in 2019, Amazon first announced its Sidewalk network, a new \
            low-bandwidth, long-distance wireless protocol and network for connecting smart \
            devices — and keeping them online when your own WiFi network, for example, goes down, \
            by piggybacking on your neighbor’s network. Since last year, Amazon has been turning its \
            Echo devices into Sidewalk bridges and select Ring and Tile devices can now access the network. \
            Now, Amazon is launching its first professional-grade Sidewalk device meant to cover large areas like a university campus or park. \
            The full name for the new device is a mouthful: the Amazon Sidewalk Bridge Pro by Ring. \
            It could be installed inside but is mostly meant to be set up outside — and ideally on a \
            high spot — and can cover hundreds of devices up to five miles away (depending on the local circumstances, of course). \
            To test the devices, Amazon partnered with Arizona State University, which will install these new Sidewalk \
            bridges on light poles on its Tempe campus. The University Technology Office plans to use it as a proof-of-concept \
            with plans to connect sunlight and temperature sensors, CO2 detectors and particle counters."
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.OK
    assert response.json == {"status": "Tech"}

def test_business(client):
    response = client.post('/predict', data=json.dumps({
            "input": "Asian stock markets have followed Wall Street lower after investors saw \
            minutes from a Federal Reserve meeting as a sign the U.S. central bank might hike interest \
            rates faster to cool inflation."
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.OK
    assert response.json == {"status": "Business"}

def test_politics(client):
    response = client.post('/predict', data=json.dumps({
            "input": "After the election, all parties agreed that unemployment is bad."
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.OK
    assert response.json == {"status": "Politics"}

def test_no_json(client):
    response = client.post('/predict', data={
            "input": "After the election, all parties agreed that unemployment is bad."
        })
    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json == {"status": "No JSON provided"}

def test_wrong_key(client):
    response = client.post('/predict', data=json.dumps({
            "wrong_key": "After the election, all parties agreed that unemployment is bad."
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json == {"status": 'No "input" key in JSON'}

def test_no_string(client):
    response = client.post('/predict', data=json.dumps({
            "input": 37
        }),
        content_type='application/json')
    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json == {"status": '"input" key does not return string'}
