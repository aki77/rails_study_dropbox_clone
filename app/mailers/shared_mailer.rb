class SharedMailer < ApplicationMailer
  def shared_email(shared_file, message)
    @shared_file = shared_file
    @message = message
    mail to: shared_file.shared_user.email, subject: "「#{shared_file.file.name}」が届いています"
  end
end
