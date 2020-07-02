// compile with -m
local moo = import "moo.jsonnet";
local moc = import "moc.jsonnet";
local core = import "daq-core-schema.jsonnet";
local head = import "head-schema.jsonnet";

{
    "core_avro.json": core(moc.avro).types,
    "head_avro.json": head(moc.avro).types,
}
