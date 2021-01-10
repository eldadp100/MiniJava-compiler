
import os
import subprocess
import shlex


def run_test():
    path = "valid_ast"
    files = os.listdir(path)
    files.sort()
    print()
    for file_name in files:
        if file_name[len(file_name) - 3:len(file_name)] == "xml":
            file_name = file_name[:len(file_name) - 4]
            subprocess.call(['./script.sh', file_name])


subprocess.call(shlex.split('mkdir -p produced_java_from_valid_ast'))
subprocess.call(shlex.split('mkdir -p our_ast_from_java'))
subprocess.call(shlex.split('mkdir -p produced_java_from_our_ast'))

run_test()


