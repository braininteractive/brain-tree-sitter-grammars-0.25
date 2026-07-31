struct ValidationError <: Exception
    msg::String
end

function parse_age(s::AbstractString)
    try
        n = parse(Int, s)
        n < 0 && throw(ValidationError("negative age"))
        n
    catch e
        if e isa ArgumentError
            rethrow()
        end
        -1
    finally
        @debug "attempted" s
    end
end

println(parse_age("42"))
