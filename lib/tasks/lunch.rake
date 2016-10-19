namespace :lunch do
  desc 'shuffle lunch'
  task notice: :environment do
    Member.lunch_deliver
  end
end
