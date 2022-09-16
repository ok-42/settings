import sys

if __name__ == '__main__':
    file_name: str = sys.argv[1]
    with open(file_name) as file:
        data = file.read().rstrip()
    for line in data.split('\n'):
        hour, count = line.split()
        print(hour, '#' * int(count))
