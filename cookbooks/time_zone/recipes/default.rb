#
# Cookbook Name:: time_zone
# Recipe:: default
#
# Set the time zone on a new instance to GMT.

# ln -s /usr/share/zoneinfo/UTC /etc/localtime
link "/etc/localtime" do
  to "/usr/share/zoneinfo/UTC"
end