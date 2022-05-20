def process(event, context):
    import base64

    if 'data' in event:
        result = base64.b64decode(event['data']).decode(
            'utf-8')
        print(result)
    else:
        print('Nothing to process')
