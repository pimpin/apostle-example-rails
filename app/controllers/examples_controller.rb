class ExamplesController < ApplicationController

  include ActionView::Helpers::TextHelper

  def index
    redirect_to action: :show, id: :single
  end

  def show
    if params[:id] == "single"
      render :single
    else
      render :multiple
    end
  end

  def update
    if params[:id] == "single"
      send_single
    else
      send_multiple
    end
  end

  def send_single
    name, email = params[:name], params[:email]

    unless name.blank? || email.blank?
      mail = Penpal::Mail.new "welcome"
      mail.to = "%s <%s>" % [name, email]
      mail.name = name
      mail.email = email
      begin
        mail.deliver!
        flash.now[:success] = "Email sent!"
      rescue => e
        flash.now[:error] = "#{e.class} => #{e.message}"
      end
    else
      flash.now[:error] = "Name and email required"
    end
  ensure
    render :single
  end


  def send_multiple
    queue = Penpal::Queue.new

    params[:emails].each do |index, email|
      name = params[:names][index]
      next if name.blank? || email.blank?

      queue << Penpal::Mail.new('welcome', email: email, name: name)

    end

    if queue.size > 0
      begin
        queue.deliver!
        flash.now[:success] = "#{pluralize queue.size, "email"} sent!"
      rescue => e
        flash.now[:error] = "#{e.class} => #{e.message}"
      end
    else
      flash.now[:error] = "At least one name and email required"
    end
  ensure
    render :multiple
  end
end
