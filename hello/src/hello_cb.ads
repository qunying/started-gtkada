with Gtk.Widget;  use Gtk.Widget;
with Gtk.Button;  use Gtk.Button;
with Glib.Object;

with Gdk.Event;

package hello_cb is
   function main_del
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return  Boolean;
   procedure main_quit (Self : access Gtk_Widget_Record'Class);
   procedure button_clicked (Self : access Gtk_Button_Record'Class);
   procedure button_quit (Self : access Gtk_Widget_Record'Class);
end hello_cb;
