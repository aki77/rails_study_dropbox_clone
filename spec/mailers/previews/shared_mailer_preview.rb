# Preview all emails at http://localhost:3000/rails/mailers/shared_mailer
class SharedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/shared_mailer/shared
  def shared
    SharedMailer.shared
  end

end
