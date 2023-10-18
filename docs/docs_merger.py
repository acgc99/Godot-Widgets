import typing
import shutil


def files_merger(path_src: str, path_out: str) -> None:
    """
    Merge files specified by path_src into path_out.
    """
    file_paths = get_all_file_paths(path_src)
    with open(path_out, "w") as file_out:
        for file_path in file_paths[:-1]:
            push_file("files/" + file_path, file_out)
            file_out.write("\n")
        push_file("files/" + file_paths[-1], file_out)


def get_file_path(line: str) -> str:
    """
    Returns file path from line.
    Line format: "[...](file path)".
    """
    return line[:-1].split("(")[1]


def get_all_file_paths(path_src: typing.TextIO) -> list[str]:
    """
    Return a list of all file paths in the given file.
    """
    with open(path_src, "r") as file_src:
        file_paths = []
        for line in file_src:
            if line.startswith("["):
                file_path = get_file_path(line[:-1])
                file_paths.append(file_path)
    return file_paths


def push_file(file_path: str, file_out: typing.TextIO) -> None:
    """
    Push contents on the file of given path into the output file
    """
    with open(file_path) as file:
        for line in file:
            file_out.write(line)


if __name__ == "__main__":
    path_src = "files/source.md"
    path_out = "../README.md"
    files_merger(path_src, path_out)
    path_copy = "../addons/widgets/README.md"
    shutil.copyfile(path_out, path_copy)
