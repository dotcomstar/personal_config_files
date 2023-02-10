import requests
from bs4 import BeautifulSoup
import os
from sys import platform

COPYPASTA_PATH_LINUX = "/d/Downloads/Video Games/Steam/userdata/333549295/730/local/cfg/dwayne/"  # WSL
COPYPASTA_PATH_WINDOWS = "D:\\Downloads\\Video Games\\Steam\\userdata\\333549295\\730\\local\cfg\\dwayne\\"  # Windows
COPYPASTA_PATH = COPYPASTA_PATH_WINDOWS  # Defaults to windows
COPYPASTAS_FILE = "copypasta.txt"

# Delete previous copypasta file.
if platform == 'linux':  # Allows me to run in WSL and windows batch files without changing the script.
    COPYPASTA_PATH = COPYPASTA_PATH_LINUX
elif platform == 'windows':
    COPYPASTA_PATH = COPYPASTA_PATH_WINDOWS
full_path = COPYPASTA_PATH + COPYPASTAS_FILE
os.remove(full_path)
fn = open(full_path, 'w+')

# Making a GET request
headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:32.0) Gecko/20100101 Firefox/32.0'}  # Need to bypass automation detection by faking a user identity.
#url = 'https://copypastatext.com/category/jokes/'
url = 'https://www.twitchquotes.com/copypastas/labels/classic'
r = requests.get(url,headers=headers)

# Parsing the HTML
soup = BeautifulSoup(r.content, 'html.parser')

#lines = soup.find_all("pre")
lines = soup.find_all("div", class_= "-copypasta")

for line in lines:
    pasta = line.text.replace('\r\n\r\n', '\r\n')
    fn.write(pasta)
    print('JEEEEE\n\nEEEEEEEJ')
    