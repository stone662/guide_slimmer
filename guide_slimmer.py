import xml.etree.ElementTree as ET
import sys


input_file = sys.argv [1]
locale = sys.argv [2]
output_file = sys.argv [3]

tree = ET.parse(input_file)
root = tree.getroot()

for child in root.findall('channel'):
    if locale not in child.attrib.get('id'):
        root.remove(child)
        print("Removed Channel " + child.attrib.get('id'))
for child in root.findall('programme'):
    if locale not in child.attrib.get('channel'):
        root.remove(child)
        print("Removed Programme " + child.attrib.get('channel'))
tree.write(output_file)