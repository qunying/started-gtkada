with Gtk.Application_Window; use Gtk.Application_Window;
with Gtk.Application;        use Gtk.Application;
with Gtk.Widget;             use Gtk.Widget;

package body exampleapp_cb is

   procedure activate (Self : access Gapplication_Record'Class) is
      Win : Gtk_Application_Window;
   begin
      Gtk_New (Win, Gtk_Application (Self));
      Win.Present;
   end activate;

   procedure open (App : Gtkada_Application; Files : GFile_Array) is
      Win_List : Widget_List.Glist;
      Win      : Gtk_Application_Window;
      use Widget_List;
   begin
      Win_List := App.Get_Windows;

      if Win_List = Widget_List.Null_List then
         Gtk_New (Win, App);
      else
         Win := Gtk_Application_Window (Widget_List.Get_Data (Win_List));
      end if;

      for I in Files'Range loop
         null;
      end loop;
      Win.Present;
   end open;

end exampleapp_cb;
