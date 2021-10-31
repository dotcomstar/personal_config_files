# This script will generate looping CSGO binds for each non-blank line in the given file.

import random
import os
from os import listdir

#copypasta_path = "/d/Downloads/Video Games/Steam/userdata/333549295/730/local/cfg/dwayne/"  # Linux
copypasta_path = "D:\\Downloads\\Video Games\\Steam\\userdata\\333549295\\730\\local\cfg\\dwayne\\"  # Windows
copypastas_file = "copypasta.txt"
keybind = "F9"

# Delete previous config files.
for file_name in listdir(copypasta_path):
    if file_name.endswith('.cfg'):
        os.remove(copypasta_path + file_name)

lines = open(copypastas_file, encoding='utf-8').read().split('\n\n')
random.shuffle(lines)
counter = 1
for quote in lines:
    if quote == '':
        continue
    quote = quote.split("\n")
    for line in quote:
        if line == '':
            continue
        file_name = str(counter) + ".cfg"
        fn = open(file_name, 'w+')
        fn.write('say ' + line + ';' + ' bind "' + keybind + '" "exec dwayne/' + str(counter + 1) + '"')
        text = line
        counter += 1

# Make the binds loop back around.
file_name = str(counter - 1) + ".cfg"
padding = ' ' * (counter // 10)  # We need this because the last line gets overwritten, not deleted and rewritten. Otherwise, we could be left with extra numbers or quotation marks.
fn = open(file_name, 'w+')
fn.write('say ' + text + ';' + ' bind "' + keybind + '" "exec dwayne/' + str(1) + '"' + padding)
