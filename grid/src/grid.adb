with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Gtk.Grid;        use Gtk.Grid;
with Gtk.Button;      use Gtk.Button;
with Gtkada.Handlers; use Gtkada.Handlers;

with grid_cb; use grid_cb;

procedure Grid is
   Win    : Gtk_Window;
   Grid   : Gtk_Grid;
   Button : Gtk_Button;
begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   -- create a top level window
   Gtk_New (Win);
   Win.Set_Title ("Grid");
   -- set the border width of the window
   Win.Set_Border_Width (10);
   -- connect the "destroy" signal
   Win.On_Destroy (main_quit'Access);

   -- Here we construct the container that is going pack our buttons
   Gtk_New (Grid);

   -- Packed the container in the Window
   Win.Add (Grid);

   -- create a button with label
   Gtk_New (Button, "Button 1");
   -- connect the click signal
   Button.On_Clicked (button_clicked'Access);

   -- Place the first button in the grid cell (0, 0), and make it fill
   -- just 1 cell horizontally and vertically (ie no spanning)
   Grid.Attach (Button, 0, 0, 1, 1);

   -- create another button with label
   Gtk_New (Button, "Button 2");
   Button.On_Clicked (button_clicked'Access);

   -- Place the second button in the grid cell (1, 0), and make it fill
   -- just 1 cell horizontally and vertically (ie no spanning)
   Grid.Attach (Button, 1, 0, 1, 1);

   -- create the quit button
   Gtk_New (Button, "Quit");
   -- connect the "clicked" signal of the button to destroy function
   Widget_Callback.Object_Connect
     (Button,
      "clicked",
      Widget_Callback.To_Marshaller (button_quit'Access),
      Win);
   -- Place the Quit button in the grid cell (0, 1), and make it
   -- span 2 columns.
   Grid.Attach (Button, 0, 1, 2, 1);

   -- Now that we are done packing our widgets, we show them all
   -- in one go, by calling Win.Show_All.
   -- This call recursively calls Show on all widgets
   -- that are contained in the window, directly or indirectly.
   Win.Show_All;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;
end Grid;
