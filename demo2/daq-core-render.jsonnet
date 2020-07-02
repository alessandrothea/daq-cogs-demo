local moo = import "moo.jsonnet";
local moc = import "moc.jsonnet";
local core = import "daq-core-schema.jsonnet";
local head = import "head-schema.jsonnet";

local render_nljs = function(name, schema) moo.render(
    model= {
        types: schema(moc.avro).types,
        namespace: "dunedaqcfg",
        name:name,
    },
    template = "avro_nljs.hpp.j2",
    filename = name+"_nljs.hpp");

[
    render_nljs("daq_core",core),
    render_nljs("head",head),
]

