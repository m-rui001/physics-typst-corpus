#!/usr/bin/env python
"""Send an image + prompt to the local free gateway's vision model."""
import base64
import json
import mimetypes
import sys
import urllib.request

BASE = 'http://127.0.0.1:8317'
KEY = 'free-local-8317'
DEFAULT_MODEL = 'or-nemotron-3.5-vl'


def ask(img_path, prompt, model=DEFAULT_MODEL, max_tokens=2000):
    mime = mimetypes.guess_type(img_path)[0] or 'image/png'
    data = base64.b64encode(open(img_path, 'rb').read()).decode()
    body = {
        'model': model,
        'max_tokens': max_tokens,
        'messages': [{'role': 'user', 'content': [
            {'type': 'text', 'text': prompt},
            {'type': 'image_url', 'image_url': {'url': 'data:%s;base64,%s' % (mime, data)}},
        ]}],
    }
    last = None
    for model_name in (model, 'nemotron-3.5-vl', model):
        body['model'] = model_name
        for _ in range(2):
            try:
                req = urllib.request.Request(BASE + '/v1/chat/completions', data=json.dumps(body).encode(),
                                             headers={'Authorization': 'Bearer ' + KEY,
                                                      'Content-Type': 'application/json'})
                d = json.load(urllib.request.urlopen(req, timeout=180))
                text = d['choices'][0]['message'].get('content') or ''
                if text.strip():
                    return text
                last = 'empty content'
            except Exception as e:
                last = str(e)
    return 'FAILED: ' + str(last)


if __name__ == '__main__':
    img = sys.argv[1]
    prompt = sys.argv[2] if len(sys.argv) > 2 else (
        'This is one page of a typeset physics paper. List concrete typesetting defects you can see: '
        'overlapping or clipped text, text running off the page or into the margin, broken or garbled math, '
        'empty boxes or missing figures, table rows misaligned, stray LaTeX commands. '
        'Answer with a short bullet list; if the page looks clean, say CLEAN.')
    model = sys.argv[3] if len(sys.argv) > 3 else DEFAULT_MODEL
    sys.stdout.reconfigure(encoding='utf-8')
    print(ask(img, prompt, model))
