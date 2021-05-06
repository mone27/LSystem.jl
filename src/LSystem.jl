module LSystem

using Luxor, Lazy

import Luxor: Reposition, Forward, Turn, Push, Pop, Message, Pencolor

export l_system, plot_turtle, plot_l_system, LTurtle

function l_system_pass(seq::Vector{<:AbstractString}, rules)
	new_seq = map(seq) do el
		if haskey(rules, el)
			return rules[el]
		else
			return [el]
		end
	end
	return collect(Iterators.flatten(new_seq))
end

"""
entry function for the L-l_system
"""
function l_system(start_seq::String, rules::Dict, times::Integer)
    seq = split(start_seq, " ")
    new_rules = Dict()
    for key in keys(rules) # splits into an array all the rules
        new_rules[key] = split(rules[key], " ")
    end 
    rules = new_rules

    for i in 1:times
        seq = l_system_pass(seq, rules)
    end
    return seq
end


mutable struct LTurtle
    turtle::Turtle
    len::Float64
end

LTurtle() = LTurtle(Turtle(), 1) # default values

# Forward(t::LTurtle, d) = Forward(t.turtle, d)
# Turn(t::LTurtle, r) = Turn(t.turtle, r)
# Reposition(t::LTurtle, x, y) = Reposition(t.turtle, x, y)
@forward LTurtle.turtle Message, Forward, Turn, Reposition, Pencolor

Base.copy(t::LTurtle) = LTurtle(copy(t.turtle), t.len)
Base.copy(t::Turtle) = Turtle(t.xpos, t.ypos, t.pendown, t.orientation, t.pencolor)

function Move(t::LTurtle, d)
    Penup(t.turtle)
    Forward(t, d)
    Pendown(t.turtle)
end

turtle_queue = Vector{LTurtle}()

function Push(t::LTurtle)
    global turtle_queue
    push!(turtle_queue, copy(t))
end

function Pop(t::LTurtle)
    global turtle_queue
    if !isempty(turtle_queue)
        last_state = pop!(turtle_queue)
        t.turtle, t.len = last_state.turtle, last_state.len # need to find a cooler system here
    end
end

function turtle_step(t, step; write_text = true)
    try
        if occursin("(", step) # This is a step with arguments
            (instr, arg) = match(r"(.+)\((.+)\)", step).captures
            arg = split(arg, ",")
            arg = parse.(Float64, arg)
            instructions[instr * "()"](t, arg...)
        else
            instructions[step](t)
        end
    catch e
        if isa(e, KeyError) #write as text steps that are unknown
            if write_text Message(t, step) end
        else
            rethrow()
        end
    end

end


function plot_turtle(seq; turtle = LTurtle(), write_text = false)
    @svg begin
        for step in seq
            turtle_step(turtle, step, write_text = write_text)
        end
    end
end

"""
List of possible instructions
"""
instructions = Dict(
    "F" => t -> Forward(t, t.len), # Move the turtle forward by a default lenght
    "F()" => (t, d) -> Forward(t, t.len * d), # More the turtle forward by the given lenght
    "T()" => Turn, # Turn the turtle right by the given angle (in degrees)
    "RMul()" => (t, a) -> t.turtle.orientation *= a, # Multiply rotation by coefficient
    "LMul()" => (t, a) -> t.len *= a, # Multiply len by coefficient
    "Col()" => Pencolor, # Accepts 3 args in rgb to change the color
    "CMul()" =>  
    "M()" => Move, # Move without writing
    "[" => Push, # save current turtle status
    "]" => Pop # restore turtle status,
)

function plot_l_system(seq, rules, times; t= LTurtle(), write_text=true)
    seq = l_system(seq, rules, times)
    plot_turtle(seq, turtle = t, write_text = write_text)
end

end # module
