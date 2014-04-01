with Ada.Text_IO; use Ada.Text_IO;
with Gtk.Main;

package body builder_cb is

   procedure main_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end main_quit;

   procedure button_clicked (Self : access Gtk_Button_Record'Class) is
   begin
      Put_Line ("Hello World!");
   end button_clicked;

   procedure button_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Put_Line ("buttion_quit is called");
      Destroy (Self);
   end button_quit;
end builder_cb;
