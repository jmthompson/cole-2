#include <signal.h>
#include <time.h>
#include <ctype.h>
#include <unistd.h>
#include <verilated.h>

#include "testbench.h"
#include "Vbus.h"

class CPU_BUS_TB : public TESTBENCH<Vbus> {
public:
    void tick(void) {
        TESTBENCH<Vbus>::tick();
    }
};

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);

    CPU_BUS_TB *tb = new CPU_BUS_TB();
    tb->reset();
    tb->opentrace("out.vcd");

	while(!tb->done()) {
		tb->tick();
	} exit(0);
}
