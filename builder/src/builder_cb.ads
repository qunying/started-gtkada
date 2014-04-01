with Gtk.Widget;  use Gtk.Widget;
with Gtk.Button; use Gtk.Button;

package builder_cb is
   procedure main_quit (Self : access Gtk_Widget_Record'Class);

   procedure button_clicked (Self : access Gtk_Button_Record'Class);
   procedure button_quit (Self : access Gtk_Widget_Record'Class);
end builder_cb;
