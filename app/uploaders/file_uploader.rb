# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  before :cache, :save_original_filename

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def save_original_filename(file)
    model.name ||= file.original_filename if file.respond_to?(:original_filename)
  end
end
