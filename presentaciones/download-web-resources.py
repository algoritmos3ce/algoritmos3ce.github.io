import json, os.path, sys, urllib.request
dir = sys.argv[1]
data = json.load(sys.stdin)
for item in data:
    url = item['url']
    path = os.path.join(dir, item['path'])
    if not os.path.isfile(path):
        print(f"{path}: downloading {url}")
        if os.path.dirname(path) != "":
            os.makedirs(os.path.dirname(path), exist_ok=True)
        urllib.request.urlretrieve(url, path)
    else:
        print(f"{path}: skipping")
