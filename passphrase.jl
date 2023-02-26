using Random

mutable struct Args
    n::Int 
    length_min::Int 
    length_max::Int 
    filepath::AbstractString
end


function parse_args(args)
    # Default settings.
    settings = Args(5, 2, 6, "/usr/share/dict/words")

    function set_n(value)
        settings.n = parse(Int, value)
    end

    function set_min(value)
        settings.length_min = parse(Int, value)
    end

    function set_max(value)
        settings.length_max = parse(Int, value)
    end

    function set_file(value)
        settings.filepath = value
    end

    f = set_file
    for a in args
        if a == "-n"
            f = set_n
        elseif a == "--min"
            f = set_min
        elseif a == "--max"
            f = set_max
        else
            f(a)
        end
    end
    return settings
end

function load_words(path::AbstractString, min::Int, max::Int)
    function acceptable(w)
        acceptable_length = min <= length(w) <= max
        acceptable_chars = ! occursin("'", w)

        return acceptable_length && acceptable_chars
    end

    [word for word in eachline(path) if acceptable(word)]
end

function main()
    args = parse_args(ARGS)
    words = load_words(args.filepath, args.length_min, args.length_max)
    words = shuffle(words)
    
    println(join(words[begin:args.n], " "))
end

main()
