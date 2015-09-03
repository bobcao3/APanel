#!/bin/ruby

require "gtk3"

class MainWindow < Gtk::Window

	def updateTime
	
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
