class Product < ActiveRecord::Base
	has_attached_file :image,
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_driver.yml",
    :styles => { :medium => "300x300", :thumb => "100x100", :large => "800x600" },
    :google_drive_options => {
      :path => proc { |style| "#{style}_#{id}_#{image.original_filename}" },
      :public_folder_id => '0B0VNyOkzIwUZQjFRU2NUX3pYSGs'
    }

end