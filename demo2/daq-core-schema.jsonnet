local re = import "re.jsonnet";
function(schema) {
    local ident = schema.string(pattern=re.ident_only),

    local osversion = schema.enum("OSVersion", ["CentOS7","CentOS8"], default="CentOS7",
                         doc="Operating system verison of the host"),
    
    local queuetype = schema.enum("QueueType", ["FollySPSCQueue","FollyMPMCQueue","StdDeQueue"], 
    	  	         default="FollySPSCQueue",
                         doc="Type of queue interconnecting DAQ modules."),

    local queue = schema.record("Queue", fields= [
    	  schema.field("ident", ident, doc="queue name"),
	  schema.field("capacity", schema.number(dtype="i4"), 2, doc="Number of entries the queue can hold"),
	  schema.field("kind", "QueueType", doc="The specific queue implementation to use"),
    ], doc = "Describes a queue connecting DAQ modules"),


    local daqmodule = schema.record("DAQModule", fields = [
    	  schema.field("ident", ident, doc="DAQ module name"),
	  schema.field("modulePath", schema.string(), doc="path where to find the shared lib corresponding to the module"),
    ], doc = "Describes a generic DAQ module"),
    
    local host = schema.record("Host", fields= [
    	schema.field("ident", ident,
                doc="The host name"),
        schema.field("osversion", "OSVersion",doc="The OS running on the host")], 
	doc="Binds a OS version to a host"),
    
    local executable = schema.record("Executable", fields=[
    	  schema.field("ident", ident, 
	  	   doc="executable name"),
          ], doc="Describes the executable for a process. This is far too simplistic, but this type can grow later..."),

    local application = schema.record("Application", fields=[
    	  schema.field("ident", ident, doc="application name"),
          schema.field("executable", "Executable", doc = "Executable to use for this application"),
	  schema.field("runsOn", "Host", doc = "Where to run the application"),
    ], doc = "Describes an application"),

    local controller = schema.record("Controller", fields=[
    	  schema.field("ident", ident, doc="application name"),
          schema.field("executable", "Executable", doc = "Executable to use for this application"),
	  schema.field("runsOn", "Host", doc = "Where to run the application"),
          schema.field("children", schema.sequence("Application"), doc = "List of child processes to control"),
    ], doc = "Describes a controller application"),

    local dfapplication = schema.record("DFApplication", fields=[
          schema.field("ident", ident, doc="application name"),
          schema.field("executable", "Executable", doc = "Executable to use for this application"),
          schema.field("runsOn", "Host", doc = "Where to run the application"),
	  schema.field("queues", schema.sequence("Queue"), doc="Queues used in the application"),
          schema.field("modules", schema.sequence("DAQModule"), doc="DAQ modules used in the application"),
    ], doc = "Describes a dataflow application"),

    types: [ osversion, host, executable, application, queuetype, queue, daqmodule, controller ],
}
