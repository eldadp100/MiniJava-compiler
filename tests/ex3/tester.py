
import os
import subprocess
import shlex

os.chdir(r"tests/ex3")

def run_test(path):
    for file_name in os.listdir(path):
        if file_name[len(file_name) - 3:len(file_name)] == "xml":
            file_name = file_name[:len(file_name) - 4]
            subprocess.call(shlex.split('./tester.sh ' + file_name + ' ' + path))


subprocess.call(shlex.split('mkdir -p temp_out'))

file_ok = open("ok.txt", "w")
file_error = open("error.txt", "w")

file_ok.write("OK\n")
file_error.write("ERROR\n")

file_ok.close()
file_error.close()

subprocess.call(shlex.split('echo invalid:'))
run_test("invalid")
subprocess.call(shlex.split('echo valid:'))
run_test("valid")

