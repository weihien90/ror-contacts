class ContactsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :restore, :download_vcard]

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

  def download_vcard
    respond_to do |format|
      format .vcf do
        send_data generate_vcard(@contact).to_s, :filename => "#{@contact.name.parameterize}.vcf", :type => :vcf
      end
    end
  end

  def search
    @keyword = params[:keyword]
    unless @keyword.blank?
      @matched_contacts = Contact.unscoped
        .where(user: current_user)
        .where("name LIKE :keyword OR email LIKE :keyword OR organization LIKE :keyword OR address LIKE :keyword", keyword: "%#{@keyword}%")
    end
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

    # Generate VCard from contact
    def generate_vcard(contact)
      vcard = VCardigan.create
      vcard.fullname contact.name
      vcard.email contact.email
      vcard.tel contact.phone
      vcard.address contact.address
      vcard.org contact.organization
      vcard.birthday contact.birthday

      return vcard
    end
end
