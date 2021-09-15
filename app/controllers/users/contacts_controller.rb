class Users::ContactsController < ApplicationController
before_action :contact_new, except: [:new, :thanks]

  def new
    @contact = Contact.new
  end

  def confirm
    render :new unless @contact.valid?
  end

  def create
    if params[:back].present?
      render :new
      return
    end
    if @contact.save
      Users::ContactMailer.contact_mail(@contact).deliver_now
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks#問い合わせありがとうございます。ページ
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :tel, :subject, :message)
  end

  def contact_new
    @contact = Contact.new(contact_params)
  end
end
