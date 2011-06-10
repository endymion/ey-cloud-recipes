#
# Cookbook Name:: crontab
# Recipe:: default
#

if ['solo','app_master'].include?(node[:instance_role])

    cron "Get Emailed Reservations" do
      minute   '*/5'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && nice rake RAILS_ENV=production email_input:reservations"
    end

    cron "Get Emailed Guest Lists" do
      minute   '*/5'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && nice rake RAILS_ENV=production email_input:guestlists"
    end

    cron "Guest List Notifications" do
      minute   '*/5'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && ./script/runner --environment=production /data/venuedriver/current/cron/guestlist_notifications.rb"
    end

    cron "Reservation Summary Notifications" do
      minute   '*/5'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && ./script/runner --environment=production /data/venuedriver/current/cron/reservations_summary_notifications.rb"
    end

    cron "Update active/inactive tickets" do
      minute   '0'
      hour     '*/1'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && rake RAILS_ENV=production tickets:update_active"
    end

    cron "Generate Events From Templates" do
      minute   '0'
      hour     '6'
      day      '*/1'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && rake RAILS_ENV=production events:create_upcoming"
    end

    cron "Incremental Customer Activity Indexing" do
      minute   '*/15'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && rake RAILS_ENV=production customer_activity:index VERBOSE=1 LIMIT=1000 && nice rake RAILS_ENV=production customer_activity:refresh_caches VERBOSE=1"
    end

    cron "Run Delayed Job Worker Threads" do
      minute   '*/15'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "cd /data/venuedriver/current && rake RAILS_ENV=production script/delayed_job start"
    end

end