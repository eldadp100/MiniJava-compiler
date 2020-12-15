import os
import subprocess
import string
from itertools import groupby


def read_file(path):
    with open(path, 'r') as f:
        out = []
        for line in f.readlines():
            line = line.strip("\t\n ")
            if len(line) > 0 and line[0] != ";":
                out.append(line)

        return "\n".join(out)


class Test:
    def __init__(self, directory, name, files):
        self.directory = directory
        self.name = name
        self.files = files
        self.validate_files()

        self.input = self.directory + '/' + self.files['java.xml'] # TODO clean
        self.output =  self.directory + '/' + self.files['ll'] # TODO clean
        self.command = "compile" #read_file(os.path.join(directory, self.files['sh'])).replace('\n','')
        self.result_output = self.output.replace(self.name, self.name + "_Generated")

    def validate_files(self):
        assert len(self.files) >= 3 , f'Invalid file count for name {self.name} - found only {len(self.files)}'
        for suffix in ['ll', 'java.xml', 'java']:
            assert suffix in self.files, f'Missing file {self.name}.{suffix}'

    def execute(self):
        command_arr = ['java', '-jar', 'mjavac.jar', 'unmarshal'] + self.command.split(' ') + [self.input, self.result_output]
        process = subprocess.Popen(command_arr,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()
        stdout = stdout.decode("utf-8")
        stderr = stderr.decode("utf-8")
        if stderr and len(stderr) > 0:
            raise Exception(stderr)

    def validate_results(self):
        expected = read_file(self.output).split("\n")
        result = read_file(self.result_output).split("\n")
        test_results = []
        all_ok = True
        if not len(expected) == len(result):
            all_ok = False
            test_results.append(f"The number of lines in your file is not the same as the number of lines in the formal one:\n\tYour file has {len(result)} lines.\n\tFormal file has {len(expected)} lines")
        else:
            test_results.append(f"Number of lines MATCH. Both files has {len(result)} lines.")
            for i in range(len(expected)):
                ex = expected[i]
                re = result[i]
                if not ex == re:
                    all_ok = False
                    test_results.append(f"Line {i+1} doesn't match.\nIn your  file it's: {re}\nIn the formal file it's: {ex}")
        return all_ok, test_results




def execute_tests(tests_path):

    print('\nStarted tests\n')
    key = lambda f: f.split('.')[0]
    for test_dir in sorted(os.listdir(tests_path), key=key):
        directory = f'{tests_path}/{test_dir}'
        test_name, files = next(groupby(sorted(os.listdir(directory), key=key), key=key))
        execute_one_test(directory, test_name, files)
        print()


def execute_one_test(directory, test_name, files):
    print(f'Started test "{test_name}"')
    try:
        test_files = {'.'.join(f.split('.')[1:]): f for f in files}
        test = Test(directory, test_name, test_files)
    except Exception as e:
        print(f'Test "{test_name}" is invalid: {e}')
        return 0
    try:
        test.execute()
        all_ok, test_output = test.validate_results()
        print('-' * 60)
        if all_ok:
            print(f'Test "{test_name}" run successfully and passed')
        else:
            print(f'Test "{test_name}" run successfully and found some issues. Here is their summery:')
            for msg in test_output:
                print(msg)
        return 1
    except Exception as e:
        print(f'Test "{test_name}" failed to run:\n\t{e}')
        return 0


if __name__ == '__main__':

    test_folders_folder = 'tests/ex2'
    if "mjavac.jar" not in os.listdir(os.path.dirname(os.path.realpath(__file__))):
        process = subprocess.Popen(["ant", "-lib", "./tools"],
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()
        stdout = stdout.decode("utf-8")
        stderr = stderr.decode("utf-8")
        if stderr and len(stderr) > 0:
            raise Exception(stderr)

    print(os.path.realpath(__file__))
    tests_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), test_folders_folder)
    execute_tests(tests_path)
