#include "list.h"
#include "window.h"


QuPoint window_position(QuWindow *win)
{
    QuRect frame = window_frame(win);
    return point(frame.origin.x, frame.origin.y);
}

void window_set_position(QuWindow *win, QuPoint pos)
{
    QuRect frame = window_frame(win);
    frame.origin.x = pos.x;
    frame.origin.y = pos.y;
    window_set_frame(win, frame);
}

QuSize window_size(QuWindow *win)
{
    QuRect frame = window_frame(win);
    return size(frame.size.width, frame.size.height);
}

void window_set_size(QuWindow *win, QuSize s)
{
    QuRect frame = window_frame(win);
    frame.size.width = s.width;
    frame.size.height = s.height;
    window_set_frame(win, frame);
}
