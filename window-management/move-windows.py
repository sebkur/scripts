#!/usr/bin/env python3
import sys
import subprocess
import re

get_output = lambda cmd: subprocess.check_output(cmd).decode("utf-8")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: {} <source desktop> <target desktop>".format(sys.argv[0]))
        print()
        print("Note: source and target desktop numbers are 0-based")
        exit(1)

    sourceDesktop = sys.argv[1]
    targetDesktop = sys.argv[2]

    print("Moving from desktop {} to {}".format(sourceDesktop, targetDesktop))

    windows = get_output(["wmctrl", "-l"])
    windowList = windows.splitlines()
    for window in windowList:
        (id, desktop, machine, title) = re.split(" +", window, 3)
        if (desktop == sourceDesktop):
            print("Moving window with id '{}' and title '{}'".format(id, title))
            subprocess.check_call(["wmctrl", "-ir", id, "-t", targetDesktop])
