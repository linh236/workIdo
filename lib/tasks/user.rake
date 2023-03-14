namespace :user do
  desc "TODO"
  task update_full_name: :environment do
    success = 0
    failed = 0
    User.all.each do |user|
      full_name = user.full_name.split("@")[0]
      if user.update(full_name: full_name)
        success += 1
      else
        failed += 1
      end
    end
    p "Success: #{success}, Failed: #{failed}"
  end

end
