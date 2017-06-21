class ContactsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = current_user.contacts.build
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      flash[:success] = "Contact added."
      redirect_to contacts_url
    else
      render 'new'
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address, :organization, :birthday)
    end
end
