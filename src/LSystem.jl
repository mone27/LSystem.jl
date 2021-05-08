module LSystem

using Luxor, Lazy

import Luxor: Reposition, Forward, Turn, Push, Pop, Message, Pencolor

export l_system, plot_turtle, plot_l_system, LTurtle, f_rule

function l_system_pass(seq::Vector{<:Any}, rules)
	new_seq = map(seq) do el
		if occursin("(", el) # This is an element with arguments
            (rule, args) = match(r"(.+)\((.+)\)", el).captures #extracts rules name
            rule_name = rule * "()"
            if haskey(rules, rule_name)
                args = split(args, ",")
                args = Meta.parse.(args) # TODO this is duplicate code
                args = eval.(args)
                return rules[rule * "()"](args...)
            else
                return [el]
            end

        elseif haskey(rules, el) # simple match without arguments
			return rules[el]()
		else
			return [el]
		end
	end
	return collect(Iterators.flatten(new_seq))
end

""" Convert a dict of strings to a dict of functions"""
function to_rules(rules::Dict)
    new_rules = Dict()
    for key in keys(rules) # splits into an array all the rules
        new_key, rule = to_f_rule(key, rules[key])
        new_rules[new_key] = rule
    end 
    rules = new_rules
end


""" Convert a string to a function"""
function to_f_rule_args(key, rules)
    rules = split(rules, " ")

    (rule_name, args_names) = match(r"(.+)\((.+)\)", key).captures
    args_names = split(args_names, ",")
    
    function rule_func(fargs...)
        rules = map(rules) do rule
            return replace_arguments(rule, args_names, fargs)
        end
        return rules
    end

    return (rule_name * "()", rule_func)
end


function to_f_rule(key, rules)
    if occursin("(", key) # this is a rules with arguments
        return to_f_rule_args(key, rules)
    else 
        rules = split(rules, " ")
        rule_func = () -> rules
        return (key, rule_func)
    end
end

function replace_arguments(rule, args_names, args)
    for (name, arg) in zip(args_names, args)
        rule = replace(rule, name => arg)
    end
    return rule
end

"""
entry function for the L-l_system
"""
function l_system(start_seq::String, rules::Dict, times::Integer)
    seq = String.(split(start_seq, " "))

    rules = to_rules(rules)
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
            (instr, args) = match(r"(.+)\((.+)\)", step).captures
            args = split(args, ",")
            args = Meta.parse.(args)
            args = eval.(args)

            instructions[instr * "()"](t, args...)
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
    "M()" => Move, # Move without writing
    "[" => Push, # save current turtle status
    "]" => Pop # restore turtle status,
)


# F(t, d) = Forward(t, t.len * d)
# LMul(t, a) =  t.len *= a
# Col(t, r, g, b) = Pencolor(t, r, g, b)
# M(t, d) = Move(t, d)



function plot_l_system(seq, rules, times; t= LTurtle(), write_text=true)
    seq = l_system(seq, rules, times)
    plot_turtle(seq, turtle = t, write_text = write_text)
end

end # module
