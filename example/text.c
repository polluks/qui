#include "qui.h"

void draw(QuContext *ctx, QuRect dirty)
{
    draw_text(ctx, "Quick and easy.", point(42, 42));
}

int app_init_cb(QuApp *app)
{
    QuWindow *win = window_new();
    window_draw_func(win, draw);
    window_show(win);
    return 1;
}

int main(int argc, char **argv)
{
    return qui_main_init(argc, argv, app_init_cb);
}