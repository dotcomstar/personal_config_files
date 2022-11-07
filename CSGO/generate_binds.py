# This script will generate looping CSGO binds for each non-blank line in the given file.
# Created by @dotcomstar on GitHub.

import random
import os
from os import listdir

# NOTE: Make sure to create a new folder for copypastas! This code will delete all the config files
# Tutorial from MaximGaming on finding your CSGO config location: https://youtu.be/rRFEN9FW3mo?t=15
# in the folder you specify below.
#COPYPASTA_PATH = "/d/Downloads/Video Games/Steam/userdata/333549295/730/local/cfg/dwayne/"  # WSL
COPYPASTA_PATH = "D:\\Downloads\\Video Games\\Steam\\userdata\\333549295\\730\\local\cfg\\dwayne\\"  # Windows
COPYPASTAS_FILE = "copypasta.txt"
KEYBIND_INGAME = "F9"  # What button do you press to say a new copypasta?
CSGO_MAX_LINE_LEN = 244  # characters

# Algorithm: Delete all existing config files in the current folder. 
# Next, split the entire copypasta file on double newlines to get a list of individual pastas.
# Now, shuffle this list so that the order of copypastas is random and each copypasta has the same
# chance of being chosen, regardless of length. Then, within each copypasta, we split on a whitespace
# closest to CSGO's max line length. This allows us to post long strings into our copypasta file and
# output sequential binds for the same copypasta. This includes always splitting on newlines, which
# allows for manual control of where to split (useful for readability in the copypasta file). 
# TODO: Split each line longer than CSGO_MAX_LINE_LEN on the nearest whitespace to the left of the max line length.

# Delete previous config files.
for file_name in listdir(COPYPASTA_PATH):
    if file_name.endswith('.cfg'):
        os.remove(COPYPASTA_PATH + file_name)

lines = open(COPYPASTAS_FILE, encoding='utf-8').read().split('\n\n')
random.shuffle(lines)
counter = 1
for quote in lines:
    if quote == '':  # Filters out empty lines
        continue
    quote = quote.split("\n")
    for line in quote:
        if line == '':  # Filters out empty lines
            continue
        file_name = str(counter) + ".cfg"
        fn = open(file_name, 'w+')
        fn.write('say "' + line + '";' + ' bind "' + KEYBIND_INGAME + '" "exec dwayne/' + str(counter + 1) + '"')
        text = line
        counter += 1

# Make the binds loop back around.
file_name = str(counter - 1) + ".cfg"  # Access the most recently added file.
padding = ' ' * (counter // 10)  # We need this because the last line gets overwritten, not deleted and rewritten. Otherwise, we could be left with extra numbers or quotation marks.
fn = open(file_name, 'w+')
fn.write('say "' + text + '";' + ' bind "' + KEYBIND_INGAME + '" "exec dwayne/1"' + padding)
