with Gtk.Builder; use Gtk.Builder;
with Gtk.Window; use Gtk.Window;
with Gtk.Button; use Gtk.Button;
with Gtkada.Handlers;  use Gtkada.Handlers;

with builder_cb; use builder_cb;
with Glib; use Glib;
with Glib.Error; use Glib.Error;
with Gtk.Main;

procedure Builder is
   Win   : Gtk_Window;
   Button : Gtk_Button;
   builder : Gtk_Builder;
   ret : GUint;
   error : aliased GError;
begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   -- construct a Gtk_Builder instance and load our UI description
   Gtk_New (Builder);
   ret := Builder.Add_From_File ("builder.ui", error'Access);

   -- connect signal handlers to the constructed widgets
   Win := Gtk_Window (Builder.Get_Object ("window"));
   -- connect the "destroy" signal
   Win.On_Destroy (main_quit'Access);

   button := Gtk_Button (Builder.Get_Object ("button1"));
   button.On_Clicked (button_clicked'Access);

   button := Gtk_Button (Builder.Get_Object ("button2"));
   button.On_Clicked (button_clicked'Access);

   button := Gtk_Button (Builder.Get_Object ("quit"));
   -- connect the "clicked" signal of the button to destroy function
   Widget_Callback.Object_Connect
     (Button,
      "clicked",
      Widget_Callback.To_Marshaller (button_quit'Access),
      Win);
   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;
end Builder;
