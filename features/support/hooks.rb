Before do
  # Reset the database here.
end

After do |scenario|
  if scenario.failed?
    # write a snapshot of the html to disk for later inspection
    save_page
  end
end