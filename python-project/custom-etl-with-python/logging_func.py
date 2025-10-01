from datetime import datetime

def log_tracking(message):
    """This function logs the mentioned message of a given stage of the
    code execution to a log file. Function returns nothing"""

    with open('./logs/code_log.txt', 'a') as f:
        f.write(f'{datetime.now()}: {message}\n')