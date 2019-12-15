#ifndef TESTBENCH_H
#define TESTBENCH_H

#include <stdlib.h>
#include <verilated_vcd_c.h>

template<class MODULE> class TESTBENCH {
    unsigned long    tick_count;
    VerilatedVcdC    *trace = NULL;

public:
    MODULE *top;

    TESTBENCH(void) {
        Verilated::traceEverOn(true);

        top = new MODULE;
        tick_count = 0;
    }

    virtual ~TESTBENCH(void) {
        delete top;

        top = NULL;
    }

    virtual void reset(void) {
        top->reset = 1;
        // Make sure any inheritance gets applied
        this->tick();
        top->reset = 0;
    }

    virtual void tick(void) {
        // Increment our own internal time reference
        tick_count++;

        // Make sure any combinatorial logic depending upon
        // inputs that may have changed before we called tick()
        // has settled before the rising edge of the clock.
        top->clk = 0;
        top->eval();

        if (trace) trace->dump(10 * tick_count - 2);

        // Toggle the clock

        // Rising edge
        top->clk = 1;
        top->eval();

        if (trace) trace->dump(10 * tick_count);

        // Falling edge
        top->clk = 0;
        top->eval();

        if (trace) {
            trace->dump(10 * tick_count + 5);
            trace->flush();
        }
    }

    virtual void opentrace(const char *filename) {
        if (!trace) {
            trace = new VerilatedVcdC;
            top->trace(trace, 99);
            trace->open(filename);
        }
    }

    // Close a trace file
    virtual void close(void) {
        if (trace) {
            trace->close();
            trace = NULL;
        }
    }

    virtual bool done(void) { return (Verilated::gotFinish()); }
};

#endif // TESTBENCH_H
