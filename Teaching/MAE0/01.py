# Import the os module
import os

# # Get the current working directory
# cwd = os.getcwd()
# print(cwd)

# # Substitute UNC to M: (Each backward slash is represented by a double \\)
# mwd = cwd.replace("M:\\","\\\\kant\\uv-cemo-u1\\tctan\\")
# print(mwd)

# # Change working directory to M:\ format
# os.chdir(mwd)

# Flush out any failed/unfinished jobs
os.system("00.bat")

# Build pdfLaTeX
os.system("01.bat")

# Clean up auxiliary files
os.system("00.bat")
