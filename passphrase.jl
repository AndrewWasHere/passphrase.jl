using Random

struct Args
    n::Int 
    length_min::Int 
    length_max::Int 
    filepaths::Vector{<:AbstractString}
end


function show_help()
    println("Usage: julia passpharse.jl [-n N] [--min N] [--max N] [-h] [[file] [file] ...]")
    println("Where:")
    println("  -n N        Set number of words to show to N (default is 5)")
    println("  --min N     Set minimum number of characters in a word to N (default is 2)")
    println("  --max N     Set maximum number of characters in a word to N (default is 6)")
    println("  -h, --help  Show this help and exit")
    println("  file        Path to file containing words list (default is /usr/share/dict/words)")
end

function parse_args(args::Vector{<:AbstractString})
    # Default settings.
    n = 5
    length_min = 2
    length_max = 6
    filepaths = ["/usr/share/dict/words"]

    function set_n(value::AbstractString)
        n = parse(Int, value)
        f = set_file
    end

    function set_min(value::AbstractString)
        length_min = parse(Int, value)
        f = set_file
    end

    function set_max(value::AbstractString)
        length_max = parse(Int, value)
        f = set_file
    end

    function set_file(value::AbstractString)
        push!(filepaths, value)
    end

    f = set_file
    for a in args
        if a == "-n"
            f = set_n
        elseif a == "--min"
            f = set_min
        elseif a == "--max"
            f = set_max
        elseif a in ("-h", "--help")
            show_help()
            exit(0)
        else
            f(a)
        end
    end

    return Args(n, length_min, length_max, filepaths)
end

function load_words(paths::Vector{<:AbstractString}, min::Int, max::Int)
    function acceptable(w::AbstractString)
        acceptable_length = min <= length(w) <= max
        acceptable_chars = ! occursin("'", w)

        return acceptable_length && acceptable_chars
    end

    words = Vector{String}()
    for p in paths
        append!(words, [word for word in eachline(p) if acceptable(word)])
    end

    return words
end

function main()
    args = parse_args(ARGS)
    words = load_words(args.filepaths, args.length_min, args.length_max)
    shuffle!(words)
    
    println(join(words[begin:min(args.n, length(words))], " "))
end

main()
