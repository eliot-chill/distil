import json

def loadConfig():
    data = {}
    with open('db/config.json') as config_file:
        data.update(json.load(config_file))
        config_file.close()
    return data


def getPassword():
    return loadConfig()["dbPass"]