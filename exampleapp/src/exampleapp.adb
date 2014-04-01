with Glib.Application;   use Glib.Application;
with Gtkada.Application; use Gtkada.Application;
with Glib;               use Glib;

with Gtk.Main;

with exampleapp_cb; use exampleapp_cb;

procedure exampleapp is
   example_app : Gtkada_Application;
   ret         : Gint;
begin
   Gtk_New
     (example_app,
      "org.gtk.exampleapp",
      G_Application_Handles_Open,
      Gtkada_Application_Handles_Open);
   example_app.On_Activate (exampleapp_cb.activate'Access);
   example_app.On_Open (exampleapp_cb.open'Access);
   ret := Run (example_app);
end exampleapp;
