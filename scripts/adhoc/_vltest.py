import base64, json, sys, urllib.request

CFG = r'E:\tools\OpenCode2API-main\config.json'
cfg = json.load(open(CFG, encoding='utf-8'))
img = sys.argv[1]
b64 = base64.b64encode(open(img, 'rb').read()).decode()
prompt = 'Describe this physics figure in 3 sentences: what is plotted, axes, and the main takeaway.'
body = {
    'model': 'opencode/nemotron-3.5-super-vl-free',
    'messages': [{'role': 'user', 'content': [
        {'type': 'text', 'text': prompt},
        {'type': 'image_url', 'image_url': {'url': 'data:image/png;base64,' + b64}},
    ]}],
    'max_tokens': 800,
}
req = urllib.request.Request('http://127.0.0.1:10000/v1/chat/completions',
                             data=json.dumps(body).encode(),
                             headers={'Authorization': 'Bearer ' + cfg['API_KEY'],
                                      'Content-Type': 'application/json'})
try:
    d = json.load(urllib.request.urlopen(req, timeout=300))
    print(d['choices'][0]['message']['content'])
except Exception as e:
    print('ERR', e)
    if hasattr(e, 'read'):
        print(e.read().decode('utf-8', 'replace')[:800])
