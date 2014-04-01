with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Gtk.Button;      use Gtk.Button;
with Gtkada.Handlers; use Gtkada.Handlers;

with main_quit;

procedure Hello is
   Win    : Gtk_Window;
begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   -- create a top level window
   Gtk_New (Win);
   Win.Set_Title ("Window");

   -- connect the "destroy" signal
   Win.On_Destroy (main_quit'Access);


   --  Show the window
   Win.Show_All;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;
end Hello;
