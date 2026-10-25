import base64, json, sys, time, urllib.request

BASE = 'http://127.0.0.1:8317'
KEY = 'free-local-8317'
path = sys.argv[1]
model = sys.argv[2] if len(sys.argv) > 2 else 'nemotron-3.5-vl'
b64 = base64.b64encode(open(path, 'rb').read()).decode()
msg = {'role': 'user', 'content': [
    {'type': 'text', 'text': 'Describe this physics paper figure in 3-5 sentences: what is plotted, axes/ranges, key curves/colors, and what it demonstrates. Be concrete.'},
    {'type': 'image_url', 'image_url': {'url': 'data:image/jpeg;base64,' + b64}}]}
body = json.dumps({'model': model, 'messages': [msg], 'max_tokens': 600}).encode()
req = urllib.request.Request(BASE + '/v1/chat/completions', data=body, headers={
    'Authorization': 'Bearer ' + KEY, 'Content-Type': 'application/json'})
t0 = time.time()
try:
    d = json.load(urllib.request.urlopen(req, timeout=180))
    print(d['choices'][0]['message'].get('content'))
    print('ELAPSED', round(time.time() - t0, 1), file=sys.stderr)
except Exception as e:
    print('ERR', e, file=sys.stderr)
    sys.exit(1)
