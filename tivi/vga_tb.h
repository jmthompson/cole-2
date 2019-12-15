#include "testbench.h"
#include <vgasim.h>
#include <Vvga.h>

class VGA_TB : public TESTBENCH<Vvga> {
        VGASIM *vgasim;

        VGA_TB(void) {
            vgasim = new VGASIM();
        }

        virtual void tick(void) {
            vgasim(
            top->
        }
};
