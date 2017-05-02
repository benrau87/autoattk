
 
import xmltodict
import json
import argparse
 
falsecount = 0
truecount = 0
 
parser = argparse.ArgumentParser(description='Get hashes')
parser.add_argument('-f', '--file', help='File to parse')
args = parser.parse_args()
with open(args.file, 'r') as readfile:
    xmlfile = readfile.read()   
	
unparsed = json.dumps(xmltodict.parse(xmlfile))
 
parsed = json.loads(unparsed)
 
for process in parsed['Scan']['Entries']['Entry']:
    if process['FalsePositive'] == 'false':
        print(process['SHA1'])
        with open('truepositives.txt', 'a') as outfile:
            outfile.write(process['SHA1'])
            outfile.write('\n')
        falsecount += 1
    else:
        truecount += 1
 
totalcount = falsecount + truecount
 
print("")
print("===============")
print("Analysis Stats")
print("===============")
print("False: " + str(falsecount))
print("True: " + str(truecount))
print("Total: " + str(totalcount))
 