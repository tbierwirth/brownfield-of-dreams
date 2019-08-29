namespace :video_position do
  desc "Changes any videos in database with position set to nil to 0"
  task video_position: :environment do
    Video.where(position: nil).update_all(position: 0)
    puts "All changes have been made."
  end
end
