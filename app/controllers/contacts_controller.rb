class ContactsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]

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

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    flash[:success] = "Contact <#{contact.name}> deleted."
    redirect_to contacts_url
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address, :organization, :birthday)
    end

    # Confirms that the contact belongs to current user
    def correct_user
      @contact = Contact.find(params[:id])
      redirect_to root_url unless current_user?(@contact.user)
    end
end
