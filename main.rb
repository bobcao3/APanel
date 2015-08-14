#!/bin/ruby

require "gtk3"

class MainWindow < Gtk::Window

	def initialize
		super(:toplevel)
		self.skip_taskbar_hint = true
		self.skip_pager_hint = true
		self.set_type_hint(Gdk::WindowTypeHint::DOCK)
		
		@box = Gtk::Box.new(:horizontal, 1)
		@button_applications = Gtk::Button.new(:label => "Applications", :mnemonic => "Applications", :stock_id => nil)
		@button_do = Gtk::Button.new(:label => " Do ", :mnemonic => "Do", :stock_id => nil)
		
		@button_applications.signal_connect("clicked") {
			system(GLib.getenv("Launcher"))
		}
		
		@box.pack_start(@button_applications,:expand => false,:fill => true,:padding =>0)
		@box.pack_start(@button_do,:expand => false,:fill => true,:padding =>0)
		self.add(@box)
		
		screen = Gdk::Screen.default
		self.resize(screen.width, 32)

	end
	
end

Gtk.init
win = MainWindow.new
win.show_all
Gtk.main
