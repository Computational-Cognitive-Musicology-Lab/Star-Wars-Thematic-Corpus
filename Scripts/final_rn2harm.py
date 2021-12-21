import os
import sys
import re

def rn2harm(filename):
    split = os.path.splitext(filename)[0]
    file = open(filename, 'r')
    new_line = ""
    if split != ".DS_Store":
        for line in file:
            if re.search('^\S+\t(([viVI]+)[^.]+)\t.+\t([^. ]+)$', line):
                new_search = re.search('^\S+\t(([viVI]+)[^.]+)\t.+\t([^. ]+)$', line)
                harte = new_search.groups()[2]
                degrees = re.findall('\([^)]+\)', harte)
                harte_search = re.findall('[b#*]*\d+', degrees[0])
                # re.search('\d+]', new_search.groups()[2])
                # print(re.search('[b#]*\d+]', new_search.groups()[2]))
                for i, deg in enumerate(harte_search):
                    num = re.search('\d+', deg)
                    acc = re.search('[b#]+', deg)
                    non_perf = {  
                        "bb": "D",
                        "b": "m",
                        "#": "A",
                        "##": "AA"
                    }
                    perf = {
                        "bb": "DD",
                        "b": "D",
                        "#": "A",
                        "##": "AA"
                    }
                    harm_deg = ""
                    if num.group() == '2' or num.group() == '3' or num.group() == '6' or num.group() == '7' or num.group() == '9' or num.group() == '10' or num.group() == '13':
                        if acc != None:
                            harm_deg = non_perf[acc.group()]+num.group()
                        else:
                            harm_deg = "M"+num.group()
                    elif num.group() == '4' or num.group() == '5' or num.group() == '11' or num.group == '12':
                        if acc != None:
                            harm_deg = perf[acc.group()]+num.group()
                        else:
                            harm_deg = "P"+num.group()
                    harte_search[i] = harm_deg
                harm = new_search.groups()[1]+''.join(harte_search)
                new_line = line.replace(new_search.groups()[0], harm)
            else:
                new_line = line
            newfile = open(split+'_rn2harm'+'.krn', 'a')
            newfile.write(new_line)

def main():
    for f in os.listdir():
        rn2harm(f)
    # args = sys.argv[1:]
    # rn2harm(args[0])
    # files = os.listdir()
    # for file in files:
    #     double_split = os.path.splitext(os.path.splitext(file)[0])
    #     if double_split[1] == '.musicxml':
    #         rn2harm(file)
    # print(args)
    return
if __name__ == "__main__":
    main()