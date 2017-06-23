class ContactsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :restore]

  def index
    @contacts = current_user.contacts.sort_by { |contact| contact.name.downcase }
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
    @contact.update_attribute(:deleted_at, DateTime.now)
    flash[:success] = "Contact <#{@contact.name}> archived."
    redirect_to contacts_url
  end

  def archived
    @archived_contacts = Contact.unscoped.archived.where(user: current_user)
  end

  def restore 
    @contact.update_attribute(:deleted_at, nil)
    flash[:success] = "Contact <#{@contact.name}> restored."
    redirect_to archived_contacts_url
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address, :organization, :birthday)
    end

    # Confirms that the contact belongs to current user
    def correct_user
      @contact = Contact.unscoped.find(params[:id])
      redirect_to root_url unless current_user?(@contact.user)
    end
end
