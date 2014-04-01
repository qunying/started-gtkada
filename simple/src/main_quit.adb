with Gtk.Widget; use Gtk.Widget;
with Gtk.Main;

procedure main_quit (Self : access Gtk_Widget_Record'Class) is
begin
  Gtk.Main.Main_Quit;
end main_quit;
