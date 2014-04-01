with Glib.Application;   use Glib.Application;
with Gtkada.Application; use Gtkada.Application;

package exampleapp_cb is
   procedure activate (Self : access Gapplication_Record'Class);
   procedure open (App : Gtkada_Application; Files : GFile_Array);
end exampleapp_cb;
