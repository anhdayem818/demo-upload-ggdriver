class Product < ActiveRecord::Base
	has_attached_file :image,
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_driver.yml",
    :styles => { :medium => "300x300", :thumb => "100x100", :large => "800x600" },
    :google_drive_options => {
      :path => proc { |style| "#{style}_#{id}_#{image.original_filename}" },
      :public_folder_id => '0B0VNyOkzIwUZQjFRU2NUX3pYSGs'
    }

  def self.cache_access_token
  	Rails.cache.fetch([name,"access_token"]) {
		  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

		  file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
		  storage = Google::APIClient::Storage.new(file_store)
		  auth = storage.authorize

		  if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
		    app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
		    flow = Google::APIClient::InstalledAppFlow.new({
		      :client_id => app_info.client_id,
		      :client_secret => app_info.client_secret,
		      :scope => SCOPE})
		    auth = flow.authorize(storage)
		    puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
		  end
		  puts auth.methods
		  puts auth.access_token
		  auth
		}
	end

	after_commit :flush_cache
    
  def self.cache_first
  	Rails.cache.fetch([name, "slider_first"]) { first }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "slider_first"])
  end
end  