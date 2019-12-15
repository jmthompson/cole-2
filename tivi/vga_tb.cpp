#include <signal.h>
#include <time.h>
#include <ctype.h>
#include <unistd.h>
#include <verilated.h>

#include "testbench.h"
#include "Vvga_tb.h"
#include "vgasim.h"

class VGA_TB : public TESTBENCH<Vvga_tb> {
public:
    VGAWIN win;

    VGA_TB(void) : win(640, 400) {
        top->cursor_on = 1;
        top->cursor_x  = 40;
        top->cursor_y  = 12;
        top->cursor_ch = 178;
        top->mode      = 0;

        Glib::signal_idle().connect(sigc::mem_fun((*this),&VGA_TB::on_tick));
    }

    void tick(void) {
        win(!top->vsync, !top->hsync, top->red, top->green, top->blue);

        //printf("ram: 0x%04X (0x%02X) count: (%d,%d) pixel: (%02X,%02X,%02X)\n", top->vga_tb__DOT__vaddr, top->vga_tb__DOT__vga__DOT__hcount, top->vga_tb__DOT__vga__DOT__vcount, top->vga_tb__DOT__vdata, top->red, top->green, top->blue);

        TESTBENCH<Vvga_tb>::tick();
    }

private:
    bool on_tick(void) {
        for (unsigned int i = 0; i < 5; i++) {
            tick();
        }

        return true;
    }
};

int main(int argc, char** argv, char** env) {
    Gtk::Main   main_instance(argc, argv);
    Verilated::commandArgs(argc, argv);

    VGA_TB *tb = new VGA_TB();
    tb->reset();
    tb->opentrace("out.vcd");

    Gtk::Main::run(tb->win);

    exit(0);
}
