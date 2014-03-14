Before do
  # Reset the database here.
end

After do |scenario|
  if scenario.failed?
    # write a snapshot of the html to disk for later inspection
    save_and_open_page "~/rails_projects/fuzzybear_capybara_saved_pages/#{scenario.title}_#{Time.now.strftime("%v %r")}"
  end
end