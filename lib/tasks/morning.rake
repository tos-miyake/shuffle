namespace :morning do
  desc 'shuffle morning'
  task notice: :environment do
    Member.deliver
  end
end
