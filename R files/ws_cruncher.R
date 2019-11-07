library(rjwsacruncher)

path="C:/sarepository/WS"

cruncher(workspace = paste(path, "estp.xml", sep='/'), cruncher_bin_directory = "C:/localdata/cruncher/bin", param_file_path = paste(path, "spec1.params", sep='/'))
