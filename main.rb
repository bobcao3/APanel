#!/bin/ruby

require "gtk3"

class DoWindow < Gtk::Window

	def initialize
		super(:popup)
		self.window_position = Gtk::Window::Position::CENTER_ALWAYS
		@box = Gtk::Box.new(:vertical, 4)
		@shutdown = Gtk::Button.new(:label => "Shutdown", :mnemonic => "Shutdown", :stock_id => nil)
		@shutdown.signal_connect("clicked") {
			exec("/bin/shutdown","now")
		}
		@reboot = Gtk::Button.new(:label => "Reboot", :mnemonic => "Reboot", :stock_id => nil)
		@reboot.signal_connect("clicked") {
			exec("/bin/reboot now")
		}
		@cancel = Gtk::Button.new(:label => "Cancel", :mnemonic => "Cancel", :stock_id => nil)
		@cancel.signal_connect("clicked") {
			self.destroy
		}
		@box.pack_start(@shutdown,:expand => true,:fill => true,:padding =>0)
		@box.pack_start(@reboot,:expand => true,:fill => true,:padding =>0)
		
		@box.pack_end(@cancel,:expand => true,:fill => true,:padding =>0)
		self.add(@box)
	end

end

class MainWindow < Gtk::Window

	def updateTime
		t = Time.now
		@time.label = t.strftime(time_format)
	end

	def initialize
		super(:toplevel)
		self.skip_taskbar_hint = true
		self.skip_pager_hint = true
		self.set_type_hint(Gdk::WindowTypeHint::DOCK)
		
		@box = Gtk::Box.new(:horizontal, 1)
		@button_applications = Gtk::Button.new(:label => "Applications", :mnemonic => "Applications", :stock_id => nil)
		@button_do = Gtk::Button.new(:label => " Do ", :mnemonic => "Do", :stock_id => nil)
		@time = Gtk::Label.new()
		
		@button_applications.signal_connect("clicked") {
			system(GLib.getenv("Launcher"))
		}
		
		@button_do.signal_connect("clicked") {
			dow = DoWindow.new
			dow.show_all
		}
		
		@box.pack_start(@button_applications,:expand => false,:fill => true,:padding =>0)
		@box.pack_start(@button_do,:expand => false,:fill => true,:padding =>0)
		@box.pack_end(@time,:expand => false,:fill => true,:padding =>0)
		self.add(@box)
		
		t = Time.now
		time_format = "%H:%M:%S"
		@time.label = t.strftime(time_format)
		GLib::Timeout.add(1000) {
			t = Time.now
			@time.label = t.strftime(time_format)
		}
      	
		screen = Gdk::Screen.default
		self.resize(screen.width, 32)

	end
	
end

Gtk.init
win = MainWindow.new
win.show_all
Gtk.main
