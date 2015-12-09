# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  before :cache, :save_original_filename
  after :remove, :delete_empty_upstream_dirs

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def save_original_filename(file)
    model.name ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  protected

    def secure_token(length = 16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length / 2))
    end
end
