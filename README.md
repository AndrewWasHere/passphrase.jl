# passphrase.jl

Random words in a range of lengths. Written in Julia.

Use:
```shell
julia passphrase.jl
    [ -n <Number of words> ]  # default is 5
    [ --min <minimum number of characters in word> ]  # default is 2
    [ --max <maximum number of characters in word> ]  # default is 6
    [ words file [words file] ... ]  # default is /usr/share/dict/words
```
Words files are assumed to have one word per line.

## Dependencies

None, other than Julia and its standard libraries.

## License

Distributed under the MIT License. See LICENSE.txt
