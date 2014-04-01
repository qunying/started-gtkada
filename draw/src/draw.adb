with Gtk.Window;       use Gtk.Window;
with Gtk.Frame;        use Gtk.Frame;
with Gtk.Button;       use Gtk.Button;
with Gtk.Drawing_Area; use Gtk.Drawing_Area;
with Gtkada.Handlers;  use Gtkada.Handlers;
with Gdk.Event;        use Gdk.Event;
with draw_cb; use draw_cb;

with Gtk.Main;
with Gtk.Enums;

procedure Draw is
   Win   : Gtk_Window;
   Frame : Gtk_Frame;
   Da    : Gtk_Drawing_Area;
begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   -- create a top level window
   Gtk_New (Win);
   Win.Set_Title ("Drawing Area");
   -- set the border width of the window
   Win.Set_Border_Width (8);
   -- connect the "destroy" signal
   Win.On_Destroy (main_quit'Access);

   -- create a frame
   Gtk_New (Frame);
   Frame.Set_Shadow_Type (Gtk.Enums.Shadow_In);
   Win.Add (Frame);

   Gtk_New (Da);
   -- set a minimum size
   Da.Set_Size_Request (100, 100);
   Frame.Add (Da);

   -- Signals used to handle the backing surface
   Da.On_Draw (draw_cb.draw_cb'Access);
   Da.On_Configure_Event (configure_event_cb'Access);
   -- Event signals
   Da.On_Motion_Notify_Event (motion_notify_event_cb'Access);
   Da.On_Button_Press_Event (button_press_event_cb'Access);

   -- Ask to receive events the drawing area doesn't normally
   -- subscribe to. In particular, we need to ask for the
   -- button press and motion notify events that want to handle.
   Da.Set_Events (Da.Get_Events or Button_Press_Mask or Pointer_Motion_Mask);

   -- Now that we are done packing our widgets, we show them all
   -- in one go, by calling Win.Show_All.
   -- This call recursively calls Show on all widgets
   -- that are contained in the window, directly or indirectly.
   Win.Show_All;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;
end Draw;
