class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show edit update destroy redirect mark_as_read]
  before_action :set_user, only: %i[create update index]
  protect_from_forgery prepend: true, with: :null_session
  skip_before_action :verify_authenticity_token

  # GET /notifications
  # GET /notifications.json
  def index
    @q = Notification.includes(:sender).all.search([:q])
    @notifications = @q.result(distinct: true).page(params[:page]).per(15)
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show; end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit; end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params.merge(sender: @user))
    respond_to do |format|
      if @notification.save
        @notification.individual_notification(users_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render @notification, status: :created }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render @notification, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect
    user_id = request.path.match(/\d{1,9}/)[0].to_i
    individual_notification = IndividualNotification.find_by(user_id: user_id, notification_id: @notification.id)
    individual_notification.update(read_at: Time.now)
    redirect_to @notification.link
  end

  def mark_all_read
    user = User.find(params[:id])
    user.individual_notifications.each do |notification|
      notification.update(read_at: Time.now)
    end
    NotifierJob.perform_later(user.cpf)
    render plain: :ok
  end

  def mark_as_read
    user = User.find_by(id: request.path.match(/\d{1,9}/)[0].to_i)
    individual_notification = IndividualNotification.find_by(user_id: user.id, notification_id: @notification.id)
    individual_notification.update(read_at: Time.now)
    NotifierJob.perform_later(user.cpf)
    render plain: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  def set_user
    if params[:notification].nil?
      @user = User.find_by(id: params[:id])
    else
      @user = User.find_by(cpf: params[:notification][:sender])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def notification_params
    params.require(:notification).permit(:title, :content, :app, :link, :channel, :module)
  end

  def users_params
    params[:notification][:users]
  end
end
