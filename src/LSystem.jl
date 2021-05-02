module LSystem

using Luxor

function l_system_pass(seq::Vector{String}, rules)
	new_seq = map(seq) do el
		if haskey(rules, el)
			return rules[el]
		else
			return [el]
		end
	end
	return collect(Iterators.flatten(new_seq))
end

## entry function for the L-l_system
function l_system(start_seq::String, rules::Dict, times::Integer)
    seq = slipt(start_seq, " ")
    for i in 1:times
        seq = l_system_pass(seq, rules)
    end
end

## List of possible instructions
instructions = Dict(
    "F" => t -> Forward(t, 10), # Move the turtle forward by a default lenght
    "F()" => (t, l) -> Forward(t, l), # More the turtle forward by the given lenght
    "T()" => (t, a) -> Turn(t, a), # Turn the turtle right by the given angle (in degrees)
    "[" => t -> Push(t), # save current turtle status
    "]" => t -> Pop(t) # restore turtle status
)

function plot_turtle(seq)
    t = Turtle()
    @svg begin
        for step in seq
            turtle_step(t, step)
        end
    end
end



function turtle_step(t, step)
    try
        if occursin("(", step) # This is a step with arguments
            (instr, arg) = match(r"(.*)\((\d+)\)", step).captures
            arg = parse(Float64, arg)
            instructions[instr * "()"](t, arg)
        else
            instructions[step](t)
        end
    catch e
        if !isa(e, KeyError) #ignore unknown steps
            rethrow()
        end
    end
    
end

end # module
