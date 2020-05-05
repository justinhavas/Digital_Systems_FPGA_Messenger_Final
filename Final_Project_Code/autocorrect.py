import sys

with open("thousand_most_common_words.txt", "r") as f:
    content = f.readlines()
content = [x.strip() for x in content]

mifText = ""
address = 2048
for word in content:
    letterNum = 0;
    for letter in word:
        if letterNum % 4 == 0 and letterNum != 0:
            address += 1
            mifText += ";\n"
        if letterNum % 4 == 0:
            mifText += '\t{0:04x}: '.format(address)
        mifText += '{0:02x}'.format(ord(letter))
        letterNum += 1
    if letterNum % 4 == 0:
        address += 1
        mifText += ";\n"
    if letterNum % 4 == 0:
        mifText += '\t{0:04x}: '.format(address)
    mifText += '00'
    letterNum += 1
    while letterNum % 4 != 0:
        mifText += "00"
        letterNum += 1
    address += 1
    mifText += ";\n"

mifTextCap = ""
for letter in mifText:
    mifTextCap += letter.capitalize()
mifText = mifTextCap
print mifText

debug = False
if debug:
    for line in mifText.split("\n"):
        data = line.split(": ")[1]
        print chr(int("{}{}".format(data[0],data[1]),16)),
        print chr(int("{}{}".format(data[2],data[3]),16)),
        print chr(int("{}{}".format(data[4],data[5]),16)),
        print chr(int("{}{}".format(data[6],data[7]),16))