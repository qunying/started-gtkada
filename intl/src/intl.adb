with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Gtk.Button;      use Gtk.Button;
with Gtkada.Handlers; use Gtkada.Handlers;
with Gtkada.Intl;     use Gtkada.Intl;

with intl_cb; use intl_cb;
with intl_locale;

procedure Intl is
   Win    : Gtk_Window;
   Button : Gtk_Button;
   prgname : constant String := "intl";
begin
   -- procedure calls to setup Locale and text domain binding
   SetLocale;
   Text_Domain (prgname);
   Bind_Text_Domain (prgname, intl_locale.path);

   --  Initialize GtkAda.
   Gtk.Main.Init;

   -- create a top level window
   Gtk_New (Win);
   Win.Set_Title (-"Window");

   -- When the window emits the "delete-event" signal (which is emitted
   -- by GTK+ in response to an event coming from the window manager,
   -- usually as a result of clicking the "close" window control), we
   -- ask it to call the on_delete_event() function as defined above.
   Win.On_Delete_Event (main_del'Access);

   -- connect the "destroy" signal
   Win.On_Destroy (main_quit'Access);

   -- set the border width of the window
   Win.Set_Border_Width (10);

   -- create a button with label
   Gtk_New (Button, -"Hello World");

   -- connect the click signal
   Button.On_Clicked (button_clicked'Access);
   -- connect the "clicked" signal of the button to destroy function
   Widget_Callback.Object_Connect
     (Button,
      "clicked",
      Widget_Callback.To_Marshaller (button_quit'Access),
      Win);
   -- This packs the button into the window. A Gtk_Window inherits from
   -- Gtk_Bin which is a special container that can only have one child.
   Win.Add (Button);

   --  Show the window
   Win.Show_All;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;
end Intl;
