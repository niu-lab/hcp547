#!/usr/bin/env python3
import click
import os
import re

DEFAULT_MACROS_FILE = os.path.join(os.path.dirname(__file__), "default.macros")


def read_macros(filename):
    pattern = r'([A-Z0-9_]+)=(.+)\n'
    macros_re = re.compile(pattern)
    macros_dict = dict()
    with open(filename, "r") as file:
        for line in file:
            line = line.strip()
            matched = macros_re.match(line)
            if matched:
                key = matched.group(1)
                value = matched.group(2)
                macros_dict[key] = value
    return macros_dict


def merged_macros(filename):
    default_macros = read_macros(DEFAULT_MACROS_FILE)
    input_macros = read_macros(filename)
    for default_macro in default_macros:
        if default_macro not in input_macros:
            input_macros[default_macro] = default_macros[default_macro]
        if len(input_macros[default_macro].strip()) == 0:
            input_macros[default_macro] = default_macros[default_macro]
    return input_macros


def write_macros(macros_dict, filename):
    with open(filename, "w+") as write_file:
        for macro in macros_dict:
            line = "{key}={value}".format(key=macro, value=macros_dict[macro])
            write_file.write(line + os.linesep)


@click.command()
@click.argument('in_config')
@click.argument("out_config")
def main(in_config, out_config):
    macros = merged_macros(in_config)
    write_macros(macros, out_config)
    pass


if __name__ == '__main__':
    main()
