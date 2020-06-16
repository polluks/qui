#import <Cocoa/Cocoa.h>

#import "qui.h"
#import "private.h"

#import "QUIContentView.h"

struct window {
    struct list *children;
    NSWindow *_win;
    QUIContentView *_contentView;
};

struct window *window_new()
{
    NSRect rect;
    NSWindowStyleMask style;
    struct window *win = malloc(sizeof(struct window));

    rect = NSMakeRect(320, 350, 480, 320);
    style = NSWindowStyleMaskTitled;
    style |= NSWindowStyleMaskClosable;

    win->_win = [[[NSWindow alloc]
        initWithContentRect:rect
        styleMask:style
        backing:NSBackingStoreBuffered
        defer:NO
    ] autorelease];

    win->_contentView = [[[QUIContentView alloc]
        initWithFrame:rect
    ] autorelease];

    [win->_win setContentView:win->_contentView];

    return win;
}

void window_show(struct window *win)
{
    [win->_win makeKeyAndOrderFront:nil];
    [win->_win makeMainWindow];
}

void window_close(struct window *win)
{
}

void window_draw_func(struct window *win,
    void (*df)(struct context *, struct QuRect))
{
    [win->_contentView setDrawFunction:df];
}