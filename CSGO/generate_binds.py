# This script will generate looping CSGO binds for each non-blank line in the given file.

copypastas_file = "copypasta.txt"
keybind = "F9"

lines = open(copypastas_file).read().splitlines()
counter = 1
for line in lines:
    if line == '':
        lines.remove(line)
for line in lines:
    file_path = str(counter) + ".cfg" 
    fp = open(file_path, 'w+')
    fp.write('say ' + line + ';' + ' bind "' + keybind + '" "exec dwayne/' + str(counter + 1) + '"')
    text = line
    counter += 1

# Make the binds loop back around.
file_path = str(len(lines)) + ".cfg" 
fp = open(file_path, 'w+')
fp.write('say ' + text + ';' + ' bind "' + keybind + '" "exec dwayne/' + str(1) + '" ')
# TODO: Figure out why this last line doesn't work without the space after the last quote
