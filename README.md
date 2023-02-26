# passphrase.jl

Random words in a range of lengths. Written in Julia.

Use:

julia passphrase.jl 
    [ -n <Number of words> ]  # default is 5
    [ --min <minimum number of characters in word> ]  # default is 2
    [ --max <maximum number of characters in word> ]  # default is 6
    [ file to read words from ]  # default is /usr/share/dict/words

Word file is assumed to have one word per line.

## Dependencies

None, other than Julia and its standard libraries.

## License

Distributed under the MIT License. See LICENSE.txt
