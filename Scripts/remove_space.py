import os

def main():
    files = os.listdir()
    for f in files:
        old = f
        new = f.replace(" ", "_")
        os.rename(old, new)
    return

if __name__ == "__main__":
    main()

