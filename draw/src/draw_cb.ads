with Gtk.Widget;  use Gtk.Widget;
with Gtk.Button;  use Gtk.Button;
with Glib.Object;

with Gdk.Event;
with Cairo;

package draw_cb is
   procedure main_quit (Self : access Gtk_Widget_Record'Class);

   function draw_cb
     (Self : access Gtk_Widget_Record'Class;
      Cr   : Cairo.Cairo_Context)
      return Boolean;

   -- Create a new surface of the appropriate size to store our scribbles
   function configure_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Configure)
      return  Boolean;

   -- Handle motion events by continuing to draw if button 1 is
   -- still held down. The ::motion-notify signal handler receives
   -- a GdkEventMotion struct which contains this information.
   function motion_notify_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Motion)
      return  Boolean;

   -- Handle button press events by either drawing a rectangle
   -- or clearing the surface, depending on which button was pressed.
   -- The ::button-press signal handler receives a GdkEventButton
   -- struct which contains this information.
   function button_press_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Button)
      return  Boolean;
end draw_cb;
