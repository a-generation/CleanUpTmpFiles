import os
import time
import shutil

APPDATA_PATH = os.getenv('APPDATA')
SIX_MONTHS_IN_SECONDS = 6 * 30 * 24 * 60 * 60

def delete_old_files(directory):
    for root, dirs, files in os.walk(directory):
        for name in files:
            if name.endswith('.tmp'):
                file_path = os.path.join(root, name)
                file_mod_time = os.path.getmtime(file_path)
                if time.time() - file_mod_time > SIX_MONTHS_IN_SECONDS:
                    os.remove(file_path)
                    print(f"Deleted: {file_path}")

if APPDATA_PATH:
    delete_old_files(APPDATA_PATH)
else:
    print("AppData directory not found.")
