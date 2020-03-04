namespace :scraper do
  desc "Check Website for Any Updates"
  task check_site_update: :environment do
    CoronaDiff.check_last_record
  end

end
