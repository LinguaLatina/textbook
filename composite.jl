using Pkg
Pkg.add("UnifyJustTheDocs")
using UnifyJustTheDocs
using Dates


root = isempty(ARGS) ?  joinpath(pwd(), "docs") : ARGS[1]

outfile = length(ARGS) > 1 ? ARGS[2]  : "composite.md"
settingsfile = length(ARGS) > 2 ? ARGS[3] : "pdf/settings.yaml"

settings = readlines(settingsfile) 


@info("Compositing source files in $root")
# create YAML header:
(m,d) = monthday(today())
yr = year(today())
datestr = "$(monthname(m)) $(d), $(yr)"
push!(settings, "date: $(datestr)")
hdr = "---\n"  * join(settings, "\n") * "\n---\n\n"

# Create single markdown file
docsmd = composite(root)
md = hdr * replace(docsmd, "`" => "")
# Another LaText gotcha:
tidier = replace(md, "-*" => "*")

# Write to disk
open(outfile,"w") do io
    write(io, tidier)
end


