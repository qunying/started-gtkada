with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;

package body grid_cb is
   -- If you return false in the "delete_event" signal handler,
   -- GTK will emit the "destroy" signal. Returning true means
   -- you don't want the window to be destroyed.
   --
   -- This is useful for popping up 'are you sure you want to quit?'
   -- type dialogs.
   function main_del
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return  Boolean
   is
   begin
      Put_Line ("Delete event encounter.");
      return True;
   end main_del;

   procedure main_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end main_quit;

   procedure button_clicked (Self : access Gtk_Button_Record'Class) is
   begin
      Put_Line ("Hello clicked");
   end button_clicked;

   procedure button_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Put_Line ("buttion_quit is called");
      Destroy (Self);
   end button_quit;

end grid_cb;
