#include "daq_core_nljs.hpp"

#include "factory.hpp"

#include "cogs/configurable.hpp"
#include "cogs/issues.hpp"


namespace demo {

    class DAQProcess : public cogs::Configurable<dunedaqcfg::Application> {
      public:
        DAQProcess() {
            ERS_LOG("DAQProcess:\t\thello");
        }
        virtual ~DAQProcess() {
            ERS_LOG("DAQProcess:\t\tgood-bye");
        }

      virtual void configure(dunedaqcfg::Application&& cfg) {
	ERS_LOG("DAQProcess:\t\t" << cfg.ident << " executes "
		<< cfg.executable.ident  << " on host " << cfg.host.ident);
        }
    };
}

DEMO_REGISTER_COMPONENT("demoDAQProcess", demo::DAQProcess);
