class Product < ActiveRecord::Base
	has_attached_file :image,
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml"
end
