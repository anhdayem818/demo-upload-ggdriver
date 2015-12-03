class Product < ActiveRecord::Base
	has_attached_file :image,
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml"
    :styles => { :medium => "300x300" },
    :google_drive_options => {
      :path => proc { |style| "#{style}_#{id}_#{photo.original_filename}" }
    }
end
