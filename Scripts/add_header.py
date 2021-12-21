import os
import pandas as pd
import sys

def insert(originalfile,string, dir):
    originalfile = dir+originalfile
    with open(originalfile,'r') as f:
        with open('newfile.txt','w') as f2: 
            f2.write(string)
            f2.write(f.read())
    os.remove(originalfile)
    os.rename('newfile.txt',originalfile)

def add_header(file_name, sheet, dir):
    # Header variables that will remain constant for all pieces in the corpus
    com = "!!!COM: John Williams"
    enc = "!!!ENC: Frank Lehman"
    eed1 = "!!!EED: Claire Arthur"
    eed2 = "!!!EED2: John McNamara"

    # Open Excel doc containing corpus metadata
    doc_name = "Star Wars Theme Corpus.xlsx"
    doc_path = "../"

    original_df = pd.read_excel(doc_path+doc_name, sheet_name=0).dropna(subset=['Number']).dropna(how='all', axis='columns')
    prequel_df = pd.read_excel(doc_path+doc_name, sheet_name=1).dropna(subset=['Number']).dropna(how='all', axis='columns')
    sequel_df = pd.read_excel(doc_path+doc_name, sheet_name=2).dropna(subset=['Number']).dropna(how='all', axis='columns')

    # Clean numbers
    original_df.Number = original_df.Number.astype(str)
    prequel_df.Number = prequel_df.Number.astype(str)
    sequel_df.Number = sequel_df.Number.astype(int).astype(str)

    df_list = [original_df, prequel_df, sequel_df]
    df = df_list[int(sheet)]

    num = file_name.split('/')[-1].split("_")[0]
    if num != ".DS":
        row = df[df["Number"] == num]
        film_year = row["Film/Year Introduced"].iloc[0].split('-')
        film = "!!!GAW: Star Wars: "+film_year[0].strip()
        year = "!!!ODT: "+film_year[1].strip()
        title = "!!!OTL: "+row["Theme"].iloc[0]
        #title = "!!!OTL: " + " ".join(file_name.split("_")[1:][:-1])

        header_components = [com, title, film, year, enc, eed1, eed2]
        header = '\n'.join(header_components)+'\n'

        insert(file_name, header, dir)

        print(header)

        return


def main(argv):
    if len(argv) > 2:
        dir = argv[1]
        sheet = argv[2]
        files = os.listdir(dir)
        for f in files:
            add_header(f, sheet, dir)
        return
    else:
        print("Not enough arguments passed")
        return



if __name__=="__main__":
    main(sys.argv)