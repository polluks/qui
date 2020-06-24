#import <Cocoa/Cocoa.h>

#import "qui.h"
#import "private.h"

#import "QUIContentView.h"

struct QuWindow {
    QuList *children;
    NSWindow *_win;
    QUIContentView *_contentView;
};

QuWindow *window_new()
{
    NSRect rect;
    NSWindowStyleMask style;
    NSColor *bg;
    QuWindow *win = malloc(sizeof(QuWindow));

    rect = NSMakeRect(320, 350, 480, 320);
    style = NSWindowStyleMaskTitled;
    style |= NSWindowStyleMaskClosable;

    win->_win = [[[NSWindow alloc]
        initWithContentRect:rect
        styleMask:style
        backing:NSBackingStoreBuffered
        defer:NO
    ] autorelease];

    bg = QuRGBA_toNSColor(QuRGBA_WindowBackground);
    [win->_win setBackgroundColor:bg];

    win->_contentView = [[[QUIContentView alloc]
        initWithFrame:rect
    ] autorelease];

    [win->_win setContentView:win->_contentView];

    return win;
}

void window_show(QuWindow *win)
{
    [win->_win makeKeyAndOrderFront:nil];
    [win->_win makeMainWindow];
}

void window_close(QuWindow *win)
{
}

void window_draw_func(QuWindow *win,
    void (*df)(QuContext *, QuRect))
{
    [win->_contentView setDrawFunction:df];
}


QuRGBA window_background_color(QuWindow *win)
{
    NSColor *bg = [win->_win backgroundColor];
    return NSColor_toQuRGBA(bg);
}

void window_set_background_color(QuWindow *win, QuRGBA c)
{
    NSColor *bg = QuRGBA_toNSColor(c);
    [win->_win setBackgroundColor:bg];
}

QuRect window_frame(QuWindow *win)
{
    NSRect frame = [win->_win frame];
    return NSRect_toQuRect(frame);
}

void window_set_frame(QuWindow *win, QuRect frame)
{
    NSRect rect = QuRect_toNSRect(frame);
    [win->_win setFrame:rect display:YES];
}

/*
int window_resizable(QuWindow *win)
{
}

void window_set_resizable(QuWindow *win, int resizable)
{
}
*/

void window_center(QuWindow *win)
{
    [win->_win center];
}
