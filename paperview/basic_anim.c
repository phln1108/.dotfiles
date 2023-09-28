#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <X11/Xlib.h>
#include <Imlib2.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    printf("reading arguments\n");
    if (argc < 4 || argc > 5) {
        fprintf(stderr, "Usage: %s <image_folder> <frame_delay> <screen_number> [loop]\n", argv[0]);
        return 1;
    }
    printf("reading arguments\n");

    char *image_folder = argv[1];
    int frame_delay = atoi(argv[2]);
    int screen_number = atoi(argv[3]);
    int should_loop = (argc == 5 && atoi(argv[4]) == 1);

    printf("acquiring display handler\n");

    Display *display = XOpenDisplay(NULL);
    Window root_window = RootWindow(display, screen_number);
    imlib_context_set_display(display);

    printf("opening dir\n");

    DIR *dir = opendir(image_folder);
    if (!dir) {
        perror("opendir");
        return 1;
    }

    printf("vinicius lixo\n");

    while (should_loop || dir) {
        printf("loop start\n");

        rewinddir(dir);
        struct dirent *entry;

        while ((entry = readdir(dir))) {
            printf("next entry\n");

            if (entry->d_type == DT_REG) {
                printf("entry is a file\n");

                char image_path[256];
                snprintf(image_path, sizeof(image_path), "%s%s", image_folder, entry->d_name);
                imlib_context_set_image(imlib_load_image(image_path));

                printf("entry path: %s\n", image_path);
                printf("creating pixmap\n");

                Pixmap pixmap = XCreatePixmap(display, root_window, imlib_image_get_width(), imlib_image_get_height(), DefaultDepth(display, screen_number));
                printf("certeza\n");
                
                imlib_context_set_drawable(pixmap);
                printf("certeza2\n");
                
                imlib_render_image_on_drawable(0, 0);

                printf("setting background\n");

                XSetWindowBackgroundPixmap(display, root_window, pixmap);
                XClearWindow(display, root_window);
                XFlush(display);

                printf("freeing pixmap\n");

                XFreePixmap(display, pixmap);
                imlib_free_image();

                usleep(frame_delay * 1000);
            }
        }

        if (!should_loop) break;
    }

    closedir(dir);
    XCloseDisplay(display);

    return 0;
}
