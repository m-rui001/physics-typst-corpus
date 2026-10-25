import base64, json, sys, time, urllib.request

BASE = sys.argv[2] if len(sys.argv) > 2 else 'http://127.0.0.1:4141'
KEY = sys.argv[3] if len(sys.argv) > 3 else 'free-local-4141'
model = sys.argv[4] if len(sys.argv) > 4 else 'sf/Qwen/Qwen3-VL-32B-Instruct'
path = sys.argv[1]
b64 = base64.b64encode(open(path, 'rb').read()).decode()
mime = 'image/jpeg' if path.lower().endswith(('.jpg', '.jpeg')) else 'image/png'
msg = {'role': 'user', 'content': [
    {'type': 'text', 'text': 'Describe this physics paper figure in 3-5 sentences: what is plotted, axes/ranges, key curves/colors, and what it demonstrates. Be concrete.'},
    {'type': 'image_url', 'image_url': {'url': 'data:%s;base64,%s' % (mime, b64)}}]}
body = json.dumps({'model': model, 'messages': [msg], 'max_tokens': 600}).encode()
req = urllib.request.Request(BASE + '/v1/chat/completions', data=body, headers={
    'Authorization': 'Bearer ' + KEY, 'Content-Type': 'application/json'})
t0 = time.time()
try:
    d = json.load(urllib.request.urlopen(req, timeout=300))
    print(d['choices'][0]['message'].get('content'))
    print('ELAPSED', round(time.time() - t0, 1), file=sys.stderr)
except Exception as e:
    print('ERR', e, file=sys.stderr)
    sys.exit(1)
