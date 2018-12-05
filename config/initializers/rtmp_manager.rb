require "#{Rails.root.join('lib')}/rtmp_manager.rb"
unless ($1 == 'db:migrate')
    RManager = RtmpManager.new
end

