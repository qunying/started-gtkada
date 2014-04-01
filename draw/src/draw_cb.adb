with Gtk.Widget; use Gtk.Widget;
with Gtk.Button; use Gtk.Button;
with Glib;       use Glib;

with Gdk.Types;  use Gdk.Types;
with Gdk.Window;
with Gtk.Main;
with Cairo;

with Interfaces; use Interfaces;

package body draw_cb is

   -- Button defintions from gtk-3.0/gdk/gdkevents.h
   -- The primary button. This is typically the left button, or the
   -- right button in a left-handed setup.
   Gdk_Button_Primary : constant := 1;
   --  The secondary button. This is typically the right mouse button, or the
   -- left button in a left-handed setup.
   Gdk_Button_Secondary : constant := 3;

   surface : Cairo.Cairo_Surface;
   use type Cairo.Cairo_Surface;

   procedure main_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      if surface /= Cairo.Null_Surface then
         Cairo.Surface_Destroy (surface);
      end if;

      Gtk.Main.Main_Quit;
   end main_quit;

   procedure Clear_Surface is
      Cr : Cairo.Cairo_Context;
   begin
      Cr := Cairo.Create (surface);
      Cairo.Set_Source_Rgb (Cr, 1.0, 1.0, 1.0);
      Cairo.Paint (Cr);
      Cairo.Destroy (Cr);
   end Clear_Surface;

   -- Redraw the screen from the surface. Note that the ::draw
   -- signal receives a ready-to-be-used cairo_t that is already
   -- clipped to only draw the exposed areas of the widget
   function draw_cb
     (Self : access Gtk_Widget_Record'Class;
      Cr   : Cairo.Cairo_Context)
      return Boolean
   is
   begin
      Cairo.Set_Source_Surface (Cr, surface, 0.0, 0.0);
      Cairo.Paint (Cr);
      return False;
   end draw_cb;

   function configure_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Configure)
      return  Boolean
   is
   begin
      if surface /= Cairo.Null_Surface then
         Cairo.Surface_Destroy (surface);
      end if;
      surface :=
         Gdk.Window.Create_Similar_Surface
           (Self.Get_Window,
            Cairo.Cairo_Content_Color,
            Self.Get_Allocated_Width,
            Self.Get_Allocated_Height);
      -- Initialize the surface to white
      Clear_Surface;

      -- We've handled the configure event, no need for further processing.
      return True;
   end configure_event_cb;

   -- Draw a rectangle on the surface at the given position
   procedure draw_brush
     (Self : access Gtk_Widget_Record'Class;
      x    : Gdouble;
      y    : Gdouble)
   is
      Cr : Cairo.Cairo_Context;
   begin

      -- Paint to the surface, where we store our state
      Cr := Cairo.Create (surface);
      Cairo.Rectangle (Cr, x - 3.0, y - 3.0, 6.0, 6.0);
      Cairo.Fill (Cr);
      Cairo.Destroy (Cr);

      -- Now invalidate the affected region of the drawing area.
      Self.Queue_Draw_Area (Gint (x - 3.0), Gint (y - 3.0), 6, 6);
   end draw_brush;

   function motion_notify_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Motion)
      return  Boolean
   is
   begin
      -- paranoia check, in case we haven't gotten a configure event
      if surface = Cairo.Null_Surface then
         return False;
      end if;

      if (Event.State and Gdk.Types.Button1_Mask) > 0 then
         draw_brush (Self, Event.X, Event.Y);
      end if;

      -- We've handled it, stop processing
      return True;
   end motion_notify_event_cb;

   function button_press_event_cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Button)
      return  Boolean
   is
   begin
      -- paranoia check, in case we haven't gotten a configure event
      if surface = Cairo.Null_Surface then
         return False;
      end if;

      if Event.Button = Gdk_Button_Primary then
         draw_brush (Self, Event.X, Event.Y);
      elsif Event.Button = Gdk_Button_Secondary then
         Clear_Surface;
         Self.Queue_Draw;
      end if;
      -- We've handled the event, stop processing
      return True;
   end button_press_event_cb;
end draw_cb;
