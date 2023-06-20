#include <gtk/gtk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <stdlib.h>

// Define the paths and commands for each icon
#define ICON_SETTINGS "/usr/share/klutzexam/resources/png/settings.png"
#define COMMAND_SETTINGS "gnome-control-center"

#define ICON_OFFICE "/usr/share/klutzexam/resources/png/office.png"
#define COMMAND_OFFICE "libreoffice --writer"

#define ICON_MUSIC "/usr/share/klutzexam/resources/png/music.png"
#define COMMAND_MUSIC "vlc"

// Callback function for button clicks
void launch_command(GtkButton *button, gpointer data)
{
    gchar *command = (gchar *)data;
    g_spawn_command_line_async(command, NULL);
}

GtkWidget *create_scaled_image(const gchar *file_path, int width, int height)
{
    GdkPixbuf *pixbuf = gdk_pixbuf_new_from_file(file_path, NULL);
    GdkPixbuf *scaled_pixbuf = gdk_pixbuf_scale_simple(pixbuf, width, height, GDK_INTERP_BILINEAR);
    GtkWidget *image = gtk_image_new_from_pixbuf(scaled_pixbuf);
    g_object_unref(pixbuf);
    g_object_unref(scaled_pixbuf);
    return image;
}

int main(int argc, char *argv[])
{
    gtk_init(&argc, &argv);

    GtkWidget *window;
    GtkWidget *grid;
    GtkWidget *button;

    // Create the main window
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "App Switcher");
    g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
    gtk_container_set_border_width(GTK_CONTAINER(window), 10);

    // Create a grid layout
    grid = gtk_grid_new();
    gtk_grid_set_row_spacing(GTK_GRID(grid), 10);
    gtk_grid_set_column_spacing(GTK_GRID(grid), 10);
    gtk_container_add(GTK_CONTAINER(window), grid);

    // Create the settings button
    button = gtk_button_new();
    gtk_grid_attach(GTK_GRID(grid), button, 0, 0, 1, 1);
    g_signal_connect(button, "clicked", G_CALLBACK(launch_command), (gpointer)COMMAND_SETTINGS);

    GtkWidget *image = create_scaled_image(ICON_SETTINGS, 64, 64);
    gtk_button_set_image(GTK_BUTTON(button), image);

    // Create the office button
    button = gtk_button_new();
    gtk_grid_attach(GTK_GRID(grid), button, 1, 0, 2, 2);
    g_signal_connect(button, "clicked", G_CALLBACK(launch_command), (gpointer)COMMAND_OFFICE);

    image = create_scaled_image(ICON_OFFICE, 128, 128);
    gtk_button_set_image(GTK_BUTTON(button), image);

    // Create the music button
    button = gtk_button_new();
    gtk_grid_attach(GTK_GRID(grid), button, 0, 1, 1, 1);
    g_signal_connect(button, "clicked", G_CALLBACK(launch_command), (gpointer)COMMAND_MUSIC);

    image = create_scaled_image(ICON_MUSIC, 128, 128);
    gtk_button_set_image(GTK_BUTTON(button), image);

    gtk_widget_show_all(window);

    gtk_main();

    return EXIT_SUCCESS;
}
